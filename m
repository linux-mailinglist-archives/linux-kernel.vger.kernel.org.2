Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54103312FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCHQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:55326 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhCHQIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:45 -0500
IronPort-SDR: w6kFO3aSJ0qkv2B+PrOEyRs75ZMV70AKuyH/1WMVqjmz46EELnh4FIEK9JFfc57dUroGTmzHAC
 Se0tPlFkokUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175670135"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175670135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:44 -0800
IronPort-SDR: OUFns45em4p49P9cokLZVeZftZt4yYCXzvn+ScjFMwJ2vbU82i/VINKStc7FNnQrtAynkOXpRR
 2HeshybNmQOw==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="430419069"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206]) ([10.212.234.206])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:41 -0800
Subject: Re: [PATCH v4 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        "pobrn@protonmail.com" <pobrn@protonmail.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210301093753.16300-1-Perry_Yuan@Dell.com>
 <551e30d2-0211-f3cb-fbb8-ee5b2f22a851@linux.intel.com>
 <SJ0PR19MB4528E7C88C955D2EE96CE3B484939@SJ0PR19MB4528.namprd19.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab14a0b2-3f3a-3796-8baf-76e635d82340@linux.intel.com>
Date:   Mon, 8 Mar 2021 09:59:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4528E7C88C955D2EE96CE3B484939@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>    module_param(force_rfkill, bool, 0444);
>>>    MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted
>>> models");
>>>
>>> +
>>
>> spurious line change
> I just want to make them separate with more space .
> If it cause concern, I will remote the line in V5.

it's fine to improve spaces/alignment, just do it in a separate patch.

> 
>>
>>>    static const struct dmi_system_id dell_device_table[] __initconst = {
>>>    	{
>>>    		.ident = "Dell laptop",
>>> @@ -2205,11 +2209,17 @@ static int __init dell_init(void)
>>>    	dell_laptop_register_notifier(&dell_laptop_notifier);
>>>
>>>    	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
>>> -	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
>>> -		micmute_led_cdev.brightness =
>> ledtrig_audio_get(LED_AUDIO_MICMUTE);
>>> -		ret = led_classdev_register(&platform_device->dev,
>> &micmute_led_cdev);
>>> -		if (ret < 0)
>>> -			goto fail_led;
>>> +
>> 	dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
>>
>> not sure why you changed the alignment?
> The previous alignment is a little not correct.
> So I adjust it
> If it cause concern, will restore it to original shape.

same here, use a different patch.

