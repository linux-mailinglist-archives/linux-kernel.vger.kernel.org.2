Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B943C39BD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 03:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGKBSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhGKBSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 21:18:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD386C0613DD;
        Sat, 10 Jul 2021 18:15:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f5so14212375pgv.3;
        Sat, 10 Jul 2021 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjdgQ6nhsPDlFW+4XA1vR8uDT5aecjdMoRGKiY+MVSg=;
        b=vfVi4jcZ7MXr9AwzqdwmeoRY5scDi4Hxiu7Z86JzNH8GMcxp+S+NPzQbZNoc6bPx0G
         f7otbgLb//cgd5r9IKsdD4tzF7qOQsNUPGERgsLD8Wc7MTS8Cw6aoi+p7weRQdBa/kfK
         pUfq3t2SQhpfHFy6cFqdM9bh7PMhvb8DRwOfK6TDCodtZ2BJnDt8k/dUXwWBvNIH+tmu
         sRSapf9WsMWl4RvF7kdy5Fvpr+hhbVZNTx8LKY3yuTt41POCNTVouPNEV2aAfeIv0SSU
         1WinmLKB0EyCU4w5XYysgmhf3HCESmo9b/dpEmv4elUF5iRn/yewtSRmqG75WwwHukib
         p7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjdgQ6nhsPDlFW+4XA1vR8uDT5aecjdMoRGKiY+MVSg=;
        b=MIj3RJp60akzxnLGCMQNvgYznWdfPaA+l9UtmKbEoJ70K0MeBJABmca+i/47PetTqg
         va0ed4dwRUjaR4KAZIY1nauP/m0y519wAziRV1/yLvsJ4F0mHZuSmJ6/D3XyQXaUc127
         JnoVQp8WdB2o9vie7lhE+cVX/iP3s+XYivr8+q0yI7nU0mWOjc60gX2uwzXOleslrwvI
         cF2uZ+Fe92rmAawVAMKJJpvQSPoNE8z4pMVxQRHRsYCusbc/uswstNF2ATzeYaw9P28m
         1Is631wg4MlZJXEu8kMHbaED4lSi5V8+Rpe+HePMZhdoYqLJzYOMoKMlC257Xckr6H8e
         B8Ag==
X-Gm-Message-State: AOAM530xag3yC1GV0YAj7DYlkpE5CsQQtt8290aet1tQRZNBdUnJzE91
        wffOZk+d6l7XTO/PwTaHivM=
X-Google-Smtp-Source: ABdhPJys4gOsCg8Zx+1BK2peWdzmzBn38VVYd5g2lZDIrk+SNtfNNPReqWyr72/ZRDzTq7/+2EfTsw==
X-Received: by 2002:aa7:8b0a:0:b029:329:f9e6:eaa6 with SMTP id f10-20020aa78b0a0000b0290329f9e6eaa6mr5367171pfd.13.1625966149925;
        Sat, 10 Jul 2021 18:15:49 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id c11sm346725pfp.0.2021.07.10.18.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 18:15:49 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 47D03900050;
        Sun, 11 Jul 2021 01:15:47 +0000 (GMT)
Date:   Sun, 11 Jul 2021 01:15:46 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210711011546.0d1958c0@gmail.com>
In-Reply-To: <20210710160813.GA3560663@roeck-us.net>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
        <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
        <20210710160813.GA3560663@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a 

On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 07, 2021 at 01:25:03PM +0000, Vincent Pelletier wrote:
> > Add the HWMON driver for DA9063
> > 
> > Originally-from: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > ---
> > Changes in v3:
> > - changed original author's Signed-off-by into an Originally-from.
> > - dropped license boilerplate
> > - only return ETIMEOUT if ADC result is not ready by the time the IRQ
> >   either triggered or timed out
> > - removed unnecessary lists
> > - changed a duplicate init_comptetion into a more useful reinit_completion
> > - dropped unused platform_set_drvdata
> > - moved temperature offset reading from mfd driver
> > 
> > Changes in v2:
> > - drop of_match_table: this should be meaningless in such sub-function
> >   driver (at least judging by other sub-function drivers for the da9063)
> > - sort includes
> > - switch to devm_hwmon_device_register_with_info
> > - registers.h changes moved to patch 1
> > - add SPDX header
> > 
> > This patch depends on patch 1/3.
> > Originally submitted by Steve Twiss in 2014:
> >   https://marc.info/?l=linux-kernel&m=139560868309857&w=2
> > 
> >  drivers/hwmon/Kconfig        |  10 ++
> >  drivers/hwmon/Makefile       |   1 +
> >  drivers/hwmon/da9063-hwmon.c | 260 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 271 insertions(+)
> >  create mode 100644 drivers/hwmon/da9063-hwmon.c
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 87624902ea80..17244cfaa855 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -515,6 +515,16 @@ config SENSORS_DA9055
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called da9055-hwmon.
> >  
> > +config SENSORS_DA9063
> > +	tristate "Dialog Semiconductor DA9063"
> > +	depends on MFD_DA9063
> > +	help
> > +	  If you say yes here you get support for the hardware
> > +	  monitoring features of the DA9063 Power Management IC.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called da9063-hwmon.
> > +
> >  config SENSORS_I5K_AMB
> >  	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
> >  	depends on PCI
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 59e78bc212cf..6855711ed9ec 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
> >  obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
> >  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
> >  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
> > +obj-$(CONFIG_SENSORS_DA9063)	+= da9063-hwmon.o
> >  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> >  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
> >  obj-$(CONFIG_SENSORS_DRIVETEMP)	+= drivetemp.o
> > diff --git a/drivers/hwmon/da9063-hwmon.c b/drivers/hwmon/da9063-hwmon.c
> > new file mode 100644
> > index 000000000000..6367685536a1
> > --- /dev/null
> > +++ b/drivers/hwmon/da9063-hwmon.c
> > @@ -0,0 +1,260 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* da9063-hwmon.c - Hardware monitor support for DA9063
> > + * Copyright (C) 2014 Dialog Semiconductor Ltd.
> > + * Copyright (C) 2021 Vincent Pelletier <plr.vincent@gmail.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>  
> 
> Unnecessary include.
> 
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/da9063/core.h>
> > +#include <linux/mod_devicetable.h>  
> 
> I don't immediately see where this include is needed. Is this a
> leftover ?
> 
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>  
> 
> Same here.
> 
> > +
> > +#define DA9063_ADC_RES	(1 << (DA9063_ADC_RES_L_BITS + DA9063_ADC_RES_M_BITS))
> > +#define DA9063_ADC_MAX	(DA9063_ADC_RES - 1)
> > +#define DA9063_2V5	2500
> > +#define DA9063_5V0	5000
> > +#define DA9063_5V5	5500
> > +#define DA9063_TJUNC_M	-398  
> 
> It doesn't matter here (I think), but it would be better to surround the
> above with () to ensure that the '-' is not interpreted as arithmetic
> operator.
> 
> > +#define DA9063_TJUNC_O	330000
> > +#define DA9063_VBBAT_M	2048
> > +
> > +enum da9063_adc {
> > +	DA9063_CHAN_VSYS = DA9063_ADC_MUX_VSYS,
> > +	DA9063_CHAN_ADCIN1 = DA9063_ADC_MUX_ADCIN1,
> > +	DA9063_CHAN_ADCIN2 = DA9063_ADC_MUX_ADCIN2,
> > +	DA9063_CHAN_ADCIN3 = DA9063_ADC_MUX_ADCIN3,
> > +	DA9063_CHAN_TJUNC = DA9063_ADC_MUX_T_SENSE,
> > +	DA9063_CHAN_VBBAT = DA9063_ADC_MUX_VBBAT,
> > +	DA9063_CHAN_LDO_G1 = DA9063_ADC_MUX_LDO_G1,
> > +	DA9063_CHAN_LDO_G2 = DA9063_ADC_MUX_LDO_G2,
> > +	DA9063_CHAN_LDO_G3 = DA9063_ADC_MUX_LDO_G3  
> 
> Many of the above defines are not used. Do you plan a follow-up commit
> to use them ? Otherwise please drop unused defines.
> 
> > +};
> > +
> > +struct da9063_hwmon {
> > +	struct da9063 *da9063;
> > +	struct mutex hwmon_mutex;
> > +	struct completion adc_ready;
> > +	signed char tjunc_offset;  
> 
> I am curious: 'char' implies 'signed'. Any reason for using 'signed' ?
> 
> Also, note that on most architectures the resulting code is more complex
> when using 'char' instead of 'int'. This is seen easily by compiling the
> driver for arm64: Replacing the above 'signed char' with 'int' reduces
> code size by 32 bytes.
> 
> > +};
> > +
> > +static int da9063_adc_manual_read(struct da9063_hwmon *hwmon, int channel)
> > +{
> > +	int ret;
> > +	unsigned char val;
> > +	unsigned char data[2];
> > +	int adc_man;  
> 
> Should this be unsigned int ?
> 
> > +
> > +	mutex_lock(&hwmon->hwmon_mutex);
> > +
> > +	val = (channel & DA9063_ADC_MUX_MASK) | DA9063_ADC_MAN;
> > +	ret = regmap_update_bits(hwmon->da9063->regmap, DA9063_REG_ADC_MAN,
> > +				 DA9063_ADC_MUX_MASK | DA9063_ADC_MAN, val);
> > +	if (ret < 0)
> > +		goto err_mread;
> > +
> > +	ret = wait_for_completion_timeout(&hwmon->adc_ready,
> > +					  msecs_to_jiffies(100));
> > +	reinit_completion(&hwmon->adc_ready);  
> 
> This is unusual. Normally I see init_completion() or reinit_completion()
> ahead of calls to wait functions.
> 
> If a request timed out and an interrupt happened after the timeout,
> the next request would return immediately with the previous result,
> since complete() would be called on the re-initialized completion
> handler. That doesn't seem to be correct to me.
> 
> > +	if (ret == 0)
> > +		dev_dbg(hwmon->da9063->dev,
> > +			"Timeout while waiting for ADC completion IRQ\n");
> > +
> > +	ret = regmap_read(hwmon->da9063->regmap, DA9063_REG_ADC_MAN, &adc_man);
> > +	if (ret < 0)
> > +		goto err_mread;
> > +
> > +	/* data value is not ready */
> > +	if (adc_man & DA9063_ADC_MAN) {
> > +		ret = -ETIMEDOUT;
> > +		goto err_mread;
> > +	}
> > +
> > +	ret = regmap_bulk_read(hwmon->da9063->regmap,
> > +			       DA9063_REG_ADC_RES_L, data, 2);
> > +	if (ret < 0)
> > +		goto err_mread;
> > +
> > +	ret = (data[0] & DA9063_ADC_RES_L_MASK) >> DA9063_ADC_RES_L_SHIFT;
> > +	ret |= data[1] << DA9063_ADC_RES_L_BITS;
> > +err_mread:
> > +	mutex_unlock(&hwmon->hwmon_mutex);
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t da9063_hwmon_irq_handler(int irq, void *irq_data)
> > +{
> > +	struct da9063_hwmon *hwmon = irq_data;
> > +
> > +	complete(&hwmon->adc_ready);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static umode_t da9063_is_visible(const void *drvdata, enum
> > +				 hwmon_sensor_types type, u32 attr, int channel)
> > +{
> > +	return 0444;
> > +}
> > +
> > +static const enum da9063_adc da9063_in_index[] = {
> > +	DA9063_CHAN_VSYS, DA9063_CHAN_VBBAT
> > +};
> > +
> > +static int da9063_read(struct device *dev, enum hwmon_sensor_types type,
> > +		       u32 attr, int channel, long *val)
> > +{
> > +	struct da9063_hwmon *hwmon = dev_get_drvdata(dev);
> > +	enum da9063_adc adc_channel;
> > +	int tmp;
> > +
> > +	switch (type) {
> > +	case hwmon_in:
> > +		if (attr != hwmon_in_input)
> > +			return -EOPNOTSUPP;
> > +		adc_channel = da9063_in_index[channel];
> > +		break;
> > +	case hwmon_temp:
> > +		if (attr != hwmon_temp_input)
> > +			return -EOPNOTSUPP;
> > +		adc_channel = DA9063_CHAN_TJUNC;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	tmp = da9063_adc_manual_read(hwmon, adc_channel);
> > +	if (tmp < 0)
> > +		return tmp;
> > +
> > +	switch (adc_channel) {
> > +	case DA9063_CHAN_VSYS:
> > +		*val = ((DA9063_5V5 - DA9063_2V5) * tmp) / DA9063_ADC_MAX +
> > +			DA9063_2V5;
> > +		break;
> > +	case DA9063_CHAN_TJUNC:
> > +		tmp -= hwmon->tjunc_offset;
> > +		*val = DA9063_TJUNC_M * tmp + DA9063_TJUNC_O;
> > +		break;
> > +	case DA9063_CHAN_VBBAT:
> > +		*val = (DA9063_5V0 * tmp) / DA9063_ADC_MAX;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const char * const da9063_in_name[] = {
> > +	"VSYS", "VBBAT"
> > +};
> > +
> > +static int da9063_read_string(struct device *dev, enum hwmon_sensor_types type,
> > +			      u32 attr, int channel, const char **str)
> > +{
> > +	switch (type) {
> > +	case hwmon_in:
> > +		if (attr != hwmon_in_label)
> > +			return -EOPNOTSUPP;
> > +		*str = da9063_in_name[channel];
> > +		break;
> > +	case hwmon_temp:
> > +		if (attr != hwmon_temp_label)
> > +			return -EOPNOTSUPP;
> > +		*str = "TJUNC";
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops da9063_ops = {
> > +	.is_visible = da9063_is_visible,
> > +	.read = da9063_read,
> > +	.read_string = da9063_read_string,
> > +};
> > +
> > +static const struct hwmon_channel_info *da9063_channel_info[] = {
> > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> > +	HWMON_CHANNEL_INFO(in,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL,
> > +			   HWMON_I_INPUT | HWMON_I_LABEL),
> > +	HWMON_CHANNEL_INFO(temp,
> > +			   HWMON_T_INPUT | HWMON_T_LABEL),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info da9063_chip_info = {
> > +	.ops = &da9063_ops,
> > +	.info = da9063_channel_info,
> > +};
> > +
> > +static int da9063_hwmon_probe(struct platform_device *pdev)
> > +{
> > +	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> > +	struct da9063_hwmon *hwmon;
> > +	struct device *hwmon_dev;
> > +	unsigned int tmp;
> > +	int irq;
> > +	int ret;
> > +
> > +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9063_hwmon),
> > +			     GFP_KERNEL);
> > +	if (!hwmon)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&hwmon->hwmon_mutex);
> > +	init_completion(&hwmon->adc_ready);
> > +	hwmon->da9063 = da9063;
> > +
> > +	irq = platform_get_irq_byname(pdev, DA9063_DRVNAME_HWMON);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +					da9063_hwmon_irq_handler,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					"HWMON", hwmon);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to request IRQ.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
> > +	if (ret < 0) {
> > +		tmp = 0;
> > +		dev_warn(&pdev->dev,
> > +			 "Temperature trimming value cannot be read (defaulting to 0)\n");
> > +	}
> > +	hwmon->tjunc_offset = (signed char) tmp;  
> 
> Nit: Unnecessary space after typecast (checkpatch --strict would tell you).
> 
> Also, I am curious: The temperature offset is a standard hwmon attribute.
> Is it an oversight to not report it, or is it on purpose ?
> 
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "da9063",
> > +							 hwmon,
> > +							 &da9063_chip_info,
> > +							 NULL);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static struct platform_driver da9063_hwmon_driver = {
> > +	.probe = da9063_hwmon_probe,
> > +	.driver = {
> > +		.name = DA9063_DRVNAME_HWMON,
> > +	},
> > +};
> > +module_platform_driver(da9063_hwmon_driver);
> > +
> > +MODULE_DESCRIPTION("Hardware monitor support device driver for Dialog DA9063");
> > +MODULE_AUTHOR("Vincent Pelletier <plr.vincent@gmail.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" DA9063_DRVNAME_HWMON);  




-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
