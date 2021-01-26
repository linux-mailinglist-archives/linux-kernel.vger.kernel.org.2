Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08A305011
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhA0DoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbhAZWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:23:37 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:21:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A3E6A1F2;
        Tue, 26 Jan 2021 23:21:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H03Vn_blbOD4; Tue, 26 Jan 2021 23:21:49 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3AD04312;
        Tue, 26 Jan 2021 23:21:48 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l4WiZ-00G98U-Te; Tue, 26 Jan 2021 23:21:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 3/4] speakup: Simplify spk_ttyio_out error handling.
Date:   Tue, 26 Jan 2021 23:21:46 +0100
Message-Id: <20210126222147.3848175-4-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126222147.3848175-1-samuel.thibault@ens-lyon.org>
References: <20210126222147.3848175-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: A3E6A1F2
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids most code indentation

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/spk_ttyio.c | 38 ++++++++++++-----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index adc1cdb..4dbd24c 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -225,27 +225,29 @@ void spk_ttyio_unregister_ldisc(void)
 static int spk_ttyio_out(struct spk_synth *in_synth, const char ch)
 {
 	struct tty_struct *tty = in_synth->dev;
+	int ret;
+
+	if (!in_synth->alive || !tty->ops->write)
+		return 0;
 
-	if (in_synth->alive && tty->ops->write) {
-		int ret = tty->ops->write(tty, &ch, 1);
-
-		if (ret == 0)
-			/* No room */
-			return 0;
-		if (ret < 0) {
-			pr_warn("%s: I/O error, deactivating speakup\n",
-				in_synth->long_name);
-			/* No synth any more, so nobody will restart TTYs,
-			 * and we thus need to do it ourselves.  Now that there
-			 * is no synth we can let application flood anyway
-			 */
-			in_synth->alive = 0;
-			speakup_start_ttys();
-			return 0;
-		}
+	ret = tty->ops->write(tty, &ch, 1);
+
+	if (ret == 0)
+		/* No room */
+		return 0;
+
+	if (ret > 0)
+		/* Success */
 		return 1;
-	}
 
+	pr_warn("%s: I/O error, deactivating speakup\n",
+		in_synth->long_name);
+	/* No synth any more, so nobody will restart TTYs,
+	 * and we thus need to do it ourselves.  Now that there
+	 * is no synth we can let application flood anyway
+	 */
+	in_synth->alive = 0;
+	speakup_start_ttys();
 	return 0;
 }
 
-- 
2.20.1

