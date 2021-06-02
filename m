Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD913398916
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhFBMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:14:34 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F17C061574;
        Wed,  2 Jun 2021 05:12:50 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id b25so2478072oic.0;
        Wed, 02 Jun 2021 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sQVqBCY+nCuybphdr/H0J7J2p3LnFtoawKXbFeEvf2g=;
        b=QthYbQnIvv9sp41ZrQbcyklFczwPQmfOB9mW+Oy6Si6nwbZPd0Ndn8wIRnoGTRV4tq
         oYw/HsrzQpcJl5cRbMEiMk5XnGjGdwoE+HMWdOilkTM/iQFAI1lJ+Lm7aAcZLxP6xiXX
         nXdFAZIWcuIebASkVPEpbojDEnj8NiwYN/Ie7AJMAVLeksCza4QDhGDSDS6I7aAuh8i0
         t59P+edPnExbJHs/8ZHTvd+z7SsO89eZF8bz+3HoGeII2rFMTyjcDrtgfSiGcleNeDG+
         VM2YXCXd1fnTA+W9aZ2OvtjBYC+cBH8U43fg9LqX5SPVZ2iRKopjJF6DDfKmcJ31MDK8
         uXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sQVqBCY+nCuybphdr/H0J7J2p3LnFtoawKXbFeEvf2g=;
        b=D3RmZP4Ax+JmpK27NYzn44fNnc6upaUBiJu5/hfg2yumgAK0oK6+Aq4DeAgbsSdQyC
         0fNhRMvoFlYkX3/PcEavhMsz69v13QgDH2KwAZNFDsOY6Ux14ZE+fVBEkpYfVgkNXxgf
         jMzhqovf7R8B3DuC7xqP+29lb7x3b/kNPXA13eFABNDj/qbh+GrjBsu2m3Q12x17MGCQ
         DMCBlpCX8tOJqHO+BlrsNfNFq5mqus61uZFFGVliznwuFFi+Ft3lpKw0Q+0sDJUmBdoQ
         d/9ssbATKJUXdK73mqVVSh2xmnuozMPVBvGKofr5DSITDj37wvuhAR64A4/eXzh5d+g9
         q4rw==
X-Gm-Message-State: AOAM532/kS+l/n6Asvu8AzI4KhQNWKbWYMILFbRL8YSjFi7vHss7zbgG
        ZBNxXGk+d+rL8atMXYe95cAhI+hSWH4=
X-Google-Smtp-Source: ABdhPJx+5AUPy9qsuq1MnCtHczdC6+q32JnetRLOxqBltFQoVrKK20gNSWVmTQHMXsSq8CBcqz+3QQ==
X-Received: by 2002:aca:488f:: with SMTP id v137mr21184898oia.173.1622635969957;
        Wed, 02 Jun 2021 05:12:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i4sm4388675oth.38.2021.06.02.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:12:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 05:12:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] hwmon: (pmbus/pim4328) Add new pmbus flag
 NO_WRITE_PROTECT
Message-ID: <20210602121248.GB2901466@roeck-us.net>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164320.2907-2-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:43:16PM +0200, Erik Rosen wrote:
> Some PMBus chips respond with invalid data when reading the WRITE_PROTECT
> register. For such chips, this flag should be set so that the PMBus core
> driver doesn't use the WRITE_PROTECT command to determine it's behavior.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Couple of nits, otherwise, for my reference,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 9 ++++++---
>  include/linux/pmbus.h            | 9 +++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index bbd745178147..cb885efc4fba 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2226,9 +2226,12 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  	 * faults, and we should not try it. Also, in that case, writes into
>  	 * limit registers need to be disabled.
>  	 */
> -	ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
> -	if (ret > 0 && (ret & PB_WP_ANY))
> -		data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
> +	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
> +		ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
> +		if (ret > 0 && (ret & PB_WP_ANY))
> +			data->flags |= PMBUS_WRITE_PROTECTED
> +				    | PMBUS_SKIP_STATUS_CHECK;

Line length limit is now 100 columns, thus the line split above is not needed.

> +	}
>  
>  	if (data->info->pages)
>  		pmbus_clear_faults(client);
> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
> index 12cbbf305969..f720470b1bab 100644
> --- a/include/linux/pmbus.h
> +++ b/include/linux/pmbus.h
> @@ -43,6 +43,15 @@
>   */
>  #define PMBUS_NO_CAPABILITY			BIT(2)
>  
> +/*
> + * PMBUS_NO_WRITE_PROTECT
> + *
> + * Some PMBus chips respond with invalid data when reading the WRITE_PROTECT
> + * register. For such chips, this flag should be set so that the PMBus core
> + * driver doesn't use the WRITE_PROTECT command to determine it's behavior.

its

> + */
> +#define PMBUS_NO_WRITE_PROTECT			BIT(4)
> +
>  struct pmbus_platform_data {
>  	u32 flags;		/* Device specific flags */
>  
> -- 
> 2.20.1
> 
