Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41AB3ADFBA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFTR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFTRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:55:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC057C06175F;
        Sun, 20 Jun 2021 10:53:34 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1dU-00012S-Pd; Sun, 20 Jun 2021 19:53:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/13] staging: rtl8188eu: simplify rtl88eu_mon_init
Date:   Sun, 20 Jun 2021 19:52:57 +0200
Message-Id: <20210620175301.14988-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620175301.14988-1-martin@kaiser.cx>
References: <20210620175301.14988-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code looks a bit nicer without goto.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/mon.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mon.c b/drivers/staging/rtl8188eu/os_dep/mon.c
index 9b40de7d39e7..6370a3d8881b 100644
--- a/drivers/staging/rtl8188eu/os_dep/mon.c
+++ b/drivers/staging/rtl8188eu/os_dep/mon.c
@@ -163,18 +163,15 @@ struct net_device *rtl88eu_mon_init(void)
 
 	dev = alloc_netdev(0, "mon%d", NET_NAME_UNKNOWN, mon_setup);
 	if (!dev)
-		goto fail;
+		return NULL;
 
 	err = register_netdev(dev);
-	if (err < 0)
-		goto fail_free_dev;
+	if (err < 0) {
+		free_netdev(dev);
+		return NULL;
+	}
 
 	return dev;
-
-fail_free_dev:
-	free_netdev(dev);
-fail:
-	return NULL;
 }
 
 void rtl88eu_mon_deinit(struct net_device *dev)
-- 
2.20.1

