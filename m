Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE4367035
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhDUQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:32:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:13093 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235380AbhDUQc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:32:28 -0400
IronPort-SDR: mNJFd0JSxZmtuWFAs7gClWirP9YSOSkhaF1/9+jXH3uYvm3/0cDflSZRkEycf+nitPQaySAkSz
 a0XXk2HsxVSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216372849"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="216372849"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 09:31:55 -0700
IronPort-SDR: SW/MX5tiLWdk3DY1dXqevEm3+fN3N/PmJZJYDLYM2dgrIq3/vVq4KoWzMR5puCefRbWJvUzv3W
 KhJovEQSwa9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="385825523"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2021 09:31:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D02361FC; Wed, 21 Apr 2021 19:32:09 +0300 (EEST)
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
Subject: [PATCH v1 4/7] drm/ili9486: Avoid spamming logs if probe is deferred
Date:   Wed, 21 Apr 2021 19:31:54 +0300
Message-Id: <20210421163157.50949-4-andriy.shevchenko@linux.intel.com>
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
 drivers/gpu/drm/tiny/ili9486.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index d7ce40eb166a..8d8dd6347b09 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -206,16 +206,12 @@ static int ili9486_probe(struct spi_device *spi)
 	drm = &dbidev->drm;
 
 	dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(dbi->reset)) {
-		DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
-		return PTR_ERR(dbi->reset);
-	}
+	if (IS_ERR(dbi->reset))
+		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
 
 	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
-	if (IS_ERR(dc)) {
-		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
-		return PTR_ERR(dc);
-	}
+	if (IS_ERR(dc))
+		return dev_err_probe(dev, PTR_ERR(dc), "Failed to get GPIO 'dc'\n");
 
 	dbidev->backlight = devm_of_find_backlight(dev);
 	if (IS_ERR(dbidev->backlight))
-- 
2.30.2

