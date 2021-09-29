Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4B41C9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbhI2QKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbhI2QJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:09:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69955C061760
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:02:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12so2031525pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RhEwLjH+6DRijdIR2kBqHdJMqJ5dxHer2ZAdAneqDLE=;
        b=NNrLehk8yXWKKBKC0MGdRutYWv0rsiTlAgbOWdVCpZIYmkQeVATvxvJkrkNuvvaSyJ
         yvnw3mhl0Gxnzj2otpnT32PHm82/a4yv/Jq9XmbafGTJ0z9pnvXddzaEjTDjq0OmLxEl
         yGoJsbtQrRe/UPtVD3dRM1znAb/wUpMoPkyYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RhEwLjH+6DRijdIR2kBqHdJMqJ5dxHer2ZAdAneqDLE=;
        b=73BYL4WNC2oF5ZhSrgWF87Em4a+Fnp3Qe6tVaf9it1pscVcgal7p1hTPrY9RG5rcwS
         LpRv/AqBq3iC3H4qDjTj3twF4E1cQrSWV9NIouny0SQe6votGAKjr3TKBSK5u88IdtXp
         AVTl43mOvKLOPEYJbq1D/GHzgn1/5Jun29YbQGZFIwyB3o/e8cBLAfOGmB2y0ExUNuTp
         qxDYYZdV3XsOXU/HeFZKbJDGrfcvjS+PL+SZ2a0gyzubme0hJzcstMZt+luypeh4OGP0
         GnGm0po0guiziDpJf6FNTqo2Ao7ICdY3RS9kYFKOpgideNvnj7FqJVgypZGm9qlZUWzB
         KLfg==
X-Gm-Message-State: AOAM530Jz36CZCh1Jhj7IMU8REe9RS3stc9ZXgwRWdpyFHF14umBXEA1
        J3dppd7+Wzl9P3Jqezml35Y/53tBJXnOKQ==
X-Google-Smtp-Source: ABdhPJzew4QuANxmpydMCxV6T94iiHJfwBVIuQULQh4d6RwMP5f339xaKlk3T5PsN9gjIql0vDI+LA==
X-Received: by 2002:a17:903:2451:b0:13b:9694:4ea3 with SMTP id l17-20020a170903245100b0013b96944ea3mr670463pls.74.1632931339985;
        Wed, 29 Sep 2021 09:02:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2f10:2763:4825:1f01])
        by smtp.gmail.com with UTF8SMTPSA id e9sm181547pjl.41.2021.09.29.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:02:19 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:02:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] power: supply: core: Move psy_has_property() to fix build
Message-ID: <YVSOCZZiSjMX5Ul7@google.com>
References: <7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:00:19PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_THERMAL=n:
> 
>     drivers/power/supply/power_supply_core.c: In function ‘__power_supply_register’:
>     drivers/power/supply/power_supply_core.c:1137:6: error: implicit declaration of function ‘psy_has_property’ [-Werror=implicit-function-declaration]
>      1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> 	  |      ^~~~~~~~~~~~~~~~
> 
> Fix this by moving psy_has_property() outside the section protected by
> CONFIG_THERMAL.
> 
> Fixes: 9ba533eb99bb2acf ("power: supply: core: Add psy_has_property()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 75575ea45f21ddc7..fc12a4f407f431a6 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
>  
> +static bool psy_has_property(const struct power_supply_desc *psy_desc,
> +			     enum power_supply_property psp)
> +{
> +	bool found = false;
> +	int i;
> +
> +	for (i = 0; i < psy_desc->num_properties; i++) {
> +		if (psy_desc->properties[i] == psp) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
>  #ifdef CONFIG_THERMAL
>  static int power_supply_read_temp(struct thermal_zone_device *tzd,
>  		int *temp)
> @@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
>  	.get_temp = power_supply_read_temp,
>  };
>  
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> -{
> -	bool found = false;
> -	int i;
> -
> -	for (i = 0; i < psy_desc->num_properties; i++) {
> -		if (psy_desc->properties[i] == psp) {
> -			found = true;
> -			break;
> -		}
> -	}
> -
> -	return found;
> -}
> -
>  static int psy_register_thermal(struct power_supply *psy)
>  {
>  	int ret;

Thanks for the fix!

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
