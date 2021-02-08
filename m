Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43383140F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhBHUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhBHTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:36:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6BC061786;
        Mon,  8 Feb 2021 11:35:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t5so20118519eds.12;
        Mon, 08 Feb 2021 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLkfqnoN6pj/NAqIhpdOb7jdNAMnGipQQ2M65QsTy4Q=;
        b=CUeH4orN2XxCoPw4eEFN8Oz4q1Qc6yh4X4CeGQSvEY5c6/KFwPNVmz9fSaiJZNSBPz
         FzyjXMyTmG6/Zkm0oD89HUYxFvt7vEN5nOx5mA3ame6XhAZUrrKgKRHl4JotlDDixpzf
         pSad6YwTzf7KLEoNS3PC5WLTipU3yzm2ofLlXXfJ1zHB5YPyZjpxaC4NbHMeXTJj6xIs
         T+7qYhW7ulHCsiSKY6WfZeq9LnMsiyvFQ+OVtAgqOH3Twhko62WXQbzcR+Am5TU4TcqY
         i5ckmD6rirDeGfFimpAtEmN1PvbH9Bz0x13v+Hg4WUA6YFz5TO2SUIPi47eZ1e0AeLqw
         31lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLkfqnoN6pj/NAqIhpdOb7jdNAMnGipQQ2M65QsTy4Q=;
        b=MRh8FrECwV3BLuhS7JDICCv6LpQLkIW6WjLdv952UObjd8AwQ99TMKI2nxZjiuyXGA
         5aWKJM3TzjXdICkN9eift1Ey1S7r9J7narkx8VSSba4RSrLBpj4HmyMynKq5fvpvDo32
         +uLSAVtnO45DEtVWqsto+DsgU0+SpewsYUKcr+2M3/QFJ0O5EJwO7/ZgIv8f65DDpexL
         PrRpwH2+sW12D8t+9d5nBRumo3xmhOeVlfFWDBryP/gewqHcO46azZrcJjNK/LtX1Zgf
         HAPuKPzwFQ4loylg0pQyQF4MVboGI/jSAIFYDg9oGrE01JDrpiVUUGG5949EIv+jG7Uo
         rdnQ==
X-Gm-Message-State: AOAM531HSt/+HUPHqftzzRK8U3cz3S4hFwQO1mQLkgKY8FpxdfhkCF8q
        XJPxEbaAz4esxQ4svzHKt6s=
X-Google-Smtp-Source: ABdhPJx3MTEvSexn+W4oAJGgxlwYWAuABMPJjc1CqBowY1bbDxut3GNqdtl+G3UokrMVTGUUSBYqmg==
X-Received: by 2002:a05:6402:22b0:: with SMTP id cx16mr11323174edb.255.1612812918607;
        Mon, 08 Feb 2021 11:35:18 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id g9sm9241414ejp.55.2021.02.08.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:35:17 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] platform/surface: Add Surface Aggregator device registry
Date:   Mon,  8 Feb 2021 20:35:02 +0100
Message-Id: <20210208193508.3038055-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface System Aggregator Module (SSAM) subsystem provides various
functionalities, which are separated by spreading them across multiple
devices and corresponding drivers. Parts of that functionality / some of
those devices, however, can (as far as we currently know) not be
auto-detected by conventional means. While older (specifically 5th- and
6th-)generation models do advertise most of their functionality via
standard platform devices in ACPI, newer generations do not.

As we are currently also not aware of any feasible way to query said
functionalities dynamically, this poses a problem. There is, however, a
device in ACPI that seems to be used by Windows for identifying
different Surface models: The Windows Surface Integration Device (WSID).
This device seems to have a HID corresponding to the overall set of
functionalities SSAM provides for the associated model.

This series introduces a device registry based on software nodes and
device hubs to solve this problem. The registry is intended to contain
all required non-detectable information.

The platform hub driver is loaded against the WSID device and
instantiates and manages SSAM devices based on the information provided
by the registry for the given WSID HID of the Surface model. All new
devices created by this hub added as child devices to this hub.

In addition, a base hub is introduced to manage devices associated with
the detachable base part of the Surface Book 3, as this requires special
handling (i.e. devices need to be removed when the base is removed).
Again, all devices created by the base hub (i.e. associated with the
base) are added as child devices to this hub.

In total, this will yield the following device structure

  WSID
   |- SSAM device 1 (physical device)
   |- SSAM device 2 (physical device)
   |- SSAM device 3 (physical device)
   |- ...
   \- SSAM base hub (virtual device)
      |- SSAM base device 1 (physical device)
      |- SSAM base device 2 (physical device)
      |- ...

While software nodes seem to be well suited for this approach due to
extensibility, they still need to be hard-coded, so I'm open for ideas
on how this could be improved.

Maximilian Luz (6):
  platform/surface: Set up Surface Aggregator device registry
  platform/surface: aggregator_registry: Add base device hub
  platform/surface: aggregator_registry: Add battery subsystem devices
  platform/surface: aggregator_registry: Add platform profile device
  platform/surface: aggregator_registry: Add DTX device
  platform/surface: aggregator_registry: Add HID subsystem devices

 MAINTAINERS                                   |   1 +
 drivers/platform/surface/Kconfig              |  26 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_registry.c     | 641 ++++++++++++++++++
 4 files changed, 669 insertions(+)
 create mode 100644 drivers/platform/surface/surface_aggregator_registry.c

-- 
2.30.0

