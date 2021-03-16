Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6333CB67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhCPC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:28:10 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51201 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhCPC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:27:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4E19E5809A0;
        Mon, 15 Mar 2021 22:27:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 22:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=2fR5y46qj1Pumlm7W0usPS7NWH
        t0hwprR9UyPY36VBQ=; b=og3396EGfG2YLfHnwFLQHdTKgxArLBHYvpNeKkEGBb
        Mnjvh+eHV7jnJ+H6c6d6TNH3lsiFF5mJH6e0IBkotbjxy/cpJWM3lOIVD+Y1oaxO
        ndHSLqrBdcH1t1YlGGMiPmyRvJHA0vbi6jQ0OGZBmgXQ7TSIvrjRRLJfTYShzy21
        2wGAe8nsIEGMVUEe2Xlc/twYz69OrDXno+grALMboLdOi5yULDWcBkW3T0fj1MjW
        zWDKz0Xuc60qDP+utZ7HUHUqWwTocLMXYt5OQJlSNODZetYe4LYvEGK6AZIuAdxb
        Z9jnYkwC53NED06YZhXQLsU1EJ6SSuRGAlDY1WetivDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2fR5y46qj1Pumlm7W
        0usPS7NWHt0hwprR9UyPY36VBQ=; b=Tbcam2L2YrPOpvybhX4yHiibPFuWAnv4q
        w/CEF9/E8UgYtuEgStkx7/6zFU1f9wjYaPh7Tdg7KwSn81e+3g92TMmfeoHJHNoU
        6WxLCAXj5ZNAoQaledrRiPBq8cd6XRe4XTOGcRdSvpq6TuceoPG4SlZUCtBykP8e
        OtD/cFXnHhQqrysEKwSJ/dU4+x0DlDRLhkenW0wU5KcRbJirp0xEhe4PGhUx14LJ
        YO/DOgZc/NlwvCfIZk8rD9hT8fpPwDhUg36jADSYUGG2gTETu08+XUJ9MI6Ek0xg
        teoi9l7pgbpnHcPe4/M7Urv4aN7KZUcvhCljpNiSshUgjt/lrGT/A==
X-ME-Sender: <xms:oRdQYC3EBJv7zFelxLqet0G9V0C6Qc5aAEHPWDLTJzV6UqSR8azMbA>
    <xme:oRdQYFERunALGA1fZChQSMUAMFBzxZZ0tISaMnT4EUVOht4cY67wrkAjXtLgb8HR6
    hsK8-cM94MeJMDy7KY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucfkphepieeirdduudeh
    rddukeelrddujeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:oRdQYK591FaVjl2kMTRTXBbF_kI3wLPXrUaVMpd2QJbZBmq9YR5k5Q>
    <xmx:oRdQYD1Dr-a8w7A6crDaVJYUM-cgs8PuUGf6GPIxx2e9H2MGjSlfiA>
    <xmx:oRdQYFEziM1hJt1VOyGRbKT5oAErLkoSzNdby09YHzk0_ZLnGuPkAQ>
    <xmx:ohdQYECtv2UALK5ChIobUwbqbIMCbKK8ar7F1bN4RhJCIy2NbXTdnw>
Received: from ThinkpadX1Yoga3.localdomain (unknown [66.115.189.177])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF3CD24006A;
        Mon, 15 Mar 2021 22:27:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 1/3] dt-bindings: Add vendor prefix for reMarkable
Date:   Mon, 15 Mar 2021 22:27:38 -0400
Message-Id: <20210316022740.132-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reMarkable AS produces eInk tablets

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..a8e1e8d2ef20 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -932,6 +932,8 @@ patternProperties:
     description: Unisoc Communications, Inc.
   "^realtek,.*":
     description: Realtek Semiconductor Corp.
+  "^remarkable,.*":
+    description: reMarkable AS
   "^renesas,.*":
     description: Renesas Electronics Corporation
   "^rex,.*":
-- 
2.30.1

