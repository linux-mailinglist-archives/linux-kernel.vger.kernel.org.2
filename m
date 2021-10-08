Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0668426BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJHNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJHNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:51:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA53C061570;
        Fri,  8 Oct 2021 06:49:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y207so10680114oia.11;
        Fri, 08 Oct 2021 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DodGuuiKsswP26uTSBYr2Axn6J56njIFPTunvh7sxfs=;
        b=VjuGOXkHp7fzjVdwu/vrneJe1yX8UwB4VzeTyQuQ3GdqkCHjBxYrSrnyPQUBABBcw1
         H0iuzyC7qNpKHFfmRmpNy9TBDjo88n+uFPw/DhlDElZBdOFcxp8lSPoVi1r7wiqbhsm6
         TiRfHHFvv/c4nQ2QSERvr/UubtRv8Ku+NnMZ78UL4nH1uJRDBTsSM0GFj4afiQVA8HUt
         q9RroF9amdoUgO2kqYSYsKsEpxG0nzGwBkUWk3rLIk+pVJA7MKepmMZ/0ELOPK9evlHh
         MrFXwFvjr7dfN9VTb2ho5OmSAzzXQd8PZ8CmzyVQHRA8bKhMZxs0iMb7yjdyntpxVLyK
         ZEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DodGuuiKsswP26uTSBYr2Axn6J56njIFPTunvh7sxfs=;
        b=HHtcU8TElebgUsPucBtuF5QRqn9B2rmSTV/35mr6+IdPTg4onnxUvM1OukDlAcBiav
         Jt16mCFGETSTehFzwTtHITTXYFljmFs0vu0FyCTtfgTkHlfzI5UU6Mn4vrUESudgUERQ
         ZHpFZlMIOHQeyeVt1Ntp1bRta4g20b4C2v9xu+YlGWwBUXbjgmjcKH+KgwPFdLToNh/5
         jK3hNUhTFgKZnVUBVLWO6vi8XRNPzWCOeRp7+6mtAcldr95aaBWtdrpKw+LuaaoW6wLP
         5i+AyFmWz47J9LERwObneG9bHfC+wTcwvwVyrg2LtTzzfWjk6jLkr6gIzutJT5ON5FYo
         /oGg==
X-Gm-Message-State: AOAM532hInjAWJyznL+niEIBDX0KVTQlC7UpBSNgEyPGI4Gh8YSQq4Ey
        +0IhAHPZxKt6b8UYsaCKOYI=
X-Google-Smtp-Source: ABdhPJxWWsmM4x5vDQBdHjQsGG6kXYItrUCIi4x4HMsS1c5f9WDrHeOgSrBtmAjybO8JXmQY4Pn7fQ==
X-Received: by 2002:aca:b882:: with SMTP id i124mr17591433oif.166.1633700999115;
        Fri, 08 Oct 2021 06:49:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8sm494961ooc.21.2021.10.08.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:49:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:49:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] hwmon: (pmbus/lm25066) Mark lm25066_coeff array const
Message-ID: <20211008134957.GA1289551@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-6-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-6-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:39AM -0700, Zev Weiss wrote:

Commit description goes here.

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied. 

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index 1ff5407b6977..dbbf8571c437 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -51,7 +51,7 @@ struct __coeff {
>  #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
>  #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
>  
> -static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
> +static const struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
>  	[lm25056] = {
>  		[PSC_VOLTAGE_IN] = {
>  			.m = 16296,
> @@ -449,7 +449,7 @@ static int lm25066_probe(struct i2c_client *client)
>  	int config;
>  	struct lm25066_data *data;
>  	struct pmbus_driver_info *info;
> -	struct __coeff *coeff;
> +	const struct __coeff *coeff;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
