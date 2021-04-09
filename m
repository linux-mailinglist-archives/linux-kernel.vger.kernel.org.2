Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ECB35A90F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 01:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhDIXIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 19:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIXIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 19:08:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA4C061762;
        Fri,  9 Apr 2021 16:08:40 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so7273273oto.2;
        Fri, 09 Apr 2021 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lpr1Vp/cOtO89rHVLcXxZ2elGZKeYl02Lj39b4gnicU=;
        b=YokWywBaf20r1JtMG0TGKj/6/R7Zo7V1Q+QHkU0M+LmEKD+2eSNWfwea76Ca9CfTqk
         wQ88K0u81uFHxsVgVjfx2K15ob2f3JCANESyhjhgPpOZzIqHJwdIFyTAEZdKo+aglbQ0
         mLx4CY5D0WwDSCvkp6tKsw4mZlePvgYGBbh/CvZgIL+IKkYGvj8m2V7YJpDrnjx/R2yK
         y3vCscP3sZm48xrP7IpKBchcY8j43N2/gXWlkI5Jd2DCcJNnNOnPlGP/BF45AVz4c/tl
         MDiV+EE4mFCuJsqvCctk67i+Gkf9zHgfRE4OHbD4tSMDwKbmZ1S/x84g0jUOUad0ekmU
         nyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lpr1Vp/cOtO89rHVLcXxZ2elGZKeYl02Lj39b4gnicU=;
        b=LQvJZohjTqpJ8UWH6G6Qo2WgZomwnpBVZUNzO067x9MkuwckM3gYwRERF6wq9A0YMo
         n/9Eeo7R3DFHIrqaEVSJas0RmDa8pQL7RXeKZDllcqroxu4r+q3loDI7GS2LE5mcS4OT
         xdBaY3VaOLOA+k/3CIdOipJ++CQhhQA8PMT1zRk4WeMO2TSKVUSfzcN27H5FcWXFRBIx
         2Cc8J9E1qRNMm6kbyxEHg83fceU60IM/8g36DEmhJDIDXskpll0QpMahRZ7zXk59oyEG
         zAajYvq98M5273oba+2z7CH5MUKVrqKSZ9m6Cqh9YtgxkmUc6xpRbVit07nf30d1I4Ej
         hZ5A==
X-Gm-Message-State: AOAM53089bLwGpv5vYwkMkIX+Nvy3kaMQedowwqNrcNkECMnKUpt8wxm
        D8RLTXtyPqi52UrFFV/1gbNPRioLaHc=
X-Google-Smtp-Source: ABdhPJzKMvsE4AME1eu0c8egA9ucA8RkdHrtaWfOCcvFYa7lBlOp/TkbPHExyqCCijtDC9lH8c24wA==
X-Received: by 2002:a9d:4509:: with SMTP id w9mr14076784ote.111.1618009720035;
        Fri, 09 Apr 2021 16:08:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2sm781554oos.16.2021.04.09.16.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Apr 2021 16:08:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Apr 2021 16:08:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Juerg Haefliger <juergh@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "Mark M . Hoffman" <mhoffman@lightlink.com>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  hwmon: (dme1737): Add missing null check on return from
 platform_get_resource
Message-ID: <20210409230837.GA69920@roeck-us.net>
References: <20210406185458.433826-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406185458.433826-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:54:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to platform_get_resource can potentially return a NULL pointer
> on failure, so add this check and return -EINVAL if it fails.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: e95c237d78c0 ("hwmon: (dme1737) Add sch311x support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Not really sure what to do with this; it is a false positive.
The resource is always set by the instantiating code (in the same
driver). Adding an error check just to make coverity happy seems
like a waste. Maybe we should introduce the equivalent of
devm_ioremap_resource() for IORESOURCE_IO.

Guenter

> ---
>  drivers/hwmon/dme1737.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> index c1e4cfb40c3d..a2157872e126 100644
> --- a/drivers/hwmon/dme1737.c
> +++ b/drivers/hwmon/dme1737.c
> @@ -2633,6 +2633,8 @@ static int dme1737_isa_probe(struct platform_device *pdev)
>  	int err;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!res)
> +		return -EINVAL;
>  	if (!devm_request_region(dev, res->start, DME1737_EXTENT, "dme1737")) {
>  		dev_err(dev, "Failed to request region 0x%04x-0x%04x.\n",
>  			(unsigned short)res->start,
