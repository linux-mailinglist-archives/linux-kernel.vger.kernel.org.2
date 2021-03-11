Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A48D337FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCKVvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCKVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:50:57 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5EC061574;
        Thu, 11 Mar 2021 13:50:57 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id r24so2555967otq.13;
        Thu, 11 Mar 2021 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RghmcBEWWaLa3LYEb5KeXgAu7tLFH8qmbtPks5jMJnM=;
        b=uw0tPyq9JKT4k4vPqANK4T8kGZQisKH51l4zEcL5z7+dnCzqdDm0M1UogB/7xDw9Ep
         nr2YeKWBFxS0RaiTxZJ/dNIpv7l+aLK8t779g50An3fQwD6n+j+FPMR89IoheBolifbh
         ZJQ57bfv4tgxXVX1AI7YrfZmk6UyoFcKZdfgFIhK88rBgJ1TEWStBpbxEWRiaynBTtEe
         HLW1bwElhdAW95yAYpa4nl8UepTpNevDTp4e+U+1KUUCh4NZdfW6LBatBeweVD4612rc
         CE5qcYsIKTMuTkWh1xpcsKrNm6y5EYboh7pOz6ZxUNMPhUd5vRp9xcHi2dLMf0L+cd+b
         +F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RghmcBEWWaLa3LYEb5KeXgAu7tLFH8qmbtPks5jMJnM=;
        b=ZXpUlELTdj2y56lEbqH/zDQCtEzaAESCtGRS5nB4cFTbOIqZGWGm6Sekt5obAOZSkw
         CYQaqibbz47D10GHHgIp7vUxFxyivZilJSkttcuO40tJKNFQfDej/PAxBLbtmC7qXbf4
         uO50Wf67YNqPFbwO8+8qLU9+ivIQXoFdbB81KRn2ekOlb2w6qytMACqmT5mZLvQLQqUs
         LbotJl/+3I5rzc0oYVem7tvKzrjveORwj7Khz5PjJCwefbmEsVacnuZtrmBSOs+mCGND
         lcLalC0HfsB723BdXWNVK78oBWChQP9tGiancvF19ohyScXWElq8QCcqNOnpDUO3Mjo8
         glnA==
X-Gm-Message-State: AOAM531iSZIBW1mnobg1QPn3RKKlnVCLqdtwlq5WgGvrBcgGb80xlPWQ
        cxNXJVQN+xEH8K8kckSjqn/kk5RZjEU=
X-Google-Smtp-Source: ABdhPJw2hMGqcY7TxtCBbMX9xSMReiGny73b/EAjQJECXqTtftYUeER38gIIMygXxGxMo6XkttOKiA==
X-Received: by 2002:a9d:61d2:: with SMTP id h18mr804034otk.113.1615499456777;
        Thu, 11 Mar 2021 13:50:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r20sm927593otd.26.2021.03.11.13.50.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:50:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:50:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiqi Li <lijq9@lenovo.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, markpearson@lenovo.com
Subject: Re: [PATCH v2] hwmon: (nct6883) Support NCT6686D
Message-ID: <20210311215055.GA36492@roeck-us.net>
References: <20210304104421.1912934-1-lijq9@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304104421.1912934-1-lijq9@lenovo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 06:44:21PM +0800, Jiqi Li wrote:
> Add support for NCT6686D chip used in the Lenovo P620.
> 
> Signed-off-by: Jiqi Li <lijq9@lenovo.com>
> Reviewed-by: Mark Pearson <markpearson@lenovo.com>
> ---
> Changes in v2: Corrected typo from NCT6886D to NCT6686D

Not entirely; the subject is still partially wrong.
No need to resend, though, I'll fix then while applying it.

Guenter

> ---
>  drivers/hwmon/nct6683.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index a23047a3bfe2..256e8d62f858 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * nct6683 - Driver for the hardware monitoring functionality of
> - *	     Nuvoton NCT6683D/NCT6687D eSIO
> + *	     Nuvoton NCT6683D/NCT6686D/NCT6687D eSIO
>   *
>   * Copyright (C) 2013  Guenter Roeck <linux@roeck-us.net>
>   *
> @@ -12,6 +12,7 @@
>   *
>   * Chip        #vin    #fan    #pwm    #temp  chip ID
>   * nct6683d     21(1)   16      8       32(1) 0xc730
> + * nct6686d     21(1)   16      8       32(1) 0xd440
>   * nct6687d     21(1)   16      8       32(1) 0xd590
>   *
>   * Notes:
> @@ -33,7 +34,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -enum kinds { nct6683, nct6687 };
> +enum kinds { nct6683, nct6686, nct6687 };
>  
>  static bool force;
>  module_param(force, bool, 0);
> @@ -41,11 +42,13 @@ MODULE_PARM_DESC(force, "Set to one to enable support for unknown vendors");
>  
>  static const char * const nct6683_device_names[] = {
>  	"nct6683",
> +	"nct6686",
>  	"nct6687",
>  };
>  
>  static const char * const nct6683_chip_names[] = {
>  	"NCT6683D",
> +	"NCT6686D",
>  	"NCT6687D",
>  };
>  
> @@ -66,6 +69,7 @@ static const char * const nct6683_chip_names[] = {
>  
>  #define SIO_NCT6681_ID		0xb270	/* for later */
>  #define SIO_NCT6683_ID		0xc730
> +#define SIO_NCT6686_ID		0xd440
>  #define SIO_NCT6687_ID		0xd590
>  #define SIO_ID_MASK		0xFFF0
>  
> @@ -1362,6 +1366,9 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
>  	case SIO_NCT6683_ID:
>  		sio_data->kind = nct6683;
>  		break;
> +	case SIO_NCT6686_ID:
> +		sio_data->kind = nct6686;
> +		break;
>  	case SIO_NCT6687_ID:
>  		sio_data->kind = nct6687;
>  		break;
