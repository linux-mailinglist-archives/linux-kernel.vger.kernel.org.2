Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB239BA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFDNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFDNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:50:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA248C061789;
        Fri,  4 Jun 2021 06:48:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so9405289wrw.6;
        Fri, 04 Jun 2021 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6krBnFnbTexLeYVxG8AbFbd9NK8E8A28cizYGAD8aHQ=;
        b=GUZTByC2w73LEV/rF5oe9BKwqj+f0JyGdXjqeHM7uE85mLXvaiEoEHmTi63HrincMB
         QhbBYcEi6OfIeVExEd1ojfxqhQr0VAeAAOxVUGDM9wEMTi2DMli2Sk4VcGun4oObiOCn
         p3n9p0Lq4baPRnRXmLZzycUZ92IKc9auEgAzXRlioqaij+u5IUONlCF+6NfFnvgY3TMx
         whvInVSPvP3YmnpRdfchDjGjkLTTE2n8j4xgAbcietPjZKzcfriNQzZMkAukZ5WNMG5x
         WH5604xXWR7MRECJ+o9xYYm0m0jjHACeTTRLGXGuOdn/s+EagG630lH7eoFeKJwfmDVi
         l3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6krBnFnbTexLeYVxG8AbFbd9NK8E8A28cizYGAD8aHQ=;
        b=hIF9R1AfgLxgg6iO/PO8YM+zrxcu/yEIvXy18x8c84w9uAoWxlLs7lSjEDt2PtoDBk
         YLjlGRmRhOKLbGC3R6Y+rtHHakSU6w9LiQkWQBgbcoQsMHKWjK3lwgm1ulGebKFXQj9t
         pGeqRetuU2h6C14y62PJz2XHTvbj8AozDj+jF0OL26BpBiTTiScYGo2Njg5lYkkuGvna
         2uD1jS7R9aVOitj6c9Z8aBV8oTlr1YiA1Pn+81cOns/WVijDNd6+1N21zhN6P1EhvMjx
         8JwuBDwTQ7bzVfbS/SWKD1UK7ix4Mc5J38XOqVK+qobbcdn8EwS65P7FPbTuj8BbK8rP
         9c6Q==
X-Gm-Message-State: AOAM532kM26acrx+XFSasBIVAE4SGD+/vJY/JuLXmeaEiagCsmoCdzlk
        /Ai1wGNgu1wBOo1l4vELFB4=
X-Google-Smtp-Source: ABdhPJxg2cq/v9q3DMgdXZaHzRqz5QNMu0IoE6u1drW4SL3CFRp6Q3qz5mlvc4w2P8z54UF4O6Gatw==
X-Received: by 2002:adf:efca:: with SMTP id i10mr4058874wrp.139.1622814505362;
        Fri, 04 Jun 2021 06:48:25 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id u16sm7403167wru.56.2021.06.04.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:48:25 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] docs: driver-api: Update Surface Aggregator user-space interface documentation
Date:   Fri,  4 Jun 2021 15:47:55 +0200
Message-Id: <20210604134755.535590-8-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604134755.535590-1-luzmaximilian@gmail.com>
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the controller-device user-space interface (cdev) documentation
for the newly introduced IOCTLs and event interface.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v2:
 - None

---
 .../surface_aggregator/clients/cdev.rst       | 127 +++++++++++++++++-
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/clients/cdev.rst b/Documentation/driver-api/surface_aggregator/clients/cdev.rst
index 248c1372d879..0134a841a079 100644
--- a/Documentation/driver-api/surface_aggregator/clients/cdev.rst
+++ b/Documentation/driver-api/surface_aggregator/clients/cdev.rst
@@ -1,9 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-.. |u8| replace:: :c:type:`u8 <u8>`
-.. |u16| replace:: :c:type:`u16 <u16>`
 .. |ssam_cdev_request| replace:: :c:type:`struct ssam_cdev_request <ssam_cdev_request>`
 .. |ssam_cdev_request_flags| replace:: :c:type:`enum ssam_cdev_request_flags <ssam_cdev_request_flags>`
+.. |ssam_cdev_event| replace:: :c:type:`struct ssam_cdev_event <ssam_cdev_event>`
 
 ==============================
 User-Space EC Interface (cdev)
@@ -23,6 +22,40 @@ These IOCTLs and their respective input/output parameter structs are defined in
 A small python library and scripts for accessing this interface can be found
 at https://github.com/linux-surface/surface-aggregator-module/tree/master/scripts/ssam.
 
+.. contents::
+
+
+Receiving Events
+================
+
+Events can be received by reading from the device-file. The are represented by
+the |ssam_cdev_event| datatype.
+
+Before events are available to be read, however, the desired notifiers must be
+registered via the ``SSAM_CDEV_NOTIF_REGISTER`` IOCTL. Notifiers are, in
+essence, callbacks, called when the EC sends an event. They are, in this
+interface, associated with a specific target category and device-file-instance.
+They forward any event of this category to the buffer of the corresponding
+instance, from which it can then be read.
+
+Notifiers themselves do not enable events on the EC. Thus, it may additionally
+be necessary to enable events via the ``SSAM_CDEV_EVENT_ENABLE`` IOCTL. While
+notifiers work per-client (i.e. per-device-file-instance), events are enabled
+globally, for the EC and all of its clients (regardless of userspace or
+non-userspace). The ``SSAM_CDEV_EVENT_ENABLE`` and ``SSAM_CDEV_EVENT_DISABLE``
+IOCTLs take care of reference counting the events, such that an event is
+enabled as long as there is a client that has requested it.
+
+Note that enabled events are not automatically disabled once the client
+instance is closed. Therefore any client process (or group of processes) should
+balance their event enable calls with the corresponding event disable calls. It
+is, however, perfectly valid to enable and disable events on different client
+instances. For example, it is valid to set up notifiers and read events on
+client instance ``A``, enable those events on instance ``B`` (note that these
+will also be received by A since events are enabled/disabled globally), and
+after no more events are desired, disable the previously enabled events via
+instance ``C``.
+
 
 Controller IOCTLs
 =================
@@ -45,9 +78,33 @@ The following IOCTLs are provided:
      - ``REQUEST``
      - Perform synchronous SAM request.
 
+   * - ``0xA5``
+     - ``2``
+     - ``W``
+     - ``NOTIF_REGISTER``
+     - Register event notifier.
 
-``REQUEST``
------------
+   * - ``0xA5``
+     - ``3``
+     - ``W``
+     - ``NOTIF_UNREGISTER``
+     - Unregister event notifier.
+
+   * - ``0xA5``
+     - ``4``
+     - ``W``
+     - ``EVENT_ENABLE``
+     - Enable event source.
+
+   * - ``0xA5``
+     - ``5``
+     - ``W``
+     - ``EVENT_DISABLE``
+     - Disable event source.
+
+
+``SSAM_CDEV_REQUEST``
+---------------------
 
 Defined as ``_IOWR(0xA5, 1, struct ssam_cdev_request)``.
 
@@ -82,6 +139,66 @@ submitted, and completed (i.e. handed back to user-space) successfully from
 inside the IOCTL, but the request ``status`` member may still be negative in
 case the actual execution of the request failed after it has been submitted.
 
-A full definition of the argument struct is provided below:
+A full definition of the argument struct is provided below.
+
+``SSAM_CDEV_NOTIF_REGISTER``
+----------------------------
+
+Defined as ``_IOW(0xA5, 2, struct ssam_cdev_notifier_desc)``.
+
+Register a notifier for the event target category specified in the given
+notifier description with the specified priority. Notifiers registration is
+required to receive events, but does not enable events themselves. After a
+notifier for a specific target category has been registered, all events of that
+category will be forwarded to the userspace client and can then be read from
+the device file instance. Note that events may have to be enabled, e.g. via the
+``SSAM_CDEV_EVENT_ENABLE`` IOCTL, before the EC will send them.
+
+Only one notifier can be registered per target category and client instance. If
+a notifier has already been registered, this IOCTL will fail with ``-EEXIST``.
+
+Notifiers will automatically be removed when the device file instance is
+closed.
+
+``SSAM_CDEV_NOTIF_UNREGISTER``
+------------------------------
+
+Defined as ``_IOW(0xA5, 3, struct ssam_cdev_notifier_desc)``.
+
+Unregisters the notifier associated with the specified target category. The
+priority field will be ignored by this IOCTL. If no notifier has been
+registered for this client instance and the given category, this IOCTL will
+fail with ``-ENOENT``.
+
+``SSAM_CDEV_EVENT_ENABLE``
+--------------------------
+
+Defined as ``_IOW(0xA5, 4, struct ssam_cdev_event_desc)``.
+
+Enable the event associated with the given event descriptor.
+
+Note that this call will not register a notifier itself, it will only enable
+events on the controller. If you want to receive events by reading from the
+device file, you will need to register the corresponding notifier(s) on that
+instance.
+
+Events are not automatically disabled when the device file is closed. This must
+be done manually, via a call to the ``SSAM_CDEV_EVENT_DISABLE`` IOCTL.
+
+``SSAM_CDEV_EVENT_DISABLE``
+---------------------------
+
+Defined as ``_IOW(0xA5, 5, struct ssam_cdev_event_desc)``.
+
+Disable the event associated with the given event descriptor.
+
+Note that this will not unregister any notifiers. Events may still be received
+and forwarded to user-space after this call. The only safe way of stopping
+events from being received is unregistering all previously registered
+notifiers.
+
+
+Structures and Enums
+====================
 
 .. kernel-doc:: include/uapi/linux/surface_aggregator/cdev.h
-- 
2.31.1

