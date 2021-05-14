Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C43809CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhENMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhENMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:45:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4FC061574;
        Fri, 14 May 2021 05:44:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so1597619pjy.3;
        Fri, 14 May 2021 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8wnTZS8xGnunoEqDK+VmTiQ9SGnjytTdHVp5eoUWD8=;
        b=eU9QK+9k/OBz5Ry2xpy6zbkUV9zrjTU44sTuHzUBci0XQGVsvCGR6pdtHeBZeOqXDm
         gt3WHEo3muwu4iE7pjHaC0/rCX2D8RoZQjoVOJKuUdtQ3I2aflBFo1kH3B5Vszrgx/M/
         V63+UFoJIXZ4wqN66Y9QuPTVlhqqkaZ84sMZnU6d3khs71f/2BgMxzV07IC5O/xsnbHB
         siBxFBrnyenPHT8W3rD1u9RAwt6R5oNbfHRZyntFCsfL4LGkS/Se4FwzC12Hxtsq8ABU
         5W1s2bFJu6rFdYSVjQN+02YX4UvAkJ2e6MpKItiwqPZQ97jvzZqr8lE0yosptydTwL3X
         YSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8wnTZS8xGnunoEqDK+VmTiQ9SGnjytTdHVp5eoUWD8=;
        b=Eng5RxBx8vL0fIb3wKAQLGEevsYyvAZqldLhsI+dJbq9vW3kTKGxdPW1qO9E075Ijy
         DyyYOZejbELphg8BWBDfBXitlof6pQd8JvyqPHYPyXDJjYU9PDBV1N7Mm2NXW8e5n6cN
         YJgRwMU3lPLWCYvEc0akzejTTd7tPO5QFTezlAlMFBAibcvYb235JIaQ35GhJTFrblkM
         lWBel7+TaTdla6vEe75iVgWB1Bq4Q/GfUAQzNhKyyx5Y27EYO4ETV0W4K9cjNonUoy9s
         3H2pPX03tlaxFtooPa4v5w/Q8vkVnBX21iKxitnF4C8HdDWH+FgCm/Nq10YvcqNxYtOQ
         oR0A==
X-Gm-Message-State: AOAM530sOaO5g24s2fSRj5jeArtywOdd2Ex95diSbHfseooJkieEQry9
        XMeUX+cv4gHTfhNgxdZhojE=
X-Google-Smtp-Source: ABdhPJw8FZkDOL5iw/ap10207hoazLUg8ROSyEzmxmJoLGyHdP+ZhTkvl7N/R5luv7fO5ilWbNBFMA==
X-Received: by 2002:a17:902:8ec9:b029:ef:5a88:e7cf with SMTP id x9-20020a1709028ec9b02900ef5a88e7cfmr19258310plo.48.1620996247777;
        Fri, 14 May 2021 05:44:07 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.114])
        by smtp.gmail.com with ESMTPSA id i197sm4131784pgc.13.2021.05.14.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:44:07 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: [PATCH v3] misc/uss720: fix memory leak in uss720_probe
Date:   Fri, 14 May 2021 20:43:48 +0800
Message-Id: <20210514124348.6587-1-mudongliangabcd@gmail.com>
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
v1->v2: add the Fixes tag
v2->v3: add changes for different versions of the patch

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

