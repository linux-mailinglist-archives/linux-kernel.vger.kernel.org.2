Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F18426BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJHNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:48:17 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10CC061570;
        Fri,  8 Oct 2021 06:46:20 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso2942095oom.4;
        Fri, 08 Oct 2021 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ScYT0P7tH1iM6DzLvWFrRk8ZzpflLzTKROgrb+A1KAU=;
        b=ZfvWYWpzAMzlZoSzBi1v2hfJmvYl1m3b2KCE5vwI/wQzNMKp4OD6QQ9sMGHPFL5Y2N
         x9P+mkZdUv75HWRAmoL0Ago71YGbqvFWZNohmZuUcm8j8WyzM9WjQ+QlH56cmAO8LWl8
         bXX9m59ZMdInysyVTndfIz6DAzfI1vrcEBwzVQAiCu2JdfCbQUoxGVYDpO7yYG8iOR9x
         gOqSLaKAOItrAQP0I3QarUfgUBn8pdt5CG3s2IZr73+MAyo+pkbwmbeW+bV/UlZ6K+OD
         hQ+tNsvJUacsoTnfDa03UlNrtTosCcbiAkvlli2+X8ohPX6lUjL2t6cgpR0q7ZUe+gqB
         E+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ScYT0P7tH1iM6DzLvWFrRk8ZzpflLzTKROgrb+A1KAU=;
        b=ukZdq5sor8tMf41HTpBtFUZvnR4eL/wUL/PILnD0vv756OAZpcx/3zi2Ck+fX2I57o
         XsFhpHGlENC9CGAmLlc2UVHPYazYb+TEQx2RyCvtNFMopWxG90eCSgD1U9wkCzTtqYG5
         uyiMKyLJ5Y+QqPXyQBROPkmvyizeo6mrk3tQYGfmUkewTCj/TdQgM0kJz0GmQ/fqbfiO
         9VDkQabgovxzOOkGPSquF4dgI2Cmp4eXeIsyVgmYQ4uml0fmoEDxUF9w5x6zRFGqxa+3
         pdZWy3KMRR8Nh3WU+nS3Y8T+qwr21pYGMvlYN6WvcVRjIQGZmDRswveXuq48UxDQK2jI
         fULw==
X-Gm-Message-State: AOAM532mPVB4rxxXnn2B7h41rNoXCffKke8dHHWB5jNYH9AvCTQGQzfi
        ug6VoKcT6pwJ9G067jl2Vpt7l+DYvj8=
X-Google-Smtp-Source: ABdhPJwc71MmX4WeKpI8WRR4aotxE0VRvMHAEEr3kjqJJDkpW5T2Nd9SjgEY54cBwMziCMxPBjX0SA==
X-Received: by 2002:a4a:c292:: with SMTP id b18mr7946988ooq.64.1633700780326;
        Fri, 08 Oct 2021 06:46:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm492731ooh.40.2021.10.08.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:46:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:46:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] hwmon: (pmbus/lm25066) Adjust lm25066
 PSC_CURRENT_IN_L mantissa
Message-ID: <20211008134618.GA1190700@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-3-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:36AM -0700, Zev Weiss wrote:
> At least as of Revision J, the datasheet has a slightly different
> value than what we'd had in the driver.
> 
Indeeed, it does.

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 1a660c4cd19f..3616705aafde 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -101,7 +101,7 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN_L] = {
> -			.m = 6852,
> +			.m = 6854,
>  			.b = -3100,
>  			.R = -2,
>  		},
