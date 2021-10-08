Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D0426BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhJHNjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJHNjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:39:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FCC061570;
        Fri,  8 Oct 2021 06:37:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 24so13906136oix.0;
        Fri, 08 Oct 2021 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGqNAsrJ4yxmiP62I+UHe9w7bOSsj56Sn9iJZ0IXADs=;
        b=mt8lm1w7Zt54ZvO4t312+xNTKK01NF2AifgX6owOmPRdWpgrRqnJ6vYEeYZfqXyxSM
         a1nPw7H+QbL1aGF6iq23lqF7kbJzbDHUaDDTD5zyKWIMr75zfwUx45trob2a+/x1o3jm
         CsZV4G6lFcX55mqBRS1/8SlH9pVm/nVZlCJR3V7pK4Aoa9FI3T6rAJ0VBN84Zrs3lsCr
         xVK5IkJwW1pK5nGAf3dp5Vo2TjGwaylDYz75wkGRe54Mz0xdahATnijHByXMhqzW8FYT
         21AkKd1KWio9gCTlCLEBC63wDlQsAKRYc4NnfRi9ldOe594688oev5Wrdq7sEwJDI4Gb
         MJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GGqNAsrJ4yxmiP62I+UHe9w7bOSsj56Sn9iJZ0IXADs=;
        b=g7NZ/hKrLRdbLzYWrpuco8Ff/N0wYbbodDvnNEA25LSqx/DxxtBO62+GqjflCCUEnn
         6fDuD5BAh8KZn3U5j4xF5i6Ne/FGccs8SGRWdWfwhiTvBH57R1239Cx6ldZ1cLuokbxt
         MeFAE3LPvTgAOe2gjRHZql8f6Usq+mUf95gDI1a+ixfqSypNS1ZO/bKOJjXSv8NXqYkv
         1tUPLKaVMmcBrkMobB9+o9/7CPsCkhq74H/YR+czgZdoditWORDhJB0QlH8WTnmYNcpv
         Bfpyyqs6NItYBBRtQwoPxdhlUYlZ5HqnmUAHy/pK0MEeqHekqP6CzHCd1miNl1GTP5sZ
         erDw==
X-Gm-Message-State: AOAM532vVvZvG7KPdmdgMRB15cRHM9gXJoLMUgycwBUcyLKMU6wg5lVA
        f/VNPdDc71VNMOkhOS1am0OOYsp7jR0=
X-Google-Smtp-Source: ABdhPJwbqspmk3FShJDshyYDgJFgTJ8sFCV4UMgdXZNOO8Bs34laVgO4jvQofMmHTFaPKW66JvwblQ==
X-Received: by 2002:aca:3c8a:: with SMTP id j132mr8060924oia.171.1633700244500;
        Fri, 08 Oct 2021 06:37:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x62sm621160oig.24.2021.10.08.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:37:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:37:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] hwmon: (pmbus/lm25066) Add offset coefficients
Message-ID: <20211008133722.GA894797@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-2-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:35AM -0700, Zev Weiss wrote:
> With the exception of the lm5066i, all the devices handled by this
> driver had been missing their offset ('b') coefficients for direct
> format readings.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index d209e0afc2ca..1a660c4cd19f 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -55,22 +55,27 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
>  	[lm25056] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 16296,
> +			.b = 1343,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN] = {
>  			.m = 13797,
> +			.b = -1833,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN_L] = {
>  			.m = 6726,
> +			.b = -537,
>  			.R = -2,
>  		},
>  		[PSC_POWER] = {
>  			.m = 5501,
> +			.b = -2908,
>  			.R = -3,
>  		},
>  		[PSC_POWER_L] = {
>  			.m = 26882,
> +			.b = -5646,
>  			.R = -4,
>  		},
>  		[PSC_TEMPERATURE] = {
> @@ -82,26 +87,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
>  	[lm25066] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 22070,
> +			.b = -1800,
>  			.R = -2,
>  		},
>  		[PSC_VOLTAGE_OUT] = {
>  			.m = 22070,
> +			.b = -1800,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN] = {
>  			.m = 13661,
> +			.b = -5200,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN_L] = {
>  			.m = 6852,
> +			.b = -3100,
>  			.R = -2,
>  		},
>  		[PSC_POWER] = {
>  			.m = 736,
> +			.b = -3300,
>  			.R = -2,
>  		},
>  		[PSC_POWER_L] = {
>  			.m = 369,
> +			.b = -1900,
>  			.R = -2,
>  		},
>  		[PSC_TEMPERATURE] = {
> @@ -111,26 +122,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
>  	[lm5064] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 4611,
> +			.b = -642,
>  			.R = -2,
>  		},
>  		[PSC_VOLTAGE_OUT] = {
>  			.m = 4621,
> +			.b = 423,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN] = {
>  			.m = 10742,
> +			.b = 1552,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN_L] = {
>  			.m = 5456,
> +			.b = 2118,
>  			.R = -2,
>  		},
>  		[PSC_POWER] = {
>  			.m = 1204,
> +			.b = 8524,
>  			.R = -3,
>  		},
>  		[PSC_POWER_L] = {
>  			.m = 612,
> +			.b = 11202,
>  			.R = -3,
>  		},
>  		[PSC_TEMPERATURE] = {
> @@ -140,26 +157,32 @@ static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
>  	[lm5066] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 4587,
> +			.b = -1200,
>  			.R = -2,
>  		},
>  		[PSC_VOLTAGE_OUT] = {
>  			.m = 4587,
> +			.b = -2400,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN] = {
>  			.m = 10753,
> +			.b = -1200,
>  			.R = -2,
>  		},
>  		[PSC_CURRENT_IN_L] = {
>  			.m = 5405,
> +			.b = -600,
>  			.R = -2,
>  		},
>  		[PSC_POWER] = {
>  			.m = 1204,
> +			.b = -6000,
>  			.R = -3,
>  		},
>  		[PSC_POWER_L] = {
>  			.m = 605,
> +			.b = -8000,
>  			.R = -3,
>  		},
>  		[PSC_TEMPERATURE] = {
