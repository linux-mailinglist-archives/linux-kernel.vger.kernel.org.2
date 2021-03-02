Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE94432A21F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836626AbhCBHTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:19:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835906AbhCBGZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54BE3B03F;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 40/44] tty: hvc, drop unneeded forward declarations
Date:   Tue,  2 Mar 2021 07:22:10 +0100
Message-Id: <20210302062214.29627-40-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forward declarations make the code larger and rewrites harder. Harder as
they are often omitted from global changes. Remove forward declarations
which are not really needed, i.e. the definition of the function is
before its first use.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvcs.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index c90848919644..0b89d878a108 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -290,36 +290,11 @@ static LIST_HEAD(hvcs_structs);
 static DEFINE_SPINLOCK(hvcs_structs_lock);
 static DEFINE_MUTEX(hvcs_init_mutex);
 
-static void hvcs_unthrottle(struct tty_struct *tty);
-static void hvcs_throttle(struct tty_struct *tty);
-static irqreturn_t hvcs_handle_interrupt(int irq, void *dev_instance);
-
-static int hvcs_write(struct tty_struct *tty,
-		const unsigned char *buf, int count);
-static int hvcs_write_room(struct tty_struct *tty);
-static int hvcs_chars_in_buffer(struct tty_struct *tty);
-
-static int hvcs_has_pi(struct hvcs_struct *hvcsd);
-static void hvcs_set_pi(struct hvcs_partner_info *pi,
-		struct hvcs_struct *hvcsd);
 static int hvcs_get_pi(struct hvcs_struct *hvcsd);
 static int hvcs_rescan_devices_list(void);
 
-static int hvcs_partner_connect(struct hvcs_struct *hvcsd);
 static void hvcs_partner_free(struct hvcs_struct *hvcsd);
 
-static int hvcs_enable_device(struct hvcs_struct *hvcsd,
-		uint32_t unit_address, unsigned int irq, struct vio_dev *dev);
-
-static int hvcs_open(struct tty_struct *tty, struct file *filp);
-static void hvcs_close(struct tty_struct *tty, struct file *filp);
-static void hvcs_hangup(struct tty_struct * tty);
-
-static int hvcs_probe(struct vio_dev *dev,
-		const struct vio_device_id *id);
-static int hvcs_remove(struct vio_dev *dev);
-static int __init hvcs_module_init(void);
-static void __exit hvcs_module_exit(void);
 static int hvcs_initialize(void);
 
 #define HVCS_SCHED_READ	0x00000001
-- 
2.30.1

