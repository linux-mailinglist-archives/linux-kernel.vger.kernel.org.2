Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6A3AEA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhFUN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624283794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUBa+f7Xm4t96iN+NkBqJ45lC6Lh0RQpTYf0i6UvBWU=;
        b=NKhWvN120MYpwFUp1C9h22fZUEINez3PA8dF/arSr0WjdXBWDNJL/dxFguzTmaq/KrmJit
        H/k0MXgMXK53iYRaYaHHwp2I4KiloYNxceJ66E1DU1GlDz7csv+dV8FSbyu0Xt9if+y3Xs
        fy++AvsqrrpHlrM1ChNaGUx6NUBRU0s=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-I8O-Sy5pNvyoSYCOEoZTzA-1; Mon, 21 Jun 2021 09:56:32 -0400
X-MC-Unique: I8O-Sy5pNvyoSYCOEoZTzA-1
Received: by mail-ot1-f71.google.com with SMTP id a60-20020a9d26420000b0290448d2be15e6so8832426otb.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sUBa+f7Xm4t96iN+NkBqJ45lC6Lh0RQpTYf0i6UvBWU=;
        b=tE456pnxEqb+tI4iaMwK4u7T96yaJ8sAxKXYllvLKxkIOseziU/hoDda0kg4xs0sv1
         1c5/LR50ct0eXyEvYgTnn6gQLvp1DUIZ9Ym95TWGq4DpXkSSlH8uECGkDmZN5tfcpkDc
         gErFkO0jpTcv6F04/M0DNyZ+dpwMTXF1/U05Kmg7s5JjKZdNStz08XIWYnECOB/3YIRq
         Rma7Ez1q9qXE3+rr2qSuwiuVLwhy/BMsVsO7gcrw+blZb2tBTyfj704rb8Gh+OXJkAer
         h7apunpqY+VGuAH8/8SVA5JxXzRgjdVaq9V4lKvxVhfNPLvNgeKSLZB0orZptDUDUPNh
         vJhw==
X-Gm-Message-State: AOAM531wTjlhD0ouAsE5GHjsZQ8oiEyIlbcCJNSVVy7chJNSJujRYy0u
        Jt7I8zazpoC4Sn2C2h52Do7j+f2/8qdBcH58Dw6Vqum+04uvaDVmsSywVEx5tQoooZCWmJqsWv7
        nqDK3xo1t1Xt3W+IjC9gJ0Dfo
X-Received: by 2002:a4a:d312:: with SMTP id g18mr15767765oos.7.1624283791939;
        Mon, 21 Jun 2021 06:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUdV8x76NSb4XfefxGAso3zUzJOfUNExo/qTPFL//uOjZSUAN1XtrfwvndilmzVFrGCpdbGA==
X-Received: by 2002:a4a:d312:: with SMTP id g18mr15767744oos.7.1624283791724;
        Mon, 21 Jun 2021 06:56:31 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 68sm2918121otx.4.2021.06.21.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 06:56:31 -0700 (PDT)
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
Date:   Mon, 21 Jun 2021 06:56:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621070621.431482-3-mhu@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/21 12:06 AM, Martin Hundebøll wrote:
> From: Debarati Biswas <debaratix.biswas@intel.com>
>
> Device Feature List (DFL) drivers may be defined in subdirectories other
> than drivers/fpga, and each DFL driver should have access to the Device
> Feature Header (DFH) register, which contains revision and type
> information. This change moves the macros specific to the DFH register
> from drivers/fpga/dfl.h to include/linux/dfl.h.
>
> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
>   drivers/fpga/dfl.h  | 48 +----------------------------------------
>   include/linux/dfl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c..6ed0353e9a99 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -17,6 +17,7 @@
>   #include <linux/bitfield.h>

bitfield.h was added to linux/dfl.h

Likely both aren't needed, try removing this one.

Tom

>   #include <linux/cdev.h>
>   #include <linux/delay.h>
> +#include <linux/dfl.h>
>   #include <linux/eventfd.h>
>   #include <linux/fs.h>
>   #include <linux/interrupt.h>
> @@ -53,32 +54,6 @@
>   #define PORT_FEATURE_ID_UINT		0x12
>   #define PORT_FEATURE_ID_STP		0x13
>   
> -/*
> - * Device Feature Header Register Set
> - *
> - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> - * For AFUs, they have DFH + GUID as common header registers.
> - * For private features, they only have DFH register as common header.
> - */
> -#define DFH			0x0
> -#define GUID_L			0x8
> -#define GUID_H			0x10
> -#define NEXT_AFU		0x18
> -
> -#define DFH_SIZE		0x8
> -
> -/* Device Feature Header Register Bitfield */
> -#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
> -#define DFH_ID_FIU_FME		0
> -#define DFH_ID_FIU_PORT		1
> -#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> -#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> -#define DFH_EOL			BIT_ULL(40)		/* End of list */
> -#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
> -#define DFH_TYPE_AFU		1
> -#define DFH_TYPE_PRIVATE	3
> -#define DFH_TYPE_FIU		4
> -
>   /* Next AFU Register Bitfield */
>   #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
>   
> @@ -403,27 +378,6 @@ struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
>   	return pdata->dev->dev.parent->parent;
>   }
>   
> -static inline bool dfl_feature_is_fme(void __iomem *base)
> -{
> -	u64 v = readq(base + DFH);
> -
> -	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> -		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> -}
> -
> -static inline bool dfl_feature_is_port(void __iomem *base)
> -{
> -	u64 v = readq(base + DFH);
> -
> -	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> -		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> -}
> -
> -static inline u8 dfl_feature_revision(void __iomem *base)
> -{
> -	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> -}
> -
>   /**
>    * struct dfl_fpga_enum_info - DFL FPGA enumeration information
>    *
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc10982351a..1cd86b2e7cb1 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -8,7 +8,9 @@
>   #ifndef __LINUX_DFL_H
>   #define __LINUX_DFL_H
>   
> +#include <linux/bitfield.h>
>   #include <linux/device.h>
> +#include <linux/io.h>
>   #include <linux/mod_devicetable.h>
>   
>   /**
> @@ -83,4 +85,54 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>   	module_driver(__dfl_driver, dfl_driver_register, \
>   		      dfl_driver_unregister)
>   
> +/*
> + * Device Feature Header Register Set
> + *
> + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> + * For AFUs, they have DFH + GUID as common header registers.
> + * For private features, they only have DFH register as common header.
> + */
> +#define DFH                     0x0
> +#define GUID_L                  0x8
> +#define GUID_H                  0x10
> +#define NEXT_AFU                0x18
> +
> +#define DFH_SIZE                0x8
> +
> +/* Device Feature Header Register Bitfield */
> +#define DFH_ID                  GENMASK_ULL(11, 0)      /* Feature ID */
> +#define DFH_ID_FIU_FME          0
> +#define DFH_ID_FIU_PORT         1
> +#define DFH_REVISION            GENMASK_ULL(15, 12)
> +#define DFH_NEXT_HDR_OFST       GENMASK_ULL(39, 16)     /* Offset to next DFH */
> +#define DFH_EOL                 BIT_ULL(40)             /* End of list */
> +#define DFH_TYPE                GENMASK_ULL(63, 60)     /* Feature type */
> +#define DFH_TYPE_AFU            1
> +#define DFH_TYPE_PRIVATE        3
> +#define DFH_TYPE_FIU            4
> +
> +/* Function to read from DFH and check if the Feature type is FME */
> +static inline bool dfl_feature_is_fme(void __iomem *base)
> +{
> +	u64 v = readq(base + DFH);
> +
> +	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> +		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> +}
> +
> +/* Function to read from DFH and check if the Feature type is port*/
> +static inline bool dfl_feature_is_port(void __iomem *base)
> +{
> +	u64 v = readq(base + DFH);
> +
> +	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> +		 (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> +}
> +
> +/* Function to read feature revision from DFH */
> +static inline u8 dfl_feature_revision(void __iomem *base)
> +{
> +	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> +}
> +
>   #endif /* __LINUX_DFL_H */

