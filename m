Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC76342392
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCSRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:43:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:43:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s2so7360093qtx.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iWTtZbypaf/PF2oQYz1A8g+KNh4Q43Kmkq97Z+9FFUk=;
        b=RZ8KV58bU6hT5xo1d8j69eB+xYu9PwsR1DUzm4JnjujlbFPkxX19l+TrXPhFoENqI9
         UekvOvessVkWGvQzjwXdRZo/Xtz+Pd2X6yr/faMZrkpS1kgw3YFLV8BUBlfxl+yqTOyl
         nIDNs4K0qzG4VawE/gPrVmbPq35/269R7x0foWrqOS+u8/r1+5eMEl8eJ9mpI3rYNlCX
         x98lwBlwszN78buHwV+wrxFvSjXQQeIuk/m9Kvr5IB9g8shrutwn8M3Yh9V7HjnaT1qO
         0FwnRVnPEvTrg26od1exkj5aIc0H/v0NJ5djK6caq1hRRQBxRc4dQdmGtQfAVfovcjct
         DNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWTtZbypaf/PF2oQYz1A8g+KNh4Q43Kmkq97Z+9FFUk=;
        b=PBGH8k0kXQiYiVeywi6nFBD8HrpBzSDb/m90tpAY2glYaETfRqnJrnAxZecFoOQcG/
         wZnzqc0vS4R/sDJLjy9Sm6sdv+AtQ4yeH5GvrvelDPzQiTJINvNr10rmqKG5JPB8jGjw
         xQZ+I5A1PkZbaCKtwp21BpQHAErAnb+bIZ2tuif22EwLW4frdYSR1nRL8p9fnsUVHUQb
         jNFFtdPhmzr9ZP/FFRO7yW2wwiN2Xrni5aZdaSIfdkt721NQ4wpGREYlAEIt16SxiZ50
         jAzPCfUzkR85muR57BLLuUcJQPIs1s2hOW6sN1U3QGPcEhGJ709wDQknvZadvxrSJ0M+
         Igiw==
X-Gm-Message-State: AOAM530+BFVZGTUeD1QRo8sh2QiZPYG0vlaS8nNHI36ltOhSGOFwhwyH
        0AErHaKk0fLvc30cdt686nY=
X-Google-Smtp-Source: ABdhPJzsKP4zRyN3mmwQMyhxZcSpQe+K/iD/QF4iLyw7BrQBsrz5LJu85mN8QYNj7cytu/OQKAJc6Q==
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr9582644qti.329.1616175808072;
        Fri, 19 Mar 2021 10:43:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:dfe0:49f0:4c4a:ea4e:c31a:9352? ([2600:1700:dfe0:49f0:4c4a:ea4e:c31a:9352])
        by smtp.gmail.com with ESMTPSA id p5sm5151652qkj.35.2021.03.19.10.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:43:27 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d4308ead-d561-19f6-510c-45e61613de54@gmail.com>
Date:   Fri, 19 Mar 2021 10:43:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319130731.GB2624@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2021 6:07 AM, Christoph Hellwig wrote:
> On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
>>  #ifdef CONFIG_ARM_LPAE
>> +	if (swiotlb_force == SWIOTLB_FORCE ||
>> +	    max_pfn > arm_dma_pfn_limit)
> 
> Does arm_dma_pfn_limit do the right thing even with the weirdest
> remapping ranges?  Maybe a commen here would be useful.

It gets assigned to either 0xffffffff or PHYS_OFFSET + arm_dma_zone_size
- 1 which is obtained from the machine descriptor, so I expect it to do
the right thing, it works for a Pi 4 in 32-bit mode for instance. This
is conditional upon enabling CONFIG_ZONE_DMA for ARM, and will otherwise
keep its original value of 0, so this should be safe AFAICT.

> 
>> +		swiotlb_init(1);
>> +	else
>> +		swiotlb_force = SWIOTLB_NO_FORCE;
> 
> Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
> and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
> That kind makes more sense than forcing the callers to do it.
> 
> While we're at it, I think swiotlb_force should probably be renamed to
> swiotlb_mode or somethng like that.
Agreed.
-- 
Florian
