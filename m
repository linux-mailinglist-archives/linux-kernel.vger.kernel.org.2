Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED533306F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhCIU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhCIU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:59:18 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A67C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:59:18 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g9so13469766ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hIzrQXT4h4W7AAe4jB29ri4tAfpUHw+wk/thHCyaZW8=;
        b=0PynGrDnEoidiWaGP32JQlA4a5VjaKkR4KQKhqeG77Fqs8yD8G7u99UoKt8GalCtyr
         TqL7WMhubuDC6guqo+zx+QQiRXrUy3UoQoZq6GnxoFv+CzUb3C7wCX8sySwmDY9bEn0I
         TL7sY5nhJo6IbgDzvcPo3qHI/ZxMgful41e/1caGki+V6vmEJuVIrxDV7wu5ZzAnAFU6
         j3xDxnAVozU8PD/meTNgkQQFmLFT7NkjPD/++eCvA08Wb0YlR080pVb466SYQTCXDEIY
         YP/1wX9/CVb3+DFxWBIOy6jI2gWuB7zfUr+as+/UcomSiYO/KQFqN3c0LR6uB4u/0x+H
         WBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hIzrQXT4h4W7AAe4jB29ri4tAfpUHw+wk/thHCyaZW8=;
        b=CbPjywVDe3NLnTBlTDTNQ4rucWaE3PEqUQXOOSJsOqTPtRJi+Z/5hqh4Z55UO9xT0j
         O3Zy+VkHOHcXTGUYO3daMkUv+gZgeVLSJaz2Kcf7uuDPDwaWbsuzFFrryBsgqNxoPmCN
         njRdkNtgW8YRwPeG/DIh0XCWWzJ0+Ynif9MjS8Fnd/P2XrcTsYvGmsBzUWx0+o9YVmyr
         G9rPBRhKKvWiiJQuNra3FqhCK6YJIOlvxZElbzhLBCBmRePg7bWOHG/t8uyb/cDisPez
         T9k4Lixq6Ry3jRkHpZcIscd+TKwgrzjFgVwX09B0s/Tf44nA/tdtSHBYWGSJIZz44BGZ
         +zFQ==
X-Gm-Message-State: AOAM5317JDp3Vas8xqBpCilLZAreUGMiTYnFpVFu3CoEjarIan0e32Ur
        Si5vM4Ju6HHo0liWtcOVdy1pME7ZCy1cFQ==
X-Google-Smtp-Source: ABdhPJx6YWGVJo0YZArjr64qms/FJr2bXrrXCNjG3kmjLDReMWKK0JV3kBMtCHPy/70KnggJjKw+AA==
X-Received: by 2002:a92:b003:: with SMTP id x3mr43220ilh.15.1615323557300;
        Tue, 09 Mar 2021 12:59:17 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i8sm7865845ilv.57.2021.03.09.12.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:59:16 -0800 (PST)
Subject: Re: [PATCH] block: rsxx: fix error return code of rsxx_pci_probe()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210308100554.10375-1-baijiaju1990@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf2dd66c-0e1e-944e-f4c5-542095f6c9d7@kernel.dk>
Date:   Tue, 9 Mar 2021 13:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308100554.10375-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 3:05 AM, Jia-Ju Bai wrote:
> Some error handling segments of rsxx_pci_probe() do not return error code, 
> so add error code for these segments.
> 
> Fixes: 8722ff8cdbfa ("block: IBM RamSan 70/80 device driver")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/block/rsxx/core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
> index 63f549889f87..6b3b9b31a3e8 100644
> --- a/drivers/block/rsxx/core.c
> +++ b/drivers/block/rsxx/core.c
> @@ -760,13 +760,17 @@ static int rsxx_pci_probe(struct pci_dev *dev,
>  	pci_set_drvdata(dev, card);
>  
>  	st = ida_alloc(&rsxx_disk_ida, GFP_KERNEL);
> -	if (st < 0)
> +	if (st < 0) {
> +		st = -ENOMEM;
>  		goto failed_ida_get;
> +	}
>  	card->disk_id = st;
>  
>  	st = pci_enable_device(dev);
> -	if (st)
> +	if (st) {
> +		st = -EIO;
>  		goto failed_enable;
> +	}
>  
>  	pci_set_master(dev);

Maybe there are some valid parts to the patch, but the two above at
least make no sense - we're returning the error here as passed from
ida_alloc or pci_enable_device, why are you overriding them?

-- 
Jens Axboe

