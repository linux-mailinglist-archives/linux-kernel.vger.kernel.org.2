Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B03FED51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343877AbhIBL7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:59:53 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41038 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245693AbhIBL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:59:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Un.jn1j_1630583931;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Un.jn1j_1630583931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 19:58:52 +0800
Subject: Re: [PATCH 22/24] x86/entry: Implement and use do_paranoid_entry()
 and paranoid_exit()
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-23-jiangshanlai@gmail.com>
 <YTCoenvIaHjLQmAC@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <44e08066-bbfb-222e-dffc-63e5b64f125f@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 19:58:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTCoenvIaHjLQmAC@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 18:33, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 01:50:23AM +0800, Lai Jiangshan wrote:
> 
>> +	call	do_paranoid_entry
>>   	ret
> 
> That's normally spelled like:
> 
> 	jmp do_paranoid_entry
> 
> But the same comment as for error_entry but more; pretty much all that's
> left in asm is things like:
> 
> 
> 	call paranoid_entry;
> 
> 	# setup args
> 	call \cfunc
> 
> 	call paranoid_exit
> 
> which seems like prime material to also pull into C to avoid the
> back-and-forth thing. In fact, why can't you call paranoid_entry/exit
> from \cfunc itself? The IDT macros should be able to help.
> 

Oh, #VC will need to switch stack.  I think we need ASM code to switch
stack since the original stack need to be "free" for next #VC.
