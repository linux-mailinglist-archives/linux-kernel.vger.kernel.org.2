Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5545A653
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhKWPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbhKWPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:16:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4EC061574;
        Tue, 23 Nov 2021 07:13:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 89E541F45695
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637680408; bh=VVBqHtz/SX7tIs2Neheb2U9p13s/n8HuyXNh6zJ0fEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A05kap74twVK5R6xNZ/8D+RtvvRBpLN8ZCwaZKkUAe3wV2vUGxlB+yjcaA4ETTQ3g
         6BUszhkZ9fSBOC7NmK8ParEyme5Rnyp2xmguIlB50hW8vJiwsSssQ0Ait19hi4ciU3
         JzmAG2AdkwtdyC8Zd/82szGk+dhsFE2dqogd551vlCoemoRGhBc5ckz1TZE7B3QfRW
         PhUrH9T7yXyjeuFRbPA8J2SWWQaBIeNSjyh7YkDCpVqLd6M75Ns7JdHCFZkItmhDRB
         qmfII/vPOMDyVoe5/5lhflwjQbup/q0Yo1HJwtlOdMTDPq34McnKC29yxRX2exdov7
         Rbd9UcgzXxK3g==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com
Subject: [PATCH v2 2/5] dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
Date:   Tue, 23 Nov 2021 12:12:49 -0300
Message-Id: <20211123151252.143631-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BSH SystemMaster (SMM) S2 board family, which consists
of: iMX8MN SMM S2 and iMX8MN SMM S2 PRO boards.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..d49c4b786f09 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -758,6 +758,8 @@ properties:
         items:
           - enum:
               - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
+              - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
+              - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
               - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
-- 
2.30.2

