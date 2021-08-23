Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5243F427C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 02:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhHWAHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhHWAHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 20:07:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 17:06:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x1so6568770plg.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MACcnjEV3XfzLLGrs9YK33EN0PE/psaIlWJd2jzwxSU=;
        b=EKI/7FX1mTDvEBFaBdLEPJx6k7BSEGx0ZAktrsBRQjEOYXa/iZKeNnj/JxlYosrdUz
         5G5BKFjETXu+MCNwmMyuVDnLhvsnviCucwA7DKte6c1wRJwTpHUU55guBMpsLn6Qt0SW
         +M5T6ZTBHb/KBonCrJeho/M9aIir85mmW2gPgz81F5aYHF7mmrxa3pHf1mSpAq6bkvR3
         IfmNoet+vbJdcYYo+wasPQefBB2K8CN0Ca0kkXhxtE14P/cZ1DG1liXn5YXOc0znV1TD
         EmazPeoBxlEH8oQVqq+Zse2EY0zsmOF+kuFJanbIVNHqjkyAeZsa7+crvYetXlwWEuUU
         insA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MACcnjEV3XfzLLGrs9YK33EN0PE/psaIlWJd2jzwxSU=;
        b=XddeOvEKKBmLB5r27OXIhiHtbdQm2DkvAvGfk9Kfxf7ePPMsBkTnZSV+w8rEa5n7hh
         BRtc5NcoweifrqWUpu5vqrfXunttujnQ1Xa2lHDJFOBuw4KSGMus0kBhl8k+shasnN8a
         kQZMStrhVzQcqb7yoYocyOCy4RBV282KwHQHVanj36/vK6x5Mu7Bss29HaQeeX/foyfH
         GEFqEA5Nzrdar9RwEFTBMwo9cThy2zZpsjHDDKxbY5Z57AJT/WnrlVotOBJoizrGbxR+
         8kFKpxDjY3eOgx2H99POrrNOIPoJ6Acf1yOPwS7uwx9sbnrvV9OV7x7RkaTHc/u3LUuQ
         sDSQ==
X-Gm-Message-State: AOAM5322Xa2478/r7L4CmqUnVhefrODq072A88z9DHGXUE9UyJgMKufw
        PFarjP+06+69HNUIf1ZKunzOBHAB4nKtNg==
X-Google-Smtp-Source: ABdhPJyfnJ/2FrbLL41XFfGAjFZHY579ZnQ88qWqrJZlc3aqXXoFUvz4BjpaQdEErlJfZFEAqGJkoQ==
X-Received: by 2002:a17:902:d709:b0:130:6b05:be3e with SMTP id w9-20020a170902d70900b001306b05be3emr14368901ply.21.1629677208015;
        Sun, 22 Aug 2021 17:06:48 -0700 (PDT)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id y14sm13408002pfi.82.2021.08.22.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 17:06:47 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
Subject: [PATCH v2] tty: Fix data race between tiocsti() and flush_to_ldisc()
Date:   Mon, 23 Aug 2021 08:06:41 +0800
Message-Id: <20210823000641.2082292-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ops->receive_buf() may be accessed concurrently from these two
functions.  If the driver flushes data to the line discipline
receive_buf() method while tiocsti() is waiting for the
ops->receive_buf() to finish its work, the data race will happen.

For example:
tty_ioctl			|tty_ldisc_receive_buf
 ->tioctsi			| ->tty_port_default_receive_buf
				|  ->tty_ldisc_receive_buf
   ->hci_uart_tty_receive	|   ->hci_uart_tty_receive
    ->h4_recv                   |    ->h4_recv

In this case, the h4 receive buffer will be overwritten by the
latecomer, and we will lost the data.

Hence, change tioctsi() function to use the exclusive lock interface
from tty_buffer to avoid the data race.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
---
V2:
	- Remove FIXME comment.

 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e8532006e960..6616d4a0d41d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2290,8 +2290,6 @@ static int tty_fasync(int fd, struct file *filp, int on)
  *	Locking:
  *		Called functions take tty_ldiscs_lock
  *		current->signal->tty check is safe without locks
- *
- *	FIXME: may race normal receive processing
  */

 static int tiocsti(struct tty_struct *tty, char __user *p)
@@ -2307,8 +2305,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;
+	tty_buffer_lock_exclusive(tty->port);
 	if (ld->ops->receive_buf)
 		ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	tty_buffer_unlock_exclusive(tty->port);
 	tty_ldisc_deref(ld);
 	return 0;
 }
--
2.25.1

