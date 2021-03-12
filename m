Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982B033879E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhCLIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:39:07 -0500
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:48872 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhCLIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:39:05 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 03:39:04 EST
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id A6B01E03A8;
        Fri, 12 Mar 2021 16:29:11 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, kael_w@yeah.net
Subject: [PATCH] arm: plat-pxa: delete redundant printing of the error
Date:   Fri, 12 Mar 2021 16:28:40 +0800
Message-Id: <20210312082841.37779-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHU4dGEhMHx1NHR0YVkpNSk5OSExMTkpCSUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6Nxw4KD8NAwESFSoMGg4j
        TykaCzlVSlVKTUpOTkhMTE5JSkNCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkJJNwY+
X-HM-Tid: 0a78258dc7262c17kusna6b01e03a8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() has already checked and printed the error,
the printing here is not necessary at all.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/arm/plat-pxa/ssp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 563440315acd..9e77b3392c1e 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -146,10 +146,8 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (ssp->irq < 0)
 		return -ENODEV;
-	}
 
 	if (dev->of_node) {
 		const struct of_device_id *id =
-- 
2.25.1

