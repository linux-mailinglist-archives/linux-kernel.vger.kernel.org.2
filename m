Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E76337232
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhCKMOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:14:33 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:46446 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhCKMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:14:02 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id E691E4002F4;
        Thu, 11 Mar 2021 20:13:59 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Wang Qing <wangqing@vivo.com>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: delete redundant printing of return value
Date:   Thu, 11 Mar 2021 20:13:54 +0800
Message-Id: <1615464836-18291-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhgeGE5DS01JHh0ZVkpNSk5PTU9DT0tISk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6OCo6TT8IIQI0EQ8WThQK
        LiJPCU1VSlVKTUpOT01PQ09LTU1KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQk1INwY+
X-HM-Tid: 0a7821353c2bd991kuwse691e4002f4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 4279e13..9d2aed7
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -613,10 +613,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	/* request the IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ defined: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
 			       0, DRV_NAME, priv);
-- 
2.7.4

