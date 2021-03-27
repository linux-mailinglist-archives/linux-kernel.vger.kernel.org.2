Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8A34B412
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC0Dl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0DkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:40:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B7C0613AA;
        Fri, 26 Mar 2021 20:40:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z2so7448574wrl.5;
        Fri, 26 Mar 2021 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hsGTOfKjvkotJaN+ySwfVHBa2ys5SbhPPuKeS61H9+4=;
        b=k+X1v3SKmAvCa7DHv4HIC0ZZToGuzK2Hd5oaw5OyfzQso9wLUEVJQ+eh8CSSfrWwD3
         R1ksKK66AtN01q9zqodDhw9wY2mKFTZfaOKGWkAf/dac3zg9g2BrMAuhBIOhoG7ZHs3X
         7DvxHwX5d4oCHIa9LORlfrV3XzmXMd2N/FqtrRtFnn05fT+EHWwmfi75SN8S1ANGilPg
         Ln31Bdx+gjm/b9bNOiXf04zH/ypJFQUkQsDL9DHP6umMsIVVsSn0S2tVoALWIA+xXpNu
         g2Ku6Uojw3/CRbta2pIzPbLV6lc9twqtCU5FAiEBWJOD7KxN9Se0WhAx/kTMeTo3ebiJ
         wGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hsGTOfKjvkotJaN+ySwfVHBa2ys5SbhPPuKeS61H9+4=;
        b=SByfzlE69dbKvle0WFuOVcCKCN4OWmkJPjYspJ5SPzoIx8L52ZO9KniKXIl5nHJqLS
         cmnSTiNB17+Wsl/8fercFzZCiSRIDeQf7V4GkMTg1Yr+aOvLg/PJR52/zt+speBPiJNJ
         FmB9+To8AraIjYXKZ/XKTL58E+NgrmQUsqp1sKvWZ1NGAMGcdafj5oqPei5/c7c8nMgc
         YUXFdJDIx5De/Z46dbAkGh6q/rXSC4YHbJUpMWeIozWuRaTcHYJGHWBkWydFUCdfPzRS
         DQ2ORLgZPY8MLX7e4+2hyr8zL18qbyh+CgSrFmxTZSY69MG8FW+gBFJur6NzOGO8nZez
         q3XQ==
X-Gm-Message-State: AOAM531PXCl0fV12WG0JHBzK+WPWgObUf6nhdPxVh7pjRLjlYOEpfinH
        8fRE7s5sG/ziLfAu3oeS5xo=
X-Google-Smtp-Source: ABdhPJweIVK9R7EL369H9ZjbTvSxL/ofs/QnXiYX6Jms+BddKEoLv23wON6DOcFyOM15xggEERniNw==
X-Received: by 2002:a05:6000:24b:: with SMTP id m11mr17441656wrz.393.1616816403031;
        Fri, 26 Mar 2021 20:40:03 -0700 (PDT)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id f126sm13481292wmf.17.2021.03.26.20.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 20:40:02 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        Mario.Limonciello@dell.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, platform-driver-x86@vger.kernel.org,
        broonie@kernel.org
References: <20210322093841.11840-1-Perry_Yuan@Dell.com>
 <a1fae1fc-2d4f-63e8-e0be-0f9c4c91640c@linux.intel.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <aabfe258-0043-44b2-9d99-a66b96a77e87@gmail.com>
Date:   Fri, 26 Mar 2021 23:39:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a1fae1fc-2d4f-63e8-e0be-0f9c4c91640c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre

Thanks for your review .

I changed the patch and explain the review comments as below

(Maybe the mail format has problem, sent from one new system thunderbird :)

On 3/23/21 2:57 PM, Pierre-Louis Bossart wrote:
> Minor comments below.
>
> On 3/22/21 4:38 AM, Perry Yuan wrote:
>> From: Perry Yuan <perry_yuan@dell.com>
>>
>> add support for Dell privacy driver for the Dell units equipped
>> hardware privacy design, which protect users privacy of audio and
>> camera from hardware level. Once the audio or camera privacy mode
>> activated, any applications will not get any audio or video stream
>> when user pressed ctrl+F4 hotkey, audio privacy mode will be
>> enabled, micmute led will be also changed accordingly
>> The micmute led is fully controlled by hardware & EC(embedded 
>> controller)
>> and camera mute hotkey is Ctrl+F9. Currently design only emmits
>
> typo: emits
fixed
>
>> SW_CAMERA_LENS_COVER event while the camera lens shutter will be
>> changed by EC & hw(hadware) control
>
> typo: hardware
fixed
>>
>> *The flow is like this:
>> 1) User presses key. HW does stuff with this key (timeout timer is 
>> started)
>> 2) WMI event is emitted from BIOS to kernel
>> 3) WMI event is received by dell-privacy
>> 4) KEY_MICMUTE emitted from dell-privacy
>> 5) Userland picks up key and modifies kcontrol for SW mute
>> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
>>     ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>         rt715->micmute_led ? LED_ON :LED_OFF);
>> 7) If "LED" is set to on dell-privacy notifies EC,
>>     and timeout is cancelled, HW mic mute activated.
>
> what happens if there is timeout? You have an explicit description of 
> the timer handling in the success case, but not what happens on a 
> timeout...
>
add more explicit description for timeout triggered case

7) If "LED" is set to on dell-privacy notifies EC, and timeout is cancelled.

     HW mic mute activated. If EC not notified,HW mic mute will also be

     activated when timeout used up, it is just later than active ack

>> diff --git 
>> a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi 
>> b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> new file mode 100644
>> index 000000000000..20c15a51ec38
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> @@ -0,0 +1,32 @@
>> +What: 
>> /sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/devices_supported
>> +Date:        Feb 2021
>> +KernelVersion:    5.12
>
> 5.13 now?
changed to 5.13
>
>> +static int dell_privacy_micmute_led_set(struct led_classdev *led_cdev,
>> +        enum led_brightness brightness)
>> +{
>> +    struct privacy_acpi_priv *priv = privacy_acpi;
>> +    acpi_status status;
>> +    acpi_handle handle;
>> +    static char *acpi_method = (char *)"ECAK";
>> +
>> +    handle = ec_get_handle();
>> +    if (!handle)
>> +        return -EIO;
>> +    if (!acpi_has_method(handle, acpi_method))
>> +        return -EIO;
>> +    status = acpi_evaluate_object(handle, acpi_method, NULL, NULL);
>> +    if (ACPI_FAILURE(status)) {
>> +        dev_err(priv->dev, "Error setting privacy EC ack value: %s\n",
>> +                acpi_format_exception(status));
>> +        return -EIO;
>> +    }
>> +    pr_debug("set dell privacy micmute ec ack event done\n");
>
> can we use dev_dbg() here? Same for all occurrences of pr_debug and 
> pr_err below, it's cleaner and easier to filter.
>
I changed some pr_xx to dev_xxx ,  but below code will be more complex 
to use dev_xxx to print the

log , because it need to get the priv->dev, but it is not registered at 
this time , I would prefer to keep use the pr_debug here.  and some 
other cases where  "priv->dev" cannot be used.


  static int __init init_dell_privacy(void)

{
         int ret;

         ret = wmi_has_guid(DELL_PRIVACY_GUID);
         if (!ret) {
                 privacy_valid = -ENODEV;
                 pr_debug("Unable to detect available Dell privacy 
devices: %d\n", ret);
                 return privacy_valid;
         }

>> +    return 0;
>> +}
>> +
>> +static int dell_privacy_acpi_remove(struct platform_device *pdev)
>> +{
>> +    struct privacy_acpi_priv *priv = 
>> dev_get_drvdata(privacy_acpi->dev);
>> +
>> +    led_classdev_unregister(&priv->cdev);
>> +
>> +    return 0;
>> +}
>> +/*
>> + * Pressing the mute key activates a time delayed circuit to 
>> physically cut
>> + * off the mute. The LED is in the same circuit, so it reflects the 
>> true
>> + * state of the HW mute.  The reason for the EC "ack" is so that 
>> software
>> + * can first invoke a SW mute before the HW circuit is cut off.  
>> Without SW
>> + * cutting this off first does not affect the time delayed muting or 
>> status
>> + * of the LED but there is a possibility of a "popping" noise.
>> + *
>> + * If the EC receives the SW ack, the circuit will be activated 
>> before the
>> + * delay completed.
>> + *
>> + * Exposing as an LED device allows the codec drivers notification 
>> path to
>> + * EC ACK to work
>> + */
>> +static int dell_privacy_leds_setup(struct device *dev)
>> +{
>> +    struct privacy_acpi_priv *priv = dev_get_drvdata(dev);
>> +    int ret = 0;
>
> useless init

Sorry, I do not get this point .

int should be needed to return error code if devm_led_classdev_register 
failed.


>
>> +
>> +    priv->cdev.name = "dell-privacy::micmute";
>> +    priv->cdev.max_brightness = 1;
>> +    priv->cdev.brightness_set_blocking = dell_privacy_micmute_led_set;
>> +    priv->cdev.default_trigger = "audio-micmute";
>> +    priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>> +    ret = devm_led_classdev_register(dev, &priv->cdev);
>> +    if (ret)
>> +        return ret;
>> +    return 0;
>> +}
>> +
>> +static int dell_privacy_acpi_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +
>> +    platform_set_drvdata(pdev, privacy_acpi);
>> +    privacy_acpi->dev = &pdev->dev;
>> +    privacy_acpi->platform_device = pdev;
>> +
>> +    ret = dell_privacy_leds_setup(&pdev->dev);
>> +    if (ret)
>> +        return -EIO;
>
> any reason to hard-code -EIO, woud 'return ret' be enough?
>
>
fixed to use return ret
>> +
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver dell_privacy_platform_drv = {
>> +    .driver = {
>> +        .name = PRIVACY_PLATFORM_NAME,
>> +    },
>> +    .probe = dell_privacy_acpi_probe,
>> +    .remove = dell_privacy_acpi_remove,
>> +};
>> +
>> +int __init dell_privacy_acpi_init(void)
>
> is the __init necessary? You call this routine from another which 
> already has this qualifier.
Yes, I need to add this when driver loading and kernel will free __init 
section mem after driver registered.
>
>> +{
>> +    int err;
>> +    struct platform_device *pdev;
>> +
>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>> +        return -ENODEV;
>> +
>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>> +    if (!privacy_acpi)
>> +        return -ENOMEM;
>> +
>> +    err = platform_driver_register(&dell_privacy_platform_drv);
>> +    if (err)
>> +        goto pdrv_err;
>> +
>> +    pdev = platform_device_register_simple(
>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>> +    if (IS_ERR(pdev)) {
>> +        err = PTR_ERR(pdev);
>> +        goto pdev_err;
>> +    }
>> +
>> +    return 0;
>> +
>> +pdev_err:
>> +    platform_device_unregister(pdev);
>> +pdrv_err:
>> +    kfree(privacy_acpi);
>> +    return err;
>> +}
>> +
>> +void __exit dell_privacy_acpi_exit(void)
>
> is the __exit required here?
same reason as __init
>
>> +{
>> +    struct platform_device *pdev = 
>> to_platform_device(privacy_acpi->dev);
>> +
>> +    platform_device_unregister(pdev);
>> +    platform_driver_unregister(&dell_privacy_platform_drv);
>> +    kfree(privacy_acpi);
>> +}
>> +
>> +MODULE_AUTHOR("Perry Yuan <perry_yuan@dell.com>");
>> +MODULE_DESCRIPTION("DELL Privacy ACPI Driver");
>> +MODULE_LICENSE("GPL");
>
>
