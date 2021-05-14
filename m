Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB9380992
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhENMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbhENMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:33:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D14C061574;
        Fri, 14 May 2021 05:32:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so1282255pjo.0;
        Fri, 14 May 2021 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErfaclmgSuY2taH4Itt0ooytROATSvud8f5aTV69WAo=;
        b=AE8IgbEoqds1qWkqppD3M7OpxY161mIGNY13sgGhyiRq9OV/ulCons6vizDU5abkZl
         QgmSYl0W6ARIJV6+SZqf+FliUxbeXXZ8PzPMqwgtA3P3FSItY3Z/qs6x0uLOtA+PKY5K
         aiYFpRPdNibCNoTBbS3ABFVtERd/39rFvCwy/zyrZ1irneM8AhfesVx/zPs2YpYTZ0pp
         /+VEzfL7mqtNCykkJCxou+Lw7UQ8/VUA0SNqtnpWUT5qoJozPYzArVtf3jN0Ks+RYY6T
         ugTbHRVsTYCBMMoceF2an+3rjDBAVbvU/TfoC3XcH+Zt6EY4g07OCcN4P05PTqJgDO8S
         7lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErfaclmgSuY2taH4Itt0ooytROATSvud8f5aTV69WAo=;
        b=m/P0YBoxNCYj5fmC2fUkEheRylqcnGR7/yZZ3R6fuob9F1wdg4KnKedppLCIDxs0w3
         alf9/7IXzYxJGPDY3XDa4YVQIL9O3e0sqdTF2CfFHkGc+ZxDFxr3r3ACyi8Deb6kY6VR
         SvacVy/xgJKw32MEooWEWtSkQ8PIk+r9+n8xHxgx24AVjCYCwFEoaFz+2vRe4Y0fDwN9
         P8vii8P0GER5Bq+i+l/uUB6WZayXuvk7CKIBQnviP5iQfURogeg6XFmqiRQj6HriwxmV
         B9FxkpdMZ4AfK9oUb8fJB0NaA5qo0V75ELWZzmWiW74AJ8tlkWZuwkxQKSwM3NJFmBh5
         6iZQ==
X-Gm-Message-State: AOAM531waWk3TMUC3eu4N0GXjvwlXYOHqfhhjQY53zmMr8DPP1h28E9S
        39ZjAGR0dUOKppkoAK/ohYpM6mclQCwcuZ0kjP3n4Q==
X-Google-Smtp-Source: ABdhPJzK+P1R4mISmjZlHZsoNN2G9ntOEmwmyNM6uUuYkflaeCeff3aXTD8ZafGBC7TvXLp4926Wkg==
X-Received: by 2002:a17:90a:8b12:: with SMTP id y18mr49906560pjn.153.1620995538446;
        Fri, 14 May 2021 05:32:18 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.114])
        by smtp.gmail.com with ESMTPSA id ms2sm4719485pjb.8.2021.05.14.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:32:17 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: [PATCH] misc/uss720: fix memory leak in uss720_probe
Date:   Fri, 14 May 2021 20:31:56 +0800
Message-Id: <20210514123156.6193-1-mudongliangabcd@gmail.com>
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

