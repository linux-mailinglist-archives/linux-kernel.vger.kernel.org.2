Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF332D182
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhCDLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239328AbhCDLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614855652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqjtYvchYAf+qyJbjLFBG7q+8nttEUzWlwLzinnl22s=;
        b=HREG5IU8FKMQxgZffl75BXSkYbq42Y0qPPZZ+DWOKr7ZPkiG4lODIaPuJKvV1sR5PtFzx3
        kcUjhaj/iB0xB1F8RQFwvDLgged710pm/9RIgEHK7dM1KqFyqmi/IY4On6sUa9ei/qQvcY
        xBDDAHK00mYB5UBVheXE8y+72BCT3rk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-e2FDh_scOUe9OjnM3h30FA-1; Thu, 04 Mar 2021 06:00:51 -0500
X-MC-Unique: e2FDh_scOUe9OjnM3h30FA-1
Received: by mail-ej1-f69.google.com with SMTP id e13so6671151ejd.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 03:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqjtYvchYAf+qyJbjLFBG7q+8nttEUzWlwLzinnl22s=;
        b=UY6H1t2PZPXO7rOT/529owCq3sZBXiB23yQtuz7t7NIsVLfpJKVrizgIXldV6W+/gZ
         I4TgpX7yILtfW30PVujWwo/VINsgPm4sCkTXreujMLrPBo+rXVefjLQcMvu2OsP/LXcd
         opVZn7PetP6jd7LxRm6pMgUTS1ik1D6CrYQKJA+XBIDU5ttCaOnC1Md3QlnEdIlOxYxl
         HbAo3MOp//lhbXzqJaWAiqdn/xM2m5azYC04ZADrZWw19MtpFFUjfHoA5y+m8yCM9sj/
         CC5bhPCyUHwKtii09DI+/c9ZE2CsXu11ZPYjkb6QjC6+AUGS+7xce8Q14mp94c6JzVe/
         QgRw==
X-Gm-Message-State: AOAM5300odRRky8hhuzjogAr3vteY3XPHlagIvAfj9Xn6dO7BzhqOzD4
        6jQU7QVBgqIHoxpyKo2ijxy6gYeapMFmmrJCS+bRh4zSYme8NtyWhjBaYurF4ZDf4RwkFOlY++u
        KduMPPecJt5i1Fy3ebJ7aEVhkwmmX4ox8vYqbaT6e9bk2F2OIzhttI2xBIniCPO/qVbqdY0YXuH
        pl
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr3595481edb.322.1614855649948;
        Thu, 04 Mar 2021 03:00:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgxBrm9H8SDVfyEa4tQjK8lyMSxNIFjbeWQfL40r6Vb4d6DKFN4rl3CIfSvcTXZYSaVLUUFg==
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr3595451edb.322.1614855649711;
        Thu, 04 Mar 2021 03:00:49 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m10sm5710370ejx.10.2021.03.04.03.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:48 -0800 (PST)
Subject: Re: [PATCH v3 0/6] platform/surface: Add Surface Aggregator device
 registry
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210212115439.1525216-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <50854143-032e-95f2-e3e1-b85590a0265b@redhat.com>
Date:   Thu, 4 Mar 2021 12:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212115439.1525216-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/12/21 12:54 PM, Maximilian Luz wrote:
> The Surface System Aggregator Module (SSAM) subsystem provides various
> functionalities, which are separated by spreading them across multiple
> devices and corresponding drivers. Parts of that functionality / some of
> those devices, however, can (as far as we currently know) not be
> auto-detected by conventional means. While older (specifically 5th- and
> 6th-)generation models do advertise most of their functionality via
> standard platform devices in ACPI, newer generations do not.
> 
> As we are currently also not aware of any feasible way to query said
> functionalities dynamically, this poses a problem. There is, however, a
> device in ACPI that seems to be used by Windows for identifying
> different Surface models: The Windows Surface Integration Device (WSID).
> This device seems to have a HID corresponding to the overall set of
> functionalities SSAM provides for the associated model.
> 
> This series introduces a device registry based on software nodes and
> device hubs to solve this problem. The registry is intended to contain
> all required non-detectable information.
> 
> The platform hub driver is loaded against the WSID device and
> instantiates and manages SSAM devices based on the information provided
> by the registry for the given WSID HID of the Surface model. All new
> devices created by this hub added as child devices to this hub.
> 
> In addition, a base hub is introduced to manage devices associated with
> the detachable base part of the Surface Book 3, as this requires special
> handling (i.e. devices need to be removed when the base is removed).
> Again, all devices created by the base hub (i.e. associated with the
> base) are added as child devices to this hub.
> 
> In total, this will yield the following device structure
> 
>   WSID
>    |- SSAM device 1 (physical device)
>    |- SSAM device 2 (physical device)
>    |- SSAM device 3 (physical device)
>    |- ...
>    \- SSAM base hub (virtual device)
>       |- SSAM base device 1 (physical device)
>       |- SSAM base device 2 (physical device)
>       |- ...
> 
> While software nodes seem to be well suited for this approach due to
> extensibility, they still need to be hard-coded, so I'm open for ideas
> on how this could be improved.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> Changes in v2:
>  - Fix Kconfig dependency
> 
> Changes in v3:
>  - Fix use of lockdep_assert_held()
> 
> Maximilian Luz (6):
>   platform/surface: Set up Surface Aggregator device registry
>   platform/surface: aggregator_registry: Add base device hub
>   platform/surface: aggregator_registry: Add battery subsystem devices
>   platform/surface: aggregator_registry: Add platform profile device
>   platform/surface: aggregator_registry: Add DTX device
>   platform/surface: aggregator_registry: Add HID subsystem devices
> 
>  MAINTAINERS                                   |   1 +
>  drivers/platform/surface/Kconfig              |  27 +
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_aggregator_registry.c     | 641 ++++++++++++++++++
>  4 files changed, 670 insertions(+)
>  create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
> 

