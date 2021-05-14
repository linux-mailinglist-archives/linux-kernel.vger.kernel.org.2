Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C5380801
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhENLEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhENLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:04:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F9C06174A;
        Fri, 14 May 2021 04:03:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so1182724pjo.0;
        Fri, 14 May 2021 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkzpwjVe0wwLmPgMR98lKn55b9EeNwElH9tA7Rxi05Y=;
        b=u70A+1kTvyXiODs3/WPwB9FXkQMx0hYRgkC/yJEiwXTclojKioNs2FFBhXTWC0pf/v
         1rpdhyD48hRsmSqRiXuFD5Z52t2Qj0SHp2QyjfhEjgjRylMbweT9zVnLmcVpN6WnxPo8
         jIL4bECIQ0btOmDTtj31F6sGT7HkhP+SfkVMCuUXN56euH9+dOmmFZNgCP9sRbilCiur
         DKrwnSdqgtWu+6CNvKEjw7qu8wesVAmaNHU+eg0CQueFMUif+Mi5e2/kmm8nHxHEZO7h
         WirDxwjkKZ7Jfu1CrgQ0Q3N8r4sRJwQ9UV3srcDrduSzwcZmjVewLeZtKnIeQc5F8uae
         WjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkzpwjVe0wwLmPgMR98lKn55b9EeNwElH9tA7Rxi05Y=;
        b=c+XjdV9H8NWkRrnmdlu8phahjQEO0swZnQ/NEY6Va8QJFjRYgojAo5Kc/S/qQrSXv/
         0zFOKaPFUTGAu3pfjcMJM6vskUm0Y9LDNLsbl+1nXHdvaefIQgAJlxuGa2p1Ea45x+mB
         aGh7ot0x1CIp12tJ9oQmyP6GxNZUWz5reiiMeNiqyYLfqAgOiI4Ebh430eG3DcRmEXmo
         BQO3o7baPluA98Qa1qaBeWnf8naeOTG7jjPR1Qn5g2HLvlONUnqhbobR+pQrXVPkxuPg
         2PmOE1wSi53PcLWRxKfXiutUXIR1rVdYDb1AjufusIhaRmY8hxW9VAUFKR3OrmlMeJgc
         uY/w==
X-Gm-Message-State: AOAM5303gPmjGs5LmPAllV7UrcxsBLlO7IbfYhUpXnAMncMozd2nsqIV
        4wS6nwGCic8ZrL5uPkqiG10=
X-Google-Smtp-Source: ABdhPJwN6s37m9kUw9Nby6kqqcqfoU5UH6stQNMFu6bHmr9GU2GtlitsMiwYzis0WSf2Oo/wz09OKQ==
X-Received: by 2002:a17:902:7888:b029:ee:cea7:6ff0 with SMTP id q8-20020a1709027888b02900eecea76ff0mr45757205pll.16.1620990209883;
        Fri, 14 May 2021 04:03:29 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.114])
        by smtp.gmail.com with ESMTPSA id ls6sm8686763pjb.57.2021.05.14.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:03:29 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: [PATCH] misc/uss720: fix memory leak in uss720_probe
Date:   Fri, 14 May 2021 19:03:17 +0800
Message-Id: <20210514110317.2041580-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uss720_probe forgets to decrease the refcount of usbdev in uss720_probe.
Fix this by decreasing the refcount of usbdev by usb_put_dev.

BUG: memory leak
unreferenced object 0xffff888101113800 (size 2048):
  comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
  hex dump (first 32 bytes):
    ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
    00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
  backtrace:
    [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
    [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
    [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
    [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
    [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/usb/misc/uss720.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index b5d661644263..748139d26263 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -736,6 +736,7 @@ static int uss720_probe(struct usb_interface *intf,
 	parport_announce_port(pp);
 
 	usb_set_intfdata(intf, pp);
+	usb_put_dev(usbdev);
 	return 0;
 
 probe_abort:
-- 
2.25.1

