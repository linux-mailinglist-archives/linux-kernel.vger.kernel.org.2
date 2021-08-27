Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335AB3FA0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhH0VHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhH0VHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:07:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B56C0613D9;
        Fri, 27 Aug 2021 14:06:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q39so11219414oiw.12;
        Fri, 27 Aug 2021 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CDXp345Gn3uWr4OQe4FdB1ldW/01Lb2vli0HT5gwyII=;
        b=M3gz+9QVSLB2yaUIJY7+tLXyiqor8G/Zt/wa677x7HaIkOjx0OrW2zq/EyLhaI7oKW
         DyqhBGEPVyyPQf4yN9UnT1ubK9ZMQSksboKOp51ovv7kdCQilZjNKGR43ai7Kc4mFp9d
         9CAvAXPZ0tIUqm0yM0PiqYuk/hzTiTmPt/hOB6//oqnwinkgX74wbH/VXyKzLgHi2TEJ
         SdmxXjt39YEBYsS0l7qR6/xmyQxWGjKOhDH+6Grv7Cj+ZJph8KM1CpN4irQ37eUEpGT4
         nU+HXMF9iRnvZxGdrOjT9wrhzsP6XMW5gIexUd3D9boO++dJWKPgJejNmhYqIapmy5JI
         k2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CDXp345Gn3uWr4OQe4FdB1ldW/01Lb2vli0HT5gwyII=;
        b=O/Pvo+8hTWECbaSZ0R+SXyuIODHq0xII2Lt7X336yxpCIWJU4S5ThjC2Cuq/jXO7kp
         h9Bo9QP+Bn4PEsvxXJBQN+SRgfblmc54/391/UxAs9By8CtbavUL9MblQDSWdGKmASFR
         eV13F9Ah4j2k/a887Dk85HVNoASe1SRdGdGFsFm9LU28CL4lMn2OZTfMCHHRSmOiBE2Q
         7a/rEqexXIGdiFRNYlOq2a6ela47Qp1taOWvXJ2O8cWFAm+UDDcuF7rtyYpGSHBJn1PD
         101ikuRuIL8clPh4EoIsrzDX1VUMPQJ7XxyAFe2tWZm09jbJlcinwv/zuDFKWsSfHOAI
         1afw==
X-Gm-Message-State: AOAM532QY+3Ijom3ypgMXZvLFqm/SkNLXygDJ+xX6vx1JImfb46EE2fM
        koPQBUrEn5N1/PFtoiBPSTs=
X-Google-Smtp-Source: ABdhPJzrP8hnz2pxdty7CooudWTgj0phnerGlhwVhY418hlIrh37uPSwGu3HCMSBXUSGsXKDN64smA==
X-Received: by 2002:a05:6808:19a:: with SMTP id w26mr16586784oic.80.1630098410509;
        Fri, 27 Aug 2021 14:06:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z25sm1570769oic.24.2021.08.27.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:06:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 14:06:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Wei Huang <wei.huang2@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] hwmon: (k10temp): Show errors failing to read
Message-ID: <20210827210648.GA678755@roeck-us.net>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827201527.24454-4-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 03:15:27PM -0500, Mario Limonciello wrote:
> Enabling Yellow Carp was initially not working "properly"
> because extra IDs were needed, but this wasn't obvious because fail values
> from `amd_smn_read` were ignored.
> 
> Don't discard errors from any functions providing them, instead pass up
> to the caller.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hwmon/k10temp.c | 87 ++++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 38bc35ac8135..2edb49d39d22 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -98,8 +98,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  
>  struct k10temp_data {
>  	struct pci_dev *pdev;
> -	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> -	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
> +	int (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> +	int (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>  	int temp_offset;
>  	u32 temp_adjust_mask;
>  	u32 show_temp;
> @@ -129,55 +129,65 @@ static const struct tctl_offset tctl_offset_table[] = {
>  	{ 0x17, "AMD Ryzen Threadripper 29", 27000 }, /* 29{20,50,70,90}[W]X */
>  };
>  
> -static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
> +static int read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>  {
> -	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
> +	return pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>  }
>  
> -static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
> +static int read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>  {
> -	pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
> +	return pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>  }
>  
> -static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
> +static int amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>  			      unsigned int base, int offset, u32 *val)
>  {
> +	int ret;
> +
>  	mutex_lock(&nb_smu_ind_mutex);
> -	pci_bus_write_config_dword(pdev->bus, devfn,
> -				   base, offset);
> -	pci_bus_read_config_dword(pdev->bus, devfn,
> -				  base + 4, val);
> +	ret = pci_bus_write_config_dword(pdev->bus, devfn,
> +					 base, offset);
> +	if (ret)
> +		goto out;
> +	ret = pci_bus_read_config_dword(pdev->bus, devfn,
> +					base + 4, val);
> +out:
>  	mutex_unlock(&nb_smu_ind_mutex);
> +	return ret;
>  }
>  
> -static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
> +static int read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  {
> -	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> -			  F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
> +	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> +				F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>  }
>  
> -static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
> +static int read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  {
> -	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> -			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
> +	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
> +				F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>  }
>  
> -static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
> +static int read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>  {
> -	amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
> +	return amd_smn_read(amd_pci_dev_to_node_id(pdev),
> +			    ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>  }
>  
> -static long get_raw_temp(struct k10temp_data *data)
> +static int get_raw_temp(struct k10temp_data *data, long *val)
>  {
>  	u32 regval;
> -	long temp;
> +	int ret;
>  
> -	data->read_tempreg(data->pdev, &regval);
> -	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
> +	ret = data->read_tempreg(data->pdev, &regval);
> +	if (ret)
> +		return ret;
> +	*val = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>  	if (regval & data->temp_adjust_mask)
> -		temp -= 49000;
> -	return temp;
> +		*val -= 49000;
> +	if (*val < 0)
> +		return -EINVAL;

Please don't do that. More on that see below.

> +	return 0;
>  }
>  
>  static const char *k10temp_temp_label[] = {
> @@ -212,24 +222,27 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  {
>  	struct k10temp_data *data = dev_get_drvdata(dev);
>  	u32 regval;
> +	int ret;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
>  		switch (channel) {
>  		case 0:		/* Tctl */
> -			*val = get_raw_temp(data);
> -			if (*val < 0)
> -				*val = 0;

We have to take the history into account here. A negative value
is not an error per se, but it suggests that the chip returns wrong
data. See commit aef17ca12719 ("hwmon: (k10temp) Only apply temperature
offset if result is positive") for some of the background. I don't really
want to change that into an error return just because we don't know
what the chip is doing. Please retain the above code, either by fixing
the values up here or in get_raw_temp().

Thanks,
Guenter

> +			ret = get_raw_temp(data, val);
> +			if (ret)
> +				return ret;
>  			break;
>  		case 1:		/* Tdie */
> -			*val = get_raw_temp(data) - data->temp_offset;
> -			if (*val < 0)
> -				*val = 0;
> +			ret = get_raw_temp(data, val) - data->temp_offset;
> +			if (ret)
> +				return ret;
>  			break;
>  		case 2 ... 9:		/* Tccd{1-8} */
> -			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> +			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>  				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
>  						  &regval);
> +			if (ret)
> +				return ret;
>  			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>  			break;
>  		default:
> @@ -240,11 +253,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  		*val = 70 * 1000;
>  		break;
>  	case hwmon_temp_crit:
> -		data->read_htcreg(data->pdev, &regval);
> +		ret = data->read_htcreg(data->pdev, &regval);
> +		if (ret)
> +			return ret;
>  		*val = ((regval >> 16) & 0x7f) * 500 + 52000;
>  		break;
>  	case hwmon_temp_crit_hyst:
> -		data->read_htcreg(data->pdev, &regval);
> +		ret = data->read_htcreg(data->pdev, &regval);
> +		if (ret)
> +			return ret;
>  		*val = (((regval >> 16) & 0x7f)
>  			- ((regval >> 24) & 0xf)) * 500 + 52000;
>  		break;
