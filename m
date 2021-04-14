Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6535F5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbhDNOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhDNOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:12:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC07C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so6078620pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vp40JX7MD1oyRAb9Y8UvaxNthRrEWLT17bpKIw89Vp8=;
        b=hgK+6erZ/ZaIIki51J5aG86ePrPsolHe2qeKZ3mg0eC79G+Ei/Bl8NcW1/owX7Xdvd
         rmz970jRX+yXh0X9NH6qR54n+i8aLCInwqGmBYXVE5Pz/41ZSjaa2XardvhUTDY0Cs8p
         Yb8qSrX8YZkIaX1LZOMsIyyp2AANwpQbaD0TPaGWdD1+oDzIhG4EZDWR4UpDRE/xVuCQ
         N8pnfMt21Jt8oaHjNOazLwIuBchS7NTnnWhbxgVR/eiJnPPzM4uD+eQIsTwsTcftdTN2
         PLFnQlYAW0zxbCBAw867haMamI/S87JyMzhiPrlCaEk/1uzEh5rdFQu8pm1apetFdwCW
         YVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vp40JX7MD1oyRAb9Y8UvaxNthRrEWLT17bpKIw89Vp8=;
        b=TLZXC8A6INzg38mC/Urt3hBBiuxDO4jVZ+kq0gHptM9iW3aDyP/vZ9AJOnxX7D+40P
         0/93FbzG+hHH47G5qYAJLvB8/45AvzMYxyk48k+lHyArerwhWd9PScuDRuCn/rowkDww
         mN22eOCSK8e0GEX+GigTNcfda1aEAm8CWjwNxlZmJx//eMdzeinmDYSzc92/JSQ0vZDj
         Vxrb7VetXwEtvnWNl+8OaTR1/FEyGuUdjvgAiDbceEx6bJ5CaicefPzNlWVkkVtQ9G5o
         8t/ojBhH4yPWS3W4smmCm07Do9cxBR+CL2/0gPDxH1dEItugLSv9Lq5SlsNJ+LdT6biw
         qHXw==
X-Gm-Message-State: AOAM530XwNlYYNa+l1bfDZTAw9OBZpUyV+7604awjqcZu/2h+VGlQRbv
        ToqE5vddSTKh1VggAjPrZRA=
X-Google-Smtp-Source: ABdhPJza5jUB4sMZoDE0tC09q1IDVXc3SViDZwxG00IgG6HA9/9/9np52gjLQ2051sKXN15McHj8Hw==
X-Received: by 2002:a17:90a:ee95:: with SMTP id i21mr4068778pjz.160.1618409536393;
        Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id i18sm6579059pfq.168.2021.04.14.07.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 9/12] swiotlb: Add bounce buffer remap address
 setting function
To:     Christoph Hellwig <hch@lst.de>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-10-ltykernel@gmail.com>
 <20210414064358.GA25877@lst.de>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <963fc95f-915e-99a2-aa5c-63ae8e2c6591@gmail.com>
Date:   Wed, 14 Apr 2021 22:12:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414064358.GA25877@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2021 2:43 PM, Christoph Hellwig wrote:
> On Tue, Apr 13, 2021 at 11:22:14AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
>> needs to be accessed via extra address space(e.g address above bit39).
>> Hyper-V code may remap extra address space outside of swiotlb. swiotlb_bounce()
>> needs to use remap virtual address to copy data from/to bounce buffer. Add
>> new interface swiotlb_set_bounce_remap() to do that.
> 
> I have no way to review what this actually doing when you only Cc me
> on a single patch.  Please make sure everyone is Cced on the whole
> series to enable proper review.
> 

Sure. I will resend all patches. Thanks for reminder.
