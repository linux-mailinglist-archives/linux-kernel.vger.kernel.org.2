Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61033FE939
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhIBG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:29:45 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24637 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhIBG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:29:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Umzy5X2_1630564123;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Umzy5X2_1630564123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 14:28:44 +0800
Subject: Re: [PATCH 00/24] x86/entry/64: Convert a bunch of ASM entry code
 into C code
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831204459.GM4353@worktop.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <b2a74b43-2b87-9f81-2e50-ea31cbd614c6@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 14:28:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831204459.GM4353@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/1 04:44, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 01:50:01AM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Many ASM code in entry_64.S can be rewritten in C if they can be written
>> to be non-instrumentable and are called in the right order regarding to
>> whether CR3/gsbase is changed to kernel CR3/gsbase.
>>
>> The patchset covert some of them to C code.
> 
> Overall, very nice! There's a lot of details to verify, but I really
> like where this ends up.
> 
> I'm not sure about moving traps.c, but whatever, that's simple stuff.
> I'll try and put some more eyeballs on this later.
> 

Hello, Peter

How is it going?

Do I need to send a new version?
How can I cooperate or participate in the details?
Do you plan to move the other path of ASM code into C code?

Thanks
Lai

PS:
And I think [PATCH 12/24] ("x86/traps: Reconstruct pt_regs on task stack
directly in fixup_bad_iret()") has nothing related to moving ASM to C
is off topic to the patchset.  It can be dropped if no one needs it.
