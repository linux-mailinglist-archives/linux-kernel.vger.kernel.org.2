Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D15367037
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhDUQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:32:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:11449 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236939AbhDUQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:32:31 -0400
IronPort-SDR: x5GusIOeLSyuBJI9uxoeS6Kz0Mxu08MAkCGqu3kGPYBP2ktdkCzhIpBuSCRIOiVKr62ePrTTb4
 OZyZaxnzV5oA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195755676"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="195755676"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 09:31:58 -0700
IronPort-SDR: jpgftBOnqMnzl6J2OJMKjJRdDuwaPEF4yuBKoJ/NElHat8bwOm3Ld3YSQlnVt2EYbM46teIylK
 x3iPDehF0gDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="384500741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2021 09:31:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EFAE42EF; Wed, 21 Apr 2021 19:32:09 +0300 (EEST)
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
Subject: [PATCH v1 7/7] drm/hx8357d: Avoid spamming logs if probe is deferred
Date:   Wed, 21 Apr 2021 19:31:57 +0300
Message-Id: <20210421163157.50949-7-andriy.shevchenko@linux.intel.com>
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
 drivers/gpu/drm/tiny/hx8357d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index c6525cd02bc2..17b2a3cb4918 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -234,10 +234,8 @@ static int hx8357d_probe(struct spi_device *spi)
 	drm = &dbidev->drm;
 
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

