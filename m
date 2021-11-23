Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7685945A658
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhKWPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhKWPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:16:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5BC06173E;
        Tue, 23 Nov 2021 07:13:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 990AE1F45693
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637680419; bh=3+R9t8LHbtis7XaGBxnamhnSmR8DMiulXO8X+uKpIJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGoDxWUT15kEpQK8OIVDxjtiqPqUBj0U6hMiZS1PsUgeRTttCtdpfK3jhvIQcJHje
         CO/9G1IElsAgP4ofD9YW+Iq+Jczpm5rUyDWXXXz27Wwt968Hfr1whKpo205ATBiWhe
         ihQ+acoQkidV8f9rdJdY4m8a4RyXfHH5x3QnR7/MJGOpv/Et5jS7ss4ci9NQKc1TrL
         k09X+qOtIyf6IMAHZGIkc9+mAzu9vbo2ZyjcrZUMn9r09HjF0we0ZRDJOUQio9oJaV
         tMX7atQC+0bbP/eAVonK+77EHH17ttZZ/Iz2avBmCXlEdsOYIBWTFjMoRfYYeWEy+4
         ZnJFiMBo7BBoQ==
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
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board
Date:   Tue, 23 Nov 2021 12:12:51 -0300
Message-Id: <20211123151252.143631-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BSH SystemMaster (SMM) M2 IMX6ULZ board.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d49c4b786f09..461b9888812e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -632,6 +632,7 @@ properties:
       - description: i.MX6ULZ based Boards
         items:
           - enum:
+              - bsh,imx6ulz-bsh-smm-m2    # i.MX6 ULZ BSH SystemMaster
               - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
-- 
2.30.2

