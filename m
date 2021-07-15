Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF833C9B79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhGOJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240761AbhGOJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626341100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jDol43uaBrThBboocyGhY5CKkpKp9TG07WBkyzgyCI=;
        b=Y0XaCgZJQcSRkKmTWJpt42HL0DtLGOwEkbd3GXYy6SUf/6R35vf/7RvYKVEVeG+90OPZXm
        HjK6Wd1kgqkZgqKw/iNp7ETyq/7d3sM9QWT32f6ZlXkXwCDjBfq0JguTvNN1hauv6EaHVZ
        Nk4geHlzNUFJ5zXNew0wRn2v4h69/ec=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-Ii7l4SfFOl-ZMFsYibJjjg-1; Thu, 15 Jul 2021 05:24:57 -0400
X-MC-Unique: Ii7l4SfFOl-ZMFsYibJjjg-1
Received: by mail-ed1-f72.google.com with SMTP id r23-20020aa7d5970000b02903ae404e7fb4so795278edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jDol43uaBrThBboocyGhY5CKkpKp9TG07WBkyzgyCI=;
        b=kje64tXReo6AIsHrOiS8qR92B1Z+3wohatGEB9dWgOxYztiOd+uQus/pJPefSy4X/V
         LUGedWQ9AIrjAWj+afYjrU+E43WaQBm9FMZFhKpdFbYmNHc4XLhmu1x3yLOoCH1RWNxO
         LpQIf9UdyhbZ4mfH35k8kKhZpipTbwm3xcO0J94ovtfcHoxsSucnlZDXLu8zGTp6wh5P
         p1JfO9ayhPaK9ett66MDEHSNz1RnvRm9ZR+ReUy/NHyW+v/tqiZWVNtK0DT1VeBpc+CH
         lK+ftWCjTZ65I3awwfN6ehMHfIQ+/nSADZMSTh7XQe+TdelYEwYBFgafBcCqOQXqSPPE
         xFrQ==
X-Gm-Message-State: AOAM530mRwND/euBVNy/4IhTEqluoaTW41xfo3w82jYRaOpH6gNQiouP
        19xKcfgFnV895ekD++Is8PQi10yI0yVVwRQVsrf2hssJNQE8UNWPKXYJD5qDIM0tx1mPVYdhh+m
        ZeVNmpqVNuiFExK11hEf3uB3W
X-Received: by 2002:a05:6402:1242:: with SMTP id l2mr5460943edw.97.1626341096223;
        Thu, 15 Jul 2021 02:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKmu2RI1E6WG+yViRLzAr6ZJVjzj0/Y5Mevmcq+nX/LqpIgKVJ1wQ9A9ofjL/TIUYlcGss3w==
X-Received: by 2002:a05:6402:1242:: with SMTP id l2mr5460926edw.97.1626341096095;
        Thu, 15 Jul 2021 02:24:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hq9sm1572816ejc.0.2021.07.15.02.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 02:24:55 -0700 (PDT)
Subject: Re: [PATCH -next] platform/x86: amd-pmc: Fix missing unlock on error
 in amd_pmc_send_cmd()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, mgross@linux.intel.com
References: <20210715074327.1966083-1-yangyingliang@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bf672394-1d52-d84c-3358-767b773ab305@redhat.com>
Date:   Thu, 15 Jul 2021 11:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715074327.1966083-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/21 9:43 AM, Yang Yingliang wrote:
> Add the missing unlock before return from function amd_pmc_send_cmd()
> in the error handling case.
> 
> Fixes: 95e1b60f8dc8 ("platform/x86: amd-pmc: Fix command completion code")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also apply this to the fixes branch and include it in my
upcoming v5.14 pdx86 fixes pull-req to Linus.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/amd-pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 680f94c7e075..663a4ca0580d 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -275,7 +275,7 @@ static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, bool set, u32 *data, u8 msg
>  				PMC_MSG_DELAY_MIN_US * RESPONSE_REGISTER_LOOP_MAX);
>  	if (rc) {
>  		dev_err(dev->dev, "failed to talk to SMU\n");
> -		return rc;
> +		goto out_unlock;
>  	}
>  
>  	/* Write zero to response register */
> 

