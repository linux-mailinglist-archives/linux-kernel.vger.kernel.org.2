Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DC3FA697
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhH1Pxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhH1Pxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:53:43 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F1C061756;
        Sat, 28 Aug 2021 08:52:52 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so330971oon.2;
        Sat, 28 Aug 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q+Ocg9t6n66QWfzQb63Nyh3M8znI6gaQbrcqs3sFG/4=;
        b=f4ulNnMg+aI9qV4pCNJZC7VZQtHA93fzhZVWNgpAzJ/i6sW7sRa56cCDHjpgKYtKKn
         6+k9LLk+2w1OR0VFRkZfW57W4WXvS3PPiMXTUkLPsV6etbFZhE7o1qu0uAZ7sWQDPr1R
         SyOpQ5celoypcz9BG2EE/POllienjPY1dGwjS8ugihZt0lzMB0eqJMNL5PgMNSiy59ya
         dj6HtkH4UYDWOa0URFq6c+FZCGZ4rZbHpGP3K8Cu3UMJemLF4tsrW/BXLXGPjXPteDNd
         wC2oexf4VgA8+vEm8wDEkcmQHTwE4i8xmTZ9qTThoV53njGqREodbXUdyJyezvJoWMYg
         69+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q+Ocg9t6n66QWfzQb63Nyh3M8znI6gaQbrcqs3sFG/4=;
        b=Xu9WG2wyFCaAmXZfyyDTPNCQspV87Z1B6YjlfY0oky/bTH0ZKCD8/qzxMe45dE58XD
         UApFQYwQGxXdP18EoqKI9GKj2XPnFmXFqDjPHsEn0WfMx9pez4P4bEztxHkwC48zsAK1
         N4LR0F08XQGlG7KPoepCyQYNQJ4+PIoVXs8bfssBBpaeb0nk97PXqEc297rvK1X+OC6F
         uZbYD3Wi6uuCVT0D+lpGFw3s1KtHggY1h50uOfDzNcghEkG/CXa5Y8UxsX2ReywZK9I0
         HYn+p/vg7bwYifkHLRb9YZgEx73HSNo9zQtf0AWI6vRl9UYXBcrZi0G+Z9sVgAuatWoY
         RPGA==
X-Gm-Message-State: AOAM530MTPcyDcYoW702N73/46d9lxbNCE4+7TNmvIGiGP2RHkBfXx1Q
        aXzTkPr7//cB4qeUHIRHY5KHW380Sr4=
X-Google-Smtp-Source: ABdhPJxHlYAg1s4un4jIGGBmp8Yg6VwhNOlYd1jxnpZgBIJcRkdBmH0NrUhf4L4FyoIl7rugyFsyDw==
X-Received: by 2002:a4a:ba0f:: with SMTP id b15mr3739989oop.31.1630165972124;
        Sat, 28 Aug 2021 08:52:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4sm354649otv.49.2021.08.28.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 08:52:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Aug 2021 08:52:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
Message-ID: <20210828155250.GA820265@roeck-us.net>
References: <20210827230433.3596370-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827230433.3596370-1-bjwyman@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
> The bytes for max_power_out from the ibm-cffps devices do not need to be
> swapped.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>

Eddie, can you confirm this ?

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index df712ce4b164..29b77f192c9e 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -171,7 +171,7 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>  		cmd = CFFPS_SN_CMD;
>  		break;
>  	case CFFPS_DEBUGFS_MAX_POWER_OUT:
> -		rc = i2c_smbus_read_word_swapped(psu->client,
> +		rc = i2c_smbus_read_word_data(psu->client,
>  						 CFFPS_MAX_POWER_OUT_CMD);
>  		if (rc < 0)
>  			return rc;
> -- 
> 2.25.1
> 
