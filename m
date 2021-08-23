Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961483F4C61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhHWOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhHWOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:32:26 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB311C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:31:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5E9BB41E96;
        Mon, 23 Aug 2021 14:31:38 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] mfd/syscon: Use of_iomap() instead of ioremap()
Date:   Mon, 23 Aug 2021 23:31:22 +0900
Message-Id: <20210823143122.253094-1-marcan@marcan.st>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This automatically selects between ioremap() and ioremap_np() on
platforms that require it, such as Apple SoCs.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 765c0210cb52..191fdb87c424 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -60,7 +60,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		goto err_map;
 	}
 
-	base = ioremap(res.start, resource_size(&res));
+	base = of_iomap(np, 0);
 	if (!base) {
 		ret = -ENOMEM;
 		goto err_map;
-- 
2.32.0

