Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97D532A215
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381362AbhCBHRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:17:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:39918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835891AbhCBGYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFF8CB030;
        Tue,  2 Mar 2021 06:22:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 30/44] tty: xtensa/iss, don't reassign to tty->port
Date:   Tue,  2 Mar 2021 07:22:00 +0100
Message-Id: <20210302062214.29627-30-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already do tty_port_link_device in rs_init, so we don't need to
reassign a port to tty->port. It would be too late in tty::ops::open
anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 1179011044a7..5d7f9c638437 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -48,7 +48,6 @@ static void rs_poll(struct timer_list *);
 
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
-	tty->port = &serial_port;
 	spin_lock_bh(&timer_lock);
 	if (tty->count == 1) {
 		timer_setup(&serial_timer, rs_poll, 0);
-- 
2.30.1

