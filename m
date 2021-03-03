Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614E32BD16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381884AbhCCPUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:20:45 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:50630 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbhCCKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Kubqf6k/HZUq1mdBnL+ASxzPtFgpk8F6M2q021zdR3Y=;
        b=q3cEGdXKm06swwTo/nG33yAV4xWpwl9cd3gHGbMo7xPwKclbVADUPWxqJpNBTIE84lg7Tzy0jJH1TOUM1FEzrJXY+d4na5onNrb/wE+pZ4eFd4atmjrksToShNzAywwidXKqtRnPb7k1sx9IB+Zxx/KwZDakFrJGL9wOGbu5FuE=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lHNSf-00081H-L1; Wed, 03 Mar 2021 10:06:31 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubifs: Report max LEB count at mount time
Date:   Wed,  3 Mar 2021 10:05:19 +0100
Message-Id: <20210303090519.9716-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no other way to directly report/query this
quantity. It is useful when planing how given filesystem
can be resized.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 fs/ubifs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index ddb2ca636c93..178680d2338f 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1552,8 +1552,8 @@ static int mount_ubifs(struct ubifs_info *c)
 	ubifs_msg(c, "LEB size: %d bytes (%d KiB), min./max. I/O unit sizes: %d bytes/%d bytes",
 		  c->leb_size, c->leb_size >> 10, c->min_io_size,
 		  c->max_write_size);
-	ubifs_msg(c, "FS size: %lld bytes (%lld MiB, %d LEBs), journal size %lld bytes (%lld MiB, %d LEBs)",
-		  x, x >> 20, c->main_lebs,
+	ubifs_msg(c, "FS size: %lld bytes (%lld MiB, %d LEBs), max %d LEBs, journal size %lld bytes (%lld MiB, %d LEBs)",
+		  x, x >> 20, c->main_lebs, c->max_leb_cnt,
 		  y, y >> 20, c->log_lebs + c->max_bud_cnt);
 	ubifs_msg(c, "reserved for root: %llu bytes (%llu KiB)",
 		  c->report_rp_size, c->report_rp_size >> 10);
-- 
2.11.0

