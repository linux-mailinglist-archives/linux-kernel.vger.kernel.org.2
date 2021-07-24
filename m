Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D863D476D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhGXK5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:57:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36417 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbhGXK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:57:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 06B375C00D4;
        Sat, 24 Jul 2021 07:37:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 24 Jul 2021 07:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Wvr2qm
        mRJet13v+vDTAPVklmW0cLpR//jwHRLbHw0vI=; b=VhVITW9xTeOI/yLQ0OBaCK
        fa65n8Njk+3x2uoJDnlm1xT7GaGw1v9CXkt5DnXcnOqZwRHcraMGz0ybJduourfh
        cjQjYqlSN7F/x2gEe/AOF9j4NYcOXKeL7y/B+6WWb+kmuTi27YyJglanuqJkVkVf
        ZHse2KqZaBaJRSTX61Dyx0AZM3hTUqwd+bMYr8gZD4xmwIOHHvO01y+eTVNR7b2L
        UDBAu1VZnQbVA7LViHutTfleRQ6ADzks46r/pVCcPvjnWMAuQTNby9To5xU9EBYe
        vxaVkf/9Mxv8qL36VZb2i+HZblRo/5DWFdzImDXoVif8KzUcmrPZ6XlSYPfiJQyw
        ==
X-ME-Sender: <xms:h_v7YO6rz8HVA5--U56l_T0qEGvCM12EKnZVPa59Tu345sA7uQAktw>
    <xme:h_v7YH4kQkVyFeFvmLbgFntBq228oWBIARi_X6deDEk4PFlVs89FWjWQf2ekN39lS
    EE95Hq_tixrW85oDao>
X-ME-Received: <xmr:h_v7YNcVe8nxn75o9M_H-ayShG-XYGkVouXG_3tXJWr5ckzgc-WEik9VbByNBOhukTFpBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvffkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgf
    effedufffhgfeuheegffffgeegveeifeeutefhieejffetudfgueevteehtdetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljh
    honhgvshdruggvvh
X-ME-Proxy: <xmx:h_v7YLLiHjgtiH_22LzyCtjiqGjqcPYc_V5GVXoR9qJtgcbUGtwqpw>
    <xmx:h_v7YCI2Ljnc69cSlTyid0Zo4aewxS8-s1OYosNFRLZN_n9NHC0zFQ>
    <xmx:h_v7YMw0jsGzDxhanhx9h2DdUL9B-rsqN7eJB_Z8G-U--TxgxBeYQw>
    <xmx:iPv7YHFNWDl176cXV2k63aWhu1SNaBRh9rJCDdt_5_1-YCUdoynv7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jul 2021 07:37:36 -0400 (EDT)
Date:   Sat, 24 Jul 2021 23:37:20 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 2/4] asus-wmi: Add dgpu disable method
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     pobrn@protonmail.com, mgross@linux.intel.com,
        corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
Message-Id: <8YYQWQ.1825YSKLVR7B3@ljones.dev>
In-Reply-To: <eed70640-6252-45f8-848f-bc5890f7807b@redhat.com>
References: <20210717081323.7925-1-luke@ljones.dev>
        <20210717081323.7925-2-luke@ljones.dev>
        <eed70640-6252-45f8-848f-bc5890f7807b@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great feedback and thorough, thank you. I feel I need to describe the 
full issue this patch tries to address now as it is causing some 
headaches.

ASUS have added an ACPI method that enables or disables the dGPU on 
these particular ROG laptops, presumably because they are unable to 
reliably deal with the dGPU waking and being used by processes in 
Windows. The ACPI method works similar to what we do in software (with 
asusctl and system76-power) by removing the device from the device tree 
so nothing can attach to it - but here it is ejected via ACPI and 
really does not exist anymore until enabled again.

So the problem is two-fold:
- A user can disable it in Windows via Armoury Crate, then reboot to 
Linux and not be able to use the dGPU as it is just not there.
- They can use the patch here to enable it, but this comes with 
caveats..

Proper enable of the dGPU again as far as my testing goes works such 
that:
1. call the ACPI method
2. rescan PCI bus to ensure the device is powered
3. call the ACPI method again to save the setting

But it appears that recent work in-kernel for many things AMD related 
has broken this for us: if the 3 steps are attempted then there is a 
fail with the parent device not able to pull out of D3cold. But only if 
the kernel is fully loaded.
```
acpi device:03: Cannot transition to power state D0 for parent in D3cold
```

If I patch the kernel to run the ACPI call as a default setting to 
enable it, then it occurs early enough in boot that it can be enabled 
correctly with userspace issuing step 3 to save it.

Getting down to brass tacks, I need to solve:
a. the D3cold issue so that a write does: write, power up, write again, 
or,
b. find how to set the default in 3 steps.

We would be perfectly fine to set a default on boot. First set and save 
takes time due to while-loops in acpi but subsequent runs after proper 
save return early. We do not suffer the same consequences as Windows 
does either, as we can do what windows does (ASUS really) in software 
rather than ACPI.

The reason this particular patch is required is because users of 
laptops with this function are unable to use the dGPU at all if 
disabled via windows. The only thing we really need to do here is 
enable it on boot and ensure the setting is saved so reboots do not 
stick on the ACPI while loop (which is approx 5 seconds).

I hope the above is clear.

Many thanks,
Luke.

On Sat, Jul 17 2021 at 18:05:03 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 7/17/21 10:13 AM, Luke D. Jones wrote:
>>  In Windows the ASUS Armory Crate program can enable or disable the
>>  dGPU via a WMI call. This functions much the same as various Linux
>>  methods in software where the dGPU is removed from the device tree.
>> 
>>  However the WMI call saves the state of dGPU (enabled or not) and
>>  this then changes the dGPU visibility in Linux with no way for
>>  Linux users to re-enable it. We expose the WMI method so users can
>>  see and change the dGPU ACPI state.
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 99 
>> ++++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |  3 +
>>   2 files changed, 102 insertions(+)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index cd881443bc2f..02762a60d27a 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -210,6 +210,9 @@ struct asus_wmi {
>>   	u8 fan_boost_mode_mask;
>>   	u8 fan_boost_mode;
>> 
>>  +	bool dgpu_disable_available;
>>  +	bool dgpu_disable;
>>  +
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>> 
>>  @@ -427,6 +430,94 @@ static void 
>> lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>   	}
>>   }
>> 
>>  +/* dGPU 
>> ********************************************************************/
>>  +static int dgpu_disable_check_present(struct asus_wmi *asus)
>>  +{
>>  +	u32 result;
>>  +	int err;
>>  +
>>  +	asus->dgpu_disable_available = false;
>>  +
>>  +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
>>  +	if (err) {
>>  +		if (err == -ENODEV)
>>  +			return 0;
>>  +		return err;
>>  +	}
>>  +
>>  +	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
>>  +		asus->dgpu_disable_available = true;
>>  +		asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int dgpu_disable_write(struct asus_wmi *asus)
>>  +{
>>  +	int err;
>>  +	u8 value;
>>  +	u32 retval;
> 
> Upside-down-christmastree declaration order please.
> 
>>  +
>>  +	value = asus->dgpu_disable;
>>  +
>>  +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
>>  +
>>  +	if (err) {
>>  +		pr_warn("Failed to set dgpu disable: %d\n", err);
>>  +		return err;
>>  +	}
>>  +
>>  +	if (retval > 1 || retval < 0) {
>>  +		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
>>  +		return -EIO;
>>  +	}
>>  +
>>  +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, 
>> "dgpu_disable");
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t dgpu_disable_show(struct device *dev,
>>  +				   struct device_attribute *attr, char *buf)
>>  +{
>>  +	struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +	bool mode = asus->dgpu_disable;
> 
> This bool local variable is not really necessary, instead you can 
> just do:
> 
> 	return sysfs_emit(buf, "%d\n", asus->dgpu_disable);
> 
> The same applies to patch 1/3 btw.
> 
>>  +
>>  +	return sysfs_emit(buf, "%d\n", mode);
>>  +}
>>  +
>>  +static ssize_t dgpu_disable_store(struct device *dev,
>>  +				    struct device_attribute *attr,
>>  +				    const char *buf, size_t count)
>>  +{
>>  +	int result;
>>  +	bool disable;
>>  +	struct asus_wmi *asus = dev_get_drvdata(dev);
> 
> Upside-down-christmastree declaration order please.
> 
>>  +
>>  +	result = kstrtobool(buf, &disable);
>>  +	if (result == -EINVAL)
>>  +		return result;
> 
> Just "if (result) ..." please.
> 
>>  +
>>  +	asus->dgpu_disable = disable;
>>  +	/*
>>  +	 * The ACPI call used does not save the mode unless the call is 
>> run twice.
>>  +	 * Once to disable, then once to check status and save - this is 
>> two code
>>  +	 * paths in the method in the ACPI dumps.
>>  +	*/
>>  +	result = dgpu_disable_write(asus);
>>  +	if (result != 0)
>>  +		return result;
>>  +
>>  +	result = dgpu_disable_write(asus);
>>  +	if (result != 0)
>>  +		return result;
>>  +
>>  +	return count;
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(dgpu_disable);
>>  +
>>   /* Battery 
>> ********************************************************************/
>> 
>>   /* The battery maximum charging percentage */
>>  @@ -2411,6 +2502,7 @@ static struct attribute 
>> *platform_attributes[] = {
>>   	&dev_attr_camera.attr,
>>   	&dev_attr_cardr.attr,
>>   	&dev_attr_touchpad.attr,
>>  +	&dev_attr_dgpu_disable.attr,
>>   	&dev_attr_lid_resume.attr,
>>   	&dev_attr_als_enable.attr,
>>   	&dev_attr_fan_boost_mode.attr,
>>  @@ -2437,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct 
>> kobject *kobj,
>>   		devid = ASUS_WMI_DEVID_LID_RESUME;
>>   	else if (attr == &dev_attr_als_enable.attr)
>>   		devid = ASUS_WMI_DEVID_ALS_ENABLE;
>>  +	else if (attr == &dev_attr_dgpu_disable.attr)
>>  +		ok = asus->dgpu_disable_available;
>>   	else if (attr == &dev_attr_fan_boost_mode.attr)
>>   		ok = asus->fan_boost_mode_available;
>>   	else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>  @@ -2698,6 +2792,10 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	if (err)
>>   		goto fail_platform;
>> 
>>  +	err = dgpu_disable_check_present(asus);
>>  +	if (err)
>>  +		goto fail_dgpu_disable;
>>  +
>>   	err = fan_boost_mode_check_present(asus);
>>   	if (err)
>>   		goto fail_fan_boost_mode;
>>  @@ -2798,6 +2896,7 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>>   fail_fan_boost_mode:
>>  +fail_dgpu_disable:
>>   fail_platform:
>>   fail_panel_od:
>>   	kfree(asus);
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index 428aea701c7b..a528f9d0e4b7 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -90,6 +90,9 @@
>>   /* Keyboard dock */
>>   #define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
>> 
>>  +/* dgpu on/off */
>>  +#define ASUS_WMI_DEVID_DGPU		0x00090020
>>  +
>>   /* DSTS masks */
>>   #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
>>   #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
>> 
> 
> Regards,
> 
> Hans
> 


