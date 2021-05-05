Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8037371F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEEJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhEEJU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD460B269;
        Wed,  5 May 2021 09:19:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/35] n_tty: move lnext handling
Date:   Wed,  5 May 2021 11:18:59 +0200
Message-Id: <20210505091928.22010-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move lnext handling from __receive_buf to n_tty_receive_buf_standard. It
simplifies the handling as it needs not fetching 'flag' and decrement
'count' in __receive_buf. Instead, all this is left up to the loop in
n_tty_receive_buf_standard which already does that.

This way, no need to repeat the action when n_tty_receive_char_special
returns true -- ldata->lnext is set there in that case, so the 'if
(ldata->lnext)' check is sufficient. The next patch will switch
n_tty_receive_char_special to return 'void'.

The result is much simplified code flow.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f0db3f41df83..d40844b7a4fb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1538,6 +1538,12 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 	while (count--) {
 		if (fp)
 			flag = *fp++;
+
+		if (ldata->lnext) {
+			n_tty_receive_char_lnext(tty, *cp++, flag);
+			continue;
+		}
+
 		if (likely(flag == TTY_NORMAL)) {
 			unsigned char c = *cp++;
 
@@ -1551,12 +1557,8 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 			}
 			if (!test_bit(c, ldata->char_map))
 				n_tty_receive_char(tty, c);
-			else if (n_tty_receive_char_special(tty, c) && count) {
-				if (fp)
-					flag = *fp++;
-				n_tty_receive_char_lnext(tty, *cp++, flag);
-				count--;
-			}
+			else
+				n_tty_receive_char_special(tty, c);
 		} else
 			n_tty_receive_char_flagged(tty, *cp++, flag);
 	}
@@ -1575,15 +1577,6 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	else if (tty->closing && !L_EXTPROC(tty))
 		n_tty_receive_buf_closing(tty, cp, fp, count);
 	else {
-		if (ldata->lnext) {
-			char flag = TTY_NORMAL;
-
-			if (fp)
-				flag = *fp++;
-			n_tty_receive_char_lnext(tty, *cp++, flag);
-			count--;
-		}
-
 		n_tty_receive_buf_standard(tty, cp, fp, count);
 
 		flush_echoes(tty);
-- 
2.31.1

