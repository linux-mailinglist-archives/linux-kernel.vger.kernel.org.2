Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAB32A21D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836610AbhCBHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:18:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835907AbhCBGZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E8AFB05C;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 42/44] tty: cleanup tty_chars_in_buffer
Date:   Tue,  2 Mar 2021 07:22:12 +0100
Message-Id: <20210302062214.29627-42-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for 'else' when the 'if' part already returned. This
makes tty_chars_in_buffer similar to tty_write_room too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 4de1c6ddb8ff..deffaefcf41d 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -57,8 +57,7 @@ int tty_chars_in_buffer(struct tty_struct *tty)
 {
 	if (tty->ops->chars_in_buffer)
 		return tty->ops->chars_in_buffer(tty);
-	else
-		return 0;
+	return 0;
 }
 EXPORT_SYMBOL(tty_chars_in_buffer);
 
-- 
2.30.1

