Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AB39810E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFBGXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:23:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53798 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhFBGXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:23:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D506201D24;
        Wed,  2 Jun 2021 08:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 6D506201D24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector4; t=1622614899;
        bh=I5ZG4i74Bbuci05fKSVfqx2SSFWVySduNNdHnTcrr28=;
        h=From:To:Subject:Date:From;
        b=mMZQXuL66kraGhH3fm3IZw897euPTILI6GWB26xETQbpQkkCyERli+lh8mjpEY2VY
         wACh9rO/praUxBUdYmB5LdTiGb0ZNzkqD76ii5akZrIf5TsEnSgwnNgnmqzEtNlr9X
         BcC2aWIn9LMzFmdqar/2/5Qbi/+0b/01SARXwKHiVL8N44kviq2IRhuF5wgou7R0Gd
         /oYCRe5/05bg6YjMq5TcSdGQkp71tY4paId956ZP+KNiCRUcTYFGdlpBMhO9ukyO89
         RcjDwlw+wTs8+stYhVCIdH7rltzISLff+qHrPAHzAn8C/s3AGnIOY0QlcH6FQRfS++
         /DfNkoTZXAEeQ==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA4C5200AF5;
        Wed,  2 Jun 2021 08:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com BA4C5200AF5
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B42C4031E;
        Wed,  2 Jun 2021 14:21:33 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl,spdif: Add compatible string for imx8ulp
Date:   Wed,  2 Jun 2021 14:04:09 +0800
Message-Id: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for imx8ulp, which supports spdif module

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 4454aca34d56..f226ec13167a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -25,6 +25,7 @@ properties:
       - fsl,imx8mq-spdif
       - fsl,imx8mm-spdif
       - fsl,imx8mn-spdif
+      - fsl,imx8ulp-spdif
 
   reg:
     maxItems: 1
-- 
2.27.0

