Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F69398F19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhFBPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhFBPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB5D6140F;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=XS/Sc2cZEorvPLj27u0uwf2k0Xuh1Wz+4wZYKQCVHcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA6np1zxE8GPjmoBCfHpG7DExsIW/br/CNw2tOIOTcVSW1T7oI8GbLy3kFjnu+7oq
         LysPS+ANLFM/MaSJfr5hmfFTfB8B0DxgBjW9gXQrRhiXgc7bsQF0Yh9XsaUbLYnm6q
         L0ro4reSdpy1aXbcAXBonwn7o90Zm9RqLQF3FE+RpCDxBv+QKU0Ced8YiNsBLs4KnR
         nCsOqo25oIudM6kTp71rsLtCjUKPYLNLFG6yd8kx1bxoeA8QAoJNSPtKSZJlIltPlU
         mWPNJ03ccvpTr9QNA+RLi8wJDf7qEnSdSemP+J+XuYE62uceQE22p3rXDnFRPn0SlI
         PYcvXB4Eml+/Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xc7-KZ; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] MAINTAINERS: update marvell,armada-3700-utmi-phy.yaml reference
Date:   Wed,  2 Jun 2021 17:43:15 +0200
Message-Id: <9342a88ed44726a1cc405470c834d746d4d0524c.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 6569d8386388 ("dt-bindings: phy: convert phy-mvebu-utmi to YAML schema")
renamed: Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
to: Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml.

Update its cross-reference accordingly.

Fixes: 6569d8386388 ("dt-bindings: phy: convert phy-mvebu-utmi to YAML schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b423b7246a3..644572ab4b2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10960,7 +10960,7 @@ MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
-F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+F:	Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 
-- 
2.31.1

