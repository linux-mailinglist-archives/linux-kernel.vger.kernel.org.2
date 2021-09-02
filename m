Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE4F3FED37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbhIBLzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:55:36 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56176 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343741AbhIBLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:55:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Un0FXAS_1630583665;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Un0FXAS_1630583665)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 19:54:26 +0800
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
 <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 19:54:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 18:50, Peter Zijlstra wrote:
> On Thu, Sep 02, 2021 at 05:21:51PM +0800, Lai Jiangshan wrote:
>>
>>
>> On 2021/9/2 16:09, Joerg Roedel wrote:
>>> On Wed, Sep 01, 2021 at 01:50:03AM +0800, Lai Jiangshan wrote:
>>>>    arch/x86/entry/Makefile            | 5 ++++-
>>>>    arch/x86/{kernel => entry}/traps.c | 0
>>>>    arch/x86/kernel/Makefile           | 5 +----
>>>>    3 files changed, 5 insertions(+), 5 deletions(-)
>>>>    rename arch/x86/{kernel => entry}/traps.c (100%)
>>>
>>>   From looking over the patch-set I didn't spot the reason for putting the
>>> entry C code into traps.c. Can you explain that please? Otherwise I'd
>>> prefer to create a new file, like arch/x86/entry/entry64.c.
>>
>>
>> I agree, and I think Peter is handling it.
> 
> I don't think I said that. I said I like the patches but there's a lot
> of scary code and details to review, which takes time.
> 
> I've now done a second reading of the patches and provided some more
> feedback, but I'm very sure I didn't get to the scary details yet.
> 
> One thing that got pointed out (by Andrew Cooper) is that by moving the
> whole SWAPGS trainwreck to C it becomes entirely 'trivial' to sneak in
> an 'accidental' per-cpu reference before having done the SWAPGS dance.
> 
> I'm myself not (yet) convinced that's a good enough reason to leave it
> in ASM, but it does certainly need consideration.
> 


It is real concern and it proves that my having put the C code in traps.c
was totally wrong.

To relieve the concern, I think the C code can be put into a single file, like
arch/x86/entry/entry64.c,  and be documented that it is as critical, dangerous as
entry_64.S and any one should take no less care on modifying/reviewing it than on
modifying/reviewing entry_64.S.

And all the other users of native_swapgs can be moved to this file too, such as
__[rd|wr]gsbase_inactive().

A noninstr function can sometimes have 'accidental' instrument to sneak in.
For example, stack-protector is instrumenting many noninstr functions now
if the CONFIG is yes.  It is normally Ok and gcc is adding per-function control
on it.

But the C code can not be instrumented by any way.  For example stack-protector
would add per-cpu reference before having done the SWAPGS dance.)  Entry C code
required a stronger limitation than noninstr code.

By the way, can objtool check the per-cpu reference?
