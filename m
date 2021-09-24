Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8038416E62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbhIXJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbhIXJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:00:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29298C061757;
        Fri, 24 Sep 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FBO3wvEQlAhNVXUCOTOLI4o07m4dLW9qRIn8f/7Mv6E=; b=YSbx19fbZqBE5cBu/8OeKuhpeS
        QCh1ACycQRrcShtRNUhIszDOK/2GZfATJqdjIvsp9MvTnd00t+wZiSYt8jTdx/72p8N56XRhhb5RD
        9l9rREZDnKpOpBMscv7f/VFqFRpkKL6vepnKhgtCD143CDeej7J5ecKuWsOEPNohzNNY=;
Received: from p200300ccff0ce8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2R-00024f-Cb; Fri, 24 Sep 2021 10:58:35 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2Q-00Ak4L-Uq; Fri, 24 Sep 2021 10:58:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, krzk@kernel.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: arm: fsl: Add E70K02 based ebook readers
Date:   Fri, 24 Sep 2021 10:58:29 +0200
Message-Id: <20210924085832.2560317-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924085832.2560317-1-andreas@kemnade.info>
References: <20210924085832.2560317-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kobo Libra H2O and Tolino Vision 5.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e..0c71dd336cab 100644
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

