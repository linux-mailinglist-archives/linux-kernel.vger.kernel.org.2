Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40334B3B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhC0CQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:16:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14565 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhC0CQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:16:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6j7Q4xP0zPrS6;
        Sat, 27 Mar 2021 10:13:38 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 10:16:03 +0800
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210319123527.173883-1-yangjihong1@huawei.com>
 <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
 <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
 <YF3OXfzl7FEV50Ir@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
Date:   Sat, 27 Mar 2021 10:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YF3OXfzl7FEV50Ir@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2021/3/26 20:06, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 26, 2021 at 12:25:37PM +0900, Namhyung Kim escreveu:
>> On Fri, Mar 26, 2021 at 11:24 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>> On 2021/3/19 20:35, Yang Jihong wrote:
>>>> In hist__find_annotations function, since different hist_entry may point to same
>>>> symbol, we free notes->src to signal already processed this symbol in stdio mode;
>>>> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
>>>>
>>>> However, there is a problem, for example, run the following command:
>>>>
>>>>    # perf record -e branch-misses -e branch-instructions -a sleep 1
>>>>
>>>> perf.data file contains different types of sample event.
>>>>
>>>> If the same IP sample event exists in branch-misses and branch-instructions,
>>>> this event uses the same symbol. When annotate branch-misses events, notes->src
>>>> corresponding to this event is set to null, as a result, when annotate
>>>> branch-instructions events, this event is skipped and no annotate is output.
>>>>
>>>> Solution of this patch is to remove zfree in hists__find_annotations and
>>>> change sort order to "dso,symbol" to avoid duplicate output when different
>>>> processes correspond to the same symbol.
> 
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Without looking at the patch, just at its description of the problem, I
> tried to annotate two events in a group, to get the annotate group view
> output with both events, and it seems I'm getting samples accounted for
> both events:
> 
> [root@five ~]# perf record -e '{branch-misses,branch-instructions}' -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.296 MB perf.data (2507 samples) ]
> [root@five ~]#
> [root@five ~]# perf report | grep -v '^#' | head -5
>      17.49%  19.19%  ThreadPoolForeg  chromium-browser              [.] v8::internal::ConcurrentMarking::Run
>      12.17%  17.04%  ThreadPoolForeg  chromium-browser              [.] v8::internal::Sweeper::RawSweep
>      11.14%  11.63%  ThreadPoolForeg  chromium-browser              [.] v8::internal::MarkingVisitorBase<v8::internal::ConcurrentMarkingVisitor, v8::internal::ConcurrentMarkingState>::ProcessStrongHeapObject<v8::internal::CompressedHeapObjectSlot>
>       7.65%   7.84%  ThreadPoolForeg  chromium-browser              [.] v8::internal::ConcurrentMarkingVisitor::ShouldVisit
>       5.66%   6.72%  ThreadPoolForeg  chromium-browser              [.] v8::internal::ConcurrentMarkingVisitor::VisitPointersInSnapshot
> 
> [root@five ~]# perf annotate --stdio2 v8::internal::ConcurrentMarking::Run
> Samples: 444  of events 'anon group { branch-misses, branch-instructions }', 4000 Hz, Event count (approx.): 596221, [percent: local period]
> v8::internal::ConcurrentMarking::Run() /usr/lib64/chromium-browser/chromium-browser
> Percent
>                               
>                               
>                       Disassembly of section .text:
>                               
>                       0000000003290b30 <v8::internal::ConcurrentMarking::Run(v8::JobDelegate*, unsigned int, bool)>:
>                       v8::internal::ConcurrentMarking::Run(v8::JobDelegate*, unsigned int, bool):
>                         push       %rbp
>                         mov        %rsp,%rbp
>                         push       %r15
>                         push       %r14
>                         mov        %rdi,%r14
>                         push       %r13
>                         mov        %edx,%r13d
>                         push       %r12
>                         mov        %ecx,%r12d
>                         push       %rbx
>                         sub        $0x1298,%rsp
>                         mov        %rsi,-0x1228(%rbp)
>                         mov        %fs:0x28,%rax
>                         mov        %rax,-0x38(%rbp)
> <SNIP>		
>                         movzwl     0x2(%rbx),%eax
>                         test       %ax,%ax
>                       ↓ jne        4a9
>                         mov        -0x10e8(%rbp),%rdx
>                         cmpw       $0x0,0x2(%rdx)
>    0.41   0.39        ↓ je         4b90
>                         movq       %rbx,%xmm0
>                         movq       %rdx,%xmm2
>                         mov        %rdx,%rbx
>                         punpcklqdq %xmm2,%xmm0
>                         movups     %xmm0,-0x10e8(%rbp)
>                         movzwl     0x2(%rdx),%eax
>                  4a9:   sub        $0x1,%eax
>                         mov        %ax,0x2(%rbx)
>    0.36   0.91          movzwl     %ax,%eax
>    0.60   0.00          mov        0x10(%rbx,%rax,8),%rax
>    3.44   2.46          mov        %rax,-0x11e0(%rbp)
>    0.00   0.34   4bf:   mov        0x8(%r13),%rax
>    0.00   0.36          add        $0x1,%r15d
>    0.00   0.34          mov        0x110(%rax),%rax
>                         mov        0x128(%rax),%rcx
>    0.88   0.36          mov        0x8(%r13),%rax
>                         mov        0x110(%rax),%rdx
>                         mov        0x130(%rdx),%rdx
>    0.00   0.48          mov        0x140(%rax),%rax
>                         mov        0x110(%rax),%rsi
>    0.61   0.47          mov        -0x11e0(%rbp),%rax
>    2.01   2.32          sub        $0x1,%rax
>                         cmp        %rcx,%rax
>    0.00   0.35          setae      %cl
>    1.31   0.33          cmp        %rdx,%rax
>                         setb       %dl
>    0.00   0.24          test       %dl,%cl
>    0.00   0.12        ↓ jne        4b70
>                         cmp        %rsi,%rax
>                       ↓ je         4b70
>                         mov        (%rax),%eax
>   29.10  29.90          add        -0x1220(%rbp),%rax
>                         cmpb       $0x0,-0x1218(%rbp)
>                         mov        %rax,-0x1210(%rbp)
>    0.00   0.65        ↓ jne        4fa0
>                         mov        -0x11e0(%rbp),%r9
>                         lea        0x6(%rax),%rbx
>    0.38   0.00   545:   movzbl     (%rbx),%eax
>    4.90   5.34          cmp        $0x4c,%al
>                       ↓ ja         5026
>    0.58   0.00   550:   lea        v8::internal::FLAGDEFAULT_abort_on_contradictory_flags+0x457,%rdi
>                         movslq     (%rdi,%rax,4),%rax
>    4.97   3.19          add        %rdi,%rax
> <SNIP>
> 
> If I ask for number of samples:
> 
> [root@five ~]# perf config annotate.show_nr_samples=true
> [root@five ~]# perf annotate --stdio2 v8::internal::ConcurrentMarking::Run
> 
> Samples: 444  of events 'anon group { branch-misses, branch-instructions }', 4000 Hz, Event count (approx.): 596221, [percent: local period]
> v8::internal::ConcurrentMarking::Run() /usr/lib64/chromium-browser/chromium-browser
> Samples
>                               
>                               
>                       Disassembly of section .text:
>                               
>                       0000000003290b30 <v8::internal::ConcurrentMarking::Run(v8::JobDelegate*, unsigned int, bool)>:
>                       v8::internal::ConcurrentMarking::Run(v8::JobDelegate*, unsigned int, bool):
>                         push       %rbp
>                         mov        %rsp,%rbp
>                         push       %r15
>                         push       %r14
>                         mov        %rdi,%r14
>                         push       %r13
>                         mov        %edx,%r13d
>                         push       %r12
>                         mov        %ecx,%r12d
>                         push       %rbx
>                         sub        $0x1298,%rsp
>                         mov        %rsi,-0x1228(%rbp)
>                         mov        %fs:0x28,%rax
>                         mov        %rax,-0x38(%rbp)
> <SNIP>
>                         movzwl     0x2(%rbx),%eax
>                         test       %ax,%ax
>                       ↓ jne        4a9
>                         mov        -0x10e8(%rbp),%rdx
>                         cmpw       $0x0,0x2(%rdx)
>       1      1        ↓ je         4b90
>                         movq       %rbx,%xmm0
>                         movq       %rdx,%xmm2
>                         mov        %rdx,%rbx
>                         punpcklqdq %xmm2,%xmm0
>                         movups     %xmm0,-0x10e8(%rbp)
>                         movzwl     0x2(%rdx),%eax
>                  4a9:   sub        $0x1,%eax
>                         mov        %ax,0x2(%rbx)
>       1      2          movzwl     %ax,%eax
>       1      0          mov        0x10(%rbx,%rax,8),%rax
>       8      5          mov        %rax,-0x11e0(%rbp)
>       0      1   4bf:   mov        0x8(%r13),%rax
>       0      1          add        $0x1,%r15d
>       0      1          mov        0x110(%rax),%rax
>                         mov        0x128(%rax),%rcx
>       3      1          mov        0x8(%r13),%rax
>                         mov        0x110(%rax),%rdx
>                         mov        0x130(%rdx),%rdx
>       0      1          mov        0x140(%rax),%rax
>                         mov        0x110(%rax),%rsi
>       2      1          mov        -0x11e0(%rbp),%rax
>       6      6          sub        $0x1,%rax
>                         cmp        %rcx,%rax
>       0      1          setae      %cl
>       2      1          cmp        %rdx,%rax
>                         setb       %dl
>       0      1          test       %dl,%cl
>       0      1        ↓ jne        4b70
>                         cmp        %rsi,%rax
>                       ↓ je         4b70
>                         mov        (%rax),%eax
>      58     73          add        -0x1220(%rbp),%rax
>                         cmpb       $0x0,-0x1218(%rbp)
>                         mov        %rax,-0x1210(%rbp)
>       0      1        ↓ jne        4fa0
>                         mov        -0x11e0(%rbp),%r9
>                         lea        0x6(%rax),%rbx
>       1      0   545:   movzbl     (%rbx),%eax
>      10     13          cmp        $0x4c,%al
>                       ↓ ja         5026
>       1      0   550:   lea        v8::internal::FLAGDEFAULT_abort_on_contradictory_flags+0x457,%rdi
>                         movslq     (%rdi,%rax,4),%rax
>       9      8          add        %rdi,%rax
> 
> <SNIP>
> 
> So it seems to be working, what am I missing? Is this strictly non
> group related?
> 
Yes, it is non group related.
This problem occurs only when different events need to be recorded at 
the same time, i.e.:
perf record -e branch-misses -e branch-instructions -a sleep 1

The output results of perf script and perf annotate do not match.
Some events are not output in perf annotate.

> - Arnaldo
> .
> 
