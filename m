Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC0317088
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBJTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhBJTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:47:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6263C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nybHHQYTtg1oEhf6PuzoAQT63cxJ5G3IZDOvK2iUB0s=; b=Nh5oOoWF7n/vD53P54dT3UTucf
        KIEEi95QReBet1jFZgTUAnDsqiEsqIV7/zPgNa9XRCAu2X/LtaN1GiE7bhLTqkmkzQkImkvd4Htkq
        /V59UXTqQZNCzMPVmVo5iHWXiivaSeSICVpVmWraZMHgvaFMGfVpTCm5dTm2+0YpO7zwfa9sgia+n
        fCwTlYp9lUV1nshXaF7FxKxKddbxd5zkAlHvriy/2gVLgCfwPO5cstzf1PZnQun0NQ/6lnixaSK3Q
        Hha0Y7koZgFk66FCkbrVuoShBeOoiGEqTauBS4PQuSuZVvo99LaWY6CcnTPTwc9E1yMPQVT6RccV7
        cs/eUlMg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9vRn-0007ZQ-Hv; Wed, 10 Feb 2021 19:46:48 +0000
Subject: Re: [PATCH] pstore/ram : Add support for cached pages
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, ccross@android.com, anton@enomsg.org,
        keescook@chromium.org, Huang Yiwei <hyiwei@codeaurora.org>
References: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
 <d59687d7-1ca3-c822-f41d-169a9e388abb@infradead.org>
Message-ID: <895146dc-de12-8275-cd71-fdae180e6fcf@infradead.org>
Date:   Wed, 10 Feb 2021 11:46:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d59687d7-1ca3-c822-f41d-169a9e388abb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 11:40 AM, Randy Dunlap wrote:
> Hi--
> 
> On 2/10/21 6:52 AM, Mukesh Ojha wrote:
>> There could be a sceanario where we define some region
> 
>                    scenario
> 
>> in normal memory and use them store to logs which is later
>> retrieved by bootloader during warm reset.
>>
>> In this scenario, we wanted to treat this memory as normal
>> cacheable memory instead of default behaviour which
>> is an overhead. Making it cacheable could improve
>> performance.
>>
>> This commit gives control to change mem_type from Device
>> tree, and also documents the value for normal memory.
>>
>> Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>>  Documentation/admin-guide/ramoops.rst |  4 +++-
>>  fs/pstore/ram.c                       |  1 +
>>  fs/pstore/ram_core.c                  | 10 ++++++++--
>>  3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
>> index b0a1ae7..8f107d8 100644
>> --- a/Documentation/admin-guide/ramoops.rst
>> +++ b/Documentation/admin-guide/ramoops.rst
>> @@ -3,7 +3,7 @@ Ramoops oops/panic logger
>>  
>>  Sergiu Iordache <sergiu@chromium.org>
>>  
>> -Updated: 17 November 2011
>> +Updated: 10 Feb 2021
>>  
>>  Introduction
>>  ------------
>> @@ -30,6 +30,8 @@ mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
>>  depends on atomic operations. At least on ARM, pgprot_noncached causes the
>>  memory to be mapped strongly ordered, and atomic operations on strongly ordered
>>  memory are implementation defined, and won't work on many ARMs such as omaps.
>> +Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
> 
> Does "mem_type=" work?  or does it need to be "mem-type=", as below?
> I.e., do both of them work?
> 

Ah yes, as documented:

"Hyphens (dashes) and underscores are equivalent in parameter names,"

thanks.


>> +which enables full cache on it. This can improve the performance.
>>  
>>  The memory area is divided into ``record_size`` chunks (also rounded down to
>>  power of two) and each kmesg dump writes a ``record_size`` chunk of
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ca6d8a8..b262c57 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>>  		field = value;						\
>>  	}
>>  
>> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
> 
>               here^^^^^^^^^^


-- 
~Randy

