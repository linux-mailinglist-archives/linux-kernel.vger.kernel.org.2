Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571336703F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbhDUQdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:33:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:31485 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239068AbhDUQdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:33:14 -0400
IronPort-SDR: UnvUWzgJpU5C2kT4SDHj5vqafQE6xBHt6p7yOUilETCWylPHpZQX9DTODw9XdeKUexPcHISBfI
 XKZENsvXNGfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183217489"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="183217489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 09:31:54 -0700
IronPort-SDR: /KdGZlOfqIx0fIq/OJyt4dPj5qBRzQbE521tpZrgJ9jd9wamzmqs056dGqJvaC83NbitTUXziA
 q3+RaAsr1KTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="445985932"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2021 09:31:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BC8DE13C; Wed, 21 Apr 2021 19:32:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Lechner <david@lechnology.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] drm/st7586: Avoid spamming logs if probe is deferred
Date:   Wed, 21 Apr 2021 19:31:52 +0300
Message-Id: <20210421163157.50949-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421163157.50949-1-andriy.shevchenko@linux.intel.com>
References: <20210421163157.50949-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO request can fail and probe may be deferred. Thus,
the error message may be printed again and again. Avoid
this by replacing DRM_DEV_ERROR() by dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/tiny/st7586.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
index ff5cf60f4bd7..fdd823e6ed44 100644
--- a/drivers/gpu/drm/tiny/st7586.c
+++ b/drivers/gpu/drm/tiny/st7586.c
@@ -323,16 +323,12 @@ static int st7586_probe(struct spi_device *spi)
 	bufsize = (st7586_mode.vdisplay + 2) / 3 * st7586_mode.hdisplay;
 
 	dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(dbi->reset)) {
-		DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
-		return PTR_ERR(dbi->reset);
-	}
+	if (IS_ERR(dbi->reset))
+		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
 
 	a0 = devm_gpiod_get(dev, "a0", GPIOD_OUT_LOW);
-	if (IS_ERR(a0)) {
-		DRM_DEV_ERROR(dev, "Failed to get gpio 'a0'\n");
-		return PTR_ERR(a0);
-	}
+	if (IS_ERR(a0))
+		return dev_err_probe(dev, PTR_ERR(a0), "Failed to get GPIO 'a0'\n");
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-- 
2.30.2

