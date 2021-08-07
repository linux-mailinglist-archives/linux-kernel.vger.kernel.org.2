Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4243E36EB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHGTFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGTFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 15:05:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 12:05:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so24557699pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDzr9j6jDQymvAZrQvh0mEZMgeOS0DQq/WzD3far9AM=;
        b=J2fkjjsuWNeHerOTcP8G/YG86fcP61VGCTe67t+htJCPDhbK4SpXkO8uXCozE3UU8z
         pZ/y/GDU1jdoV+vx3geGIb4nwo+yUe9S5Y+jlzxN46DUb/Wx9m/mqJ40h61hYUEnDWOG
         5rLAhFNVsOH0mrGF8/0ztqDQeMi3urRXLQsQokYzNDYs9FqkgAiELj/+zNRIYxXF0FRS
         x0Kb5rtMpUsegprUY0SWWuhBUA8IGwlzDYJdcPmZaBmf9uQq1MR+WXr5RplKS9EXhL+F
         gU0zvgOEE25YwjsjveGRNtktbH7RGCZd1L3BNYv4OsThvYQWNM4w5ZZnOoPUKj284dpy
         l9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDzr9j6jDQymvAZrQvh0mEZMgeOS0DQq/WzD3far9AM=;
        b=MWul6tg38VWfRQrYgoT7stJJ+WfI1InHR/szLYj8+onqpeDDH32Zy8JPrw8pB6UHLP
         u3pg89Eeyd0RJ/0Im+xDS9dSpj0b0RVkP91tXwv/wPJvY7n//MepnlaLsu4rWenwvYwD
         B1ukfsi0d9LBi6kHV1DfHlYRv81T+n+k3DZ0k0S8g9brwVQMqrqFxCmtJImPg7IkOB6E
         QF+x7/Tv2zNowjsiUBB/STYRt2jmnmefTZcceFq/br57Okk3ZR8UcUsfHuMQ5VDvCMiJ
         TNTNBAtc8W5kUEtCOckzPPad2fslJqO6dY5u4hhXWN6D7IYR4kcMkbPCShzyYklGtzte
         yiIg==
X-Gm-Message-State: AOAM531Qaq9uzhET3/fWeKDVh9gBdn3OQrt+pVYJ5nGjLEKQNpmgl15p
        JnKBo2YgbFC895xaM69vJ6o=
X-Google-Smtp-Source: ABdhPJwLpYFtek7YvpqTwxl/4Qq+Nuz2NdUl0gVBdSJPakAfLwkU4B3FHdFl7I8X6nr0bt8E4YLdHA==
X-Received: by 2002:a17:90a:ce05:: with SMTP id f5mr27351733pju.93.1628363118743;
        Sat, 07 Aug 2021 12:05:18 -0700 (PDT)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id i13sm14859090pfr.79.2021.08.07.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 12:05:18 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
Subject: [PATCH] tty: Fix data race between tiocsti() and flush_to_ldisc()
Date:   Sun,  8 Aug 2021 03:05:13 +0800
Message-Id: <20210807190513.3810821-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ops->receive_buf() may be accessed concurrently from these two
functions.  If the driver flushes data to the line discipline
receive_buf() method while tiocsti() is using the ops->receive_buf(),
the data race will happen.

For example:
tty_ioctl                       |tty_ldisc_receive_buf
 ->tioctsi                      | ->tty_port_default_receive_buf
                                |  ->tty_ldisc_receive_buf
   ->hci_uart_tty_receive       |   ->hci_uart_tty_receive
    ->h4_recv                   |    ->h4_recv

In this case, the h4 receive buffer will be overwritten by the
latecomer, and it cause a memory leak.

Hence, change tioctsi() function to use the exclusive lock interface
from tty_buffer to avoid the data race.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
---
 drivers/tty/tty_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e8532006e960..746fe13a2054 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2307,8 +2307,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
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

