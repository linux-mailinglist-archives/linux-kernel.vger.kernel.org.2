Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7579A368831
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhDVUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhDVUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:48:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CDBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oiB0fYzitH19QgB8n6QuufnwiQE42rlZZ25AFlDDFQ8=; b=WAnG1Q6yslpE7l2FM6DMLWKzJ4
        1VtAc2CLt9DlJgXe72U9KrwOowGV31AWIudUmA39A3bd4eryqS/MpoQlNq+fkVdAzaJTzQ8eB4wZT
        ov7PVnIi7pni11A9x86Sgpo0kREkz/LzgPjduAA1hSDYhhh/IysGqP/36Jf/hTagQP8bSUL3YVCOw
        SX4RBEEb/T+lThCKfrgA0ZZU7Qw7g480o+Rds8IykNwp38lkRjkMzok4N21hmAyD1P0z5ybCX6eOZ
        4bo22phCSreP4NO2XXbT/h/TqOYbC1cglN34SxjiWkIsJK/rQL5+xsR1FFvptAca8l/aOc02l3e8O
        EVnoiQxg==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZgDn-000ywn-Bb; Thu, 22 Apr 2021 20:46:58 +0000
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     "Saripalli, RK" <rsaripal@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210422171013.50207-1-rsaripal@amd.com>
 <20210422171013.50207-2-rsaripal@amd.com>
 <ee949efc-018c-8b70-3224-da4f24b217b6@infradead.org>
 <6813af1c-6a59-47ca-ce40-939512092b09@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6e755a24-1309-e75a-175c-196951f1167c@infradead.org>
Date:   Thu, 22 Apr 2021 13:46:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6813af1c-6a59-47ca-ce40-939512092b09@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 12:32 PM, Saripalli, RK wrote:
> 
> 
> On 4/22/2021 12:49 PM, Randy Dunlap wrote:
>> On 4/22/21 10:10 AM, Ramakrishna Saripalli wrote:
>>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>>
>>> ====================
>>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>  arch/x86/include/asm/msr-index.h              |  2 ++
>>>  arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
>>>  4 files changed, 27 insertions(+)
>>
>> as from v1:
> 
> Randy, could you clarify your comments please?. Is there something here I need to change/clarify/fix?
> 

Only that I had made these same comments (below)
in v1 of the patch.

https://lore.kernel.org/lkml/4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org/

>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 04545725f187..58f6bd02385b 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3940,6 +3940,11 @@
>>>  			Format: {"off"}
>>>  			Disable Hardware Transactional Memory
>>>  
>>> +	predict_store_fwd	[X86] This option controls PSF mitigation
>>
>> 	predict_store_fwd=	...
>>
> 
> OK
> 
>>> +			off - Turns on PSF mitigation.
>>> +			on  - Turns off PSF mitigation.
>>> +			default : on.
>>
>> 			default: on.
>>
> 
> OK
> 
>>> +
>>>  	preempt=	[KNL]
>>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>>  			none - Limited to cond_resched() calls

-- 
~Randy

