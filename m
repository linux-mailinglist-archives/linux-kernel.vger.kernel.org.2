Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E23761A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhEGIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:06:57 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:36784 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235165AbhEGIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:06:56 -0400
Received: from jax4mhob23.registeredsite.com (jax4mhob23.registeredsite.com [64.69.218.111])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 14780X9s030019
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:33 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob23.registeredsite.com (8.14.4/8.14.4) with ESMTP id 14780TUq171253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 7 May 2021 04:00:29 -0400
Received: (qmail 24075 invoked by uid 0); 7 May 2021 08:00:29 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 7 May 2021 08:00:29 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/3] dt-bindings: display: simple: Add YTS700TLBC-02-100C and G104AGE-L02
Date:   Fri,  7 May 2021 10:00:15 +0200
Message-Id: <20210507080017.2794-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds these panels to the dt bindings:
- Yes Optoelectronics YTS700TLBC-02-100C
- Innolux G104AGE-L02

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b3797ba2698b..d87d6ef496b9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -156,6 +156,8 @@ properties:
       - innolux,g070y2-l01
         # Innolux Corporation 10.1" G101ICE-L01 WXGA (1280x800) LVDS panel
       - innolux,g101ice-l01
+        # Innolux Corporation 7" G104AGE-L02 (800x600) LVDS panel
+      - innolux,g104age-l02
         # Innolux Corporation 12.1" WXGA (1280x800) TFT LCD panel
       - innolux,g121i1-l01
         # Innolux Corporation 12.1" G121X1-L03 XGA (1024x768) TFT LCD panel
@@ -293,6 +295,8 @@ properties:
       - winstar,wf35ltiacd
         # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel
       - yes-optoelectronics,ytc700tlag-05-201c
+        # Yes Optoelectronics YTS700TLBC-02-100C (1024x600) TFT LCD panel
+      - yes-optoelectronics,yts700tlbc-02-100c
 
   backlight: true
   enable-gpios: true
-- 
2.17.1

