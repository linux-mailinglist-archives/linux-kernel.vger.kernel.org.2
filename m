Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9614931DD20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBQQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:17:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:39945 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhBQQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:17:36 -0500
IronPort-SDR: 60a0An1pZLny3oi6z00XdFkKSddNp3vNgB854Y70JXmRE5MLLKEhXSZY+A6q2OmxzeR+xep8Jr
 bgodiuTZSq1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="163019614"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="163019614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 08:15:51 -0800
IronPort-SDR: nFkPI59WHleHomyyQnTLiz9UFCiPfhCn2YA9VEETu0tlr9Ih8wY++elKUw7McEH7+MRGFI3l5w
 OkOl1/JKLSZA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="385244288"
Received: from gretavix-mobl.amr.corp.intel.com (HELO [10.255.228.22]) ([10.255.228.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 08:15:49 -0800
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <perry979106@gmail.com>,
        Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        platform-driver-x86@vger.kernel.org, broonie@kernel.org
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <bf048701-4e6b-ad18-1a73-8bca5c922425@linux.intel.com>
 <79277bf2-3c9e-8b66-47a9-b926a2576f7f@gmail.com>
 <31982e8d-3b0d-7187-8798-900f95d876ee@linux.intel.com>
 <e66d8098-beb6-1299-20aa-42cfe13882f6@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <882f4b80-c182-4038-39bd-eddb2ecc7800@linux.intel.com>
Date:   Wed, 17 Feb 2021 08:23:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e66d8098-beb6-1299-20aa-42cfe13882f6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/21 6:47 AM, Perry Yuan wrote:
> Hi Pierre:
> On 2021/2/16 22:56, Pierre-Louis Bossart wrote:
>>
>>>>> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
>>>>> +    {"PNP0C09", 0},
>>>>> +    { },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
>>>>> +
>>>>> +static struct platform_driver dell_privacy_platform_drv = {
>>>>> +    .driver = {
>>>>> +        .name = PRIVACY_PLATFORM_NAME,
>>>>> +        .acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
>>>>> +    },
>>>>
>>>> no .probe?
>>> Originally i added the probe here, but it cause the driver  .probe 
>>> called twice. after i use platform_driver_probe to register the 
>>> driver loading process, the duplicated probe issue resolved.
>>>
>>> I
>>>>
>>>>> +    .remove = dell_privacy_acpi_remove,
>>>>> +};
>>>>> +
>>>>> +int __init dell_privacy_acpi_init(void)
>>>>> +{
>>>>> +    int err;
>>>>> +    struct platform_device *pdev;
>>>>> +    int privacy_capable = wmi_has_guid(DELL_PRIVACY_GUID);
>>>>> +
>>>>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>>>>> +    if (!privacy_acpi)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    pdev = platform_device_register_simple(
>>>>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>>>>> +    if (IS_ERR(pdev)) {
>>>>> +        err = PTR_ERR(pdev);
>>>>> +        goto pdev_err;
>>>>> +    }
>>>>> +    err = platform_driver_probe(&dell_privacy_platform_drv,
>>>>> +            dell_privacy_acpi_probe);
>>>>> +    if (err)
>>>>> +        goto pdrv_err;
>>>>
>>>> why is the probe done here? Put differently, what prevents you from 
>>>> using a 'normal' platform driver, and do the leds_setup in the 
>>>> .probe()?
>>> At first ,I used the normal platform driver framework, however tt 
>>> cause the driver  .probe called twice. after i use 
>>> platform_driver_probe to register the driver loading process, the 
>>> duplicated probe issue resolved.
>>
>> This sounds very odd...
>>
>> this looks like a conflict with the ACPI subsystem finding a device 
>> and probing the driver that's associated with the PNP0C09 HID, and 
>> then this module __init  creating a device manually which leads to a 
>> second probe
>>
>> Neither the platform_device_register_simple() nor 
>> platform_driver_probe() seem necessary?Because this privacy acpi 
>> driver file has dependency on the ec handle, 
> so i want to determine if the driver can be loaded basing on the EC ID 
> PNP0C09 matching.
> 
> So far,It works well for me to register the privacy driver with  the 
> register sequence.
> Dose it hurt to keep current registering process with 
> platform_driver_probe used?

Sorry, I don't understand why you need to list PNP0C09 HID in a matching 
table if it's not used to probe anything.

The purpose of those matching tables is that when this HID is found, the 
core will invoke the probe callback with no need for any manual 
intervention.

If you want to do things manually with the module init, that's fine, 
it's the combination of the two that I find questionable.

It's like having both a manual and automatic transmission in a car, with 
the automatic transmission not coupled to the wheels.

