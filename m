Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0F319DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBLL4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhBLLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:55:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B05C061574;
        Fri, 12 Feb 2021 03:55:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so7540767wry.2;
        Fri, 12 Feb 2021 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPL+pi7tfOJgqXhdpEPJQS69XteO55VN6vxo2/M4MKY=;
        b=kiBZY+OXC05nGliMqCIc9bbsWmWW9JaphUr+4IKugf1bXCQhMGsXBLz8sx+mc50B5b
         ipIzSSLsJLGQ/LU1AKBIxChV2eSNmzVEr2J/e8dtfFXf0WAit5un+JgpsAOinps8Q6AQ
         c4wUoGixFO7SUYey3F0XdyejujQWnyKfsHCXq2+1g42PN2VUzV84MjPBw1chpm+wSPtp
         XaNso9v0j5T1yUaRRgNqk7cNsP9fLBOekXnS5dgzm8oXCokXhoS3tyM4sO6nl8zdvjQ2
         JGkTBx62BNwQSIqJ0P+YMgGMnCLkxBKKfXJFo0lIdp0gX2tcirxuYoKb5BVgXDKhn4+u
         Ag/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPL+pi7tfOJgqXhdpEPJQS69XteO55VN6vxo2/M4MKY=;
        b=oB/3g6jXaa1Qra55ghbNtOHTmORycubt3ptFeitCVGx7uaNv+5h/9/1xEuafqyWI1C
         haI55wBcGyUEbaj13MHN2FG5mVi8Gy+F+opS8wightqyrgcc81zRjzzibfGX2esqGfw0
         rOVYNb5GhLRmBMnG4qFxnScU1dSymkEgFwIkyx8s4YCKSJE98pMsONGvUDsIeVNi6hFP
         NycYWHYpyYRK1212OD8SZOaa3kf0oQNbiqA7YBWgfvbkXiAUgy9j1d8nAN5LnnzvW+2w
         hZOHY6yVu04+Qf4iuDFSxw81AJd4oplc+0tenllLY5DyGTjookv2qWKTJ5BhDQkdIape
         G5+g==
X-Gm-Message-State: AOAM5331gnt4HJ9pA/JTENsd11jJKFO6xjLkozjH9pYwOT/Rm4U2837s
        U2oNcEDMB97/4A/R6y9Unxo=
X-Google-Smtp-Source: ABdhPJwdhzy7UJ6koChLNIDqpt7fUBASqhXl9+Yp5UsofpF2z8ccGiXbQ6soyb5Mk1qOrP9CaU3sOA==
X-Received: by 2002:adf:f003:: with SMTP id j3mr3014035wro.335.1613130899081;
        Fri, 12 Feb 2021 03:54:59 -0800 (PST)
Received: from xws.localdomain (p5487bf16.dip0.t-ipconnect.de. [84.135.191.22])
        by smtp.gmail.com with ESMTPSA id p1sm9455560wru.86.2021.02.12.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 03:54:58 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] platform/surface: Add Surface Aggregator device registry
Date:   Fri, 12 Feb 2021 12:54:33 +0100
Message-Id: <20210212115439.1525216-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
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

Changes in v2:
 - Fix Kconfig dependency

Changes in v3:
 - Fix use of lockdep_assert_held()

Maximilian Luz (6):
  platform/surface: Set up Surface Aggregator device registry
  platform/surface: aggregator_registry: Add base device hub
  platform/surface: aggregator_registry: Add battery subsystem devices
  platform/surface: aggregator_registry: Add platform profile device
  platform/surface: aggregator_registry: Add DTX device
  platform/surface: aggregator_registry: Add HID subsystem devices

 MAINTAINERS                                   |   1 +
 drivers/platform/surface/Kconfig              |  27 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_registry.c     | 641 ++++++++++++++++++
 4 files changed, 670 insertions(+)
 create mode 100644 drivers/platform/surface/surface_aggregator_registry.c

-- 
2.30.1

