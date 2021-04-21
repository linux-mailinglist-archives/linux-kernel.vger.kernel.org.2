Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF536644A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhDUETM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:19:12 -0400
Received: from mout02.posteo.de ([185.67.36.66]:52775 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233956AbhDUETK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:19:10 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B02542400E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618978713; bh=afYnVbBUBCcbBpGUC8kPMPOj6LgnxiZUKhc/Q49cKPA=;
        h=From:To:Cc:Subject:Date:From;
        b=RhOjmhVd9CFCIYRlU2U3toJscIeh6IJ+yOnbKB3wrlY7XB1aR78mnpVkAxfVlOyFL
         Xb1ATl8IPpuLO6uH+hnj1fFRJxqHnaLZwNIEx0v7NcxwyBg0Z0QGg+hGd+sFlhloxi
         sbFlxTK/ltyXRnAxQn1Nt79d64RLPMa5MDOxdl8JAHhIH2J0lrLG2y8kA9QDjwdqlx
         PIk+/9LSEtfrkBjyXRMgFwwxK7cZp7BN4XkXMbYzwBiyyYoo1IIOmjbPNO/Q9tuv4v
         EJnzUyNmGRlzlEQeSqu05YMklrd0d2ou9SxuVgXsDDNjDFmga8icWulwtwLwZF+weF
         OKUJRbWL4i6FQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FQ6k00wqgz6tmS;
        Wed, 21 Apr 2021 06:18:32 +0200 (CEST)
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] phy: phy-core-mipi-dphy.c: Correct reference version
Date:   Wed, 21 Apr 2021 04:17:41 +0000
Message-Id: <20210421041740.8451-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rest of the code refers to version 1.2 of the MIPI D-PHY
specification. But this comment refers to 2.1, while a sub comment of
the function refers to 1.2 again. Replace 2.1 with 1.2.

Signed-off-by: Sebastian Fricke <sebastian.fricke@posteo.net>
---
 drivers/phy/phy-core-mipi-dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 14e0551cd319..79e754c4a8b4 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -17,7 +17,7 @@
 /*
  * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
  * from the valid ranges specified in Section 6.9, Table 14, Page 41
- * of the D-PHY specification (v2.1).
+ * of the D-PHY specification (v1.2).
  */
 int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 				     unsigned int bpp,
-- 
2.25.1

