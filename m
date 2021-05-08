Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FB377075
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEHHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:42:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA23C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 00:41:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h7so6402132plt.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXDnjyKB879WWu5HcCyEpj+JYchBF3522PxjAdZvJYs=;
        b=F/4YnN8yxt//sE9DlamHWHTc96qn/GPkfoyWB1/Py1GREbXZdWUqoPnB5jaMbga8/D
         7gSPWOn9cIqCRsNZw+w8TygZdrAQS5F8Themq5i0WUd9ct2Jc7se2LLPbMlrzkFDTftF
         WkXjhkvO2D/Q8yxMpaCpcqqni61GUERQomCLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXDnjyKB879WWu5HcCyEpj+JYchBF3522PxjAdZvJYs=;
        b=mxiPlNV/oqH+HcP4m3JPX0cKqETL0l5QMmuKGzPJWSbvt7R29aUETUtWLnISlVw7fM
         1pgnVxD/NkaAwN2ApNih/1xbZUsPOER9yfUJGrR3nZ5ihfQHMlDPfRpWQc63P59c7yNK
         oSqVwk7VXphAzvA/fJTsPa4e5iMZh4bWVV71ctOTLo2BL5+7/1AX/aQrrLsMAyj0Ivmi
         OJA13y6H8ecBDTSe2GQ4Lco2Xj2kZRE9Kz3Vs4YmGANCkneXazgRS1w9UFVfEKN6pxfb
         gEwj5+a/p5rstLDut0dEOV82Y99aftOcaw4HuaMGJLxfxLsalKNFe2jJfyBmjBmX6i5/
         Ykow==
X-Gm-Message-State: AOAM5308t0MPHRiDWOxl2ThyBoQH6VuL3EhlDZTUX4tzNcslBFp1ckot
        jq1Rq4X6GVi0MGB1VZJEIJzXLg==
X-Google-Smtp-Source: ABdhPJwDAIUQ5Bm3lnAj91OHtapwoTD9/ukTdlyybiBqXZum5GZVgyBBhkyHT9Pyg7QZlOAx5whsiw==
X-Received: by 2002:a17:90b:1055:: with SMTP id gq21mr27086958pjb.91.1620459679691;
        Sat, 08 May 2021 00:41:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ab8b:4a3d:46ab:361c])
        by smtp.gmail.com with ESMTPSA id w1sm6769687pgh.26.2021.05.08.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 00:41:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] component: Move host device to end of device lists on binding
Date:   Sat,  8 May 2021 00:41:18 -0700
Message-Id: <20210508074118.1621729-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device lists are poorly ordered when the component device code is
used. This is because component_master_add_with_match() returns 0
regardless of component devices calling component_add() first. It can
really only fail if an allocation fails, in which case everything is
going bad and we're out of memory. The host device (called master_dev in
the code), can succeed at probe and be put on the device lists before
any of the component devices are probed and put on the lists.

Within the component device framework this usually isn't that bad
because the real driver work is done at bind time via
component{,master}_ops::bind(). It becomes a problem when the driver
core, or host driver, wants to operate on the component device outside
of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
driver core doesn't understand the relationship between the host device
and the component devices and could possibly try to operate on component
devices when they're already removed from the system or shut down.

Normally, device links or probe defer would reorder the lists and put
devices that depend on other devices in the lists at the correct
location, but with component devices this doesn't happen because this
information isn't expressed anywhere. Drivers simply succeed at
registering their component or host with the component framework and
wait for their bind() callback to be called once the other components
are ready. We could make various device links between 'master_dev' and
'component->dev' but it's not necessary. Let's simply move the hosting
device to the end of the device lists when the component device fully
binds. This way we know that all components are present and have probed
properly and now the host device has really probed so it's safe to
assume the host driver ops can operate on any component device.

This fixes the msm display driver shutdown path when the DSI controller
is connected to a DSI bridge that is controlled via i2c. In this case,
the msm display driver wants to tear down the display pipeline on
shutdown at msm_pdev_shutdown() by calling drm_atomic_helper_shutdown(),
and it can't do that unless the whole display chain is still probed and
active in the system. When a display bridge is on i2c, the i2c device
for the bridge will be created whenever the i2c controller probes, which
could be before or after the msm display driver probes. If the i2c
controller probes after the display driver, then the i2c controller will
be shutdown before the display controller during system wide shutdown
and thus i2c transactions will stop working before the display pipeline
is shut down. This means we'll have the display bridge trying to access
an i2c bus that's shut down because drm_atomic_helper_shutdown() is
trying to disable the bridge after the bridge is off.

Moving the host device to the end of the lists at bind time moves the
drm_atomic_helper_shutdown() call before the i2c bus is shutdown.
This fixes the immediate problem, but we could improve it a bit by
modeling device links from the component devices to the host device
indicating that they supply something, although it is slightly different
because the consumer doesn't need the suppliers to probe to succeed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rob Clark <robdclark@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index dcfbe7251dc4..de645420bae2 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 
+#include "base.h"
+
 /**
  * DOC: overview
  *
@@ -657,6 +659,14 @@ int component_bind_all(struct device *master_dev, void *data)
 				c = master->match->compare[i - 1].component;
 				component_unbind(c, master, data);
 			}
+	} else {
+		/*
+		 * Move to the tail of the list so that master_dev driver ops
+		 * like 'shutdown' or 'remove' are called before any of the
+		 * dependencies that the components have are shutdown or
+		 * removed.
+		 */
+		device_pm_move_to_tail(master_dev);
 	}
 
 	return ret;

base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
https://chromeos.dev

