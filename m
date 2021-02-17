Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64BA31DBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhBQOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhBQOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:44:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:43:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d24so21844323lfs.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8FxXuT4j8laMTP+nqfNAPzKKyyOeazfWCeXnGIadDA=;
        b=lOsoc9XKEvECRyePRX2tUvEu0JRzP5yzZBVXwuu/P7813LsNLMaHlHExbgC//l/5qL
         tob9oTtX8KZwJjeKeX4sWE7vOOYrbmb31cTSVxOWjRwsJQ1q5Gw26HaCyT2lglsVPGjR
         slv/MqdykBPyvB3t/3HtBWZ9/ldxnaQ6NH2tRIypJoemlO9qQ0xRW6RwidvkpszlpD4O
         CFPRH4y4HdmvsiclxX6PfcVYjonLAh4atIwMpsHd7HoFiexG55NbNQYKKqwW6jOwLU6r
         7E6Kbd9Tv5dMrn0Odm2yLlXm9p+srcAaJMIje5z7cUr+O38mBqusRposBjveNxlj+CxT
         IAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8FxXuT4j8laMTP+nqfNAPzKKyyOeazfWCeXnGIadDA=;
        b=FwKhT42WPHR5lMChLraTJAJspTg0+9ts7CkGX8pI0XlNXARd/y6toQTuyjjUlkq/p3
         nkXBrLXLBwZ5JPBIUYlZA2uTch7Wu22KZoM4vLZ1vZVNvB2y7o3fPDIuEltl2VwFHzRr
         mHFjmso47ESh5j/9i+LmvHVHxoSH9FxChh99hxqorajKpkbFjsJ+ZVutmVmhA2R6hoRk
         xEyq61wPhIeSoUP3YnHVx4t9CrStpQsznOgJuqWzAF8zwsni6b324glymNHUrs7xMEJg
         Q6kQm1QBiFy9iqDnCNQ0z7UpILS4AVIVXPyhLf/bHIDPq3uZyI6q8GKcmMefukkuS6DC
         6ywQ==
X-Gm-Message-State: AOAM530DyYAhNQ9tvidBS53jGveuYQO+7Wpz0sgapLX99FgVnzhb4KsZ
        dHxI65WEoPDj4dzeuX4hO8EDU0sfeva5RhjE
X-Google-Smtp-Source: ABdhPJxKnuUhiwaiYroJRt6DhyFnnf/IYdPMC8G5xe761e2h9OkkiA2d42zDzhuVtRI9HQ66TitE/w==
X-Received: by 2002:a19:c792:: with SMTP id x140mr15192729lff.546.1613573029440;
        Wed, 17 Feb 2021 06:43:49 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.225])
        by smtp.googlemail.com with ESMTPSA id b28sm270522lfo.190.2021.02.17.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:43:48 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Subject: [PATCH] tty: fix when iov_iter_count() returns 0 in tty_write()
Date:   Wed, 17 Feb 2021 20:43:47 +0600
Message-Id: <20210217144347.2962551-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in iov_iter_revert[1] when iov_iter_count() returns 0,
therefore INT_MAX is passed to iov_iter_revert() causing > MAX_RW_COUNT
warning.

static inline ssize_t do_tty_write()
{
..
	size_t count = iov_iter_count(from);
..
		size_t size = count;
		if (ret != size)
			iov_iter_revert(from, size-ret);

[1] WARNING: lib/iov_iter.c:1090
Call Trace:
 do_tty_write drivers/tty/tty_io.c:967 [inline]
 file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658

Fixes: 494e63ee9c("tty: implement write_iter")
Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/tty/tty_io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 816e709afa56..8d6d579ecc3b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -905,6 +905,9 @@ static inline ssize_t do_tty_write(
 	ssize_t ret, written = 0;
 	unsigned int chunk;
 
+	if (!count)
+		return -EINVAL;
+
 	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

