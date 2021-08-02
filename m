Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF03DD45B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhHBKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232553AbhHBKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627901718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5o/a06yfnFBviosRbiOcmSJO5qx6JCpa3jU9bEMZ6Jk=;
        b=CrSU/e1i6mgUHFHeojyNe5EoEyZJjfgoEhfvx4Ec6FCzfyy0+SC2nn+hz8cZ2uDPp4SVWL
        DjOcUJEy9yudunLjX2qr8ONH7pRtLf8sftx10tlSYOMSHCwRoQEi9ejsHwlM1ukM/JkJBO
        FSoE8WtOendo1b65aizwqrIx/K0tVLU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-PpqKS40MMnGaKpvAeRRQRA-1; Mon, 02 Aug 2021 06:55:17 -0400
X-MC-Unique: PpqKS40MMnGaKpvAeRRQRA-1
Received: by mail-ed1-f70.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso8476677edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5o/a06yfnFBviosRbiOcmSJO5qx6JCpa3jU9bEMZ6Jk=;
        b=WmV0cAqOufSAZCENRXiPOSVupVEjXEBGOvBREcvX101t43KtU4m2Hmh+M2lkBW9udC
         YbIYONI2UDiN1V9YZPnbcEJIUdmLq6t2YuYkfppkFDIYenFA4HgsnNiwOrhIroD+Xb9H
         ztQfnwXfiO2ib3F3ObmTkEyh1Is0iJc0sspXXZ+YXDiXUB3YTt8kuLls1gP14ZF1ARaW
         emfNXwDUPasuWB5WnJfJq4Hn7aXRCG2Au/ss/OBWMR5YkvWAcfRofMIZ7O6xYYC+FY9Q
         6U5xC+ip6Rxvn3SMWKTwdjdzlFI9fK7Z2Z+MW3+sjouG6W0YgyqxAR282dr8WAPQBoUf
         zL3A==
X-Gm-Message-State: AOAM530g7pTJ6rbFrD/6Fe44FMxDWdezkn6seXp2MOE5g8YSuWiUK1/J
        r2MToRKqWMG72wUqGdEyyBNoiVBfpcHXSq2yRnfhxEGZyQv/2toQIvYiT/7eb1ISeKaaGlydvVg
        WFxX/IIiIx23dfbtn3BOVsduC
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr15707708ejb.87.1627901716533;
        Mon, 02 Aug 2021 03:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB8NLPv396gFrOWKXN8fy/pkBG8Jhv72bjUPXZoLBiOYiesHC9qww6qEr4MOFiB3KXDp0Dnw==
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr15707685ejb.87.1627901716305;
        Mon, 02 Aug 2021 03:55:16 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id ec38sm5859312edb.40.2021.08.02.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 03:55:15 -0700 (PDT)
Subject: Re: [PATCH 2/4] asus-wmi: Add dgpu disable method
To:     Luke Jones <luke@ljones.dev>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
References: <20210717081323.7925-1-luke@ljones.dev>
 <20210717081323.7925-2-luke@ljones.dev>
 <eed70640-6252-45f8-848f-bc5890f7807b@redhat.com>
 <8YYQWQ.1825YSKLVR7B3@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b78e6a5-71b8-fda7-9798-903c7e460de4@redhat.com>
Date:   Mon, 2 Aug 2021 12:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8YYQWQ.1825YSKLVR7B3@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 7/24/21 1:37 PM, Luke Jones wrote:
> Great feedback and thorough, thank you. I feel I need to describe the full issue this patch tries to address now as it is causing some headaches.
> 
> ASUS have added an ACPI method that enables or disables the dGPU on these particular ROG laptops, presumably because they are unable to reliably deal with the dGPU waking and being used by processes in Windows. The ACPI method works similar to what we do in software (with asusctl and system76-power) by removing the device from the device tree so nothing can attach to it - but here it is ejected via ACPI and really does not exist anymore until enabled again.
> 
> So the problem is two-fold:
> - A user can disable it in Windows via Armoury Crate, then reboot to Linux and not be able to use the dGPU as it is just not there.
> - They can use the patch here to enable it, but this comes with caveats..
> 
> Proper enable of the dGPU again as far as my testing goes works such that:
> 1. call the ACPI method
> 2. rescan PCI bus to ensure the device is powered
> 3. call the ACPI method again to save the setting
> 
> But it appears that recent work in-kernel for many things AMD related has broken this for us: if the 3 steps are attempted then there is a fail with the parent device not able to pull out of D3cold. But only if the kernel is fully loaded.
> ```
> acpi device:03: Cannot transition to power state D0 for parent in D3cold
> ```
> 
> If I patch the kernel to run the ACPI call as a default setting to enable it, then it occurs early enough in boot that it can be enabled correctly with userspace issuing step 3 to save it.
> 
> Getting down to brass tacks, I need to solve:
> a. the D3cold issue so that a write does: write, power up, write again, or,
> b. find how to set the default in 3 steps.

I  think we should try to get b. to work (again), we really don't want to add
something highly Asus specific to the standard ACPI boot-patrhs. IOW ideally
this should all be contained inside the asus-wmi.ko file which I believe
means that we need b.

I think the best way forward here is to send an email to the authors of the
recent changes which broke b. +  the linux-acpi and linux-pci mailinglists and
then try to solve things with those folks.

I guess it would be good if you can first figure out which recent commit
exactly broke b.

Regards,

Hans



> 
> We would be perfectly fine to set a default on boot. First set and save takes time due to while-loops in acpi but subsequent runs after proper save return early. We do not suffer the same consequences as Windows does either, as we can do what windows does (ASUS really) in software rather than ACPI.
> 
> The reason this particular patch is required is because users of laptops with this function are unable to use the dGPU at all if disabled via windows. The only thing we really need to do here is enable it on boot and ensure the setting is saved so reboots do not stick on the ACPI while loop (which is approx 5 seconds).
> 
> I hope the above is clear.
> 
> Many thanks,
> Luke.
> 
> On Sat, Jul 17 2021 at 18:05:03 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 7/17/21 10:13 AM, Luke D. Jones wrote:
>>>  In Windows the ASUS Armory Crate program can enable or disable the
>>>  dGPU via a WMI call. This functions much the same as various Linux
>>>  methods in software where the dGPU is removed from the device tree.
>>>
>>>  However the WMI call saves the state of dGPU (enabled or not) and
>>>  this then changes the dGPU visibility in Linux with no way for
>>>  Linux users to re-enable it. We expose the WMI method so users can
>>>  see and change the dGPU ACPI state.
>>>
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c            | 99 ++++++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>>   2 files changed, 102 insertions(+)
>>>
>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>  index cd881443bc2f..02762a60d27a 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -210,6 +210,9 @@ struct asus_wmi {
>>>       u8 fan_boost_mode_mask;
>>>       u8 fan_boost_mode;
>>>
>>>  +    bool dgpu_disable_available;
>>>  +    bool dgpu_disable;
>>>  +
>>>       bool throttle_thermal_policy_available;
>>>       u8 throttle_thermal_policy_mode;
>>>
>>>  @@ -427,6 +430,94 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>>       }
>>>   }
>>>
>>>  +/* dGPU ********************************************************************/
>>>  +static int dgpu_disable_check_present(struct asus_wmi *asus)
>>>  +{
>>>  +    u32 result;
>>>  +    int err;
>>>  +
>>>  +    asus->dgpu_disable_available = false;
>>>  +
>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
>>>  +    if (err) {
>>>  +        if (err == -ENODEV)
>>>  +            return 0;
>>>  +        return err;
>>>  +    }
>>>  +
>>>  +    if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
>>>  +        asus->dgpu_disable_available = true;
>>>  +        asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
>>>  +    }
>>>  +
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static int dgpu_disable_write(struct asus_wmi *asus)
>>>  +{
>>>  +    int err;
>>>  +    u8 value;
>>>  +    u32 retval;
>>
>> Upside-down-christmastree declaration order please.
>>
>>>  +
>>>  +    value = asus->dgpu_disable;
>>>  +
>>>  +    err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
>>>  +
>>>  +    if (err) {
>>>  +        pr_warn("Failed to set dgpu disable: %d\n", err);
>>>  +        return err;
>>>  +    }
>>>  +
>>>  +    if (retval > 1 || retval < 0) {
>>>  +        pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
>>>  +        return -EIO;
>>>  +    }
>>>  +
>>>  +    sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
>>>  +
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static ssize_t dgpu_disable_show(struct device *dev,
>>>  +                   struct device_attribute *attr, char *buf)
>>>  +{
>>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>>  +    bool mode = asus->dgpu_disable;
>>
>> This bool local variable is not really necessary, instead you can just do:
>>
>>     return sysfs_emit(buf, "%d\n", asus->dgpu_disable);
>>
>> The same applies to patch 1/3 btw.
>>
>>>  +
>>>  +    return sysfs_emit(buf, "%d\n", mode);
>>>  +}
>>>  +
>>>  +static ssize_t dgpu_disable_store(struct device *dev,
>>>  +                    struct device_attribute *attr,
>>>  +                    const char *buf, size_t count)
>>>  +{
>>>  +    int result;
>>>  +    bool disable;
>>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>
>> Upside-down-christmastree declaration order please.
>>
>>>  +
>>>  +    result = kstrtobool(buf, &disable);
>>>  +    if (result == -EINVAL)
>>>  +        return result;
>>
>> Just "if (result) ..." please.
>>
>>>  +
>>>  +    asus->dgpu_disable = disable;
>>>  +    /*
>>>  +     * The ACPI call used does not save the mode unless the call is run twice.
>>>  +     * Once to disable, then once to check status and save - this is two code
>>>  +     * paths in the method in the ACPI dumps.
>>>  +    */
>>>  +    result = dgpu_disable_write(asus);
>>>  +    if (result != 0)
>>>  +        return result;
>>>  +
>>>  +    result = dgpu_disable_write(asus);
>>>  +    if (result != 0)
>>>  +        return result;
>>>  +
>>>  +    return count;
>>>  +}
>>>  +
>>>  +static DEVICE_ATTR_RW(dgpu_disable);
>>>  +
>>>   /* Battery ********************************************************************/
>>>
>>>   /* The battery maximum charging percentage */
>>>  @@ -2411,6 +2502,7 @@ static struct attribute *platform_attributes[] = {
>>>       &dev_attr_camera.attr,
>>>       &dev_attr_cardr.attr,
>>>       &dev_attr_touchpad.attr,
>>>  +    &dev_attr_dgpu_disable.attr,
>>>       &dev_attr_lid_resume.attr,
>>>       &dev_attr_als_enable.attr,
>>>       &dev_attr_fan_boost_mode.attr,
>>>  @@ -2437,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>           devid = ASUS_WMI_DEVID_LID_RESUME;
>>>       else if (attr == &dev_attr_als_enable.attr)
>>>           devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>>  +    else if (attr == &dev_attr_dgpu_disable.attr)
>>>  +        ok = asus->dgpu_disable_available;
>>>       else if (attr == &dev_attr_fan_boost_mode.attr)
>>>           ok = asus->fan_boost_mode_available;
>>>       else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>>  @@ -2698,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>       if (err)
>>>           goto fail_platform;
>>>
>>>  +    err = dgpu_disable_check_present(asus);
>>>  +    if (err)
>>>  +        goto fail_dgpu_disable;
>>>  +
>>>       err = fan_boost_mode_check_present(asus);
>>>       if (err)
>>>           goto fail_fan_boost_mode;
>>>  @@ -2798,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>   fail_sysfs:
>>>   fail_throttle_thermal_policy:
>>>   fail_fan_boost_mode:
>>>  +fail_dgpu_disable:
>>>   fail_platform:
>>>   fail_panel_od:
>>>       kfree(asus);
>>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>>  index 428aea701c7b..a528f9d0e4b7 100644
>>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>>  @@ -90,6 +90,9 @@
>>>   /* Keyboard dock */
>>>   #define ASUS_WMI_DEVID_KBD_DOCK        0x00120063
>>>
>>>  +/* dgpu on/off */
>>>  +#define ASUS_WMI_DEVID_DGPU        0x00090020
>>>  +
>>>   /* DSTS masks */
>>>   #define ASUS_WMI_DSTS_STATUS_BIT    0x00000001
>>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT    0x00000002
>>>
>>
>> Regards,
>>
>> Hans
>>
> 
> 

