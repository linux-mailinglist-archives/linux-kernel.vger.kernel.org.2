Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133413AC3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhFRGVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:21:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhFRGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B3B91FE0C;
        Fri, 18 Jun 2021 06:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90hIoEOiclMDq4Rix7TBaSibL8uUQATRthtyaIL6SWQ=;
        b=0obMtDWlQZXfV9ZjwD9pgl5+CZOvMprzUESC+XFzhNZvoolnClhN9mqvAkmVz3gkrmwEh6
        5/AkhWS8UJbDL8ix52VDZmILNRj4yRBF48dFPYgDug9sNwtw3F3EtY0LIe4cyLwiX7+3UD
        ru0UGulyPok1cB1yFSIAZP90QedqSKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90hIoEOiclMDq4Rix7TBaSibL8uUQATRthtyaIL6SWQ=;
        b=2Cxxgg0oLxfXmuSpve+BJy+jVYuoL9tDXtUde9uYAIKQJjE2bymV8a/3T7WyXnta2wvHE8
        YGFF8uZKle5Y1RCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D718BA3BC8;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 51/70] mxser: make mxser_board::idx really an index
Date:   Fri, 18 Jun 2021 08:14:57 +0200
Message-Id: <20210618061516.662-52-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_board::idx is named as index, but actually contain a base. So
assign index there. And for base, introduce a local variable.

This is needed for the next patch (use index as a bit index).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ea5e61a5a173..30b3a5ab6bea 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1910,7 +1910,7 @@ static int mxser_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	struct mxser_board *brd;
-	unsigned int i;
+	unsigned int i, base;
 	unsigned long ioaddress;
 	unsigned short nports = MXSER_NPORTS(ent->driver_data);
 	struct device *tty_dev;
@@ -1927,7 +1927,8 @@ static int mxser_probe(struct pci_dev *pdev,
 	}
 
 	brd = &mxser_boards[i];
-	brd->idx = i * MXSER_PORTS_PER_BOARD;
+	brd->idx = i;
+	base = i * MXSER_PORTS_PER_BOARD;
 
 	retval = pcim_enable_device(pdev);
 	if (retval) {
@@ -1966,12 +1967,12 @@ static int mxser_probe(struct pci_dev *pdev,
 
 	for (i = 0; i < nports; i++) {
 		tty_dev = tty_port_register_device(&brd->ports[i].port,
-				mxvar_sdriver, brd->idx + i, &pdev->dev);
+				mxvar_sdriver, base + i, &pdev->dev);
 		if (IS_ERR(tty_dev)) {
 			retval = PTR_ERR(tty_dev);
 			for (; i > 0; i--)
 				tty_unregister_device(mxvar_sdriver,
-					brd->idx + i - 1);
+					base + i - 1);
 			goto err_relbrd;
 		}
 	}
@@ -1991,10 +1992,10 @@ static int mxser_probe(struct pci_dev *pdev,
 static void mxser_remove(struct pci_dev *pdev)
 {
 	struct mxser_board *brd = pci_get_drvdata(pdev);
-	unsigned int i;
+	unsigned int i, base = brd->idx * MXSER_PORTS_PER_BOARD;
 
 	for (i = 0; i < brd->nports; i++) {
-		tty_unregister_device(mxvar_sdriver, brd->idx + i);
+		tty_unregister_device(mxvar_sdriver, base + i);
 		tty_port_destroy(&brd->ports[i].port);
 	}
 
-- 
2.32.0

