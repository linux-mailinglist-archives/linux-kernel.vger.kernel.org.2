Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7D31CC85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBPO6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:58:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:1208 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBPO6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:58:48 -0500
IronPort-SDR: N2EXDkv9ZEiOAYjPDLrjhARvCoYtRpdAXWpIvaq9xEj50RfW/cO496RbCb6zpW8OmmMEO5q7D3
 VTlH545b7A/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="170567169"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="170567169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 06:57:02 -0800
IronPort-SDR: Zq8HeEFeVHOnTSnG3IYXfriCk8fqQlPxgpK1Y13YT0NeoKk6/diCeKu85sfiEYrJMO2cvVSdy8
 8Xdh08xlsvxA==
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; 
   d="scan'208";a="361706392"
Received: from nshettyk-mobl1.amr.corp.intel.com (HELO [10.212.9.66]) ([10.212.9.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 06:56:58 -0800
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31982e8d-3b0d-7187-8798-900f95d876ee@linux.intel.com>
Date:   Tue, 16 Feb 2021 08:56:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <79277bf2-3c9e-8b66-47a9-b926a2576f7f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static const struct acpi_device_id privacy_acpi_device_ids[] = {
>>> +    {"PNP0C09", 0},
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, privacy_acpi_device_ids);
>>> +
>>> +static struct platform_driver dell_privacy_platform_drv = {
>>> +    .driver = {
>>> +        .name = PRIVACY_PLATFORM_NAME,
>>> +        .acpi_match_table = ACPI_PTR(privacy_acpi_device_ids),
>>> +    },
>>
>> no .probe?
> Originally i added the probe here, but it cause the driver  .probe 
> called twice. after i use platform_driver_probe to register the driver 
> loading process, the duplicated probe issue resolved.
> 
> I
>>
>>> +    .remove = dell_privacy_acpi_remove,
>>> +};
>>> +
>>> +int __init dell_privacy_acpi_init(void)
>>> +{
>>> +    int err;
>>> +    struct platform_device *pdev;
>>> +    int privacy_capable = wmi_has_guid(DELL_PRIVACY_GUID);
>>> +
>>> +    if (!wmi_has_guid(DELL_PRIVACY_GUID))
>>> +        return -ENODEV;
>>> +
>>> +    privacy_acpi = kzalloc(sizeof(*privacy_acpi), GFP_KERNEL);
>>> +    if (!privacy_acpi)
>>> +        return -ENOMEM;
>>> +
>>> +    pdev = platform_device_register_simple(
>>> +            PRIVACY_PLATFORM_NAME, PLATFORM_DEVID_NONE, NULL, 0);
>>> +    if (IS_ERR(pdev)) {
>>> +        err = PTR_ERR(pdev);
>>> +        goto pdev_err;
>>> +    }
>>> +    err = platform_driver_probe(&dell_privacy_platform_drv,
>>> +            dell_privacy_acpi_probe);
>>> +    if (err)
>>> +        goto pdrv_err;
>>
>> why is the probe done here? Put differently, what prevents you from 
>> using a 'normal' platform driver, and do the leds_setup in the .probe()?
> At first ,I used the normal platform driver framework, however tt cause 
> the driver  .probe called twice. after i use platform_driver_probe to 
> register the driver loading process, the duplicated probe issue resolved.

This sounds very odd...

this looks like a conflict with the ACPI subsystem finding a device and 
probing the driver that's associated with the PNP0C09 HID, and then this 
module __init  creating a device manually which leads to a second probe

Neither the platform_device_register_simple() nor 
platform_driver_probe() seem necessary?
