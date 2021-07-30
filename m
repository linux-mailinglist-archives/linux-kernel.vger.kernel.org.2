Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087343DB6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhG3KHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:07:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53370
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238404AbhG3KHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:07:16 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EF69C3F110;
        Fri, 30 Jul 2021 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627639631;
        bh=Jhq/1IlrtOSAQtOrAABmocJHmXPN2QNcHDbWLf6fdHk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Ok+V5PVmWgwUWAfWMW0cPxsK+FAD/wWDvAIIIlBMDI8ohtGX8/5YiDFYnYuBRB43q
         novlh4b6tnq5TSwx3dVvNnxwYx6jETSB7l18Ongf1PXgATDKAPJWe8zZrzH0iqtFMI
         yrv9RmVdVNeljSKn4XrYgfDuVl8pDVAVWgP0csIa64WpkjyW6K2T3uj8UlKd6XuqgJ
         VT5G9Ri8CeL4CfAovYNiw6ZwXF80033i5yVQu6fQVvM4I5o+8+qs/0b05roRZXivwu
         By2SM7Lit5XHNqbaEr9D2xPEgzEqibbBKDvid6JL3rCgxWpwAoNx5+OFNi9zVBd/99
         DA7AM+aXmW7Uw==
From:   Colin King <colin.king@canonical.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parport: remove non-zero check on count
Date:   Fri, 30 Jul 2021 11:07:10 +0100
Message-Id: <20210730100710.27405-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for count appears to be incorrect since a non-zero count
check occurs a couple of statements earlier. Currently the check is
always false and the dev->port->irq != PARPORT_IRQ_NONE part of the
check is never tested and the if statement is dead-code. Fix this
by removing the check on count.

Note that this code is pre-git history, so I can't find a sha for
it.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/parport/ieee1284_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
index 2c11bd3fe1fd..17061f1df0f4 100644
--- a/drivers/parport/ieee1284_ops.c
+++ b/drivers/parport/ieee1284_ops.c
@@ -518,7 +518,7 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
 				goto out;
 
 			/* Yield the port for a while. */
-			if (count && dev->port->irq != PARPORT_IRQ_NONE) {
+			if (dev->port->irq != PARPORT_IRQ_NONE) {
 				parport_release (dev);
 				schedule_timeout_interruptible(msecs_to_jiffies(40));
 				parport_claim_or_block (dev);
-- 
2.31.1

