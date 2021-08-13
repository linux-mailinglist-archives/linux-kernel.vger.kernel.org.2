Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276CD3EB138
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhHMHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:13:48 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35043 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239314AbhHMHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:13:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 089EA320091C;
        Fri, 13 Aug 2021 03:13:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 13 Aug 2021 03:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5Ox8bB
        B6CMSdCRBCCE2WbWhUzjtC5NF7M61SSNbQgUY=; b=a2HI5eRhl+zX6TsHEhnlYe
        KwOt4mSIw2rKEwxz2fQifTLsg0l6DtEBc0J9zOeSxEGpBqHzI3UbIVStilf34L/1
        vPtRItbs4gqM3rSpqvjkW+oHBYkpHRmErd1uMTZ8j+s0gA+Mr8xkHLycUXnvX4/0
        vPqAV3Y967VDGAZ2WdHNZPv9vEytwgWnIuF+cuJtIOCjEBc3GZeD2JXaOkwl5fPS
        TqXeeEeiyDocTeb3wXooxCrgQS1gspgdsda4YXf6vn576kiqXYM7jCVvn3ewqD7+
        g7VEOe1Q10TprOExECQMd7ioieZlOz31KX7jd86ZEyufvTQRGpnoUAxQDatbjCew
        ==
X-ME-Sender: <xms:jxsWYc0gNga9vBFQluhRwXr7wwuZII8xN01T8PoSvlS2FOEyT2Ky7g>
    <xme:jxsWYXFBdpFSRSenf7mJ1jGRM6c_T3hXdxOOy5K7Zq_TKRfL5gUwY1Yw2iNh48Oh9
    BPxMF8MIpVUjrNsn0s>
X-ME-Received: <xmr:jxsWYU67sXcG7ks-8v88ac-V96U3yGMfu0OG15sE-5W7PUc-_WLBdrPE2TkeyFHdf6CwWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fgfeefudffhffgueehgeffffeggeevieefueethfeijefftedugfeuveethedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslh
    hjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jxsWYV1AwDlAfJUCUjN6_S8WsidyQHvhR2z3nunBWsKQuh3k2NFwpQ>
    <xmx:jxsWYfG5rogJ7y8BC_TgFltAfiRlEB3BHQ7iI_WAEZbTcnG6EaCnwg>
    <xmx:jxsWYe9NhhYyZa02tZ4WaQ_TfMkWIMNY5gUVQ5Gm3OWiAHbrHV0EfQ>
    <xmx:kBsWYVMaigUzf4kBGVSYR_gpmn5SdIRSDMOp2uHsdbIiwFpXicJerA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Aug 2021 03:13:16 -0400 (EDT)
Date:   Fri, 13 Aug 2021 19:13:03 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Add support for platform_profile
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hadess@hadess.net,
        platform-driver-x86@vger.kernel.org
Message-Id: <R1ORXQ.WGLIPS8I54X63@ljones.dev>
In-Reply-To: <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
References: <20210813024201.9518-1-luke@ljones.dev>
        <35JRXQ.1ZW8QHWM1YRG@ljones.dev>
        <9cceb3cb-f6d3-ade4-b219-87b2bbce5798@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 13 2021 at 09:03:04 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/13/21 7:27 AM, Luke Jones wrote:
>>  I'm unsure of how to update the existing code for fn+f5 (next 
>> thermal profile) used by laptops like the TUF series that have 
>> keyboard over i2c. I was thinking of the following:
>> 
>>  static int throttle_thermal_policy_switch_next(struct asus_wmi 
>> *asus)
>>  {
>>  struct platform_profile_handler *handler = 
>> &asus->platform_profile_handler; // added
>>  u8 new_mode = asus->throttle_thermal_policy_mode + 1;
>> 
>>  if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>>   new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> 
>>  // asus->throttle_thermal_policy_mode = new_mode;
>>  // return throttle_thermal_policy_write(asus);
>>  return handler->profile_set(&asus->platform_profile_handler, 
>> new_mode); // added
>>  }
>> 
>>  * two lines added, two commented
> 
> I was going to say it is best to just send a key-press event to 
> userspace
> (we can define a new EV_KEY_.... code for this) and then let userspace
> handle things. But I see that this is currently already handled by 
> the kernel,
> so that is not really an option.
> 
>>  I'm not able to test this though, and there are very few active 
>> people in my discord with TUF/i2c laptops to ask for testing also.
>> 
>>  My concern here is to get the platform_profile correctly updated. 
>> Simply updating asus->throttle_thermal_policy_mode isn't going to 
>> achieve what we'll want.
> 
> Right, there is no need to go through handler->profile_set() you have 
> defined
> profile_set yourself after all and it does not do anything different 
> then the
> old code you are replacing here.
> 
> The trick is to call platform_profile_notify() after 
> throttle_thermal_policy_write()
> this will let userspace, e.g. power-profiles-daemon know that the 
> profile has
> been changed and it will re-read it then, resulting in a call to
> handler->profile_get()
> 
> So the new throttle_thermal_policy_switch_next() would look like this:
> 
> static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> {
>         u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> 	int err; // new
> 
>         if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
>                 new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> 
>         asus->throttle_thermal_policy_mode = new_mode;
> 
>         err = throttle_thermal_policy_write(asus); // changed
> 	if (err == 0)                              // new
> 		platform_profile_notify();         // new
> 
> 	return err;                                // new
> }
> 
> As you can see the only new thing here is the
> platform_profile_notify() call on a successful write,
> which is such a small change that I'm not overly worried about
> not being able to test this.
> 
> I hope this helps.
> 
> Regards,
> 
> Hans
> 
> 
>>  On Fri, Aug 13 2021 at 14:42:01 +1200, Luke D. Jones 
>> <luke@ljones.dev> wrote:
>>>  Add initial support for platform_profile where the support is
>>>  based on availability of ASUS_THROTTLE_THERMAL_POLICY.
>>> 
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>  ---
>>>   drivers/platform/x86/asus-wmi.c | 112 
>>> ++++++++++++++++++++++++++++++++
>>>   1 file changed, 112 insertions(+)
>>> 
>>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>>> b/drivers/platform/x86/asus-wmi.c
>>>  index 90a6a0d00deb..62260043c15c 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -26,6 +26,7 @@
>>>   #include <linux/rfkill.h>
>>>   #include <linux/pci.h>
>>>   #include <linux/pci_hotplug.h>
>>>  +#include <linux/platform_profile.h>
>>>   #include <linux/power_supply.h>
>>>   #include <linux/hwmon.h>
>>>   #include <linux/hwmon-sysfs.h>
>>>  @@ -219,6 +220,9 @@ struct asus_wmi {
>>>       bool throttle_thermal_policy_available;
>>>       u8 throttle_thermal_policy_mode;
>>> 
>>>  +    struct platform_profile_handler platform_profile_handler;
>>>  +    bool platform_profile_support;
>>>  +
>>>       // The RSOC controls the maximum charging percentage.
>>>       bool battery_rsoc_available;
>>> 
>>>  @@ -2144,6 +2148,106 @@ static ssize_t 
>>> throttle_thermal_policy_store(struct device *dev,
>>>   // Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>>>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>>> 
>>>  +/* Platform profile 
>>> ***********************************************************/
>>>  +static int platform_profile_get(struct platform_profile_handler 
>>> *pprof,
>>>  +                enum platform_profile_option *profile)
>>>  +{
>>>  +    struct asus_wmi *asus;
>>>  +    int tp;
>>>  +
>>>  +    asus = container_of(pprof, struct asus_wmi, 
>>> platform_profile_handler);
>>>  +
>>>  +    /* All possible toggles like throttle_thermal_policy here */
>>>  +    if (asus->throttle_thermal_policy_available) {
>>>  +        tp = asus->throttle_thermal_policy_mode;
>>>  +    } else {
>>>  +        return -1;
>>>  +    }
>>>  +
>>>  +    if (tp < 0)
>>>  +        return tp;
>>>  +
>>>  +    switch (tp) {
>>>  +    case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>>>  +        *profile = PLATFORM_PROFILE_BALANCED;
>>>  +        break;
>>>  +    case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
>>>  +        *profile = PLATFORM_PROFILE_PERFORMANCE;
>>>  +        break;
>>>  +    case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
>>>  +        *profile = PLATFORM_PROFILE_QUIET;
>>>  +        break;
>>>  +    default:
>>>  +        return -EINVAL;
>>>  +    }
>>>  +
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static int platform_profile_set(struct platform_profile_handler 
>>> *pprof,
>>>  +                enum platform_profile_option profile)
>>>  +{
>>>  +    struct asus_wmi *asus;
>>>  +    int tp;
>>>  +
>>>  +    asus = container_of(pprof, struct asus_wmi, 
>>> platform_profile_handler);
>>>  +
>>>  +    /* All possible toggles like throttle_thermal_policy here */
>>>  +    if (!asus->throttle_thermal_policy_available) {
>>>  +        return -1;
>>>  +    }
>>>  +
>>>  +    switch (profile) {
>>>  +    case PLATFORM_PROFILE_PERFORMANCE:
>>>  +        tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>>>  +        break;
>>>  +    case PLATFORM_PROFILE_BALANCED:
>>>  +        tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>  +        break;
>>>  +    case PLATFORM_PROFILE_QUIET:
>>>  +        tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>>>  +        break;
>>>  +    default:
>>>  +        return -EOPNOTSUPP;
>>>  +    }
>>>  +
>>>  +    if (asus->throttle_thermal_policy_available) {
>>>  +        asus->throttle_thermal_policy_mode = tp;
>>>  +        return throttle_thermal_policy_write(asus);
>>>  +    }
>>>  +    return 0;
>>>  +}
>>>  +
>>>  +static int platform_profile_setup(struct asus_wmi *asus)
>>>  +{
>>>  +    int err;
>>>  +
>>>  +    if (asus->throttle_thermal_policy_available) {
>>>  +        pr_info("Using throttle_thermal_policy for 
>>> platform_profile support\n");
>>>  +    } else {
>>>  +        /*
>>>  +         * Not an error if a component platform_profile relies on 
>>> is unavailable
>>>  +         * so early return, skipping the setup of 
>>> platform_profile.
>>>  +        */
>>>  +        return 0;
>>>  +    }
>>>  +    asus->platform_profile_handler.profile_get = 
>>> platform_profile_get;
>>>  +    asus->platform_profile_handler.profile_set = 
>>> platform_profile_set;
>>>  +
>>>  +    set_bit(PLATFORM_PROFILE_QUIET, 
>>> asus->platform_profile_handler.choices);
>>>  +    set_bit(PLATFORM_PROFILE_BALANCED,
>>>  +        asus->platform_profile_handler.choices);
>>>  +    set_bit(PLATFORM_PROFILE_PERFORMANCE,
>>>  +        asus->platform_profile_handler.choices);
>>>  +
>>>  +    err = 
>>> platform_profile_register(&asus->platform_profile_handler);
>>>  +    if (err)
>>>  +        return err;
>>>  +
>>>  +    asus->platform_profile_support = true;
>>>  +    return 0;
>>>  +}
>>>  +
>>>   /* Backlight 
>>> ******************************************************************/
>>> 
>>>   static int read_backlight_power(struct asus_wmi *asus)
>>>  @@ -2904,6 +3008,10 @@ static int asus_wmi_add(struct 
>>> platform_device *pdev)
>>>       else
>>>           throttle_thermal_policy_set_default(asus);
>>> 
>>>  +    err = platform_profile_setup(asus);
>>>  +    if (err)
>>>  +        goto fail_platform_profile_setup;
>>>  +
>>>       err = panel_od_check_present(asus);
>>>       if (err)
>>>           goto fail_panel_od;
>>>  @@ -2993,6 +3101,7 @@ static int asus_wmi_add(struct 
>>> platform_device *pdev)
>>>       asus_wmi_sysfs_exit(asus->platform_device);
>>>   fail_sysfs:
>>>   fail_throttle_thermal_policy:
>>>  +fail_platform_profile_setup:
>>>   fail_fan_boost_mode:
>>>   fail_egpu_enable:
>>>   fail_dgpu_disable:
>>>  @@ -3017,6 +3126,9 @@ static int asus_wmi_remove(struct 
>>> platform_device *device)
>>>       asus_fan_set_auto(asus);
>>>       asus_wmi_battery_exit(asus);
>>> 
>>>  +    if (asus->platform_profile_support)
>>>  +        platform_profile_remove();
>>>  +
>>>       kfree(asus);
>>>       return 0;
>>>   }
>>>  --
>>>  2.31.1
>>> 
>> 
>> 
> 

Hi Hans,

Very helpful, thanks. I'd completely failed to notice 
platform_profile_notify in the platform_profile.h :| I've now put that 
in throttle_thermal_policy_write() just after sysfs_notify().

I will submit new version after completing other feedback.

Many Thanks,
Luke.


