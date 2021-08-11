Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F53E993D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHKTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:54:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCBC061765;
        Wed, 11 Aug 2021 12:53:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so3102790qtx.1;
        Wed, 11 Aug 2021 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Rj3jowo4rLKTb5DL/a/sgrAp1nwTAibErIjLWBeFZM=;
        b=gBrqComJtE/krGIQfEmDF6IG7fhP+pnMLgmJfkWv/TcSv09Pl+014rGDGTCT6Mp1GR
         NbMmQdiR0ue4BZDMNzE+ElVX5GJZGxeEBonVQ/m8/t09QhCF/1BPymL356VL9qGp+yS8
         sQUhRK7m6BzlU7rbZH4QKdiGJ5wxCy+VRazapd+wT1/zNAuu/SRy5pkFbhcHUw5FoTfr
         O3H7+2e3xCq8TZk4oWylKIC2Zxz7IR4j5DGnriBOb3dUZMNATtn2/pGFLqp5GbGrHEtC
         3Timawg7v+zSncVtMq8GsS1lLKZ0iQg8wcx6KYwnQD+ShRj1cLoL9rOMC6dzdRBF66YQ
         HhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7Rj3jowo4rLKTb5DL/a/sgrAp1nwTAibErIjLWBeFZM=;
        b=NEcXLszGL69T4HZXNCe5KG9/8+k3BgMStBunOajU88WXLWSRKWrCJ7D7qrhgH90N3G
         MhdfkJQRcZFKVKFP0Ajoo/Tho5iodnMlFp3FTG2aKdoNiwnDy5OMCZvQuXb0EpEfzprU
         bgwHsux3MQfuzDlfO+zlLdXXxYXZ/HhZo6T0bscgLpHyTTM7ekLpakxTODYADndRXy4d
         ObdnkTIktRfQiRZPDvhWnRDgNXGJRuWVz/+0MaWJSHnAI4EiIUIM+ict1FPPrkXIOGUM
         DtZ5DRvTNQEEGe23BTas7rCGyNrYbqlm0YDuD/lJFRZV9iNT+F3fRwRTMUsofbqC+dUk
         1HtQ==
X-Gm-Message-State: AOAM531jJcfpN+oWVL2+YwgdopGDF3w5DnIIgqoEyaa6V7PXV88Qivc6
        gwH9HGVQ6hINEbuL/aLaVMI=
X-Google-Smtp-Source: ABdhPJzv3si9poBiguRuyMRL0g21rM7yQcqGtXv5Hm/jQnebhhsTvuQGmnp1hsEA2vyCbVTmcZ4Org==
X-Received: by 2002:a05:622a:170f:: with SMTP id h15mr398490qtk.378.1628711628482;
        Wed, 11 Aug 2021 12:53:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5sm100619qkj.16.2021.08.11.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:53:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 12:53:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (pmbus/bpa-rs600) Remove duplicate
 defininitions
Message-ID: <20210811195346.GA966404@roeck-us.net>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811041738.15061-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 04:17:37PM +1200, Chris Packham wrote:
> Commit 787c095edaa9 ("hwmon: (pmbus/core) Add support for rated
> attributes") added definitions for MFR_VIN_MIN etc so we can remove the
> local definitions of these from the bpa-rs600 driver.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/pmbus/bpa-rs600.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> index d205b41540ce..d495faa89799 100644
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
> @@ -83,28 +74,28 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
>  
>  	switch (reg) {
>  	case PMBUS_VIN_UV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MIN);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VIN_MIN);
>  		break;
>  	case PMBUS_VIN_OV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VIN_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VIN_MAX);
>  		break;
>  	case PMBUS_VOUT_UV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MIN);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VOUT_MIN);
>  		break;
>  	case PMBUS_VOUT_OV_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_VOUT_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_VOUT_MAX);
>  		break;
>  	case PMBUS_IIN_OC_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IIN_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IIN_MAX);
>  		break;
>  	case PMBUS_IOUT_OC_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_IOUT_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_IOUT_MAX);
>  		break;
>  	case PMBUS_PIN_OP_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_PIN_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
>  		break;
>  	case PMBUS_POUT_OP_WARN_LIMIT:
> -		ret = pmbus_read_word_data(client, 0, 0xff, BPARS600_MFR_POUT_MAX);
> +		ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_POUT_MAX);

If the above is correct, the driver reports the wrong attributes. For example,
PMBUS_MFR_PIN_MAX is supposed to report the rated limit, not the warning limit.
What does the datasheet say ?

Guenter

>  		break;
>  	case PMBUS_VIN_UV_FAULT_LIMIT:
>  	case PMBUS_VIN_OV_FAULT_LIMIT:
> -- 
> 2.32.0
> 
