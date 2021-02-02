Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2730BEAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhBBMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:49:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39557 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhBBMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:49:22 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1l6v6m-0000gP-8U; Tue, 02 Feb 2021 13:48:40 +0100
Received: from jbe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1l6v6k-00081d-NI; Tue, 02 Feb 2021 13:48:38 +0100
From:   Juergen Borleis <jbe@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] fs: ubifs: set s_uuid in super block to support ima/evm uuid options
Date:   Tue,  2 Feb 2021 13:48:38 +0100
Message-Id: <20210202124838.30805-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

This is required to provide uuid based integrity functionality for:
ima_policy (fsuuid option) and the 'evmctl' command ('--uuid' option).

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Juergen Borleis <jbe@pengutronix.de>
---
 fs/ubifs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index cb3acfb7dd1f..b990baed4de0 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2231,6 +2231,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		err = -ENOMEM;
 		goto out_umount;
 	}
+	memcpy(&sb->s_uuid, &c->uuid, sizeof(c->uuid));
 
 	mutex_unlock(&c->umount_mutex);
 	return 0;
-- 
2.20.1

