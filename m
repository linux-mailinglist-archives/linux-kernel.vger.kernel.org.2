Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9335595A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbhDFQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:40:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhDFQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:40:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lTokE-0007EU-Sf; Tue, 06 Apr 2021 16:40:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regmap-irq: Fix dereference of a potentially null d->virt_buf
Date:   Tue,  6 Apr 2021 17:40:02 +0100
Message-Id: <20210406164002.430221-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The clean up of struct d can potentiallly index into a null array
d->virt_buf causing errorenous pointer dereferencing issues on
kfree calls.  Fix this by adding a null check on d->virt_buf before
attempting to traverse the array to kfree the objects.

Addresses-Coverity: ("Dereference after null check")
Fixes: 4c5014456305 ("regmap-irq: Introduce virtual regs to handle more config regs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/regmap/regmap-irq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index e6343ccc6aa1..760296a4b606 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -901,9 +901,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
-	for (i = 0; i < chip->num_virt_regs; i++)
-		kfree(d->virt_buf[i]);
-	kfree(d->virt_buf);
+	if (d->virt_buf) {
+		for (i = 0; i < chip->num_virt_regs; i++)
+			kfree(d->virt_buf[i]);
+		kfree(d->virt_buf);
+	}
 	kfree(d);
 	return ret;
 }
-- 
2.30.2

