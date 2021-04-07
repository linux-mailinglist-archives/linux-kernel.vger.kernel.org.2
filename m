Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF044356A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351362AbhDGKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351169AbhDGKkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E778613CE;
        Wed,  7 Apr 2021 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=4kdGQLKD5QZqI2txCJcBEXqco33DJCxonvayaCmjC6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mASRszcHLAyyk953aYUbU3G/d7Is9mt2HWNycR4fUaYHei5+AXyabnSYOtvQOkb/Y
         A/rfEY1Rjk1DMzbNElWkvUVM6v772d5Y/qujzzfqY+E7s6bL4iR4nrlEjZKnWbB7wx
         qmdmWbOJO8IXK8GO/Cj1H6quVlbuYTjj7YLqI0kdZKE5BbDOVZwl66NbEbaSpH6gqb
         PMyuHo3qrlrYwE+YgukEzfmfOboMFt8suzeKD06FnhUZmM9+Tbvun0eLe6TLFeLWMo
         nPpI9wbQ6MMKJaVZeLtYGzQzC0HVCUzM7zPW+qSPc0O8xxRlCgx23PiRTyt0Fk51Ta
         00mvJSyVyt86Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b6-0000Fd-AX; Wed, 07 Apr 2021 12:39:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] USB: serial: ftdi_sio: simplify TIOCGSERIAL permission check
Date:   Wed,  7 Apr 2021 12:39:24 +0200
Message-Id: <20210407103925.829-24-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the deprecated custom_divisor field is an unprivileged
operation so after verifying that flag field does not contain any
privileged changes both updates can be carried out by any user.

Combine the two branches and drop the erroneous comment.

Note that private flags field is only used for ASYNC flags so there's no
need to try to retain any other bits when updating the flags.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3fd7875200b9..9228e56a91c0 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1496,27 +1496,16 @@ static int set_serial_info(struct tty_struct *tty,
 	mutex_lock(&priv->cfg_lock);
 	old_priv = *priv;
 
-	/* Do error checking and permission checking */
-
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((ss->flags ^ priv->flags) & ~ASYNC_USR_MASK) {
 			mutex_unlock(&priv->cfg_lock);
 			return -EPERM;
 		}
-		priv->flags = ((priv->flags & ~ASYNC_USR_MASK) |
-			       (ss->flags & ASYNC_USR_MASK));
-		priv->custom_divisor = ss->custom_divisor;
-		goto check_and_exit;
 	}
 
-
-	/* Make the changes - these are privileged changes! */
-
-	priv->flags = ((priv->flags & ~ASYNC_FLAGS) |
-					(ss->flags & ASYNC_FLAGS));
+	priv->flags = ss->flags & ASYNC_FLAGS;
 	priv->custom_divisor = ss->custom_divisor;
 
-check_and_exit:
 	write_latency_timer(port);
 
 	if ((priv->flags ^ old_priv.flags) & ASYNC_SPD_MASK ||
-- 
2.26.3

