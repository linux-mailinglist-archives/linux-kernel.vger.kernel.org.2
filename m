Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFF34D878
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhC2Tog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:44:36 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57326 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhC2ToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:44:24 -0400
Received: by mail-io1-f72.google.com with SMTP id y2so11655559ioa.23
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2jXqd5aaFNpRqFsoVJoIotG0Bi63SDagwQS5vWH17Jk=;
        b=TFFfq1ZIR/t33AYYC48KW2yWtTQogWY/djlS+pn9k6D/eZ/NHLQUC0F7+gaul9gYvt
         SdvgFRIbuTXyGgaOkevcFTkv+haB3a33E8aoO3UTMYeaJgLGrqMs3sCgSwA0CW9KkKmL
         j2dn95WvcJRp8zIE5jrBzVOPUsqm7LLe5hqK1iTsw7oki2j0UhbpQbJWCIEns39vtetf
         klL0+GWUKKZI/raCzOantB9yBEgK26rZjERRv70P5DsNx7fAKRXbCY/pgzYokTtktDX0
         txV1cu+riwxNN5xZrQR/p9lMifjFvZrLq60hYj1truR0jniFh3v62Qovftv5fJbOLHW+
         P2Cw==
X-Gm-Message-State: AOAM533aLFWlqPYrRUcd03k54R4kAASqfbXaLpT+0TRsch6aW8zctSKW
        J7ECgSmhTcxUcUx4wYAXrgmi25EGjkPGhoC7VA7OJkH5Ot9h
X-Google-Smtp-Source: ABdhPJy/ZudhkqwfnKEhdS/yKCJpkGSSCxnzBrzHksrAyg/qGBUzjTyQgd+9aCKPwglbBHyo4r30jJoQbms5ya3aikRvOeMg8+mY
MIME-Version: 1.0
X-Received: by 2002:a02:3304:: with SMTP id c4mr25517291jae.68.1617047063801;
 Mon, 29 Mar 2021 12:44:23 -0700 (PDT)
Date:   Mon, 29 Mar 2021 12:44:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2b42905beb21b3f@google.com>
Subject: [syzbot] KMSAN: uninit-value in efuse_one_byte_read
From:   syzbot <syzbot+6610740013f861b6e829@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        florian.c.schilhabel@googlemail.com, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    29ad81a1 arch/x86: add missing include to sparsemem.h
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12d4e126d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b573c14b733efb1c
dashboard link: https://syzkaller.appspot.com/bug?extid=6610740013f861b6e829
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6610740013f861b6e829@syzkaller.appspotmail.com

r8712u: register rtl8712_netdev_ops to netdev_ops
usb 2-1: r8712u: USB_SPEED_HIGH with 0 endpoints
usb 2-1: r8712u: Boot from EEPROM: Autoload OK
=====================================================
BUG: KMSAN: uninit-value in efuse_one_byte_read+0x206/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:76
CPU: 1 PID: 4662 Comm: kworker/1:3 Tainted: G        W         5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 efuse_one_byte_read+0x206/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:76
 r8712_efuse_pg_packet_read+0x29c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:245
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----data@usb_read8 created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
=====================================================
=====================================================
BUG: KMSAN: uninit-value in r8712_efuse_pg_packet_read+0x77c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:246
CPU: 1 PID: 4662 Comm: kworker/1:3 Tainted: G    B   W         5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 r8712_efuse_pg_packet_read+0x77c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:246
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 efuse_one_byte_read+0x2cd/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:86
 r8712_efuse_pg_packet_read+0x29c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:245
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----data@usb_read8 created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
=====================================================
=====================================================
BUG: KMSAN: uninit-value in r8712_efuse_pg_packet_read+0x79b/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:251
CPU: 1 PID: 4662 Comm: kworker/1:3 Tainted: G    B   W         5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 r8712_efuse_pg_packet_read+0x79b/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:251
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 efuse_one_byte_read+0x2cd/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:86
 r8712_efuse_pg_packet_read+0x29c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:245
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----data@usb_read8 created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
=====================================================
=====================================================
BUG: KMSAN: uninit-value in r8712_efuse_pg_packet_read+0xb56/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:244
CPU: 1 PID: 4662 Comm: kworker/1:3 Tainted: G    B   W         5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:120
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 r8712_efuse_pg_packet_read+0xb56/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:244
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
 efuse_one_byte_read+0x2cd/0x2e0 drivers/staging/rtl8712/rtl8712_efuse.c:86
 r8712_efuse_pg_packet_read+0x29c/0xcd0 drivers/staging/rtl8712/rtl8712_efuse.c:245
 r871xu_drv_init+0x1cfb/0x2fe0 drivers/staging/rtl8712/usb_intf.c:443
 usb_probe_interface+0xfcc/0x1520 drivers/usb/core/driver.c:396
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_set_configuration+0x3872/0x3eb0 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x317/0x570 drivers/usb/core/driver.c:293
 really_probe+0xe15/0x24d0 drivers/base/dd.c:558
 driver_probe_device+0x29d/0x3a0 drivers/base/dd.c:740
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:846
 bus_for_each_drv+0x2c8/0x3f0 drivers/base/bus.c:431
 __device_attach+0x56a/0x890 drivers/base/dd.c:914
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:961
 bus_probe_device+0x17e/0x3d0 drivers/base/bus.c:491
 device_add+0x2c15/0x31d0 drivers/base/core.c:3109
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x5b99/0x8870 drivers/usb/core/hub.c:5591
 process_one_work+0x1219/0x1fe0 kernel/workqueue.c:2275
 worker_thread+0x10ec/0x2340 kernel/workqueue.c:2421
 kthread+0x521/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----data@usb_read8 created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
