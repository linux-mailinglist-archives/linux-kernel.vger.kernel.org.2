Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054203FF427
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347371AbhIBT1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbhIBT1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:27:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46DDC061575;
        Thu,  2 Sep 2021 12:26:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i3-20020a056830210300b0051af5666070so3931327otc.4;
        Thu, 02 Sep 2021 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/irr6D8qG0SQzF5oPNMlXJMYSZ2i27k5N+EsFPZBN8=;
        b=AJuJHfAEnNFsobWyPZ9KGY2PGdXzq279KZdeU347W9S29NPgIW22MNu97RB+2zJzx/
         6WV/0jhSxdqP2bIqm8HNrEKSXAhZFzsvncjFQsNdlT5aCYEkFLYZzQofwKtcaMvQVxbv
         5s9YDZC32Vcorv38NB4KdRKgC7seE7kvc4HpYRtbyYvlnfR/MiolrCqkQ2EofD5BOY2M
         0APec281TkP8myUjTfQ6sKV7GUXGmB2K6SvgNB5xU2LCKGLLaGRVbk+XS/+qRLmj2bWJ
         fYQU/Mn+EbYbjqz2785il5vNRuGJQd3gq41wbjJsgdgVNnka0cGvoy96NcTEWcBQj4zO
         bW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j/irr6D8qG0SQzF5oPNMlXJMYSZ2i27k5N+EsFPZBN8=;
        b=J5ojyWrXDEaZYkxxlqUHO85FyTpsT/ncePet1UhqZ1pM5JS191QZlMHH9MkHSgUHq6
         2LiJQNdNqXY8Zg+JmofMSmENMnporJXhJD4jhnigopsqKTU4lvtqMXnithYX4xYVBjVq
         Kc6a0TI5UJAYY184Z57FpWUJ3GzFcd054C/B5EqbAYABMMICVQgTXutOOMSxddAYgUA8
         /ykUmtH/EF39N+Bn6jQP1+iYV9FKXPsezfDNPPHLnwaMvN9btiq0pMM+BY8e4HG0lz9q
         ag5Ng8OCyWvWKCithvquM8uqalvanXjIUzyC12dqNMw1druG/Z113utjHoQ1ww0A7FAi
         PqmA==
X-Gm-Message-State: AOAM531BFRO9g9/ynzhOH2zgpR+UWMLeDqHmCX/AJ9XyiipjtI2KJKwc
        IWIk6DtNuZuSyfJHagVp7jhcjzagcIU=
X-Google-Smtp-Source: ABdhPJwq/SXhv7chptBXiigdpNMWt+rcOMXBWWianeykbBWISVz/12DJaypm5jkM9z08jZCewe0gOw==
X-Received: by 2002:a9d:7c8a:: with SMTP id q10mr3842736otn.160.1630610805906;
        Thu, 02 Sep 2021 12:26:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm544085oic.31.2021.09.02.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:26:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Sep 2021 12:26:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, yazen.ghannam@amd.com,
        mingo@redhat.com, nathan.fontenot@amd.com, lewis.carroll@amd.com
Subject: Re: [PATCH 3/3] k10temp: Add power sensor for family 19h
Message-ID: <20210902192643.GA1872340@roeck-us.net>
References: <20210902174155.7365-1-nchatrad@amd.com>
 <20210902174155.7365-3-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902174155.7365-3-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:11:55PM +0530, Naveen Krishna Chatradhi wrote:
> On newer Fam19h server line of AMD processors a new channel
> is created to report and manage socket power limits.
> 
> This patch creates hwmon_power sensor to report current power,
> power cap and max power cap of the socket.
> While at it, update the k10temp documentation
> 
> Tested-by: suma hegde <suma.hegde@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Would it make sense to add this to fam15h_power instead ?
Just wondering, no strong opinion. That driver does seem to be
a bit messy, so it might be best to leave it alone.

One other question, though: We had to drop the amd_energy driver
because it opened up an attack surface. Is the power consumption
reported by this patch vague enough that this won't be a problem ?

Thanks,
Guenter

> ---
>  Documentation/hwmon/k10temp.rst |  18 ++++++
>  drivers/hwmon/k10temp.c         | 106 ++++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/Documentation/hwmon/k10temp.rst b/Documentation/hwmon/k10temp.rst
> index 91b99adc6c48..d5a78a7b6ca5 100644
> --- a/Documentation/hwmon/k10temp.rst
> +++ b/Documentation/hwmon/k10temp.rst
> @@ -132,3 +132,21 @@ On Family 17h and Family 18h CPUs, additional temperature sensors may report
>  Core Complex Die (CCD) temperatures. Up to 8 such temperatures are reported
>  as temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
>  variant.
> +
> +On Family 19h server line of CPUs, additionally driver may report socket
> +current power consumption with power cap and power cap max. This requires the
> +HSMP support exported in the amd_nb module.
> +
> +The power1_cap can be set to any value, SMU FW will limit the maximum cap to
> +the value reported by power1_cap_max entry. The SMU FW may not take any action
> +if the power1_cap is set to a value lesser than the minimum socket consumption.
> +
> +The following attributes may be reported.
> +
> +================ ===== ========================================================
> +Name             Perm  Description
> +================ ===== ========================================================
> +power1_input     RO    Socket current Power consumed
> +power1_cap       RW    Socket Power limit can be set between 0 and power1_cap_max
> +power1_cap_max   RO    Maximum powerlimit calculated and reported by the SMU FW
> +================ ===== ========================================================
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 3618a924e78e..b993fdd94979 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -105,6 +105,9 @@ struct k10temp_data {
>  	u32 show_temp;
>  	bool is_zen;
>  	u32 ccd_offset;
> +	bool show_power;
> +	char pwr_label[20];
> +	u32 power_cap_max;
>  };
>  
>  #define TCTL_BIT	0
> @@ -197,10 +200,14 @@ static int k10temp_read_labels(struct device *dev,
>  			       enum hwmon_sensor_types type,
>  			       u32 attr, int channel, const char **str)
>  {
> +	struct k10temp_data *data = dev_get_drvdata(dev);
>  	switch (type) {
>  	case hwmon_temp:
>  		*str = k10temp_temp_label[channel];
>  		break;
> +	case hwmon_power:
> +		*str = data->pwr_label;
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -254,12 +261,43 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  	return 0;
>  }
>  
> +static int k10temp_read_power(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct k10temp_data *data = dev_get_drvdata(dev);
> +	struct hsmp_message msg = { 0 };
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		msg.msg_id = HSMP_GET_SOCKET_POWER;
> +		break;
> +	case hwmon_power_cap:
> +		msg.msg_id = HSMP_GET_SOCKET_POWER_LIMIT;
> +		break;
> +	case hwmon_power_cap_max:
> +		/* power_cap_max does not change dynamically, hence return the cached value */
> +		*val = data->power_cap_max * 1000;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	msg.response_sz = 1;
> +	err = hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
> +	if (!err)
> +		/* power metric is reported in micro watts. hence multiply by 1000 */
> +		*val = msg.response[0] * 1000;
> +
> +	return err;
> +}
> +
>  static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
>  			u32 attr, int channel, long *val)
>  {
>  	switch (type) {
>  	case hwmon_temp:
>  		return k10temp_read_temp(dev, attr, channel, val);
> +	case hwmon_power:
> +		return k10temp_read_power(dev, attr, channel, val);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -308,12 +346,45 @@ static umode_t k10temp_is_visible(const void *_data,
>  			return 0;
>  		}
>  		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +		case hwmon_power_cap_max:
> +		case hwmon_power_label:
> +			/* Show power attributes only if show_power is available */
> +			if (data->show_power)
> +				break;
> +			return 0;
> +		case hwmon_power_cap:
> +			if (data->show_power)
> +				return 0644;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
>  	default:
>  		return 0;
>  	}
>  	return 0444;
>  }
>  
> +static int k10temp_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	struct hsmp_message msg = { 0 };
> +	struct k10temp_data *data = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_power && attr == hwmon_power_cap) {
> +		msg.response_sz = 1;
> +		msg.num_args	= 1;
> +		msg.msg_id	= HSMP_SET_SOCKET_POWER_LIMIT;
> +		msg.args[0]	= val / 1000;
> +		return hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
>  static bool has_erratum_319(struct pci_dev *pdev)
>  {
>  	u32 pkg_type, reg_dram_cfg;
> @@ -362,6 +433,9 @@ static const struct hwmon_channel_info *k10temp_info[] = {
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL |
> +			   HWMON_P_CAP | HWMON_P_CAP_MAX),
>  	NULL
>  };
>  
> @@ -369,6 +443,7 @@ static const struct hwmon_ops k10temp_hwmon_ops = {
>  	.is_visible = k10temp_is_visible,
>  	.read = k10temp_read,
>  	.read_string = k10temp_read_labels,
> +	.write = k10temp_write,
>  };
>  
>  static const struct hwmon_chip_info k10temp_chip_info = {
> @@ -390,6 +465,32 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>  	}
>  }
>  
> +static int k10temp_get_max_power(struct k10temp_data *data)
> +{
> +	int err;
> +	struct hsmp_message msg = { 0 };
> +
> +	msg.msg_id = HSMP_GET_SOCKET_POWER_LIMIT_MAX;
> +	msg.response_sz = 1;
> +	err = hsmp_send_message(amd_pci_dev_to_node_id(data->pdev), &msg);
> +	if (!err)
> +		data->power_cap_max = msg.response[0];
> +	return err;
> +}
> +
> +static void check_power_support(struct k10temp_data *data)
> +{
> +	/* HSMP support is required to obtain power metrics */
> +	if (!amd_nb_has_feature(AMD_NB_HSMP))
> +		return;
> +
> +	if (k10temp_get_max_power(data))
> +		return;
> +
> +	sprintf(data->pwr_label, "socket%d_pwr", amd_pci_dev_to_node_id(data->pdev));
> +	data->show_power = true;
> +}
> +
>  static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	int unreliable = has_erratum_319(pdev);
> @@ -448,6 +549,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  		switch (boot_cpu_data.x86_model) {
>  		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
> +		case 0x30 ... 0x31:
> +			check_power_support(data);
> +			data->ccd_offset = 0x154;
> +			k10temp_get_ccd_support(pdev, data, 8);
> +			break;
>  		case 0x21:		/* Zen3 Ryzen Desktop */
>  		case 0x50 ... 0x5f:	/* Green Sardine */
>  			data->ccd_offset = 0x154;
