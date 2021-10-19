Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538E4332B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhJSJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhJSJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634636495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QecxdLTWPEyiceKCSJDV+pAbr0vqICEs6iWHJyVMLgQ=;
        b=JsB/yfqHPDAKuZh4OHRWXfD9xm/8uK/SMYrSo3t/pg3bE8k3v0VwkXMnSbOZ7DTdfsIXBA
        voecCfKSS1OfZiuz6nDTsOlHuLYUaT9qu3rpoUswP1fsdbj/gpsgbVpapla0K653K7ystx
        S4kDK0OI9khPW8V/ldHvsnwgl6VEnqo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-jayS8za5P_qat7BHAH263g-1; Tue, 19 Oct 2021 05:41:33 -0400
X-MC-Unique: jayS8za5P_qat7BHAH263g-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so14019368edj.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QecxdLTWPEyiceKCSJDV+pAbr0vqICEs6iWHJyVMLgQ=;
        b=03QnETvdqFB7D0nTxVm4jSsNmyvUMW+MEkBtM9OhVW+mOUhxdlI9Nb44/h5kL9eTEB
         eHKj4n67CkfU6raeO3WBo7+V9VgUc9D/f41kK/hYK7NbNexbwth3rJM6JaxnkDXFpsC5
         tMCgjOhP5n9y6tlnmQvnLylFxYc5NXS95ulN4Pdu5N4Ob9yq21VtzjqeKLXmt1XA4XCM
         tQQ7J265ZQEBEgPpzn1a/x5Y5G2XuxSPIY5PM95auVrNCug07zh3SxnID5ljIWyuzInA
         wMzLKBC0nGRmxxDppkdoADNMiEwKCgiuL/rV2sFOWOui/NvhVXCu7CfsoYnmNeQa+YBw
         aQiA==
X-Gm-Message-State: AOAM531TRXR8bSRNrgsnGGeai26KlmenfNHbGI7sQsPdno8+dQXVpVAA
        Iru+8SYqe2JBpczYPw+lD3LF4deQikMh14K9dYQ7VDDKfIVzl0Jv3cxkuQ0lyCuatp17twxLazD
        PdX0spyT13uKQxcYMX7fJLapz
X-Received: by 2002:a05:6402:b15:: with SMTP id bm21mr52231789edb.380.1634636492048;
        Tue, 19 Oct 2021 02:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjhspGNPctl83/78PwUmiyxdDVcRg7Rnhc33W1FMZDTcIY7LNhXoCp6P6v7RiIxsTUuH4dAw==
X-Received: by 2002:a05:6402:b15:: with SMTP id bm21mr52231737edb.380.1634636491577;
        Tue, 19 Oct 2021 02:41:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id di4sm11104015edb.34.2021.10.19.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 02:41:31 -0700 (PDT)
Message-ID: <cad3c7dc-cfba-6032-4951-7c2061797b7b@redhat.com>
Date:   Tue, 19 Oct 2021 11:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Convert platform driver to
 use dev_groups
Content-Language: en-US
To:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211003091949.7339-1-len.baker@gmx.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211003091949.7339-1-len.baker@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On 10/3/21 11:19, Len Baker wrote:
> Platform drivers have the option of having the platform core create and
> remove any needed sysfs attribute files. So take advantage of that and
> refactor the attributes management to avoid to register them "by hand".
> 
> Also, due to some attributes are optionals, refactor the code and move
> the logic inside the "is_visible" callbacks of the attribute_group
> structures.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>

Thank you for the patch, this indeed results in a nice improvement.

Unfortunately I cannot take this as is (because it will trigger
a BUG_ON). See my inline remarks, if you can do a v2 with those
fixed that would be great.

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 536 ++++++++++++---------------
>  1 file changed, 236 insertions(+), 300 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 07b9710d500e..270eb4f373c9 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -332,9 +332,7 @@ static struct {
>  	u32 battery_force_primary:1;
>  	u32 input_device_registered:1;
>  	u32 platform_drv_registered:1;
> -	u32 platform_drv_attrs_registered:1;
>  	u32 sensors_pdrv_registered:1;
> -	u32 sensors_pdrv_attrs_registered:1;
>  	u32 sensors_pdev_attrs_registered:1;
>  	u32 hotkey_poll_active:1;
>  	u32 has_adaptive_kbd:1;
> @@ -983,20 +981,6 @@ static void tpacpi_shutdown_handler(struct platform_device *pdev)
>  	}
>  }
> 
> -static struct platform_driver tpacpi_pdriver = {
> -	.driver = {
> -		.name = TPACPI_DRVR_NAME,
> -		.pm = &tpacpi_pm,
> -	},
> -	.shutdown = tpacpi_shutdown_handler,
> -};
> -
> -static struct platform_driver tpacpi_hwmon_pdriver = {
> -	.driver = {
> -		.name = TPACPI_HWMON_DRVR_NAME,
> -	},
> -};
> -
>  /*************************************************************************
>   * sysfs support helpers
>   */
> @@ -1488,53 +1472,6 @@ static ssize_t uwb_emulstate_store(struct device_driver *drv, const char *buf,
>  static DRIVER_ATTR_RW(uwb_emulstate);
>  #endif
> 
> -/* --------------------------------------------------------------------- */
> -
> -static struct driver_attribute *tpacpi_driver_attributes[] = {
> -	&driver_attr_debug_level, &driver_attr_version,
> -	&driver_attr_interface_version,
> -};
> -
> -static int __init tpacpi_create_driver_attributes(struct device_driver *drv)
> -{
> -	int i, res;
> -
> -	i = 0;
> -	res = 0;
> -	while (!res && i < ARRAY_SIZE(tpacpi_driver_attributes)) {
> -		res = driver_create_file(drv, tpacpi_driver_attributes[i]);
> -		i++;
> -	}
> -
> -#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
> -	if (!res && dbg_wlswemul)
> -		res = driver_create_file(drv, &driver_attr_wlsw_emulstate);
> -	if (!res && dbg_bluetoothemul)
> -		res = driver_create_file(drv, &driver_attr_bluetooth_emulstate);
> -	if (!res && dbg_wwanemul)
> -		res = driver_create_file(drv, &driver_attr_wwan_emulstate);
> -	if (!res && dbg_uwbemul)
> -		res = driver_create_file(drv, &driver_attr_uwb_emulstate);
> -#endif
> -
> -	return res;
> -}
> -
> -static void tpacpi_remove_driver_attributes(struct device_driver *drv)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
> -		driver_remove_file(drv, tpacpi_driver_attributes[i]);
> -
> -#ifdef THINKPAD_ACPI_DEBUGFACILITIES
> -	driver_remove_file(drv, &driver_attr_wlsw_emulstate);
> -	driver_remove_file(drv, &driver_attr_bluetooth_emulstate);
> -	driver_remove_file(drv, &driver_attr_wwan_emulstate);
> -	driver_remove_file(drv, &driver_attr_uwb_emulstate);
> -#endif
> -}
> -
>  /*************************************************************************
>   * Firmware Data
>   */
> @@ -3008,7 +2945,14 @@ static struct attribute *adaptive_kbd_attributes[] = {
>  	NULL
>  };
> 
> +static umode_t hadaptive_kbd_attr_is_visible(struct kobject *kobj,
> +					     struct attribute *attr, int n)
> +{
> +	return tp_features.has_adaptive_kbd ? attr->mode : 0;
> +}
> +
>  static const struct attribute_group adaptive_kbd_attr_group = {
> +	.is_visible = hadaptive_kbd_attr_is_visible,
>  	.attrs = adaptive_kbd_attributes,
>  };
> 
> @@ -3106,8 +3050,6 @@ static void hotkey_exit(void)
>  	hotkey_poll_stop_sync();
>  	mutex_unlock(&hotkey_mutex);
>  #endif
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
> -
>  	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
>  		   "restoring original HKEY status and mask\n");
>  	/* yes, there is a bitwise or below, we want the
> @@ -3502,14 +3444,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  			 */
>  			if (acpi_evalf(hkey_handle, &hotkey_adaptive_all_mask,
>  				       "MHKA", "dd", 2)) {
> -				if (hotkey_adaptive_all_mask != 0) {
> +				if (hotkey_adaptive_all_mask != 0)
>  					tp_features.has_adaptive_kbd = true;
> -					res = sysfs_create_group(
> -						&tpacpi_pdev->dev.kobj,
> -						&adaptive_kbd_attr_group);
> -					if (res)
> -						goto err_exit;
> -				}
>  			} else {
>  				tp_features.has_adaptive_kbd = false;
>  				hotkey_adaptive_all_mask = 0x0U;
> @@ -3563,9 +3499,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  	}
> 
>  	tabletsw_state = hotkey_init_tablet_mode();
> -	res = sysfs_create_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
> -	if (res)
> -		goto err_exit;
> 
>  	/* Set up key map */
>  	keymap_id = tpacpi_check_quirks(tpacpi_keymap_qtable,
> @@ -3662,9 +3595,6 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>  	return 0;
> 
>  err_exit:
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &adaptive_kbd_attr_group);
> -
>  	return (res < 0) ? res : 1;
>  }
> 
> @@ -4396,7 +4326,14 @@ static struct attribute *bluetooth_attributes[] = {
>  	NULL
>  };
> 
> +static umode_t bluetooth_attr_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int n)
> +{
> +	return tp_features.bluetooth ? attr->mode : 0;
> +}
> +
>  static const struct attribute_group bluetooth_attr_group = {
> +	.is_visible = bluetooth_attr_is_visible,
>  	.attrs = bluetooth_attributes,
>  };
> 
> @@ -4418,11 +4355,7 @@ static void bluetooth_shutdown(void)
> 
>  static void bluetooth_exit(void)
>  {
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
> -			&bluetooth_attr_group);
> -
>  	tpacpi_destroy_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID);
> -
>  	bluetooth_shutdown();
>  }
> 
> @@ -4536,17 +4469,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
>  				RFKILL_TYPE_BLUETOOTH,
>  				TPACPI_RFK_BLUETOOTH_SW_NAME,
>  				true);
> -	if (res)
> -		return res;
> -
> -	res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
> -				&bluetooth_attr_group);
> -	if (res) {
> -		tpacpi_destroy_rfkill(TPACPI_RFK_BLUETOOTH_SW_ID);
> -		return res;
> -	}
> -
> -	return 0;
> +	return res;
>  }
> 
>  /* procfs -------------------------------------------------------------- */
> @@ -4653,7 +4576,14 @@ static struct attribute *wan_attributes[] = {
>  	NULL
>  };
> 
> +static umode_t wan_attr_is_visible(struct kobject *kobj, struct attribute *attr,
> +				   int n)
> +{
> +	return tp_features.wan ? attr->mode : 0;
> +}
> +
>  static const struct attribute_group wan_attr_group = {
> +	.is_visible = wan_attr_is_visible,
>  	.attrs = wan_attributes,
>  };
> 
> @@ -4675,11 +4605,7 @@ static void wan_shutdown(void)
> 
>  static void wan_exit(void)
>  {
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
> -		&wan_attr_group);
> -
>  	tpacpi_destroy_rfkill(TPACPI_RFK_WWAN_SW_ID);
> -
>  	wan_shutdown();
>  }
> 
> @@ -4723,18 +4649,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
>  				RFKILL_TYPE_WWAN,
>  				TPACPI_RFK_WWAN_SW_NAME,
>  				true);
> -	if (res)
> -		return res;
> -
> -	res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
> -				&wan_attr_group);
> -
> -	if (res) {
> -		tpacpi_destroy_rfkill(TPACPI_RFK_WWAN_SW_ID);
> -		return res;
> -	}
> -
> -	return 0;
> +	return res;
>  }
> 
>  /* procfs -------------------------------------------------------------- */
> @@ -5635,30 +5550,35 @@ static ssize_t cmos_command_store(struct device *dev,
> 
>  static DEVICE_ATTR_WO(cmos_command);
> 
> +static struct attribute *cmos_attributes[] = {
> +	&dev_attr_cmos_command.attr,
> +	NULL
> +};
> +
> +static umode_t cmos_attr_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	return cmos_handle ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group cmos_attr_group = {
> +	.is_visible = cmos_attr_is_visible,
> +	.attrs = cmos_attributes,
> +};
> +
>  /* --------------------------------------------------------------------- */
> 
>  static int __init cmos_init(struct ibm_init_struct *iibm)
>  {
> -	int res;
> -
>  	vdbg_printk(TPACPI_DBG_INIT,
> -		"initializing cmos commands subdriver\n");
> +		    "initializing cmos commands subdriver\n");
> 
>  	TPACPI_ACPIHANDLE_INIT(cmos);
> 
>  	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
> -		str_supported(cmos_handle != NULL));
> -
> -	res = device_create_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
> -	if (res)
> -		return res;
> +		    str_supported(cmos_handle != NULL));
> 
> -	return (cmos_handle) ? 0 : 1;
> -}
> -
> -static void cmos_exit(void)
> -{
> -	device_remove_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
> +	return cmos_handle ? 0 : 1;
>  }
> 
>  static int cmos_read(struct seq_file *m)
> @@ -5699,7 +5619,6 @@ static struct ibm_struct cmos_driver_data = {
>  	.name = "cmos",
>  	.read = cmos_read,
>  	.write = cmos_write,
> -	.exit = cmos_exit,
>  };
> 
>  /*************************************************************************
> @@ -6210,7 +6129,6 @@ struct ibm_thermal_sensors_struct {
>  };
> 
>  static enum thermal_access_mode thermal_read_mode;
> -static const struct attribute_group *thermal_attr_group;
>  static bool thermal_use_labels;
> 
>  /* idx is zero-based */
> @@ -6383,12 +6301,26 @@ static struct attribute *thermal_temp_input_attr[] = {
>  	NULL
>  };
> 
> -static const struct attribute_group thermal_temp_input16_group = {
> -	.attrs = thermal_temp_input_attr
> -};
> +static umode_t thermal_attr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int n)
> +{
> +	if (thermal_read_mode == TPACPI_THERMAL_NONE)
> +		return 0;
> +
> +	if (attr == THERMAL_ATTRS(8) || attr == THERMAL_ATTRS(9) ||
> +	    attr == THERMAL_ATTRS(10) || attr == THERMAL_ATTRS(11) ||
> +	    attr == THERMAL_ATTRS(12) || attr == THERMAL_ATTRS(13) ||
> +	    attr == THERMAL_ATTRS(14) || attr == THERMAL_ATTRS(15)) {
> +		if (thermal_read_mode != TPACPI_THERMAL_TPEC_16)
> +			return 0;
> +	}
> 
> -static const struct attribute_group thermal_temp_input8_group = {
> -	.attrs = &thermal_temp_input_attr[8]
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group thermal_attr_group = {
> +	.is_visible = thermal_attr_is_visible,
> +	.attrs = thermal_temp_input_attr,
>  };
> 
>  #undef THERMAL_SENSOR_ATTR_TEMP
> @@ -6412,7 +6344,14 @@ static struct attribute *temp_label_attributes[] = {
>  	NULL
>  };
> 
> +static umode_t temp_label_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int n)
> +{
> +	return thermal_use_labels ? attr->mode : 0;
> +}
> +
>  static const struct attribute_group temp_label_attr_group = {
> +	.is_visible = temp_label_attr_is_visible,
>  	.attrs = temp_label_attributes,
>  };
> 
> @@ -6423,7 +6362,6 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
>  	u8 t, ta1, ta2, ver = 0;
>  	int i;
>  	int acpi_tmp7;
> -	int res;
> 
>  	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
> 
> @@ -6498,42 +6436,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
>  		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
>  		thermal_read_mode);
> 
> -	switch (thermal_read_mode) {
> -	case TPACPI_THERMAL_TPEC_16:
> -		thermal_attr_group = &thermal_temp_input16_group;
> -		break;
> -	case TPACPI_THERMAL_TPEC_8:
> -	case TPACPI_THERMAL_ACPI_TMP07:
> -	case TPACPI_THERMAL_ACPI_UPDT:
> -		thermal_attr_group = &thermal_temp_input8_group;
> -		break;
> -	case TPACPI_THERMAL_NONE:
> -	default:
> -		return 1;
> -	}
> -
> -	res = sysfs_create_group(&tpacpi_hwmon->kobj, thermal_attr_group);
> -	if (res)
> -		return res;
> -
> -	if (thermal_use_labels) {
> -		res = sysfs_create_group(&tpacpi_hwmon->kobj, &temp_label_attr_group);
> -		if (res) {
> -			sysfs_remove_group(&tpacpi_hwmon->kobj, thermal_attr_group);
> -			return res;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void thermal_exit(void)
> -{
> -	if (thermal_attr_group)
> -		sysfs_remove_group(&tpacpi_hwmon->kobj, thermal_attr_group);
> -
> -	if (thermal_use_labels)
> -		sysfs_remove_group(&tpacpi_hwmon->kobj, &temp_label_attr_group);
> +	return thermal_read_mode == TPACPI_THERMAL_NONE ? 1 : 0;
>  }
> 
>  static int thermal_read(struct seq_file *m)
> @@ -6560,7 +6463,6 @@ static int thermal_read(struct seq_file *m)
>  static struct ibm_struct thermal_driver_data = {
>  	.name = "thermal",
>  	.read = thermal_read,
> -	.exit = thermal_exit,
>  };
> 
>  /*************************************************************************
> @@ -8735,14 +8637,34 @@ static ssize_t fan_watchdog_store(struct device_driver *drv, const char *buf,
>  static DRIVER_ATTR_RW(fan_watchdog);
> 
>  /* --------------------------------------------------------------------- */
> +
>  static struct attribute *fan_attributes[] = {
> -	&dev_attr_pwm1_enable.attr, &dev_attr_pwm1.attr,
> +	&dev_attr_pwm1_enable.attr,
> +	&dev_attr_pwm1.attr,
>  	&dev_attr_fan1_input.attr,
> -	NULL, /* for fan2_input */
> +	&dev_attr_fan2_input.attr,
> +	&driver_attr_fan_watchdog.attr,
>  	NULL
>  };
> 
> +static umode_t fan_attr_is_visible(struct kobject *kobj, struct attribute *attr,
> +				   int n)
> +{
> +	if (fan_status_access_mode != TPACPI_FAN_NONE ||
> +	    fan_control_access_mode != TPACPI_FAN_WR_NONE) {
> +		if (attr == &dev_attr_fan2_input.attr) {
> +			if (!tp_features.second_fan)
> +				return 0;
> +		}
> +
> +		return attr->mode;
> +	}


Can you refactor this one to not have nested if-s and put the
"return attr->mode;" at the end like the other is_visible
functions please ?


> +
> +	return 0;
> +}
> +
>  static const struct attribute_group fan_attr_group = {
> +	.is_visible = fan_attr_is_visible,
>  	.attrs = fan_attributes,
>  };
> 
> @@ -8772,7 +8694,6 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
> 
>  static int __init fan_init(struct ibm_init_struct *iibm)
>  {
> -	int rc;
>  	unsigned long quirks;
> 
>  	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
> @@ -8869,27 +8790,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		fan_get_status_safe(NULL);
> 
>  	if (fan_status_access_mode != TPACPI_FAN_NONE ||
> -	    fan_control_access_mode != TPACPI_FAN_WR_NONE) {
> -		if (tp_features.second_fan) {
> -			/* attach second fan tachometer */
> -			fan_attributes[ARRAY_SIZE(fan_attributes)-2] =
> -					&dev_attr_fan2_input.attr;
> -		}
> -		rc = sysfs_create_group(&tpacpi_hwmon->kobj,
> -					 &fan_attr_group);
> -		if (rc < 0)
> -			return rc;
> -
> -		rc = driver_create_file(&tpacpi_hwmon_pdriver.driver,
> -					&driver_attr_fan_watchdog);
> -		if (rc < 0) {
> -			sysfs_remove_group(&tpacpi_hwmon->kobj,
> -					&fan_attr_group);
> -			return rc;
> -		}
> +	    fan_control_access_mode != TPACPI_FAN_WR_NONE)
>  		return 0;
> -	} else
> -		return 1;
> +
> +	return 1;
>  }
> 
>  static void fan_exit(void)
> @@ -8897,11 +8801,6 @@ static void fan_exit(void)
>  	vdbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_FAN,
>  		    "cancelling any pending fan watchdog tasks\n");
> 
> -	/* FIXME: can we really do this unconditionally? */
> -	sysfs_remove_group(&tpacpi_hwmon->kobj, &fan_attr_group);
> -	driver_remove_file(&tpacpi_hwmon_pdriver.driver,
> -			   &driver_attr_fan_watchdog);
> -
>  	cancel_delayed_work(&fan_watchdog_task);
>  	flush_workqueue(tpacpi_wq);
>  }
> @@ -9963,6 +9862,35 @@ static ssize_t palmsensor_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(palmsensor);
> 
> +static struct attribute *proxsensor_attributes[] = {
> +	&dev_attr_dytc_lapmode.attr,
> +	&dev_attr_palmsensor.attr,
> +	NULL
> +};
> +
> +static umode_t proxsensor_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int n)
> +{
> +	if (attr == &dev_attr_dytc_lapmode.attr) {
> +		/*
> +		 * Platforms before DYTC version 5 claim to have a lap sensor,
> +		 * but it doesn't work, so we ignore them.
> +		 */
> +		if (!has_lapsensor ||  dytc_version < 5)
> +			return 0;
> +	} else if (attr == &dev_attr_palmsensor.attr) {
> +		if (!has_palmsensor)
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group proxsensor_attr_group = {
> +	.is_visible = proxsensor_attr_is_visible,
> +	.attrs = proxsensor_attributes,
> +};
> +
>  static int tpacpi_proxsensor_init(struct ibm_init_struct *iibm)
>  {
>  	int palm_err, lap_err, err;
> @@ -9981,43 +9909,16 @@ static int tpacpi_proxsensor_init(struct ibm_init_struct *iibm)
>  	if (lap_err && (lap_err != -ENODEV))
>  		return lap_err;
> 
> -	if (has_palmsensor) {
> -		err = sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_palmsensor.attr);
> -		if (err)
> -			return err;
> -	}
> -
>  	/* Check if we know the DYTC version, if we don't then get it */
>  	if (!dytc_version) {
>  		err = dytc_get_version();
>  		if (err)
>  			return err;
>  	}
> -	/*
> -	 * Platforms before DYTC version 5 claim to have a lap sensor, but it doesn't work, so we
> -	 * ignore them
> -	 */
> -	if (has_lapsensor && (dytc_version >= 5)) {
> -		err = sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_dytc_lapmode.attr);
> -		if (err)
> -			return err;
> -	}
> -	return 0;
> -}
> 
> -static void proxsensor_exit(void)
> -{
> -	if (has_lapsensor)
> -		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_dytc_lapmode.attr);
> -	if (has_palmsensor)
> -		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_palmsensor.attr);
> +	return 0;
>  }
> 
> -static struct ibm_struct proxsensor_driver_data = {
> -	.name = "proximity-sensor",
> -	.exit = proxsensor_exit,
> -};
> -

So when I came here during the review I decided a v2 was necessary.

The way the sub-drivers inside thinkpad_acpi work is they must have a
struct ibm_struct associated with them, even if it is just for the name
field.

This is enforced rather harshly (something to fix in another patch)
by this bit of code:

```
static int __init ibm_init(struct ibm_init_struct *iibm)
{
        int ret;
        struct ibm_struct *ibm = iibm->data;
        struct proc_dir_entry *entry;

        BUG_ON(ibm == NULL);
```

The name is used in various places and the struct is also used to
store various house-keeping flags.

So for v2 please keep the proxsensor_driver_data struct here, as well
as for dprc_driver_data.


>  /*************************************************************************
>   * DYTC Platform Profile interface
>   */
> @@ -10432,37 +10333,18 @@ static struct attribute *kbdlang_attributes[] = {
>  	NULL
>  };
> 
> -static const struct attribute_group kbdlang_attr_group = {
> -	.attrs = kbdlang_attributes,
> -};
> -
> -static int tpacpi_kbdlang_init(struct ibm_init_struct *iibm)
> +static umode_t kbdlang_attr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int n)
>  {
>  	int err, output;
> 
>  	err = get_keyboard_lang(&output);
> -	/*
> -	 * If support isn't available (ENODEV) then don't return an error
> -	 * just don't create the sysfs group.
> -	 */
> -	if (err == -ENODEV)
> -		return 0;
> -
> -	if (err)
> -		return err;
> -
> -	/* Platform supports this feature - create the sysfs file */
> -	return sysfs_create_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_group);
> +	return err ? 0 : attr->mode;
>  }

get_keyboard_lang() consists of 2 not cheap ACPI calls, one of
which involves talking to the embedded-controller over some slow bus.

Please keep kbdlang_init() and make it set a flag to use inside
kbdlang_attr_is_visible().


> 
> -static void kbdlang_exit(void)
> -{
> -	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_group);
> -}
> -
> -static struct ibm_struct kbdlang_driver_data = {
> -	.name = "kbdlang",
> -	.exit = kbdlang_exit,
> +static const struct attribute_group kbdlang_attr_group = {
> +	.is_visible = kbdlang_attr_is_visible,
> +	.attrs = kbdlang_attributes,
>  };
> 
>  /*************************************************************************
> @@ -10533,41 +10415,127 @@ static ssize_t wwan_antenna_type_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(wwan_antenna_type);
> 
> +static struct attribute *dprc_attributes[] = {
> +	&dev_attr_wwan_antenna_type.attr,
> +	NULL
> +};
> +
> +static umode_t dprc_attr_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	return has_antennatype ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group dprc_attr_group = {
> +	.is_visible = dprc_attr_is_visible,
> +	.attrs = dprc_attributes,
> +};
> +
>  static int tpacpi_dprc_init(struct ibm_init_struct *iibm)
>  {
> -	int wwanantenna_err, err;
> +	int err = get_wwan_antenna(&wwan_antennatype);
> 
> -	wwanantenna_err = get_wwan_antenna(&wwan_antennatype);
>  	/*
>  	 * If support isn't available (ENODEV) then quit, but don't
>  	 * return an error.
>  	 */
> -	if (wwanantenna_err == -ENODEV)
> +	if (err == -ENODEV)
>  		return 0;
> 
> -	/* if there was an error return it */
> -	if (wwanantenna_err && (wwanantenna_err != -ENODEV))
> -		return wwanantenna_err;
> -	else if (!wwanantenna_err)
> -		has_antennatype = true;
> +	/* If there was an error return it */
> +	if (err)
> +		return err;
> 
> -	if (has_antennatype) {
> -		err = sysfs_create_file(&tpacpi_pdev->dev.kobj, &dev_attr_wwan_antenna_type.attr);
> -		if (err)
> -			return err;
> -	}
> +	has_antennatype = true;
>  	return 0;
>  }
> 
> -static void dprc_exit(void)
> +/* --------------------------------------------------------------------- */
> +
> +static struct attribute *tpacpi_attributes[] = {
> +	&driver_attr_debug_level.attr,
> +	&driver_attr_version.attr,
> +	&driver_attr_interface_version.attr,
> +#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
> +	&driver_attr_wlsw_emulstate.attr,
> +	&driver_attr_bluetooth_emulstate.attr,
> +	&driver_attr_wwan_emulstate.attr,
> +	&driver_attr_uwb_emulstate.attr,
> +#endif
> +	NULL
> +};
> +
> +#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
> +static umode_t tpacpi_attr_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
>  {
> -	if (has_antennatype)
> -		sysfs_remove_file(&tpacpi_pdev->dev.kobj, &dev_attr_wwan_antenna_type.attr);
> +	if (attr == &driver_attr_wlsw_emulstate.attr) {
> +		if (!dbg_wlswemul)
> +			return 0;
> +	} else if (attr == &driver_attr_bluetooth_emulstate.attr) {
> +		if (!dbg_bluetoothemul)
> +			return 0;
> +	} else if (attr == &driver_attr_wwan_emulstate.attr) {
> +		if (!dbg_wwanemul)
> +			return 0;
> +	} else if (attr == &driver_attr_uwb_emulstate.attr) {
> +		if (!dbg_uwbemul)
> +			return 0;
> +	}
> +
> +	return attr->mode;
>  }
> +#endif
> 
> -static struct ibm_struct dprc_driver_data = {
> -	.name = "dprc",
> -	.exit = dprc_exit,

As mentioned above this struct needs to be kept around,
with just the name set.

> +static const struct attribute_group tpacpi_attr_group = {
> +#ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
> +	.is_visible = tpacpi_attr_is_visible,
> +#endif
> +	.attrs = tpacpi_attributes,
> +};
> +
> +static const struct attribute_group *tpacpi_groups[] = {
> +	&adaptive_kbd_attr_group,
> +	&hotkey_attr_group,
> +	&bluetooth_attr_group,
> +	&wan_attr_group,
> +	&proxsensor_attr_group,
> +	&kbdlang_attr_group,
> +	&dprc_attr_group,
> +	&tpacpi_attr_group,
> +	NULL,
> +};
> +
> +static const struct attribute_group *tpacpi_hwmon_groups[] = {
> +	&thermal_attr_group,
> +	&temp_label_attr_group,
> +	&fan_attr_group,
> +	&tpacpi_attr_group,
> +	NULL,
> +};
> +
> +/****************************************************************************
> + ****************************************************************************
> + *
> + * Platform drivers
> + *
> + ****************************************************************************
> + ****************************************************************************/
> +
> +static struct platform_driver tpacpi_pdriver = {
> +	.driver = {
> +		.name = TPACPI_DRVR_NAME,
> +		.pm = &tpacpi_pm,
> +		.dev_groups = tpacpi_groups,
> +	},
> +	.shutdown = tpacpi_shutdown_handler,
> +};
> +
> +static struct platform_driver tpacpi_hwmon_pdriver = {
> +	.driver = {
> +		.name = TPACPI_HWMON_DRVR_NAME,
> +		.dev_groups = tpacpi_hwmon_groups,
> +	},
>  };
> 
>  /****************************************************************************
> @@ -11064,19 +11032,13 @@ static struct ibm_init_struct ibms_init[] __initdata = {
>  	},
>  	{
>  		.init = tpacpi_proxsensor_init,
> -		.data = &proxsensor_driver_data,
>  	},
>  	{
>  		.init = tpacpi_dytc_profile_init,
>  		.data = &dytc_profile_driver_data,
>  	},
> -	{
> -		.init = tpacpi_kbdlang_init,
> -		.data = &kbdlang_driver_data,
> -	},
>  	{
>  		.init = tpacpi_dprc_init,
> -		.data = &dprc_driver_data,
>  	},
>  };
> 
> @@ -11090,8 +11052,6 @@ static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
> 
>  	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
>  		ibm = ibms_init[i].data;
> -		WARN_ON(ibm == NULL);
> -
>  		if (!ibm || !ibm->name)
>  			continue;
> 
> @@ -11221,26 +11181,16 @@ static void thinkpad_acpi_module_exit(void)
> 
>  	if (tpacpi_hwmon)
>  		hwmon_device_unregister(tpacpi_hwmon);
> -
>  	if (tpacpi_sensors_pdev)
>  		platform_device_unregister(tpacpi_sensors_pdev);
>  	if (tpacpi_pdev)
>  		platform_device_unregister(tpacpi_pdev);
> -
> -	if (tp_features.sensors_pdrv_attrs_registered)
> -		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
> -	if (tp_features.platform_drv_attrs_registered)
> -		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
> -
>  	if (tp_features.sensors_pdrv_registered)
>  		platform_driver_unregister(&tpacpi_hwmon_pdriver);
> -
>  	if (tp_features.platform_drv_registered)
>  		platform_driver_unregister(&tpacpi_pdriver);
> -
>  	if (proc_dir)
>  		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
> -
>  	if (tpacpi_wq)
>  		destroy_workqueue(tpacpi_wq);
> 
> @@ -11308,20 +11258,6 @@ static int __init thinkpad_acpi_module_init(void)
>  	}
>  	tp_features.sensors_pdrv_registered = 1;
> 
> -	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
> -	if (!ret) {
> -		tp_features.platform_drv_attrs_registered = 1;
> -		ret = tpacpi_create_driver_attributes(
> -					&tpacpi_hwmon_pdriver.driver);
> -	}
> -	if (ret) {
> -		pr_err("unable to create sysfs driver attributes\n");
> -		thinkpad_acpi_module_exit();
> -		return ret;
> -	}
> -	tp_features.sensors_pdrv_attrs_registered = 1;
> -
> -
>  	/* Device initialization */
>  	tpacpi_pdev = platform_device_register_simple(TPACPI_DRVR_NAME, -1,
>  							NULL, 0);
> --
> 2.25.1
> 

Regards,

Hans

