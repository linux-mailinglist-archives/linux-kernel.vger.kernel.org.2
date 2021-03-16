Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0F33D471
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhCPM46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:56:58 -0400
Received: from m12-14.163.com ([220.181.12.14]:36054 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhCPMzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=L4EhQ
        n+V7RMC+e9zULsyR5LaAYD6Z7Y5sVnlmmzcacw=; b=nu0SSb2s+rj5WsRoN6tkZ
        YpN6J2lIQyiOvPcuum5A5+USeYDr+yDwjHebjUuSIow9bj8Q2RZWR74b1+MjSBMd
        AuD34zQU84INscOTI3lBKDc+qeno8kvY1WvAGO2MYZiEpLB5YvcD4oIxmVsB3ndf
        OWp+Xv42KMnJ/63+OlhTYE=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAnP0ukqlBgYhfcpg--.27432S2;
        Tue, 16 Mar 2021 20:55:02 +0800 (CST)
From:   angkery <angkery@163.com>
To:     kishon@ti.com, vkoul@kernel.org, yuehaibing@huawei.com,
        rikard.falkeborn@gmail.com, weiyongjun1@huawei.com, jsarha@ti.com
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] Revert "phy: ti: j721e-wiz: add missing of_node_put"
Date:   Tue, 16 Mar 2021 20:51:38 +0800
Message-Id: <20210316125138.2421-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAnP0ukqlBgYhfcpg--.27432S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4UGFWrXF1fuF1fuF45KFg_yoW3Zwb_K3
        409rZ7WrWqv3Wvy3WjqF1fXasFkws7uFWkuFs5K3s5A343A3yj9rnruFn8K3y3ury09r98
        u3y8Zan7Cr1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU516wtUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLRNXI1SIlTYAtgABsC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

This reverts commit 00f2e6f668b05c259f3f8d1e943318bcad8486e7.

The duplicate from #796 should be removed.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 59439a9..448d8d1 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -793,7 +793,6 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 			dev_err(dev,
 				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
 				__func__, subnode->name, ret);
-			of_node_put(subnode);
 			return ret;
 		}
 		of_property_read_u32(subnode, "cdns,num-lanes", &num_lanes);
-- 
1.9.1


