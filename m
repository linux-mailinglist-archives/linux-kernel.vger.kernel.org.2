Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA63EB14D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhHMHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:21:16 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54015 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236982AbhHMHVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:21:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 139E03200921;
        Fri, 13 Aug 2021 03:20:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 13 Aug 2021 03:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SRw5Rc
        bBaxDf8ZMBr0a6INE1g+SFXFHLMN3zcQf9cn8=; b=a3m18m7m7DlHAla1RTDVEN
        pj0+igk+0xk21P3ojHw1mnBCU1uqDtNYQksWPyfMolPtq0rEWZ5OubcQ9KzsFUHc
        tTWmy1nvKmxlSYtTiKzQYl9NRNtCEMySpptYzRAS5RkC5+b5a7aml/+aBTCtwnYf
        +2XfW0mQAdVs/l8TTbRRy9KNkc/iJ60W9/KTII+0Gin0wjDP0HuZkJGy8seqNeef
        4LPJ2bh7ofcY51WFcd5cf+GSzu7mmFWXvskfoqvkok9MY5Zddx8vDNO89ocFhUZ1
        I5lTgyBtx++Ia/j+oR7qqy0Qz0McKx9Y9sVS7B0LQWUhNNW/BgYbQlNHsieO21TQ
        ==
X-ME-Sender: <xms:Tx0WYdYFZTj7HPC4fnLONWuv2WjFbAWwWYMyAszRGs-c5LzOlnsj3g>
    <xme:Tx0WYUbcfwM1lVpKrtucQrJ-SMDoWqv8l-vZKU94alU5-gIFdcZOtXANIRroNX331
    ZUjNJFRnu_q72WUIMA>
X-ME-Received: <xmr:Tx0WYf8FQBkGe5B1KlL8DsdefHdMFzo90HPTd9G8h2vATxupRTpkNz0X3KafWypRXbHJGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Tx0WYboTnTPezRuYNI0iFhpx0wZlCCMPr07l_ToqkxbFamBsnsCRAg>
    <xmx:Tx0WYYpGVtHEdG_H4FcHlYAdmgHubAOVe3IAclR7KKuTtLN_7Zl_lg>
    <xmx:Tx0WYRShOtmvN3HvjVvnQvW28J4tObH-5rbjxpF2puAAfLA8TZLsWQ>
    <xmx:UB0WYVAcubFNznvvlZGQrQRt_Jx6YwuxUiRtM6su-ogwnWDBGLGV5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Aug 2021 03:20:44 -0400 (EDT)
Date:   Fri, 13 Aug 2021 19:20:29 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <5EORXQ.4I9IMHJZVTB93@ljones.dev>
In-Reply-To: <c1cbd0eb-9680-3ede-bae8-977c03c1ebd2@redhat.com>
References: <20210813024201.9518-1-luke@ljones.dev>
        <c1cbd0eb-9680-3ede-bae8-977c03c1ebd2@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 13 2021 at 08:47:56 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi Luke,
> 
> Thank you for this patch, it is great to see more and more laptop
> models getting support for the standard platform_profile userspace 
> API.
> 
> On 8/13/21 4:42 AM, Luke D. Jones wrote:
>>  Add initial support for platform_profile where the support is
>>  based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c | 112 
>> ++++++++++++++++++++++++++++++++
>>   1 file changed, 112 insertions(+)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 90a6a0d00deb..62260043c15c 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -26,6 +26,7 @@
>>   #include <linux/rfkill.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci_hotplug.h>
>>  +#include <linux/platform_profile.h>
>>   #include <linux/power_supply.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/hwmon-sysfs.h>
>>  @@ -219,6 +220,9 @@ struct asus_wmi {
>>   	bool throttle_thermal_policy_available;
>>   	u8 throttle_thermal_policy_mode;
>> 
>>  +	struct platform_profile_handler platform_profile_handler;
>>  +	bool platform_profile_support;
>>  +
>>   	// The RSOC controls the maximum charging percentage.
>>   	bool battery_rsoc_available;
>> 
>>  @@ -2144,6 +2148,106 @@ static ssize_t 
>> throttle_thermal_policy_store(struct device *dev,
>>   // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>> 
>>  +/* Platform profile 
>> ***********************************************************/
>>  +static int platform_profile_get(struct platform_profile_handler 
>> *pprof,
>>  +				enum platform_profile_option *profile)
>>  +{
>>  +	struct asus_wmi *asus;
>>  +	int tp;
>>  +
>>  +	asus = container_of(pprof, struct asus_wmi, 
>> platform_profile_handler);
>>  +
>>  +	/* All possible toggles like throttle_thermal_policy here */
>>  +	if (asus->throttle_thermal_policy_available) {
>>  +		tp = asus->throttle_thermal_policy_mode;
>>  +	} else {
>>  +		return -1;
>>  +	}
>>  +
>>  +	if (tp < 0)
>>  +		return tp;
>>  +
>>  +	switch (tp) {
>>  +	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>>  +		*profile = PLATFORM_PROFILE_BALANCED;
>>  +		break;
>>  +	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>>  +		*profile = PLATFORM_PROFILE_PERFORMANCE;
>>  +		break;
>>  +	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>>  +		*profile = PLATFORM_PROFILE_QUIET;
>>  +		break;
>>  +	default:
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int platform_profile_set(struct platform_profile_handler 
>> *pprof,
>>  +				enum platform_profile_option profile)
>>  +{
>>  +	struct asus_wmi *asus;
>>  +	int tp;
>>  +
>>  +	asus = container_of(pprof, struct asus_wmi, 
>> platform_profile_handler);
>>  +
>>  +	/* All possible toggles like throttle_thermal_policy here */
>>  +	if (!asus->throttle_thermal_policy_available) {
>>  +		return -1;
>>  +	}
>>  +
>>  +	switch (profile) {
>>  +	case PLATFORM_PROFILE_PERFORMANCE:
>>  +		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>>  +		break;
>>  +	case PLATFORM_PROFILE_BALANCED:
>>  +		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>  +		break;
>>  +	case PLATFORM_PROFILE_QUIET:
>>  +		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>>  +		break;
>>  +	default:
>>  +		return -EOPNOTSUPP;
>>  +	}
>>  +
>>  +	if (asus->throttle_thermal_policy_available) {
> 
> You already check for asus->throttle_thermal_policy_available a couple
> of lines higher in this function and you return when it is not
> available ...
> 
> I guess this was intended to also have a second if () for
> fan-boost mode ?

Yes, sorry I missed that. I'd initially looked at adding fan-boost also 
but as it is *fans only* I didn't see the value in adding it. I've also 
not seen any use of this in the wild bar one laptop which was likely to 
be retired many months ago.

> 
> Since you are not adding support for fan-boost mode at this time,
> it would be best (IMHO) to drop this second if for now and
> just take this path unconditionally.
> 

Adjusted now.

> 
>>  +		asus->throttle_thermal_policy_mode = tp;
>>  +		return throttle_thermal_policy_write(asus);
>>  +	}
>>  +	return 0;
>>  +}
>>  +
>>  +static int platform_profile_setup(struct asus_wmi *asus)
>>  +{
>>  +	int err;
>>  +
>>  +	if (asus->throttle_thermal_policy_available) {
>>  +		pr_info("Using throttle_thermal_policy for platform_profile 
>> support\n");
>>  +	} else {
>>  +		/*
>>  +		 * Not an error if a component platform_profile relies on is 
>> unavailable
>>  +		 * so early return, skipping the setup of platform_profile.
>>  +		*/
>>  +		return 0;
>>  +	}
>>  +	asus->platform_profile_handler.profile_get = platform_profile_get;
>>  +	asus->platform_profile_handler.profile_set = platform_profile_set;
>>  +
>>  +	set_bit(PLATFORM_PROFILE_QUIET, 
>> asus->platform_profile_handler.choices);
>>  +	set_bit(PLATFORM_PROFILE_BALANCED,
>>  +		asus->platform_profile_handler.choices);
>>  +	set_bit(PLATFORM_PROFILE_PERFORMANCE,
>>  +		asus->platform_profile_handler.choices);
>>  +
>>  +	err = platform_profile_register(&asus->platform_profile_handler);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	asus->platform_profile_support = true;
>>  +	return 0;
>>  +}
>>  +
>>   /* Backlight 
>> ******************************************************************/
>> 
>>   static int read_backlight_power(struct asus_wmi *asus)
>>  @@ -2904,6 +3008,10 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	else
>>   		throttle_thermal_policy_set_default(asus);
>> 
>>  +	err = platform_profile_setup(asus);
>>  +	if (err)
>>  +		goto fail_platform_profile_setup;
>>  +
>>   	err = panel_od_check_present(asus);
>>   	if (err)
>>   		goto fail_panel_od;
>>  @@ -2993,6 +3101,7 @@ static int asus_wmi_add(struct 
>> platform_device *pdev)
>>   	asus_wmi_sysfs_exit(asus->platform_device);
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>>  +fail_platform_profile_setup:
>>   fail_fan_boost_mode:
> 
> I think you need to add this:
> 
> 	if (asus->platform_profile_support)
> 		platform_profile_remove();
> 
> here so that if later fail-exit paths are taken the platform_profile
> support gets unregistered again.

Good catch, thanks! :)

Next version will come after some testing.

> 
>>   fail_egpu_enable:
>>   fail_dgpu_disable:
>>  @@ -3017,6 +3126,9 @@ static int asus_wmi_remove(struct 
>> platform_device *device)
>>   	asus_fan_set_auto(asus);
>>   	asus_wmi_battery_exit(asus);
>> 
>>  +	if (asus->platform_profile_support)
>>  +		platform_profile_remove();
>>  +
>>   	kfree(asus);
>>   	return 0;
>>   }
>> 
> 
> Regards,
> 
> Hans
> 


