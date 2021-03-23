Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1A34683C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhCWS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:57:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:16493 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhCWS5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:57:21 -0400
IronPort-SDR: PHYNVYkCXVP0kxT/b1tbIOQ0gUVaxwzQ34XgziYIop/SOqS3t4D6SMeKhlqPD3iymwxwFwNxXU
 rTWGL8kf+2/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="169877145"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="169877145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:57:20 -0700
IronPort-SDR: Q8HJVXl7Lyjl4C2eiFKbLw3GMyYwt6HBnf30s3xNBWhJK1VcUz0LDuN/q+U2d9JFpEkmzVza5K
 kX/iKBm8sHdA==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452273433"
Received: from laguitie-mobl.amr.corp.intel.com (HELO [10.252.129.185]) ([10.252.129.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 11:57:19 -0700
Subject: Re: [PATCH v5 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, platform-driver-x86@vger.kernel.org,
        broonie@kernel.org
References: <20210322093841.11840-1-Perry_Yuan@Dell.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a1fae1fc-2d4f-63e8-e0be-0f9c4c91640c@linux.intel.com>
Date:   Tue, 23 Mar 2021 13:57:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322093841.11840-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor comments below.

On 3/22/21 4:38 AM, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
> 
> add support for Dell privacy driver for the Dell units equipped
> hardware privacy design, which protect users privacy of audio and
> camera from hardware level. Once the audio or camera privacy mode
> activated, any applications will not get any audio or video stream
> when user pressed ctrl+F4 hotkey, audio privacy mode will be
> enabled, micmute led will be also changed accordingly
> The micmute led is fully controlled by hardware & EC(embedded controller)
> and camera mute hotkey is Ctrl+F9. Currently design only emmits

typo: emits

> SW_CAMERA_LENS_COVER event while the camera lens shutter will be
> changed by EC & hw(hadware) control

typo: hardware
> 
> *The flow is like this:
> 1) User presses key. HW does stuff with this key (timeout timer is started)
> 2) WMI event is emitted from BIOS to kernel
> 3) WMI event is received by dell-privacy
> 4) KEY_MICMUTE emitted from dell-privacy
> 5) Userland picks up key and modifies kcontrol for SW mute
> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
> 	ledtrig_audio_set(LED_AUDIO_MICMUTE,
> 		rt715->micmute_led ? LED_ON :LED_OFF);
> 7) If "LED" is set to on dell-privacy notifies EC,
> 	and timeout is cancelled, HW mic mute activated.

what happens if there is timeout? You have an explicit description of 
the timer handling in the success case, but not what happens on a timeout...

> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> new file mode 100644
> index 000000000000..20c15a51ec38
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> @@ -0,0 +1,32 @@
> +What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/devices_supported
> +Date:		Feb 2021
> +KernelVersion:	5.12

5.13 now?

> +static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
> +		enum led_brightness brightness)
> +{
> +	struct privacy_acpi_priv *priv = privacy_acpi;
> +	acpi_status status;
> +	acpi_handle handle;
> +	static char *acpi_method = (char *)"ECAK";
> +
> +	handle = ec_get_handle();
> +	if (!handle)
> +		return -EIO;
> +	if (!acpi_has_method(handle, acpi_method))
> +		return -EIO;
> +	status = acpi_evaluate_object(handle, acpi_method, NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(priv->dev, "Error setting privacy EC ack value: %s\n",
> +				acpi_format_exception(status));
> +		return -EIO;
> +	}
> +	pr_debug("set dell privacy micmute ec ack event done\n");

can we use dev_dbg() here? Same for all occurrences of pr_debug and 
pr_err below, it's cleaner and easier to filter.

> +	return 0;
> +}
> +
> +static int dell_privacy_acpi_remove(struct platform_device *pdev)
> +{
> +	struct privacy_acpi_priv *priv = dev_get_drvdata(privacy_acpi->dev);
> +
> +	led_classdev_unregister(&priv->cdev);
> +
> +	return 0;
> +}
> +/*
> + * Pressing the mute key activates a time delayed circuit to physically cut
> + * off the mute. The LED is in the same circuit, so it reflects the true
> + * state of the HW mute.  The reason for the EC "ack" is so that software
> + * can first invoke a SW mute before the HW circuit is cut off.  Without SW
> + * cutting this off first does not affect the time delayed muting or status
> + * of the LED but there is a possibility of a "popping" noise.
> + *
> + * If the EC receives the SW ack, the circuit will be activated before the
> + * delay completed.
> + *
> + * Exposing as an LED device allows the codec drivers notification path to
> + * EC ACK to work
> + */
> +static int dell_privacy_leds_setup(struct device *dev)
> +{
> +	struct privacy_acpi_priv *priv = dev_get_drvdata(dev);
> +	int ret = 0;

useless init

> +
> +	priv->cdev.name = "dell-privacy::micmute";
> +	priv->cdev.max_brightness = 1;
> +	priv->cdev.brightness_set_blocking = dell_privacy_micmute_led_set;
> +	priv->cdev.default_trigger = "audio-micmute";
> +	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +	ret = devm_led_classdev_register(dev, &priv->cdev);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static int dell_privacy_acpi_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	platform_set_drvdata(pdev, privacy_acpi);
> +	privacy_acpi->dev = &pdev->dev;
> +	privacy_acpi->platform_device = pdev;
> +
> +	ret = dell_privacy_leds_setup(&pdev->dev);
> +	if (ret)
> +		return -EIO;

any reason to hard-code -EIO, woud 'return ret' be enough?


> +
> +	return 0;
> +}
> +
> +static struct platform_driver dell_privacy_platform_drv = {
> +	.driver = {
> +		.name = PRIVACY_PLATFORM_NAME,
> +	},
> +	.probe = dell_privacy_acpi_probe,
> +	.remove = dell_privacy_acpi_remove,
> +};
> +
> +int __init dell_privacy_acpi_init(void)

is the __init necessary? You call this routine from another which 
already has this qualifier.

> +{
> +	int err;
> +	struct platform_device *pdev;
> +
> +	if (!wmi_has_guid(DELL_PRIVACY_GUID))
> +		return -ENODEV;
> +
> +	privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
> +	if (!privacy_acpi)
> +		return -ENOMEM;
> +
> +	err = platform_driver_register(&dell_privacy_platform_drv);
> +	if (err)
> +		goto pdrv_err;
> +
> +	pdev = platform_device_register_simple(
> +			PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		err = PTR_ERR(pdev);
> +		goto pdev_err;
> +	}
> +
> +	return 0;
> +
> +pdev_err:
> +	platform_device_unregister(pdev);
> +pdrv_err:
> +	kfree(privacy_acpi);
> +	return err;
> +}
> +
> +void __exit dell_privacy_acpi_exit(void)

is the __exit required here?

> +{
> +	struct platform_device *pdev = to_platform_device(privacy_acpi->dev);
> +
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&dell_privacy_platform_drv);
> +	kfree(privacy_acpi);
> +}
> +
> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
> +MODULE_LICENSE("GPL");


