Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC07419280
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhI0KvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:51:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39357 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233866AbhI0Ku6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:50:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Upn50xz_1632739756;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Upn50xz_1632739756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Sep 2021 18:49:17 +0800
Subject: Re: [PATCH V2 02/41] x86/traps: Remove stack-protector from traps.c
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-3-jiangshanlai@gmail.com> <YVGalJLOyK235XvG@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <d4e653e7-1f23-eec9-4db7-964298fc1dc5@linux.alibaba.com>
Date:   Mon, 27 Sep 2021 18:49:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVGalJLOyK235XvG@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/27 18:19, Borislav Petkov wrote:
> On Sun, Sep 26, 2021 at 11:07:59PM +0800, Lai Jiangshan wrote:
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 8f4e8fa6ed75..0e054e2304c6 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -48,6 +48,9 @@ KCOV_INSTRUMENT		:= n
>>   
>>   CFLAGS_head$(BITS).o	+= -fno-stack-protector
>>   
>> +CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
> 
> Why this too?
> 
>> +CFLAGS_traps.o			+= -fno-stack-protector
> 
> Isn't this enough to disable stack protector for this file?
> 

I did not investigate deep enough.  I reviewed the generated code and
found %gs is accessed early for the C entry function and searched for
solution and I chose to copy the code that I thought is the most complete:
kernel/entry/Makefile

Using only "-fno-stack-protector" is enough to disable stack protector with
my .config, I'm not so sure about other configuration.

Thanks
Lai
