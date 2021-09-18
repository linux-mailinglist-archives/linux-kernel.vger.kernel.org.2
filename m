Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B218C41072C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhIRO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbhIRO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:57:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C76EC06175F;
        Sat, 18 Sep 2021 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sY5Chu7KvzBtPuZi7MF1vbiiSkqIye6uR5G7w2b+md4=; b=XypnSMmcP6iQrKEGG97fvCAlRH
        yHXssxVHxCGUiBCsKfe2RCLb8gWRAZMaU/OYFeFaoNDeIoHyQBezvvngJL7Th61L6KwmLzLltZI/w
        HPph5RvMrJ6AfnWQILbyWqaRRrxinLAcK79ri9a19xHpZ3bGSxHMblZ/6xnCGBGy/BPk=;
Received: from p200300ccff3476001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff34:7600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mRb8s-0003mQ-MT; Sat, 18 Sep 2021 16:16:34 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mRb8s-008zMh-7a; Sat, 18 Sep 2021 16:16:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, krzk@kernel.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/4] dt-bindings: arm: fsl: Add E70K02 based ebook readers
Date:   Sat, 18 Sep 2021 16:16:24 +0200
Message-Id: <20210918141627.2142457-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210918141627.2142457-1-andreas@kemnade.info>
References: <20210918141627.2142457-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kobo Libra H2O and Tolino Vision 5.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e..90b7ae3c5117 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -494,6 +494,7 @@ properties:
               - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
               - kobo,tolino-shine2hd
               - kobo,tolino-shine3
+              - kobo,tolino-vision5
               - revotics,imx6sl-warp      # Revotics WaRP Board
           - const: fsl,imx6sl
 
@@ -502,6 +503,7 @@ properties:
           - enum:
               - fsl,imx6sll-evk
               - kobo,clarahd
+              - kobo,librah2o
           - const: fsl,imx6sll
 
       - description: i.MX6SX based Boards
-- 
2.30.2

