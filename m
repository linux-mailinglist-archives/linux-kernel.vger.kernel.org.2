Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0523CC452
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhGQQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhGQQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626537477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Lnlp3V8M3/kRYDW1gANYfuMRIKDZLS7gsUfdmhXePs=;
        b=WyVzNDPDGm5+kHarjWzwgnYdKv9hFQPWFWY0F2u+6H2adyyxDMNOzsh5HrOPYqenz/wjob
        iEYiz5Toq/+Bh7YPT2a062PQ5FEcG62o+VlphDULyX49wOqPcHR/7DBCLG3SvGYWEl41Zw
        P7HnJrvjx0TDEiXEz+EYx9Tx97bWt+E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-OHx7kJ1xOaGkP1CuZ-grcw-1; Sat, 17 Jul 2021 11:57:56 -0400
X-MC-Unique: OHx7kJ1xOaGkP1CuZ-grcw-1
Received: by mail-ed1-f69.google.com with SMTP id ee46-20020a056402292eb02903a1187e547cso6501345edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Lnlp3V8M3/kRYDW1gANYfuMRIKDZLS7gsUfdmhXePs=;
        b=mS3csFwefb6N/3pDSmeyEBAKewto3XJHYZnB9afOjmQVy92pmHX+jhofojKXDzlKGR
         zwDaznQ/VqZwo0BtqlZG7eoxVzKFF5Eig5R2TLHoJxjHCiE6liw1RXMmq25UWfaOUV6C
         z4wOXQIJpWJxhr9i16pc1xMuujvRu0RAI29c6HF5oKW2j28RCY0oINMBdaq10ECcbY66
         kKKQE/R+EG3y2t5ZueiWqm9lL8JSLzRXnTt3ZrGZ4th+4wICGhvSKI9xyl+HRCnKL5dp
         fNMCS2lbfP1O2mxIYpDF9h01AdWxiWHDoTbyMkn+fbPzOi+BdZEF3EIQKYo4/LhuzZhN
         NPxQ==
X-Gm-Message-State: AOAM530bh7YklUTImByj/57ZxyJbS5C3fBJWze+XHtKRS4sh0fOqbPsZ
        lBlvX6wtT/tWebY/r1PWgeaZJhIRVzo2DqK502FOc0uO38NFVeJlrpRGCAPpL7eO96+Eur8/mMb
        mcFkBGOapV7JPCiV2wDSUxzEz
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr23029944edd.254.1626537475562;
        Sat, 17 Jul 2021 08:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO3noPz8DjoShn8yb+AJWxVzl/p4vT9QRyWaC+m4pw4R1z+Ok/xOTw+nUb7PDjF5j5yVMqbw==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr23029926edd.254.1626537475393;
        Sat, 17 Jul 2021 08:57:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c28sm4036620ejc.102.2021.07.17.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 08:57:54 -0700 (PDT)
Subject: Re: [PATCH 3/4] asus-wmi: Add egpu enable method
To:     Luke Jones <luke@ljones.dev>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
References: <20210717081323.7925-1-luke@ljones.dev>
 <20210717081323.7925-3-luke@ljones.dev> <UXQDWQ.MHGH7K6W57R5@ljones.dev>
 <65RDWQ.DNBXEUQTBV352@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <adb670de-e69a-6944-3d37-d2c0ef36d378@redhat.com>
Date:   Sat, 17 Jul 2021 17:57:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <65RDWQ.DNBXEUQTBV352@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 7/17/21 10:19 AM, Luke Jones wrote:
> Damn. I thought `-v2` on `git send-email` would bump patch version too. What is the correct way to do that for a full patch sequence?

You need to split the sending of patches into 2 steps, which generally is a good
idea anyways, since that will also allow you to easily add a cover-letter to the
series:

Lets say you are ready to send v3 and you have the 3 patches as the last 3
commits in your git tree's current HEAD, then you would do:

git format-patch --cover-letter -v3 HEAD~3
$EDITOR v3-0000*.patch
# Edit the cover letter, say something like:
# Hi All here is v3 of my ... series, which does foobar
# new in v3 is ...
# And don't forget to set the Subject
git send-email v3-00*.patch

And you're done. I hope this helps.

Regards,

Hans





> 
> On Sat, Jul 17 2021 at 20:15:30 +1200, Luke Jones <luke@ljones.dev> wrote:
>> Apologies, I forgot that the patches contain sequence. There is actually no 4th patch (the patch itself was already upstreamed).
>>
>> Sincere regards,
>> Luke.
>>
>> On Sat, Jul 17 2021 at 20:13:23 +1200, Luke D. Jones <luke@ljones.dev> wrote:
>>> The X13 Flow laptops can utilise an external GPU. This requires
>>> toggling an ACPI method which will first disable the internal
>>> dGPU, and then enable the eGPU.
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>> ---
>>>  drivers/platform/x86/asus-wmi.c            | 91 ++++++++++++++++++++++
>>>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>>>  2 files changed, 94 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>> index 02762a60d27a..ee5d8656641e 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -210,6 +210,9 @@ struct asus_wmi {
>>>      u8 fan_boost_mode_mask;
>>>      u8 fan_boost_mode;
>>>
>>> +    bool egpu_enable_available; // 0 = enable
>>> +    bool egpu_enable;
>>> +
>>>      bool dgpu_disable_available;
>>>      bool dgpu_disable;
>>>
>>> @@ -430,6 +433,86 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>>      }
>>>  }
>>>
>>> +/* eGPU ********************************************************************/
>>> +static int egpu_enable_check_present(struct asus_wmi *asus)
>>> +{
>>> +    u32 result;
>>> +    int err;
>>> +
>>> +    asus->egpu_enable_available = false;
>>> +
>>> +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_EGPU, &result);
>>> +    if (err) {
>>> +        if (err == -ENODEV)
>>> +            return 0;
>>> +        return err;
>>> +    }
>>> +
>>> +    if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
>>> +        asus->egpu_enable_available = true;
>>> +        asus->egpu_enable = result & ASUS_WMI_DSTS_STATUS_BIT;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int egpu_enable_write(struct asus_wmi *asus)
>>> +{
>>> +    int err;
>>> +    u8 value;
>>> +    u32 retval;
>>> +
>>> +    value = asus->egpu_enable;
>>> +
>>> +    err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, value, &retval);
>>> +
>>> +    if (err) {
>>> +        pr_warn("Failed to set egpu disable: %d\n", err);
>>> +        return err;
>>> +    }
>>> +
>>> +    if (retval > 1 || retval < 0) {
>>> +        pr_warn("Failed to set egpu disable (retval): 0x%x\n", retval);
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    sysfs_notify(&asus->platform_device->dev.kobj, NULL, "egpu_enable");
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static ssize_t egpu_enable_show(struct device *dev,
>>> +                   struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>> +    bool mode = asus->egpu_enable;
>>> +
>>> +    return sysfs_emit(buf, "%d\n", mode);
>>> +}
>>> +
>>> +static ssize_t egpu_enable_store(struct device *dev,
>>> +                    struct device_attribute *attr,
>>> +                    const char *buf, size_t count)
>>> +{
>>> +    int result;
>>> +    bool disable;
>>> +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>> +
>>> +    result = kstrtobool(buf, &disable);
>>> +    if (result == -EINVAL)
>>> +        return result;
>>> +
>>> +    asus->egpu_enable = disable;
>>> +
>>> +    result = egpu_enable_write(asus);
>>> +    if (result != 0)
>>> +        return result;
>>> +
>>> +    return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(egpu_enable);
>>> +
>>>  /* dGPU ********************************************************************/
>>>  static int dgpu_disable_check_present(struct asus_wmi *asus)
>>>  {
>>> @@ -2502,6 +2585,7 @@ static struct attribute *platform_attributes[] = {
>>>      &dev_attr_camera.attr,
>>>      &dev_attr_cardr.attr,
>>>      &dev_attr_touchpad.attr,
>>> +    &dev_attr_egpu_enable.attr,
>>>      &dev_attr_dgpu_disable.attr,
>>>      &dev_attr_lid_resume.attr,
>>>      &dev_attr_als_enable.attr,
>>> @@ -2529,6 +2613,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>>>          devid = ASUS_WMI_DEVID_LID_RESUME;
>>>      else if (attr == &dev_attr_als_enable.attr)
>>>          devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>> +    else if (attr == &dev_attr_egpu_enable.attr)
>>> +        ok = asus->egpu_enable_available;
>>>      else if (attr == &dev_attr_dgpu_disable.attr)
>>>          ok = asus->dgpu_disable_available;
>>>      else if (attr == &dev_attr_fan_boost_mode.attr)
>>> @@ -2792,6 +2878,10 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>      if (err)
>>>          goto fail_platform;
>>>
>>> +    err = egpu_enable_check_present(asus);
>>> +    if (err)
>>> +        goto fail_egpu_enable;
>>> +
>>>      err = dgpu_disable_check_present(asus);
>>>      if (err)
>>>          goto fail_dgpu_disable;
>>> @@ -2896,6 +2986,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>>  fail_sysfs:
>>>  fail_throttle_thermal_policy:
>>>  fail_fan_boost_mode:
>>> +fail_egpu_enable:
>>>  fail_dgpu_disable:
>>>  fail_platform:
>>>  fail_panel_od:
>>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>>> index a528f9d0e4b7..17dc5cb6f3f2 100644
>>> --- a/include/linux/platform_data/x86/asus-wmi.h
>>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>>> @@ -90,6 +90,9 @@
>>>  /* Keyboard dock */
>>>  #define ASUS_WMI_DEVID_KBD_DOCK        0x00120063
>>>
>>> +/* dgpu on/off */
>>> +#define ASUS_WMI_DEVID_EGPU        0x00090019
>>> +
>>>  /* dgpu on/off */
>>>  #define ASUS_WMI_DEVID_DGPU        0x00090020
>>>
>>> -- 
>>> 2.31.1
>>>
>>
> 
> 

