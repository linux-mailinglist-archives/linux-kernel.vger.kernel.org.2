Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062553DC9D1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 06:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhHAE1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 00:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHAE1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 00:27:06 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F0C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 21:26:57 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 13-20020a4ae1ad0000b029024b19a4d98eso3578361ooy.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=moYJAI6IKGsvSFokzFbQjWI1AKw/0VGF4EI8VgYlBHI=;
        b=R9jMZ73rYTfklD/SvK3ERhRkt886+N2VNSJ0Im1f0Ge1i9Kx4TUPdZNIuB+QKbKM8c
         Ay1ogTjO2nw1gn222+nDVI7Sgh3KRaDnkepT7ywjvWujqV1iGsDVNX48d6jLd4z8r9TR
         TagAQJRE8Ix3Z+GO9S3E07faghWv7cRHjvzx4RpeQJwYRBn6y9l3sdMTlS0HqHrvsqM4
         S/3yn/B2OrWvj402yMnIIbXlF3wBhAnE5zdVq4aa2zxCpWoK9yv61QyYf6fsJHMxU6MY
         UdZqRrZgrPS865J4EM1PALTmEf/5dSDs74QvwyHkdPO2WnRcPb7GbZzsoirqsMEhHTqG
         spXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moYJAI6IKGsvSFokzFbQjWI1AKw/0VGF4EI8VgYlBHI=;
        b=XP4V4uMaBi3+6ZdocUqKQkdRKlz+pUjtE0B/f4MNuE1hzy22dxExzClBeCqMLKa6nD
         fzsQQg2rEPImzEZL5eskopBHUw/26+ZfsSEK3z+FD+u0C3+Rt+84qz+AmGOIPrYNk74u
         jsby1q8VvhInJLKRsUWwoLUfoPMXvEDXBYIuUkwYDu4rxteCZIGUDtae03Bu/omWIOU1
         OXK82UpduehxozXHBpzF8bNZRPin3CvN9pytt5GRdQ7urONvT8LjT5MPPY+yOoAIYpfM
         Yc9WtXycvo+I1sE+FNWfroND7HzZP9//d2viyHvmuzDMuI9+u4u4KMO9Ko4E2kqL4Lik
         yI4A==
X-Gm-Message-State: AOAM532ooblRKCTgn4b7J5N0Ru64vNMY7wzlWw2M9mja7U7yNnbsxcfY
        xuy9EhdUkGvH8vzIyVFya44=
X-Google-Smtp-Source: ABdhPJxO6rAWQegQYxqlXfjq9ExGR8l0DVPAjeGk1+qUTQv/1A0+JJevBokaULrCCb6ZhuQ3UPVYXw==
X-Received: by 2002:a4a:4fca:: with SMTP id c193mr6647541oob.33.1627792017269;
        Sat, 31 Jul 2021 21:26:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2sm1238131oti.24.2021.07.31.21.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 21:26:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 4/4] swiotlb: Free tbl memory in swiotlb_exit()
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>, will@kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        iommu@lists.linux-foundation.org,
        Claire Chang <tientzu@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210720133826.9075-1-will@kernel.org>
 <20210720133826.9075-5-will@kernel.org>
 <20210731182611.GA3792424@roeck-us.net> <YQYHDYnRegV0Xlv5@fedora>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <52cc40eb-3f6b-5abc-9130-af9216760701@roeck-us.net>
Date:   Sat, 31 Jul 2021 21:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQYHDYnRegV0Xlv5@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 7:29 PM, Konrad Rzeszutek Wilk wrote:
> On Sat, Jul 31, 2021 at 11:26:11AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Tue, Jul 20, 2021 at 02:38:26PM +0100, Will Deacon wrote:
>>> Although swiotlb_exit() frees the 'slots' metadata array referenced by
>>> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
>>> despite no longer being usable.
>>>
>>> Extend swiotlb_exit() to free the buffer pages as well as the slots
>>> array.
>>>
>>
>> This patch causes qemu pseries emulations to crash. Backtrace and bisect
>> log see below. Reverting it fixes the problem.
> 
> I am 99% sure it is fixed by this patch (which should be in linux-next
> in 5 minutes):
> 

Yes, it does.

FWIW:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> 
>>From a449ffaf9181b5a2dc705d8a06b13e0068207fd4 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Fri, 30 Jul 2021 12:42:31 +0100
> Subject: [PATCH] powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
> 
> Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> buffer pages are returned to an encrypted state prior to being freed.
> 
> Sachin reports that this leads to the following crash on a Power server:
> 
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> 
> Nick spotted that this is because set_memory_encrypted() is issuing an
> ultracall which doesn't exist for the processor, and should therefore
> be gated by mem_encrypt_active() to mirror the x86 implementation.
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
> ---
>   arch/powerpc/platforms/pseries/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
>   
>   int set_memory_encrypted(unsigned long addr, int numpages)
>   {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>   	if (!PAGE_ALIGNED(addr))
>   		return -EINVAL;
>   
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>   
>   int set_memory_decrypted(unsigned long addr, int numpages)
>   {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>   	if (!PAGE_ALIGNED(addr))
>   		return -EINVAL;
>   
> 

