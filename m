Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1032F6C5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCEXpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:20 -0500
Received: from smtpcmd02106.aruba.it ([62.149.158.106]:55112 "EHLO
        smtpcmd15181.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229781AbhCEXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:43 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7eloTKx; Sat, 06 Mar 2021 00:44:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987883; bh=L+FMs4qBP5A4tZWhhtEAJGU6zjMIuOkcgabsTE+LYnU=;
        h=From:To:Subject:Date:MIME-Version;
        b=NyM8LYXDOkq4fLXHTvCjK1Nb+gqi4zbFJffjvUAgd+f/eRtPe+ItTfmnELp2vM8RK
         a+gtmwFbyoeUaakgq5NtVPXmlwLKtetggevpu67AutcZUtcK2h33lQ7OcMueMfLJt3
         pz7Rkjf75uRM4fwHT31gb7ZBi5umpqB9aVlcJv9vd90DLmvTkzcG8DRHQHJdC8XKiQ
         h4o4C0rxn+YkEiFTnKvml8VKPyqMwQeMZJ7kiwy8ywTAsA0nO4u2x0Xz600w3VY5k6
         pMRUOCcbcKQlbk7ED4RvH8bOzIM+K2aK4hZJZGmUpdeitwSf57Y9Nde8pZMEf6b/U8
         Mx6mDqKhVjMVA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 8/9] drm/panel: simple: add Jenson JT60249-01
Date:   Sat,  6 Mar 2021 00:44:25 +0100
Message-Id: <20210305234427.572114-9-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJJICPsYTIQqANHNAY9JioPU95qdZp7ybyeIBAmJIwL39BzuorocT3L2d748Dycpgo4ZvSTyxlkVU59j9Ba+GDLcT5p2is6Isq1NvY0Or0eSpQk6By6z
 bIIEWHcoV0wM/YJPNLs8nsh/MBAVH9OYQwBUnNAaS6/BXEVFUiiL85mtcYNqpvNQsQHUbdcqaCdzAFG63uCK56aZ6XtvZJrQUEPZPbijFmApBwSM1ReLAc6y
 3AR7nkgm4bU4fCCo1re79tXxvpcwt0pbIskoyZgOW9TwPzvN7WWyXCCw7moY0P/7h3lmrTdX5lRfnRCd6G+wpJMVQtRskJZtPiiGnWHTmLogcp9No7bW0mrK
 5aSV5YUy380MGnXd6bldc9RWGE/8Qb7JqegcF11RvqigMZ1yijoISIPJegMr2m4udG4IyIjSE/C6yw1gwMUpF20pZxIHIsgba+ASvxmSJj5Njr8HqYTibNVm
 QU2a0CTEYyoVsP4SmHW1wFkr60XdlwT8GfvFwxv5p8ytN24QcWWXGpU5waSuRDHCK++xb/9b8hu6WNvtIHd6CkvwFH+WsgEknzBTmt5AsA26x3EjGJ5UuTRm
 H8b9EiIKo4bwXG/S0OHoaAUfIpM3OM9zf5qeuWzR/qwWiZeQ4SIbszTFqqRbf/R4X1cW+/tRNGMvZKPBEEQ6+6cigGyNMMpZgn+BEEUp9HYjASjM+2587s1q
 YtUKEI/H0rLgG+Qy+fpvQWjCdG1t1j9rpWTk6WRB3mv9qh8ENGIxyg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

This patch adds support for Jenson JT60249-01 800x480 5" panel to DRM
simple panel driver.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f96f820a890b..1966ace764c3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2580,6 +2580,30 @@ static const struct panel_desc jenson_jt60248_01 = {
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode jenson_jt60249_01_mode = {
+	.clock = 25000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 8,
+	.hsync_end = 800 + 8 + 4,
+	.htotal = 800 + 8 + 4 + 8,
+	.vdisplay = 480,
+	.vsync_start = 480 + 8,
+	.vsync_end = 480 + 8 + 4,
+	.vtotal = 480 + 8 + 4 + 8,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc jenson_jt60249_01 = {
+	.modes = &jenson_jt60249_01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+};
+
 static const struct drm_display_mode kingdisplay_kd116n21_30nv_a010_mode = {
 	.clock = 81000,
 	.hdisplay = 1366,
@@ -4355,6 +4379,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "jenson,jt60248-01",
 		.data = &jenson_jt60248_01,
+	}, {
+		.compatible = "jenson,jt60249-01",
+		.data = &jenson_jt60249_01,
 	}, {
 		.compatible = "kingdisplay,kd116n21-30nv-a010",
 		.data = &kingdisplay_kd116n21_30nv_a010,
-- 
2.25.1

