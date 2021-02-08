Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC231413D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhBHVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235435AbhBHT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612814146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRrDtnyYuyW+GWA2hcWcAIgvqFUC4FmUxdsZVu1EqAc=;
        b=STB66d6TlDuRA2/MNc6KH7LhXbnv3bwclxGKCVj2zpnZzxWcByisGhhruAIBIaWHXqdK6j
        2kFoFBs/RLsiOh4U8JrdDjVgaAOWLlzHtuhD59OIg6yGDQkRDP3DGq72dxbjHg3nUtxhMV
        6ApAK/GNaaXcHwz7YwajbBf7ReT/Fds=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-5tO_3_U6N2CwCWCq7S4fiQ-1; Mon, 08 Feb 2021 14:55:42 -0500
X-MC-Unique: 5tO_3_U6N2CwCWCq7S4fiQ-1
Received: by mail-ed1-f70.google.com with SMTP id y6so15209953edc.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRrDtnyYuyW+GWA2hcWcAIgvqFUC4FmUxdsZVu1EqAc=;
        b=JwQStlnGurnX/EArMeAXb972OqYNAxblWpu1k2cQ6w+btgnk4IubnwqmJf3Zs0bl5Q
         U7Yf+yONtJlvF9ItDgOY+EtL34tabRnrNbEC15Q+2f9omRFULJJEaWaauv0dTfd3atTj
         EqZRTUGnTaj0SLLmq2g540vYmuL2W97Inpts95CSvDsbUhNA8jwqanEXKOlgY2qfbv3H
         gBRHPs5Qa4/V7OUCVB/d1DYmWWfEqcn0kMG529U2oimGx1OzXLEL97OvoqLjYbZXJC73
         3E7ITLGPjkzrvxCIdz6tnzthkZsVHbTmzTK5pmUobaETHtpxdl8RDaqW7PVldaZLgD8M
         GZrA==
X-Gm-Message-State: AOAM530jFTFKf1XG0swPDWhgyBDVfCBGLapkDpYaCHG1YCwd6D2GUa+y
        ZuLap2yQN+XLNAqRmBHx7aUSUcp69ZqSq/rd1+F57cBS2nCdIu6VcFkCmoCbCgbTUySgEDqQvIg
        /6plNkVrPGz2d1nOUJ1xUZGUUbTGFomfalHnJD7WErhqRck2Zde9zr9jRW70uAFY6KpxbJnfj1q
        wM
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr19107104eje.541.1612814141386;
        Mon, 08 Feb 2021 11:55:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxve9SM8SC2Gpxq59ecEk7qbwSrbqSZDxnsvnvMhwDL6XGBMftUhmPplK08NTp4TLNyQUROg==
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr19107072eje.541.1612814140908;
        Mon, 08 Feb 2021 11:55:40 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id kv24sm9025719ejc.117.2021.02.08.11.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:55:40 -0800 (PST)
Subject: Re: [PATCH 0/6] platform/surface: Add Surface Aggregator device
 registry
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208193508.3038055-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d11ec6b6-8fca-7174-3be8-22683798ffb6@redhat.com>
Date:   Mon, 8 Feb 2021 20:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208193508.3038055-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/8/21 8:35 PM, Maximilian Luz wrote:
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

This series looks good to me.

One question is this 5.12 material, or is this intended for 5.13
(together with drivers attaching to the newly instantiated devices) ?

I can drop this into for-next tomorrow, that gives it just about
enough "baking" time in -next to still make it into 5.12
(this should be pretty safe to push to for-next despite it being
somewhat close to the cutoff point as it is a new driver).

Maximilian, do you want me to add this series to for-next tomorrow,
or would you prefer for it to go to -next after 5.12-rc1
(and thus end up in 5.13) ?

Regards,

Hans






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
>  drivers/platform/surface/Kconfig              |  26 +
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_aggregator_registry.c     | 641 ++++++++++++++++++
>  4 files changed, 669 insertions(+)
>  create mode 100644 drivers/platform/surface/surface_aggregator_registry.c
> 

