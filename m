Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C631C6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:24:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 23:24:02 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lBuiG-0003lF-5E; Tue, 16 Feb 2021 08:24:00 +0100
Received: from jbe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1lBuiF-0002Me-5u; Tue, 16 Feb 2021 08:23:59 +0100
From:   Juergen Borleis <jbe@pengutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v2] fs: ubifs: set s_uuid in super block to support ima/evm uuid options
Date:   Tue, 16 Feb 2021 08:23:34 +0100
Message-Id: <20210216072334.7575-2-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210216072334.7575-1-jbe@pengutronix.de>
References: <20210216072334.7575-1-jbe@pengutronix.de>
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

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Co-developed-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 fs/ubifs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 138b9426c6c1..a8383ca39a47 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2230,6 +2230,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 
+	import_uuid(&sb->s_uuid, c->uuid);
+
 	mutex_unlock(&c->umount_mutex);
 	return 0;
 
-- 
2.20.1

