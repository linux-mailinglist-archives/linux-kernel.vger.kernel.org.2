Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024EE33D02B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhCPIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:54:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33636 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235797AbhCPIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:54:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4938B200328;
        Tue, 16 Mar 2021 09:54:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0B1A203E04;
        Tue, 16 Mar 2021 09:54:03 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F944402C1;
        Tue, 16 Mar 2021 09:53:59 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl_spdif: Add compatible string for new platforms
Date:   Tue, 16 Mar 2021 16:40:53 +0800
Message-Id: <1615884053-4264-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for new added platforms which support spdif module.
They are i.MX8QXP, i.MX8MM, i.MX8MN, i.MX8MQ.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 50449b6d1048..4454aca34d56 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -21,6 +21,10 @@ properties:
       - fsl,vf610-spdif
       - fsl,imx6sx-spdif
       - fsl,imx8qm-spdif
+      - fsl,imx8qxp-spdif
+      - fsl,imx8mq-spdif
+      - fsl,imx8mm-spdif
+      - fsl,imx8mn-spdif
 
   reg:
     maxItems: 1
-- 
2.27.0

