Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6463E9DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhHLElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhHLElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:41:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EAC061765;
        Wed, 11 Aug 2021 21:40:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z24so4100099qtn.8;
        Wed, 11 Aug 2021 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6eARFBlE91w21+8A+HUHu10HO/FvE+uS1fZMYBvnhGs=;
        b=p/vzeqyowIO1sb2W08hDxI7wmqZsJkais2HIBQKh5s7iv/0gpl1DUJz4GyYrR8IYHk
         qS0FFmSus2aG6J3HEPE7fcOnhqK2Zp1I0mjb1g3lbl6dlBIECHuU+07/n2JJ5u2dtUoM
         4NK9PbOrk8Kyk1XHYmy5mu9i8E+YA9qPUGBK1NXGEg/fZ25uUINMg6iARnra46YiIvwn
         rrWkcQm0N2+gaYWAW/CIcaeRs9tXY4ZHSo+Gn1pDhmXfAnNTePD/6G40KRYL+8/EKy33
         fzkmX3Xo+KD9/udwQkpnKSMf9zCP1i2ltjuFZQKyxAGIZH/oKOaUpsEeaZZNNAEssIsC
         M5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6eARFBlE91w21+8A+HUHu10HO/FvE+uS1fZMYBvnhGs=;
        b=HzYgRgqjCm7KinEJWJUUcJXpNsIptxqZJhYhYU3BVKv+6QFL5LBspbGewZaUv0T/if
         uzwqVDyRMlrZnDTk9MQp6NwpDuBpxS9ox3yq0ZSIlN/S+oqGC4EqcItZ4WejsmzEI338
         D7eOuAVoorn2HxIEvtJZ19xoHxM82r3OPizCP8JnzF5dYV/OXhaXP8V6fIO7NP92MAhW
         sY0XpIj+nbaK86vbQ1u+31bg8+9ZmMQD6bRFUyxtfLoqu75TYvh8L+rOhD3dy9P59Jot
         g9enbaYH4HBYovg+Ap9Pb48wgAg32RR5l8GNfbxcd0R3Ru7BaZjR+7jvPUS+MZua9Ljw
         7eXg==
X-Gm-Message-State: AOAM530kNdWjw0ubwnrb+YTpOYia4k0aeRSw2AVhH1SShGR7L7jdYF39
        DY29Lt6MbcZ+j2D6UxmX0nH1ZvFQPd4=
X-Google-Smtp-Source: ABdhPJw5xJImzf9+g8Ki0ykqepUFlsRPIVziKsxNkxDm3iHfYbMuS2o1H/TQkISZg/jWeOOFnMp9+A==
X-Received: by 2002:ac8:5204:: with SMTP id r4mr2133492qtn.38.1628743236270;
        Wed, 11 Aug 2021 21:40:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12sm588157qti.92.2021.08.11.21.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:40:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 21:40:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/bpa-rs600) Don't use rated limits
 as warn limits
Message-ID: <20210812044034.GA1115914@roeck-us.net>
References: <20210812014000.26293-1-chris.packham@alliedtelesis.co.nz>
 <20210812014000.26293-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812014000.26293-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:39:59PM +1200, Chris Packham wrote:
> In the initial implementation a number of PMBUS_x_WARN_LIMITs were
> mapped to MFR fields. This was incorrect as these MFR limits reflect the
> rated limit as opposed to a limit which will generate warning. Instead
> return -ENXIO like we were already doing for other WARN_LIMITs.
> 
> Subsequently these rated limits have been exposed generically as new
> fields in the sysfs ABI so the values are still available.
> 
> Fixes: 15b2703e5e02 ("hwmon: (pmbus) Add driver for BluTek BPA-RS600")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v2:
>     - Reworked to remove the mapping of warning limits to rated limits.
> 
>  drivers/hwmon/pmbus/bpa-rs600.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> index d205b41540ce..84dee86399cb 100644
> --- a/drivers/hwmon/pmbus/bpa-rs600.c
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -12,15 +12,6 @@
>  #include <linux/pmbus.h>
>  #include "pmbus.h"
>  
> -#define BPARS600_MFR_VIN_MIN	0xa0
> -#define BPARS600_MFR_VIN_MAX	0xa1
> -#define BPARS600_MFR_IIN_MAX	0xa2
> -#define BPARS600_MFR_PIN_MAX	0xa3
> -#define BPARS600_MFR_VOUT_MIN	0xa4
> -#define BPARS600_MFR_VOUT_MAX	0xa5
> -#define BPARS600_MFR_IOUT_MAX	0xa6
> -#define BPARS600_MFR_POUT_MAX	0xa7
> -
>  enum chips { bpa_rs600, bpd_rs600 };
>  
>  static int bpa_rs600_read_byte_data(struct i2c_client *client, int page, int reg)
> @@ -83,29 +74,13 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
>  
>  	switch (reg) {
>  	case PMBUS_VIN_UV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MIN);
> -		break;
>  	case PMBUS_VIN_OV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MAX);
> -		break;
>  	case PMBUS_VOUT_UV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MIN);
> -		break;
>  	case PMBUS_VOUT_OV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MAX);
> -		break;
>  	case PMBUS_IIN_OC_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IIN_MAX);
> -		break;
>  	case PMBUS_IOUT_OC_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IOUT_MAX);
> -		break;
>  	case PMBUS_PIN_OP_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_PIN_MAX);
> -		break;
>  	case PMBUS_POUT_OP_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_POUT_MAX);
> -		break;
>  	case PMBUS_VIN_UV_FAULT_LIMIT:
>  	case PMBUS_VIN_OV_FAULT_LIMIT:
>  	case PMBUS_VOUT_UV_FAULT_LIMIT:
