Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78833D9957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhG1XPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhG1XO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:14:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C7C061757;
        Wed, 28 Jul 2021 16:14:55 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id m11so2623544qtx.7;
        Wed, 28 Jul 2021 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ND6P2qhhxVzhXD27q/VZREJKfmBf1qojaMwKs8f07mY=;
        b=XrVW7J1cTd9w1mlMMY0ZbiDmfgJPrbRoiE5iN0tvZifsBRQoPA9by/jMhpCCik3TYr
         xa3fRxfMPqrcQ3aAepboMRM79Nu64PNMUvxFQICiSsCknyoZwRVdxbT3avV093nctP90
         RhAaT1C09DbBZ65GUtThHuhlwA3lGjMfZeracGWwuqsxx/qCyE58mlDFTQHYGgxQhISH
         KCD3fG/ZwDD5E/HUm1is++QZqhwPKao0+CbZAR1T1ErQ0ngntBoOl9SdCd1EmFWqEcPU
         bEhGWd24erECabie5RS/YrqFLs+38zxQPitLpYibuFCRWqiP9jfp4oRWvMODK1qbTc+X
         3wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ND6P2qhhxVzhXD27q/VZREJKfmBf1qojaMwKs8f07mY=;
        b=QSrsIxDMi0XLDqJn2H6LY4Lw7VqmTiNGC3vHzFiPhVF1l8bpXmtZe8cV6tPxW0lNnD
         lvrNL3UZqmf7rYKgem1Pq61TgzfHOE7Q0qJ9WShSgZEENXm2zsoUlGcPvZGURNaMsmzS
         4/uywfUboQR4OwVPNGb8WO3o3Rz6uKMlLJSt77b8mdsNJvWVHUnnOOjo4AHbso0JDrbX
         00QHtrcNJ0gv9RDdcOik+YPvIpscN92a+EPqWj4G5lxsUqRnI5/gnKfDabZdj+JQz9/U
         R+OysUcuQGfqrBpNOEq1H2CjyGqXi9Wz4WFMjsvCsJZp1w0VXs0VkNS6H/YRhGpzqElj
         d8rw==
X-Gm-Message-State: AOAM532Zh0fdIKQ7hJJMOnr218DXiflsIAwuDQGPwT3Qx+pPTA3WOpoU
        KwtwmRijEDfg1QkMhr9zJqA=
X-Google-Smtp-Source: ABdhPJyo/28Q4MOpP2UJ3HddkSLkEDjlP/piWCl1SaA7cTIgZlN/rTxKx4Pf/otDtkSxYIZR9xEbIA==
X-Received: by 2002:a05:622a:283:: with SMTP id z3mr1855229qtw.312.1627514094886;
        Wed, 28 Jul 2021 16:14:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm764298qkf.88.2021.07.28.16.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 16:14:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Fix write bits for LED control
To:     Brandon Wyman <bjwyman@gmail.com>, Joel Stanley <joel@jms.id.au>,
        openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie James <eajames@linux.ibm.com>
References: <20210728224140.3672294-1-bjwyman@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2517b3a8-6549-3ee6-76d3-6545a38cf6ea@roeck-us.net>
Date:   Wed, 28 Jul 2021 16:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728224140.3672294-1-bjwyman@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 3:41 PM, Brandon Wyman wrote:
> From: "B. J. Wyman" <bjwyman@gmail.com>
> 
> When doing a PMBus write for the LED control on the IBM Common Form
> Factor Power Supplies (ibm-cffps), the DAh command requires that bit 7
> be low and bit 6 be high in order to indicate that you are truly
> attempting to do a write.
> 
> Signed-off-by: B. J. Wyman <bjwyman@gmail.com>

Please be consistent and use "Brandon Wyman".

Guenter

> ---
>   drivers/hwmon/pmbus/ibm-cffps.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index 5668d8305b78..df712ce4b164 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -50,9 +50,9 @@
>   #define CFFPS_MFR_VAUX_FAULT			BIT(6)
>   #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
>   
> -#define CFFPS_LED_BLINK				BIT(0)
> -#define CFFPS_LED_ON				BIT(1)
> -#define CFFPS_LED_OFF				BIT(2)
> +#define CFFPS_LED_BLINK				(BIT(0) | BIT(6))
> +#define CFFPS_LED_ON				(BIT(1) | BIT(6))
> +#define CFFPS_LED_OFF				(BIT(2) | BIT(6))
>   #define CFFPS_BLINK_RATE_MS			250
>   
>   enum {
> 

