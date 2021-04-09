Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5937F3592BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhDIDN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhDIDN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:13:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4CC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:13:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s11so3306958pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+DOjZGX/u6rbr2K2XlXD1oEUmYKSnesPXX/ShoCtN0M=;
        b=NvIL21zOmeCCpYpUvhPnREkyrOsjc6hDE4wd7oEcgjEBnUjKXFuKhCvH3956iRzqDa
         6jfYI7Ci7hhvI/TgSk3LDPqIO/ScZGcG1XJZrL3k24KXr8tihXsqm7PnHQZAceEXGvj/
         ItQkL5tzl22HoBJu78izANiE0gu53bIOXuGSI0JSnU19pxMvnxhpMCTWMzI9co/PkbJ2
         ohvt6wDatg/Py7H8bjjKeks9OEcVkw7pXd8wQIQ+PO1rRRFyR5o6zWPLOaefjZtrF4q6
         DulaFT+yP3NRTKYNEEtWeQ6JkUd7ZhTOe3fQGxMp1uVO1z2svZ16gCVwIoJeL7yXFQZR
         RfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+DOjZGX/u6rbr2K2XlXD1oEUmYKSnesPXX/ShoCtN0M=;
        b=ozonc6beiIkOz0mgbVTx2bSSyYBo2Src/CYBGXo87/Aa3dhQFugZ3z+1BekE9qCj7z
         ezBQM9bpfjICN2k/Wu88JZfwxOTqfkiqPmh9hxSA8c6jRc6VjMK+Z+J5iuhsJ5XNYl51
         d6FpqsUk7aIPiKbeo7I6CAW9wA0lcW3qeJVLw7EUskhgZZ5wQxIqo1tV1awN61HmbLcq
         YliDEEM9bdpjf/9vTapK85mI5PMM0ya5dZqiyOn1z8rbnPRtynxZVe1+eNaKH4WEtRyP
         ynCVcReCySsjwa+W7zidsW6jy9vnp9/5oLEkMlFsyr6THt9EHX35yFkd2S/InzBx5NJu
         bEVw==
X-Gm-Message-State: AOAM533chJFYnudBlcGYKAxSNMSiRHtc+hRw9j/s19pH5c9MH1EbCtwa
        tJZri6lOO8NfkVBFgwYubro=
X-Google-Smtp-Source: ABdhPJxRQVtg0/bwI9ZbPf1bAEwjzRMn66tsTWxNgC1iYvkUTAX9QtsvwyheLFsjw+xAuuDvJoMXNg==
X-Received: by 2002:aa7:800c:0:b029:22d:3f81:553 with SMTP id j12-20020aa7800c0000b029022d3f810553mr10333434pfi.41.1617937990429;
        Thu, 08 Apr 2021 20:13:10 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b17sm664893pfv.187.2021.04.08.20.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 20:13:09 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
To:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
 <20210323015350.399493-1-f.fainelli@gmail.com> <20210324084250.GA4474@lst.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
Date:   Thu, 8 Apr 2021 20:13:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210324084250.GA4474@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2021 1:42 AM, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
>> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
>> default_nslabs to occur since we are not going to use those slabs. If a
>> platform was somehow setting swiotlb_no_force and a later call to
>> swiotlb_init() was to be made we would still be proceeding with
>> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
>> was set on the kernel command line we would have only allocated 2KB.
>>
>> This would be inconsistent and the point of initializing default_nslabs
>> to 1, was intended to allocate the minimum amount of memory possible, so
>> simply remove that minimal allocation period.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks! Konrad, can you apply this patch to your for-linus-5.13 branch
if you are also happy with it?
-- 
Florian
