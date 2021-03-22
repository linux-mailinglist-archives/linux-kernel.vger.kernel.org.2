Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A533451D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCVVeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:34:22 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:36980 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhCVVdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:33:50 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id OSB9lKwj3tpGHOSBIlyOij; Mon, 22 Mar 2021 22:33:48 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1616448828; bh=RyCES0euy+yDAsc27Yqqlm8eevv6OL5wk0CPEXsf8Ok=;
        h=From;
        b=i0e9HIL6MQaG5j2X+GTT6DhWw4sOvKrmxStXfRKCM0lPGYbtCu2YCALMWQiOTuPzn
         lZkwmaz7DEz/17deltFUzL8Z1AyEQ5WhwKv0+0IE1Ib6r1KzrE+cNqrYaUBCQfL7CN
         e6ud0VbPxaQUIo/N2aukhmpR/UUmbH4WLS2F5XZQ6NWeP+nF9lrRxOnr2W7jJDRtWD
         wwpNEoVIgIxJg3yEuI6AWQ3hH1w7bMr9/zJHRiNT1coLagIHNZ/nzrEwP7VUsg33Ei
         ffFGc/++OToKEG5Kt2iMyPrfgSDTJ/uxBNpMlykNmPHlO7wplW1btYl1yl63QWg+Xa
         ovmPwwQ2QLLCQ==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60590d3c cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=OpddqcCamwGiTB6aXU0A:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/tilcdc: fix LCD pixel clock setting
Date:   Mon, 22 Mar 2021 22:33:36 +0100
Message-Id: <20210322213337.26667-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322213337.26667-1-dariobin@libero.it>
References: <20210322213337.26667-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfAC5Flr2DXI/3y8tjQP1ykuGXiiK8y/WSYfF+QIHBOHrIa43VFbF5O6hDlBQyvABFoD7VhsSNvbvNGr/O5X3Qb3axwzL/ACPN/uzXJ+Q1mLUjXDYxvwB
 l3pcRdEgaEhtLL9usYBgZq1mY0p3SqfCrR2uXZHtOwfff6y/ZMgyixqI3rrHwp6aL6//csBTLrqzkRX8klLcjyNgs+FHexwfWzkKLBroY4yo3hMbFtToOUUr
 16TzWcpACvsG+IYd8VCNOU6oCvgN9ALx3QWdYzFyYJSNQuWYU4G7RKjVgwHsa7Lki7JiBGBheqbwNfN0IcGArO0ZMwK+xRfEk671GHNvTU7KDVKVLELixdiN
 0oRBd8BY5UdzAp8gKQtRhpW9ZJA0Aek3oklwNp7KeTclmX2o2AiARcDZ8H1YS8i3VDcyfJs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tilcdc_pclk_diff() compares the requested pixel clock rate to the
real one, so passing it clk_rate instead of clk_rate / clkdiv caused
it to fail even if the clk_rate was properly set. Adding the
real_pclk_rate variable makes the code more readable.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

(no changes since v2)

Changes in v2:
- Rename clk_div_rate to real_pclk_rate.
- Provide pixel clock rate to tilcdc_pclk_diff().

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index aeec5786617d..ac6228cb04d9 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -203,7 +203,7 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
-	unsigned long clk_rate, real_rate, pclk_rate;
+	unsigned long clk_rate, real_rate, real_pclk_rate, pclk_rate;
 	unsigned int clkdiv;
 	int ret;
 
@@ -214,7 +214,8 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
 
 	ret = clk_set_rate(priv->clk, pclk_rate * clkdiv);
 	clk_rate = clk_get_rate(priv->clk);
-	if (ret < 0 || tilcdc_pclk_diff(pclk_rate, clk_rate) > 5) {
+	real_pclk_rate = clk_rate / clkdiv;
+	if (ret < 0 || tilcdc_pclk_diff(pclk_rate, real_pclk_rate) > 5) {
 		/*
 		 * If we fail to set the clock rate (some architectures don't
 		 * use the common clock framework yet and may not implement
-- 
2.17.1

