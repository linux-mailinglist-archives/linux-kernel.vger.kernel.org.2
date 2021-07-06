Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006643BDC45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGFRbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhGFRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:31:03 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFAFC061574;
        Tue,  6 Jul 2021 10:28:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w74so78429oiw.8;
        Tue, 06 Jul 2021 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pjXT6P96MgHuIttwz8cgGLmOjMu+HL6XnL6K6LaGWKc=;
        b=R4SuCmWMSQmrVPUJPXC6txDxYVP/RsCcGjGgsd5nYPKiVQMOvFPmf8K6CiejnAbvQB
         nGV4v6sovQyBo4huAfxfs5vpjou3Mnb9F5G4/Ss1Y5DKhrl6hghLgHPVZbYdbqdbl9ua
         M5J9UgtgWBvV/bZ7VHWNTQJvX5TlQOyaiRSQBTxPs6t3POAc12x4ptUpOmw0x+rvwuAH
         DGCksfOhsQOoEkQtS4qjej4iVA3Tyd9mh5ZKAgldsQ8bciqS9LqBvE/2f3y930Z9+Hzv
         yVVhJgjteAqMGEgyC96eZBJe5Yxma8xGbXL+Rke+LmUzN7FKCKSpl8JtSZZ8G2UfVYTf
         0VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pjXT6P96MgHuIttwz8cgGLmOjMu+HL6XnL6K6LaGWKc=;
        b=FtmOb2qQhHVaM7yxBtBuDzOmrWTSq73zf4FDNRfX40LX+OIITbbJZWiTQ6sloWYeb1
         55nlf3KZ77Zu4r6YVzdmnf4TlTfooqVtXj3cYo7CKgO/JEqT1UCMakGQPiCCJPKgXpw/
         0w6K1qoe8PV3pli4EQA/Pu/qRAPTlTZDMUfz2fib9q1MMq2Jn5buKe892Dx8+lfCSipG
         oM0Dqpb4NHV5RPyLHG4KxtLFP1RgNNhB8i/tvvDkf+DP7DuLw1DtlUp+MEULafY8E/Bd
         p1j0AhxAoF8zC8tuWQOOqpYRSak1N9z2T+AJftSMSrYfu9eSfNVJ09j6kYJIRRk4DT8z
         F3sQ==
X-Gm-Message-State: AOAM530T3duRUgAzQMbKnMqPX9kF5EdmnqzDEkZR7PtEkoWF9qUWDgwM
        /PJBXBwRtRlFeOnnYDtT2kk=
X-Google-Smtp-Source: ABdhPJzuGUNHvhnU/A09hJaDWrEAuxtai92S+J6ZGJA9v+YioF5bpU7mPSVODZFOkre9q8HiQkRzkw==
X-Received: by 2002:a54:488b:: with SMTP id r11mr12811645oic.116.1625592503305;
        Tue, 06 Jul 2021 10:28:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x43sm1881830otr.38.2021.07.06.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:28:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jul 2021 10:28:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 1/3] mfd: da9063: Add HWMON dependencies
Message-ID: <20210706172821.GA943349@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:34:47PM +0000, Vincent Pelletier wrote:
> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Dependencies required for DA9063 HWMON support.
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Directly set da9063->t_offset.
> Let MFD probe succeed even if DA9063_REG_T_OFFSET cannot be read.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> Changes in v2:
> - registers.h changes moved from patch 2

Please version your patch series.

> 
> Originally submitted by Steve Twiss in 2014:
>   https://marc.info/?l=linux-kernel&m=139560864709852&w=2
> 
>  drivers/mfd/da9063-core.c            |  8 +++++++
>  include/linux/mfd/da9063/core.h      |  3 +++
>  include/linux/mfd/da9063/registers.h | 34 ++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index df407c3afce3..14c2a8df9ae3 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -197,6 +197,14 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  		}
>  	}
>  
> +	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &da9063->t_offset);
> +	if (ret < 0) {
> +		da9063->t_offset = 0;
> +		dev_warn(da9063->dev,
> +			 "Temperature trimming value cannot be read (defaulting to 0)\n");
> +		ret = 0;
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index fa7a43f02f27..c0c57c6f6230 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -85,6 +85,9 @@ struct da9063 {
>  	int		chip_irq;
>  	unsigned int	irq_base;
>  	struct regmap_irq_chip_data *regmap_irq;
> +
> +	/* Trimming */
> +	int		t_offset;
>  };
>  
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq);
> diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
> index 6e0f66a2e727..297631ddda39 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -512,6 +512,7 @@
>  
>  /* DA9063_REG_GPIO_0_1 (addr=0x15) */
>  #define	DA9063_GPIO0_PIN_MASK			0x03
> +#define	DA9063_GPIO0_PIN_MASK_SHIFT		0
>  #define		DA9063_GPIO0_PIN_ADCIN1		0x00
>  #define		DA9063_GPIO0_PIN_GPI		0x01
>  #define		DA9063_GPIO0_PIN_GPO_OD		0x02
> @@ -523,6 +524,7 @@
>  #define		DA9063_GPIO0_TYPE_GPO_VDD_IO2	0x04
>  #define	DA9063_GPIO0_NO_WAKEUP			0x08
>  #define	DA9063_GPIO1_PIN_MASK			0x30
> +#define	DA9063_GPIO1_PIN_MASK_SHIFT		4
>  #define		DA9063_GPIO1_PIN_ADCIN2_COMP	0x00
>  #define		DA9063_GPIO1_PIN_GPI		0x10
>  #define		DA9063_GPIO1_PIN_GPO_OD		0x20
> @@ -536,6 +538,7 @@
>  
>  /* DA9063_REG_GPIO_2_3 (addr=0x16) */
>  #define	DA9063_GPIO2_PIN_MASK			0x03
> +#define	DA9063_GPIO2_PIN_MASK_SHIFT		0
>  #define		DA9063_GPIO2_PIN_ADCIN3		0x00
>  #define		DA9063_GPIO2_PIN_GPI		0x01
>  #define		DA9063_GPIO2_PIN_GPO_PSS	0x02
> @@ -851,6 +854,7 @@
>  #define	DA9063_VSYS_VAL_BASE			0x00
>  
>  /* DA9063_REG_ADC_RES_L (addr=0x37) */
> +#define	DA9063_ADC_RES_L_SHIFT			6
>  #define	DA9063_ADC_RES_L_BITS			2
>  #define	DA9063_ADC_RES_L_MASK			0xC0
>  
> @@ -1014,6 +1018,36 @@
>  #define DA9063_GPIO_DIM				0x80
>  #define DA9063_GPIO_PWM_MASK			0x7F
>  
> +/* DA9063_REG_ADC_CFG (addr=0xC9) */
> +#define DA9063_REG_ADCIN1_CUR_MASK		0x03
> +#define DA9063_REG_ADCIN1_CUR_SHIFT		0
> +#define		DA9063_ADCIN1_CUR_1UA		0x00
> +#define		DA9063_ADCIN1_CUR_2UA		0x01
> +#define		DA9063_ADCIN1_CUR_10UA		0x02
> +#define		DA9063_ADCIN1_CUR_40UA		0x03
> +#define DA9063_REG_ADCIN2_CUR_MASK		0x0C
> +#define DA9063_REG_ADCIN2_CUR_SHIFT		2
> +#define		DA9063_ADCIN2_CUR_1UA		0x00
> +#define		DA9063_ADCIN2_CUR_2UA		0x01
> +#define		DA9063_ADCIN2_CUR_10UA		0x02
> +#define		DA9063_ADCIN2_CUR_40UA		0x03
> +#define DA9063_REG_ADCIN3_CUR_MASK		0x10
> +#define DA9063_REG_ADCIN3_CUR_SHIFT		4
> +#define		DA9063_ADCIN3_CUR_10UA		0x00
> +#define		DA9063_ADCIN3_CUR_40UA		0x01
> +#define DA9063_REG_ADCIN1_DEB_MASK		0x20
> +#define DA9063_REG_ADCIN1_DEB_SHIFT		5
> +#define		DA9063_ADCIN1_DEB_OFF		0x00
> +#define		DA9063_ADCIN1_DEB_ON		0x01
> +#define DA9063_REG_ADCIN2_DEB_MASK		0x40
> +#define DA9063_REG_ADCIN2_DEB_SHIFT		6
> +#define		DA9063_ADCIN2_DEB_OFF		0x00
> +#define		DA9063_ADCIN2_DEB_ON		0x01
> +#define DA9063_REG_ADCIN3_DEB_MASK		0x80
> +#define DA9063_REG_ADCIN3_DEB_SHIFT		7
> +#define		DA9063_ADCIN3_DEB_OFF		0x00
> +#define		DA9063_ADCIN3_DEB_ON		0x01
> +
>  /* DA9063_REG_CONFIG_H (addr=0x10D) */
>  #define DA9063_PWM_CLK_MASK			0x01
>  #define		DA9063_PWM_CLK_PWM2MHZ		0x00
> -- 
> 2.32.0
> 
