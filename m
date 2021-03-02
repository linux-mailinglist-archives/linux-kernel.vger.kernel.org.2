Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3532A220
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836634AbhCBHTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:19:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:39966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835905AbhCBGZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC774B03B;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/44] tty: localise ptychar and make it const
Date:   Tue,  2 Mar 2021 07:22:06 +0100
Message-Id: <20210302062214.29627-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptychar was not const, so mark it as such. And move this variable to the
only place where it's used.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c8cbf08b6dcf..7cf57e6cadbf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1196,8 +1196,6 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 	return 0;
 }
 
-static char ptychar[] = "pqrstuvwxyzabcde";
-
 /**
  *	pty_line_name	-	generate name for a pty
  *	@driver: the tty driver in use
@@ -1211,6 +1209,7 @@ static char ptychar[] = "pqrstuvwxyzabcde";
  */
 static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
+	static const char ptychar[] = "pqrstuvwxyzabcde";
 	int i = index + driver->name_base;
 	/* ->name is initialized to "ttyp", but "tty" is expected */
 	sprintf(p, "%s%c%x",
-- 
2.30.1

