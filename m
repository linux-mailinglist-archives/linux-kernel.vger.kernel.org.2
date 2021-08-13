Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1C3EAFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhHMF1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:27:51 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59645 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238668AbhHMF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:27:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3305B320092B;
        Fri, 13 Aug 2021 01:27:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 13 Aug 2021 01:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WPptHg
        5CUXWrlgbhnxdyswXl3gr/UPHyV4c6qD4buvc=; b=s37n2OJfjDysZSavwTfeAk
        klltW+ejANsy5UqQaQi8yCDz/1yG6BJu3r40LI/WbaXG5clM9B83fx6yxWa9YoKs
        oFpX9DUTGYZ1BSOoaLDiVPSISD7AoZGIIVaX1QEY7aO0ZY3mB9gleGkY6RMyv6SO
        e6pQ2HmNh2Rry4/WwJMIAM7+1slxYYuu9Rl6yg1alCw3es3S3huxuXECf1/V9eJ8
        b8p0PKWye/JGYXzGEXRf0kmEnKhk6xaQoVBXQQapAuN9DAOXiZbPgCFGB2rqzsP2
        XYMqBMMoclCOJLOt4NwoPudFkhdkv2rlRabG6DZ27QnyH7HVWvkKHKtNRYPzh9kw
        ==
X-ME-Sender: <xms:ugIWYeq9st2JqS7gRENFpclsRyv_6n4XtHX4VDIA2OgACgx5WBf9jQ>
    <xme:ugIWYco0aUMtnvajdC899i7yJZ3bDrKYvOJb7KT7zgdqrBotZJWFtUIOJgT8ZmM42
    -iD6uf_ICa-Q4tEAxE>
X-ME-Received: <xmr:ugIWYTNO0QYZawigwqxHVj66e51OQhtDz3tRBb8xP_w0wQM41ByeeGk3bxKY3lkYjFtJIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtsehttdertd
    ertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpefgfeefudffhffgueehgeffffeggeevieefueethf
    eijefftedugfeuveethedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ugIWYd6JR4nBZvETVEfrfvJntnaNRc3FVyM7rMJpSN8IY57nJLNFeQ>
    <xmx:ugIWYd7rPpLi70IzWr8acckVIHTUH4NbYhI5tUN8iGj_u7Bpta7VZg>
    <xmx:ugIWYdh9QkJA2azGc6n9QD7BB-OxpXx9mdQtIe3dppA0uz9RKb3sZw>
    <xmx:ugIWYfSyRgtx_e-py83u3pAheEx175qCTooyc71DpqdZJBCJuHphUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Aug 2021 01:27:18 -0400 (EDT)
Date:   Fri, 13 Aug 2021 17:27:03 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
In-Reply-To: <20210813024201.9518-1-luke@ljones.dev>
References: <20210813024201.9518-1-luke@ljones.dev>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unsure of how to update the existing code for fn+f5 (next thermal 
profile) used by laptops like the TUF series that have keyboard over 
i2c. I was thinking of the following:

static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
{
 struct platform_profile_handler *handler = 
&asus->platform_profile_handler; // added
 u8 new_mode = asus->throttle_thermal_policy_mode + 1;

 if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
  new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;

 // asus->throttle_thermal_policy_mode = new_mode;
 // return throttle_thermal_policy_write(asus);
 return handler->profile_set(&asus->platform_profile_handler, 
new_mode); // added
}

* two lines added, two commented

I'm not able to test this though, and there are very few active people 
in my discord with TUF/i2c laptops to ask for testing also.

My concern here is to get the platform_profile correctly updated. 
Simply updating asus->throttle_thermal_policy_mode isn't going to 
achieve what we'll want.

Regards,
Luke.


On Fri, Aug 13 2021 at 14:42:01 +1200, Luke D. Jones <luke@ljones.dev> 
wrote:
> Add initial support for platform_profile where the support is
> based on availability of ASUS_THROTTLE_THERMAL_POLICY.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 112 
> ++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index 90a6a0d00deb..62260043c15c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -26,6 +26,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/platform_profile.h>
>  #include <linux/power_supply.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> @@ -219,6 +220,9 @@ struct asus_wmi {
>  	bool throttle_thermal_policy_available;
>  	u8 throttle_thermal_policy_mode;
> 
> +	struct platform_profile_handler platform_profile_handler;
> +	bool platform_profile_support;
> +
>  	// The RSOC controls the maximum charging percentage.
>  	bool battery_rsoc_available;
> 
> @@ -2144,6 +2148,106 @@ static ssize_t 
> throttle_thermal_policy_store(struct device *dev,
>  // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>  static DEVICE_ATTR_RW(throttle_thermal_policy);
> 
> +/* Platform profile 
> ***********************************************************/
> +static int platform_profile_get(struct platform_profile_handler 
> *pprof,
> +				enum platform_profile_option *profile)
> +{
> +	struct asus_wmi *asus;
> +	int tp;
> +
> +	asus = container_of(pprof, struct asus_wmi, 
> platform_profile_handler);
> +
> +	/* All possible toggles like throttle_thermal_policy here */
> +	if (asus->throttle_thermal_policy_available) {
> +		tp = asus->throttle_thermal_policy_mode;
> +	} else {
> +		return -1;
> +	}
> +
> +	if (tp < 0)
> +		return tp;
> +
> +	switch (tp) {
> +	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int platform_profile_set(struct platform_profile_handler 
> *pprof,
> +				enum platform_profile_option profile)
> +{
> +	struct asus_wmi *asus;
> +	int tp;
> +
> +	asus = container_of(pprof, struct asus_wmi, 
> platform_profile_handler);
> +
> +	/* All possible toggles like throttle_thermal_policy here */
> +	if (!asus->throttle_thermal_policy_available) {
> +		return -1;
> +	}
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (asus->throttle_thermal_policy_available) {
> +		asus->throttle_thermal_policy_mode = tp;
> +		return throttle_thermal_policy_write(asus);
> +	}
> +	return 0;
> +}
> +
> +static int platform_profile_setup(struct asus_wmi *asus)
> +{
> +	int err;
> +
> +	if (asus->throttle_thermal_policy_available) {
> +		pr_info("Using throttle_thermal_policy for platform_profile 
> support\n");
> +	} else {
> +		/*
> +		 * Not an error if a component platform_profile relies on is 
> unavailable
> +		 * so early return, skipping the setup of platform_profile.
> +		*/
> +		return 0;
> +	}
> +	asus->platform_profile_handler.profile_get = platform_profile_get;
> +	asus->platform_profile_handler.profile_set = platform_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_QUIET, 
> asus->platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED,
> +		asus->platform_profile_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE,
> +		asus->platform_profile_handler.choices);
> +
> +	err = platform_profile_register(&asus->platform_profile_handler);
> +	if (err)
> +		return err;
> +
> +	asus->platform_profile_support = true;
> +	return 0;
> +}
> +
>  /* Backlight 
> ******************************************************************/
> 
>  static int read_backlight_power(struct asus_wmi *asus)
> @@ -2904,6 +3008,10 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	else
>  		throttle_thermal_policy_set_default(asus);
> 
> +	err = platform_profile_setup(asus);
> +	if (err)
> +		goto fail_platform_profile_setup;
> +
>  	err = panel_od_check_present(asus);
>  	if (err)
>  		goto fail_panel_od;
> @@ -2993,6 +3101,7 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  	asus_wmi_sysfs_exit(asus->platform_device);
>  fail_sysfs:
>  fail_throttle_thermal_policy:
> +fail_platform_profile_setup:
>  fail_fan_boost_mode:
>  fail_egpu_enable:
>  fail_dgpu_disable:
> @@ -3017,6 +3126,9 @@ static int asus_wmi_remove(struct 
> platform_device *device)
>  	asus_fan_set_auto(asus);
>  	asus_wmi_battery_exit(asus);
> 
> +	if (asus->platform_profile_support)
> +		platform_profile_remove();
> +
>  	kfree(asus);
>  	return 0;
>  }
> --
> 2.31.1
> 


