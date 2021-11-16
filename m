Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87AD452F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhKPKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234126AbhKPKmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:42:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96FDB63219;
        Tue, 16 Nov 2021 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637059198;
        bh=KXVulQyk9zj7rAfwDnBQuE3jExJ9gnFzn/aqFe3RSzU=;
        h=From:To:Cc:Subject:Date:From;
        b=BpsHgfdJK0JErilME0uqhNp7mPH2m8XWz7IpHoWAQ9TzUPprWQbiPnQlihisP7axc
         V05AW2yBmfWGpIV554iUB0GbGFjIDpaPywnKIOHXB+JUMHkC/LwnnJyVJ1VCoNPJHL
         09mgPmyC+JjTjuc5N7KA68oA94bQ/IppDLP+OZ3aLVuSBYgfjyvSOX/g6XGAGSnIoL
         itl8d1Cv4FeVFV/Uer6e0nngMi1sb+memK0uPGs9WLt0aeXzN1gTKR6a55O1+6f7+W
         KWbFxkuwZpWlDNC8TgTpGTO7HUz1iqzABFI4a9IH6vpsYjIiShcBKNdfJLwfZ6qclq
         Ome9uuHYVJ/lw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Konstantin Porotchkin <kostap@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] phy: mvebu-cp110-utmi: Fix kernel-doc warns
Date:   Tue, 16 Nov 2021 16:09:46 +0530
Message-Id: <20211116103951.34482-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the format and add description for ops to fix the below warnings:

drivers/phy/marvell/phy-mvebu-cp110-utmi.c:94: warning: Function parameter or member 'syscon' not described in 'mvebu_cp110_utmi'
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:94: warning: Function parameter or member 'ops' not described in 'mvebu_cp110_utmi'

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 08d178a4dc13..aa27c7994610 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -82,9 +82,9 @@
  * struct mvebu_cp110_utmi - PHY driver data
  *
  * @regs: PHY registers
- * @syscom: Regmap with system controller registers
+ * @syscon: Regmap with system controller registers
  * @dev: device driver handle
- * @caps: PHY capabilities
+ * @ops: phy ops
  */
 struct mvebu_cp110_utmi {
 	void __iomem *regs;
-- 
2.31.1

