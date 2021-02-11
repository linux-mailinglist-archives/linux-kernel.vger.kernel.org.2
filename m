Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21522319354
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBKTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBKTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:47:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193DC061574;
        Thu, 11 Feb 2021 11:46:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so8220599edd.5;
        Thu, 11 Feb 2021 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JO1yJnzNGk+cfdm/MK4Cg/ptUIdGMILlgNKobj7r/6Q=;
        b=GKd6kKv4UhqDP76SbugI5dy2FIavaEualhuGpHb2s6pLWcHHWS7PKzG9GcH9bFYSut
         E3o6NhsZ3hSISh3Lg0qtMDW86qfOeowALwxJQVTi7b6kiNaLbCfELEmrrjmw9NijX3rm
         Ei8EaX9c2Y/euW3bX3kXu3SXJUonyku4SuKz2Ew522G/b134wXQV0AVlOaWvRgfgERN7
         17rGF0H1bNHENZIlAAQrUOuIg/iwHdblVs9h3C3YKaUZsPE0lNFV/eCnN0AGKfqC76Nr
         RUlv0E7KpjLQ34WOI0U9rEw0KZfe1E8ParnU7yUaZdmZLT5KDsvDdtBkGIzrbJzF46Wn
         IVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JO1yJnzNGk+cfdm/MK4Cg/ptUIdGMILlgNKobj7r/6Q=;
        b=LwBXNIoRjroAn9vemA7/WiJPOQeRFom3+NP1HQbCLXQYlqtR1+6zPvQ7xhubIHaisL
         4x+MeafhesqlLvrXpLBP4RsBZi4ZNwaLjlpSvXMMhUN66z4HYJBqqhDlOmxwsw4RaMuK
         f5+yFXUJXpZox2PFuASUkRRb6RJsJqUGz+x9nyDozQNB50pxP6Vrs7pZBozsGjwYmdi8
         WSeGUH3Yq8/QtSDY+FGrWiF+wu3C2mE7ksdyOlRVMCz58B0IChoU/2xLBYxqXUuTpcg5
         lHoQ193Pc6ZZ7q7SmLJbOgnXw9J4V2X7zIX39Hxlle12TWfq8cIeJpfXZfvnkL/xBBkQ
         O2eA==
X-Gm-Message-State: AOAM532LWb2Y+xnW1w7Aa8i6ui8CF5OTajdtd/8KqJRi+KnNt75unaRs
        8EEYElmIbZYGxfSetthaAJ+A18mWJ4YtFQ==
X-Google-Smtp-Source: ABdhPJx7gkS+eZ+LAuuinByra5e97OOO3PCFJF0btCpRLmxNoEDwaW3WK5wQ3ebr/J5/ihecHe9+rw==
X-Received: by 2002:aa7:c0cd:: with SMTP id j13mr9821640edp.156.1613072805308;
        Thu, 11 Feb 2021 11:46:45 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:44 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] platform/surface: Add Surface Aggregator device registry
Date:   Thu, 11 Feb 2021 20:46:30 +0100
Message-Id: <20210211194636.568929-1-luzmaximilian@gmail.com>
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

Changes in v2:
 - Fix Kconfig dependency

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
2.30.0

