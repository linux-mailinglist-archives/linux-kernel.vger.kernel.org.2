Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0534FAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhCaH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:59:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48422 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhCaH6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:58:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 905C91A01AD;
        Wed, 31 Mar 2021 09:58:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A3751A1543;
        Wed, 31 Mar 2021 09:58:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B4D3640319;
        Wed, 31 Mar 2021 09:58:42 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: dt-bindings: ak5558: Add compatible string for ak5552
Date:   Wed, 31 Mar 2021 15:44:46 +0800
Message-Id: <1617176686-25528-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617176686-25528-1-git-send-email-shengjiu.wang@nxp.com>
References: <1617176686-25528-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "asahi-kasei,ak5552" for ak5552

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
index 36934098170c..e28708db6686 100644
--- a/Documentation/devicetree/bindings/sound/ak5558.txt
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -4,7 +4,7 @@ This device supports I2C mode only.
 
 Required properties:
 
-- compatible : "asahi-kasei,ak5558"
+- compatible : "asahi-kasei,ak5558" or "asahi-kasei,ak5552".
 - reg : The I2C address of the device.
 
 Optional properties:
-- 
2.27.0

