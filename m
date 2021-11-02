Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA7442A40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:22:26 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36603 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhKBJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:22:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UujaEY1_1635844786;
Received: from 30.22.113.90(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UujaEY1_1635844786)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 17:19:47 +0800
Message-ID: <d4ae23dd-377e-8316-909b-d5bdeacc0904@linux.alibaba.com>
Date:   Tue, 2 Nov 2021 17:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V4 04/50] x86/xen: Add
 xenpv_restore_regs_and_return_to_usermode()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Peter Anvin <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
 <20211026141420.17138-5-jiangshanlai@gmail.com> <YYD9ohN2Zcy4EdMb@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YYD9ohN2Zcy4EdMb@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/2 16:58, Borislav Petkov wrote:

>>   	 */
>>   
>> -	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
>> +	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", \
> 
> Instead of sprinkling all those ALTERNATIVE calls everywhere,
> why don't you simply jump to the xenpv-one at the
> swapgs_restore_regs_and_return_to_usermode label itself and have a
> single ALTERNATIVE there?
> 

It will add a 5-byte NOP at the beginning of the native
swapgs_restore_regs_and_return_to_usermode.  I avoided adding unneeded
code in the native code even if it is NOPs and avoided melting xenpv-one into
the native one which will reduce the code readability.

I will follow your preference since a 5-byte NOP is so negligible in the slow
path with an iret instruction.

Or other option that adds macros to wrap the ALTERNATIVE.
RESTORE_REGS_AND_RETURN_TO_USERMODE and
COND_RESTORE_REGS_AND_RETURN_TO_USERMODE (test %eax before jmp in native case)


