Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E235C430
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhDLKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:40:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:27107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237567AbhDLKkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:40:15 -0400
IronPort-SDR: So6wR7sDk2qZ8vcxA+sVweJZSCAVWb3VYJzqluSqWHjpbtKSyjVhfnmkpR/G76P2vZ8Mieu/Ms
 CY+xSNhm9Bnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="214624134"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="214624134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 03:39:56 -0700
IronPort-SDR: /yvyGcOvJ/lkRaqfRjqQJl81c6adRXAKxZ//MrdN1qhUUUtwShVc/C7BC16CQ/VecIj9Xcunsl
 5vhUFeIvI7Rw==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="423741123"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.12.105]) ([10.237.12.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 03:39:52 -0700
Subject: Re: [PATCH v7 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        pierre-louis.bossart@linux.intel.com, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, platform-driver-x86@vger.kernel.org,
        broonie@kernel.org, Dell.Client.Kernel@dell.com,
        mario.limonciello@outlook.com
References: <20210412091919.27608-1-Perry_Yuan@Dell.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <63b8dca1-83d0-09ab-3622-0baa68bbf776@linux.intel.com>
Date:   Mon, 12 Apr 2021 12:39:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210412091919.27608-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2021 11:19 AM, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
> 

(...)

> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 70edc5bb3a14..e7ffc0b81208 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -31,6 +31,8 @@
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
>   
> +#include "dell-privacy-wmi.h"
> +
>   struct quirk_entry {
>   	bool touchpad_led;
>   	bool kbd_led_not_present;
> @@ -90,6 +92,7 @@ static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
>   static bool force_rfkill;
> +static bool has_privacy;
>   
>   module_param(force_rfkill, bool, 0444);
>   MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
> @@ -2206,10 +2209,16 @@ static int __init dell_init(void)
>   
>   	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
>   	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> -		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> -		ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> -		if (ret < 0)
> -			goto fail_led;
> +		if (dell_privacy_present())
> +			has_privacy = true;
> +		else
> +			has_privacy = false;

Bit, of nitpicking, but you can write above shorter:
has_privacy = dell_privacy_present();
