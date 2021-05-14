Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83723809A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhENMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhENMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:35:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628BC061574;
        Fri, 14 May 2021 05:34:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso1559409pjj.0;
        Fri, 14 May 2021 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErfaclmgSuY2taH4Itt0ooytROATSvud8f5aTV69WAo=;
        b=bQpuUyoXJmCT/ZpqkIKVIrWwNWw141T+6IdbtfRNKRe0MgFf1EOsATSf4F2pHTHI/D
         Rqa8NUBOjhX5eAQ35KJuZRBqAcoV+8V9ZYA8k1RToFABGz9kqq0WXR742CdHSVBuvTtU
         fTooGdHoNlmzyB1uTV5KQWMsNIJNy/07Td/K+Ybb2TsujaWlg9A4AzfYVuS7dFc6whc5
         j6xqp9DIVLhBkjsiNAbsAoEVfHv9uvnoBE29Plcqux1vh8M4kFPG6+p00iRu+KK3XioB
         iSD8OHZPJOrOMYvnEGR1pr/JpTv/V5ZyNM/l99Tg70vcirUbYT79WcIZ5sIOBam9+y5H
         xs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErfaclmgSuY2taH4Itt0ooytROATSvud8f5aTV69WAo=;
        b=kjNscKqFAA+XuCPxj6kRI/S2W+BOrFsY2Rq163J6kP40B3UYZEC6BTnh4DrBdsOOMj
         quBbaO/HMeft1QEaF75brU2xzRBm2Pf0eoK87cGg2NNzaiEebEGgkzVvDgrGYWZ3p94p
         MrIHXoY2aRjjhZ9LBhks7+eeChJ5mg+75yhuSZBExZd5C5gL3WYryj/eG+lP4I5vP4aW
         5QntjAbGdlFOrEZQ+bymLc900hzygLnr0Ow8Ms86r12thiYSKGj02kZhAlJX3YzSSndf
         Dz2DySskjG4XD1gl6KhlGeReIWMHYwIGF1S+bv0JKd5aHxwohGs7Gc6T2QUgCIK7Sv6k
         tt5A==
X-Gm-Message-State: AOAM533KPXgKIHPl3Je0zWwyoanx66gd7bW9L0IITO2+M7jJA0sHie7E
        400z4kKG9rLvvt1hkd4FaDQwK2avyjxfK5Gzfg4teg==
X-Google-Smtp-Source: ABdhPJyqqn+qBYLXGh+Gk9tSU5NT2C+mk4vCK0k7r7g7Pyp2gdvaAHueG38jfDUK6CL/bEoG9o6DUA==
X-Received: by 2002:a17:902:a5ca:b029:ef:ac0a:f00f with SMTP id t10-20020a170902a5cab02900efac0af00fmr4995222plq.22.1620995687121;
        Fri, 14 May 2021 05:34:47 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.114])
        by smtp.gmail.com with ESMTPSA id g8sm4071337pfo.85.2021.05.14.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:34:46 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: [PATCH v2] misc/uss720: fix memory leak in uss720_probe
Date:   Fri, 14 May 2021 20:34:25 +0800
Message-Id: <20210514123425.6345-1-mudongliangabcd@gmail.com>
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
Fixes: 0f36163d3abe ("usb: fix uss720 schedule with interrupts off")
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

