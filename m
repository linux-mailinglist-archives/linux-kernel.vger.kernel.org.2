Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E0439139
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhJYIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:34:06 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37936 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231241AbhJYIeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:34:04 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72pLa3ZhGrgfAA--.33945S3;
        Mon, 25 Oct 2021 16:31:08 +0800 (CST)
Subject: Re: [PATCH 4/4] MAINTAINERS: Add git tree and missing files for
 KPROBES
To:     Masami Hiramatsu <mhiramat@kernel.org>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
 <1635132660-5038-5-git-send-email-yangtiezhu@loongson.cn>
 <20211025153821.baa3f5d90fd40943ee28d2e1@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c10e50c8-081b-aca6-eefe-eac463cb5a30@loongson.cn>
Date:   Mon, 25 Oct 2021 16:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20211025153821.baa3f5d90fd40943ee28d2e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx72pLa3ZhGrgfAA--.33945S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy5ury7Gr4xKF13GrWxJFb_yoW5AryrpF
        4vgrn3Zr4xGr18J39Fgw1Ska4Ivw1kZrsruFn7Kwn5AF1qvr48Xrn293ya9F92qrZ0gFWS
        yryxAFyjga4xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Jr0_Gr1lYx0E2Ix0cI8IcVAFwI0_Jr
        0_Jr4lYx0Ec7CjxVAajcxG14v26r1j6r4UMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jfo7ZUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2021 02:38 PM, Masami Hiramatsu wrote:
> On Mon, 25 Oct 2021 11:31:00 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
>> rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, add them.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   MAINTAINERS | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4372473..0e9bc60 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10506,10 +10506,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>>   M:	"David S. Miller" <davem@davemloft.net>
>>   M:	Masami Hiramatsu <mhiramat@kernel.org>
>>   S:	Maintained
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
> NACK. As I said, this branch was prepared when I discussed with tip maintainer
> on kretprobe stackfix series but now it has been maintained on Steve's tracing
> tree.
>
> Steve, should we put your tree here?

If yes, should I update patch #4 and then send a v2 version of this 
patch set?

@@ -10505,11 +10505,16 @@ M:    Naveen N. Rao <naveen.n.rao@linux.ibm.com>
  M:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  M:     "David S. Miller" <davem@davemloft.net>
  M:     Masami Hiramatsu <mhiramat@kernel.org>
+L:     linux-trace-devel@vger.kernel.org
  S:     Maintained
+Q:     https://patchwork.kernel.org/project/linux-trace-devel/list/
+T:     git 
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  F:     Documentation/trace/kprobes.rst
  F:     include/asm-generic/kprobes.h
  F:     include/linux/kprobes.h
  F:     kernel/kprobes.c
+F:     lib/test_kprobes.c
+F:     samples/kprobes

By the way, it seems that we should also update the TRACING git tree [1]?
If yes, should I send the following change as a new patch #5 in the v2 
version
or do the following change in the above patch #4?

@@ -19065,8 +19070,10 @@ F:     drivers/char/tpm/
  TRACING
  M:     Steven Rostedt <rostedt@goodmis.org>
  M:     Ingo Molnar <mingo@redhat.com>
+L:     linux-trace-devel@vger.kernel.org
  S:     Maintained
-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 
perf/core
+Q:     https://patchwork.kernel.org/project/linux-trace-devel/list/
+T:     git 
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  F:     Documentation/trace/ftrace.rst
  F:     arch/*/*/*/ftrace.h
  F:     arch/*/kernel/ftrace.c

  [1] 
https://lore.kernel.org/lkml/20211019091344.65629198@gandalf.local.home/

  Thanks,
  Tiezhu

>
> Anyway, I will pick your [1/4]-[3/4].
>
> Thank you,
>
>>   F:	Documentation/trace/kprobes.rst
>>   F:	include/asm-generic/kprobes.h
>>   F:	include/linux/kprobes.h
>>   F:	kernel/kprobes.c
>> +F:	lib/test_kprobes.c
>> +F:	samples/kprobes
>>   
>>   KS0108 LCD CONTROLLER DRIVER
>>   M:	Miguel Ojeda <ojeda@kernel.org>
>> -- 
>> 2.1.0
>>
>

