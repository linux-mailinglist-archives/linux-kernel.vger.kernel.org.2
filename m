Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79837374B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhEEJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhEEJUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F445B27D;
        Wed,  5 May 2021 09:19:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 28/35] nozomi: simplify ntty_chars_in_buffer
Date:   Wed,  5 May 2021 11:19:21 +0200
Message-Id: <20210505091928.22010-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntty_chars_in_buffer is overly complicated. Simplify it by inverting the
condition.

Side FIXME: how can dc or port be NULL here?

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/nozomi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 62c16731ccd8..5e0ddf22931e 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1780,16 +1780,11 @@ static unsigned int ntty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct port *port = tty->driver_data;
 	struct nozomi *dc = get_dc_by_tty(tty);
-	s32 rval = 0;
 
-	if (unlikely(!dc || !port)) {
-		goto exit_in_buffer;
-	}
-
-	rval = kfifo_len(&port->fifo_ul);
+	if (unlikely(!dc || !port))
+		return 0;
 
-exit_in_buffer:
-	return rval;
+	return kfifo_len(&port->fifo_ul);
 }
 
 static const struct tty_port_operations noz_tty_port_ops = {
-- 
2.31.1

