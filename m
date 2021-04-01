Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB6351E58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhDASjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhDASQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F28706113B;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=ekIVTXtWg0qIVZoCnSn6WFNsby2PlIa7pgvfL4Nneeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXPSy9WdyMsLa4Am/wRozwOsV17YhCpkoI9SgpZdbpUbGjzStSmK1Ydr+0J4UHcjQ
         drZ775xX9i1vVlzhDBhnIgjnB8cPtSV1cwI5W5Am7LDwwpPFJsW4AIh1hE6MXJwAqq
         F9W6VLErd80E2jolClL5GaL/ZAkK5+x8LdlEIHgGyY22hofjw8Ca/uDe2oFNYJpvLn
         ePbcbFN6GPzZh7/oazI8zIjUOlc/k8X5zNQSIfr/P+zECEir9Cp4HJim49QmT7gaut
         WaBCbinNmPuDKmW/zDl3WpIVE2shSZpLQWmSg37TZmhcREKRIsQTW/3/lSi4IXeau7
         8c8EFznJVXlPw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2t-W9; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/32] MAINTAINERS: update marvell,armada-3700-utmi-phy.yaml reference
Date:   Thu,  1 Apr 2021 14:17:33 +0200
Message-Id: <ab0ef465a9c679b273761bcae3249ccb1fcbd707.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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
index b16830f54226..17bd389b7985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10774,7 +10774,7 @@ MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
-F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+F:	Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
 F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
 F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
 
-- 
2.30.2

