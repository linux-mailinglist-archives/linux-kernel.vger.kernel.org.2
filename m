Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921339810C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFBGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:22:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39330 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhFBGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:22:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4AD61A35AA;
        Wed,  2 Jun 2021 08:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com A4AD61A35AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1622614822;
        bh=916qkDrbfLsKea6v3J9EiWiH16tJt1dJtsGTn8zGZMM=;
        h=From:To:Subject:Date:From;
        b=osPWG7HF4wbDUh6UkQpDFSqdLTOzxNN0k9Ej83Unbhh9ktSyxgehINw8ZDR1nnAFG
         FMX+E5a7dNtNMrcV6EhBg7K7XrZkfisvwH0lg2/nKqJhwVT+B0bySseDmq8dFDU/W6
         3+OrgsnwqhgjnmJbRiQ2mHQH9sSMgdFF3ZtKdQlTq9EMZbsxGUacHpEU3Ss/jiXyt/
         yAAb6A4GUGvk9Sv0YxDwBL8+eVU8uF9B28l+pczF8b5OOsyOnb/uY5quq9fStxvNf/
         IW1DTgnbXttRdNzN+9XcGnlvJDg7KOubIYqnPyLP5ODub+d+Mi+QmxNVbNt1BeNS0F
         8jyadsRh7WXFA==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDCA81A1E65;
        Wed,  2 Jun 2021 08:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com EDCA81A1E65
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AE51F4028B;
        Wed,  2 Jun 2021 14:20:16 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl-sai: Add compatible string for imx8mm/8mn/8mp/8ulp
Date:   Wed,  2 Jun 2021 14:02:50 +0800
Message-Id: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for imx8mm/8mn/8mp/8ulp, these platforms all
support SAI IP.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 0dc83cc4a236..c71c5861d787 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -9,8 +9,10 @@ Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
 			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai" or
-			  "fsl,imx8qm-sai".
+			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai",
+			  "fsl,imx8qm-sai", "fsl,imx8mm-sai",
+			  "fsl,imx8mn-sai", "fsl,imx8mp-sai", or
+			  "fsl,imx8ulp-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.27.0

