Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4432A214
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381353AbhCBHRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:17:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:39920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835892AbhCBGYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 232A7B035;
        Tue,  2 Mar 2021 06:22:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 32/44] tty: xtensa/iss, setup the timer statically
Date:   Tue,  2 Mar 2021 07:22:02 +0100
Message-Id: <20210302062214.29627-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_TIMER and avoid runtime initialization of the serial_timer.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/platforms/iss/console.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 3b89d9ceb06a..8ea261b8c022 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -31,21 +31,18 @@
 #define SERIAL_MAX_NUM_LINES 1
 #define SERIAL_TIMER_VALUE (HZ / 10)
 
+static void rs_poll(struct timer_list *);
+
 static struct tty_driver *serial_driver;
 static struct tty_port serial_port;
-static struct timer_list serial_timer;
-
+static DEFINE_TIMER(serial_timer, rs_poll);
 static DEFINE_SPINLOCK(timer_lock);
 
-static void rs_poll(struct timer_list *);
-
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
 	spin_lock_bh(&timer_lock);
-	if (tty->count == 1) {
-		timer_setup(&serial_timer, rs_poll, 0);
+	if (tty->count == 1)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	}
 	spin_unlock_bh(&timer_lock);
 
 	return 0;
-- 
2.30.1

