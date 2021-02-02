Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D430BE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBBM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:29:11 -0500
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:45626 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBBM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:29:00 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id 032F7540228;
        Tue,  2 Feb 2021 20:27:55 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/tegra: remove unneeded variable: "ret"
Date:   Tue,  2 Feb 2021 04:27:48 -0800
Message-Id: <20210202122748.15597-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0gfGBgdQhpCH0pIVkpNSklJTUNDTE1JSUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46ITo4Pj8KHzYIMioDLhAt
        PAsKCz1VSlVKTUpJSU1DQ0xNTkxMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSkJPQjcG
X-HM-Tid: 0a7762b6b183d995kuws032f7540228
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded variable: "ret".

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/tegra/dpaux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 105fb9cdbb3b..b8abd55f3ef8 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -279,7 +279,6 @@ static void tegra_dpaux_hotplug(struct work_struct *work)
 static irqreturn_t tegra_dpaux_irq(int irq, void *data)
 {
 	struct tegra_dpaux *dpaux = data;
-	irqreturn_t ret = IRQ_HANDLED;
 	u32 value;
 
 	/* clear interrupts */
@@ -296,7 +295,7 @@ static irqreturn_t tegra_dpaux_irq(int irq, void *data)
 	if (value & DPAUX_INTR_AUX_DONE)
 		complete(&dpaux->complete);
 
-	return ret;
+	return IRQ_HANDLED;
 }
 
 enum tegra_dpaux_functions {
-- 
2.29.0

