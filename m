Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F76339C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCMHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 02:47:34 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:60652 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhCMHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 02:47:05 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A5306400162;
        Sat, 13 Mar 2021 15:47:01 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH 1/2] ata: delete redundant printing of return value
Date:   Sat, 13 Mar 2021 15:46:56 +0800
Message-Id: <1615621617-1343-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkNDT0oeQhhCQk1IVkpNSk5NSUpNSUpDQkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6HRw*Gj8VTFEwPR45CTIM
        ECJPFA1VSlVKTUpOTUlKTUlJSUtCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSk5JTzcG
X-HM-Tid: 0a782a8d883cd991kuwsa5306400162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/ata/libahci_platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index de638da..2e7ea75
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -582,11 +582,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	hpriv->irq = irq;
 
-- 
2.7.4

