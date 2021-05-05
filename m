Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181FC373729
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhEEJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:20:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhEEJU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:20:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56B99B272;
        Wed,  5 May 2021 09:19:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/35] n_tty: invert TTY_NORMAL condition in n_tty_receive_buf_standard
Date:   Wed,  5 May 2021 11:19:02 +0200
Message-Id: <20210505091928.22010-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle !TTY_NORMAL as a short path and 'continue' the loop. Do the rest as
a normal code flow. This decreases the indentation level by one and
makes the code flow more understandable.

IOW, we avoid
  if (cond) {
    LONG CODE;
  } else
    single_line();
by
  if (!cond) {
    single_line();
    continue;
  }
  LONG CODE;

While at it, invert also the 'if (!test_bit) A else B' into 'if
(test_bit) B else A'.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e7c9dce14f88..01883e5c8bbd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1541,21 +1541,24 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 			continue;
 		}
 
-		if (likely(flag == TTY_NORMAL)) {
-			if (I_ISTRIP(tty))
-				c &= 0x7f;
-			if (I_IUCLC(tty) && L_IEXTEN(tty))
-				c = tolower(c);
-			if (L_EXTPROC(tty)) {
-				put_tty_queue(c, ldata);
-				continue;
-			}
-			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char(tty, c);
-			else
-				n_tty_receive_char_special(tty, c);
-		} else
+		if (unlikely(flag != TTY_NORMAL)) {
 			n_tty_receive_char_flagged(tty, c, flag);
+			continue;
+		}
+
+		if (I_ISTRIP(tty))
+			c &= 0x7f;
+		if (I_IUCLC(tty) && L_IEXTEN(tty))
+			c = tolower(c);
+		if (L_EXTPROC(tty)) {
+			put_tty_queue(c, ldata);
+			continue;
+		}
+
+		if (test_bit(c, ldata->char_map))
+			n_tty_receive_char_special(tty, c);
+		else
+			n_tty_receive_char(tty, c);
 	}
 }
 
-- 
2.31.1

