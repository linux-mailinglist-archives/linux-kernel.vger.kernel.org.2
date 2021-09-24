Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7EB416939
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbhIXBHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:07:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD3C061574;
        Thu, 23 Sep 2021 18:06:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u22so12298194oie.5;
        Thu, 23 Sep 2021 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ArpQncnpQmSaNPsbvlT3rEkygRJSB+QsZ3dkPtwwBe0=;
        b=l+T916tq9xQJB1u3pK0jVjmfnXOhPhvuzGNUTDtKTHwjA6ySKT+1StK1eCjmhvFtOe
         LWDA8cuobfhzOuoBi7FKPc4+76w9poAX0MhV4Fueq9s77sZgGVk5Bpoc5wRxxj8PGiZC
         RwVeHludygeeX8h1X5UPloDg5Rzmus7SInQQLTz/fQtiGdTvf3SNxGL74jVW6zwXzVCQ
         XmzYKsTX8aStPGN1/OS7IuGysIQNTowl9bhKOb1MGgY4NX8ZkSZyDzc8uzH0HHUfSBCc
         ab4V/CFjkiPkvpCuwu7zY3ti2MkILVX45jXce4c5JEL7SS2W2aKCWD3rKUZuyEjZMYKs
         AavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ArpQncnpQmSaNPsbvlT3rEkygRJSB+QsZ3dkPtwwBe0=;
        b=uuxTvGvE3BAER1O7y6xwG2ZG9jzv+hcQtI33Qp7NTVVMQSVRVSMejZ/PQWqFNjDLvo
         uFKPlFeoJaS8UvKTKW30q7yrHeXEinD9oEFIRwokdRg2QCUKmbaDoDsOfk0Go8DQhLl5
         9wtOzHVUAKJOmAAxTgTBOhkmrS7pI98f8Z2Je4tD3sO+8NbGXvyJ8mdNWG8Eekmisn4P
         MwU6otq255OIe2YKYfSmaYUas9JdpAdxprVJKb68tzb085rT7JZOMTUJtr264PjSlMpj
         mBhxyEPJwrJhta8MArKAIT5TC4cHxSqdk4ZEV47Vo3jz11RVFMDbWEJVXrk2zjS3/EqA
         Oi2Q==
X-Gm-Message-State: AOAM531R7xt6xeL7Debo+G+aem4n7jdEEseXqtmOiMGrJ1LSim3AUJy7
        6aULWBQhyLfQNR4XRSq2g5A=
X-Google-Smtp-Source: ABdhPJzGDid0sKGbfIBrtk3UGtAEmAdTGjUMbRnzidj0RpdRfT61NKAidIg//pXt0Je0+1zTi84QVg==
X-Received: by 2002:aca:645:: with SMTP id 66mr6054976oig.145.1632445566502;
        Thu, 23 Sep 2021 18:06:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 37sm667324oti.7.2021.09.23.18.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:06:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:06:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: (mlxreg-fan): Fix out of bounds read on
 array fan->pwm
Message-ID: <20210924010604.GA3029410@roeck-us.net>
References: <20210920180921.16246-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920180921.16246-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:09:21PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Array fan->pwm[] is MLXREG_FAN_MAX_PWM elements in size, however the
> for-loop has a off-by-one error causing index i to be out of range
> causing an out of bounds read on the array. Fix this by replacing
> the <= operator with < in the for-loop.
> 
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: 35edbaab3bbf ("hwmon: (mlxreg-fan) Extend driver to support multiply cooling devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/mlxreg-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
> index 35228ed112d7..feab9ec6a6ca 100644
> --- a/drivers/hwmon/mlxreg-fan.c
> +++ b/drivers/hwmon/mlxreg-fan.c
> @@ -554,7 +554,7 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
>  {
>  	int i, j;
>  
> -	for (i = 0; i <= MLXREG_FAN_MAX_PWM; i++) {
> +	for (i = 0; i < MLXREG_FAN_MAX_PWM; i++) {
>  		struct mlxreg_fan_pwm *pwm = &fan->pwm[i];
>  
>  		if (!pwm->connected)
