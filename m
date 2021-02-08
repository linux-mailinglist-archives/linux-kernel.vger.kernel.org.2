Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D931414C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhBHVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhBHUFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:05:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52AC061786;
        Mon,  8 Feb 2021 12:04:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so20348734edd.5;
        Mon, 08 Feb 2021 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FoOGu4DWs4SGRzlg+DWt3ZeJ09EkG63bI00A+8Dr1co=;
        b=qBtvbqWbP0LqThDEoZW31gQ2D8KekmkA2yDSmAqYfIi4tMhnKEn0ttShOlI601gn8R
         1JgoJLCpW5Ku8f0CxapTJmm5j6G4eq7brCkidB3LCiEFhaWekjkrvrd9EfCKRHLPMsoH
         gw4priPqksRX5IjmOdeApREMRwKi20ynPZeFLpF+p5ZkMxSR8mhvLMn4yYAkTjJYjLcS
         rhRyva+VyC9Xyvma306WE2dNxjt6X0T6+yl1BLvJPvrGL8146IQgeP+fhzUg/c7fO/nx
         tli+cwc9+USTYZ4GHspJ2lWAv0tSAN0UhUHTZ5dVST3pT/pERWkkcc1v4lv5wN7GpslR
         HP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FoOGu4DWs4SGRzlg+DWt3ZeJ09EkG63bI00A+8Dr1co=;
        b=UgNLFV3xx7IW5Y+MTEx1TlN1lryJ+FQTlFqxtx8Bs6wQWIxQWK3TEjJLH7Q1waMIdV
         Wguub77oW3C9xIXLb6B6pSpXPCTbrebdRSuEuJFTsqHyGaxNIlfZlq3YBP6Q9S07NbXS
         9pz8jkRjBqyua4dvgM4tR5mm0vGWXt35g8mi69azOlf+9RjfegKqmL/KJYe5C7i1TG+H
         RD175lyYf14lZFh8tPoVwXAKTHIWL+F3dftyMX/n0SvuZ1J1JjgciFOzlg++z5TnVz3c
         nrHCCjJy/UuOasYiS7QDv/MaI4AAvdC7UrWA6NBRLXEAB5DKOA3BRdidoMCSylX/DFq4
         vzeg==
X-Gm-Message-State: AOAM533ofknwGmJSXwiFZZ9hp9gyEXO7WXPVvtxoY8id6vcfX0ze5kR5
        +uQWXcL8JqgKN9AZ1fxfHqB5Lpz/SQ84Kg==
X-Google-Smtp-Source: ABdhPJwqVO9PxtEZimcJYZZMtmO1GrgUXfnVU/n/nymys3HAFqRdllzuHNrfEfH0I8xrEzzII4PcIw==
X-Received: by 2002:a50:aade:: with SMTP id r30mr1093556edc.15.1612814668102;
        Mon, 08 Feb 2021 12:04:28 -0800 (PST)
Received: from [10.17.0.29] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id m14sm10429114edl.10.2021.02.08.12.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 12:04:27 -0800 (PST)
Subject: Re: [PATCH 0/6] platform/surface: Add Surface Aggregator device
 registry
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
 <d11ec6b6-8fca-7174-3be8-22683798ffb6@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <33e4cf40-4ed8-0b82-d4b2-ec483d8562e1@gmail.com>
Date:   Mon, 8 Feb 2021 21:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d11ec6b6-8fca-7174-3be8-22683798ffb6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 8:55 PM, Hans de Goede wrote:
> Hi,
> 
> On 2/8/21 8:35 PM, Maximilian Luz wrote:
>> The Surface System Aggregator Module (SSAM) subsystem provides various
>> functionalities, which are separated by spreading them across multiple
>> devices and corresponding drivers. Parts of that functionality / some of
>> those devices, however, can (as far as we currently know) not be
>> auto-detected by conventional means. While older (specifically 5th- and
>> 6th-)generation models do advertise most of their functionality via
>> standard platform devices in ACPI, newer generations do not.
>>
>> As we are currently also not aware of any feasible way to query said
>> functionalities dynamically, this poses a problem. There is, however, a
>> device in ACPI that seems to be used by Windows for identifying
>> different Surface models: The Windows Surface Integration Device (WSID).
>> This device seems to have a HID corresponding to the overall set of
>> functionalities SSAM provides for the associated model.
>>
>> This series introduces a device registry based on software nodes and
>> device hubs to solve this problem. The registry is intended to contain
>> all required non-detectable information.
>>
>> The platform hub driver is loaded against the WSID device and
>> instantiates and manages SSAM devices based on the information provided
>> by the registry for the given WSID HID of the Surface model. All new
>> devices created by this hub added as child devices to this hub.
>>
>> In addition, a base hub is introduced to manage devices associated with
>> the detachable base part of the Surface Book 3, as this requires special
>> handling (i.e. devices need to be removed when the base is removed).
>> Again, all devices created by the base hub (i.e. associated with the
>> base) are added as child devices to this hub.
>>
>> In total, this will yield the following device structure
>>
>>    WSID
>>     |- SSAM device 1 (physical device)
>>     |- SSAM device 2 (physical device)
>>     |- SSAM device 3 (physical device)
>>     |- ...
>>     \- SSAM base hub (virtual device)
>>        |- SSAM base device 1 (physical device)
>>        |- SSAM base device 2 (physical device)
>>        |- ...
>>
>> While software nodes seem to be well suited for this approach due to
>> extensibility, they still need to be hard-coded, so I'm open for ideas
>> on how this could be improved.
> 
> This series looks good to me.
> 
> One question is this 5.12 material, or is this intended for 5.13
> (together with drivers attaching to the newly instantiated devices) ?
> 
> I can drop this into for-next tomorrow, that gives it just about
> enough "baking" time in -next to still make it into 5.12
> (this should be pretty safe to push to for-next despite it being
> somewhat close to the cutoff point as it is a new driver).
> 
> Maximilian, do you want me to add this series to for-next tomorrow,
> or would you prefer for it to go to -next after 5.12-rc1
> (and thus end up in 5.13) ?

I wouldn't mind giving this a bit more time to maybe collect some more
reviews.

The only real functionality that depends on this and would be ready for
5.12 right now is the performance profile. Everything else will have to
go into 5.13 anyway (still need to cleanup and prepare patches for
that), so 5.13 seems to be the better target for me.

Regards,
Max

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
>>
>> Maximilian Luz (6):
>>    platform/surface: Set up Surface Aggregator device registry
>>    platform/surface: aggregator_registry: Add base device hub
>>    platform/surface: aggregator_registry: Add battery subsystem devices
>>    platform/surface: aggregator_registry: Add platform profile device
>>    platform/surface: aggregator_registry: Add DTX device
>>    platform/surface: aggregator_registry: Add HID subsystem devices
>>
>>   MAINTAINERS                                   |   1 +
>>   drivers/platform/surface/Kconfig              |  26 +
>>   drivers/platform/surface/Makefile             |   1 +
>>   .../surface/surface_aggregator_registry.c     | 641 ++++++++++++++++++
>>   4 files changed, 669 insertions(+)
>>   create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
>>
> 
