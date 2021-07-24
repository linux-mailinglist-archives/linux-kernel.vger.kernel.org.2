Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CFE3D4A60
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhGXVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:15:49 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33759 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:15:48 -0400
Received: by mail-io1-f70.google.com with SMTP id l9-20020a6b70090000b02904df6556dad4so4931132ioc.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9iYrqGAAdxwKje2sxdJy/PYqYhRehawHyrqfWvqBrbQ=;
        b=hPRFcnYb1SEADonYc6ekiqgFXgVb10qFr6cAo90GagvF4m9YTwIxCl3a4oBOC1PhnQ
         F2IKg38xBHpcJdSX/4oPEZw5EW2X3NLrNsbMn+R02NMOSDkqbH94ZjXyCR/ZpDhdG7Ah
         FSJiwNKDXT8jWJOh1wG0kCSwYri13AqCxB5mWzS0MN5j1Sj/nKRe+Q/a1niou1maGbre
         +6YAUXm1pjp2g4wY6nCwZryw+yki+C4FDqLMbL3YP1umeEtHUVWLsZHRlaFE/C+SL3P+
         MJ0//o2jai6Z+8LxySbx1pgHq3b06rI8kVRicubwJotFhNQWPexF6clkh0dIQAVB74S4
         uKBQ==
X-Gm-Message-State: AOAM530D6Ns8Vbo9hXZPB0dzAayJfXoOQF6BLqgQwpCXPlcmRx/VFVXI
        Gu4DMKDmW6puqKFV1zGo2Pmn3K0mt0tL6I2WE/gGeRbm4eQS
X-Google-Smtp-Source: ABdhPJytZBrtn3ZR1FVixAo+62Fhqm0xl9opg0g3YFB9i9+eoO2FLjuusJUb4QDuVZ5+jtaasbBzIsxBFVUAoblr18aBLgDztBm8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35aa:: with SMTP id v42mr4547689jal.21.1627163780048;
 Sat, 24 Jul 2021 14:56:20 -0700 (PDT)
Date:   Sat, 24 Jul 2021 14:56:20 -0700
In-Reply-To: <0000000000003a41f705a9c74dfa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019ea4305c7e597d4@google.com>
Subject: Re: [syzbot] INFO: task hung in usb_register_dev
From:   syzbot <syzbot+e761775e8f4a28711f19@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, charu@tickmarks.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    8e6cb5d27e82 usb: dwc3: dwc3-qcom: Fix typo in the dwc3 vb..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=147c6fea300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db8b503c237253ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e761775e8f4a28711f19
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144874dc300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f8aa92300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e761775e8f4a28711f19@syzkaller.appspotmail.com

INFO: task kworker/0:1:7 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:25496 pid:    7 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/0:2:2618 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:25496 pid: 2618 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/0:0:4391 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24504 pid: 4391 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/0:3:4397 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:25128 pid: 4397 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/0:4:4401 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:24368 pid: 4401 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/0:5:4403 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:25416 pid: 4403 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 rwsem_down_write_slowpath+0x8e3/0x1190 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
 sisusb_probe+0x21c/0xbe3 drivers/usb/misc/sisusbvga/sisusb.c:3038
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc2f/0x2180 drivers/base/core.c:3352
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2559
 hub_port_connect drivers/usb/core/hub.c:5300 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x15b0 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor259:4947 blocked for more than 146 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor259 state:D stack:28160 pid: 4947 ppid:  4378 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:6078
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x786/0x1060 kernel/locking/mutex.c:1104
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c3/0x1110 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_openat fs/open.c:1236 [inline]
 __se_sys_openat fs/open.c:1231 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1231
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x403ce7
RSP: 002b:00007fffe48c13f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 0000000000403ce7
RDX: 0000000000000002 RSI: 00007fffe48c1470 RDI: 00000000ffffff9c
RBP: 00007fffe48c1470 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffe48c150c R14: 00007fffe48c1520 R15: 00007fffe48c1510
INFO: task syz-executor259:4950 blocked for more than 146 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor259 state:D stack:27640 pid: 4950 ppid:  4382 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:6078
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x786/0x1060 kernel/locking/mutex.c:1104
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c3/0x1110 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_openat fs/open.c:1236 [inline]
 __se_sys_openat fs/open.c:1231 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1231
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x403ce7
RSP: 002b:00007fffe48c13f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 0000000000403ce7
RDX: 0000000000000002 RSI: 00007fffe48c1470 RDI: 00000000ffffff9c
RBP: 00007fffe48c1470 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffe48c150c R14: 00007fffe48c1520 R15: 00007fffe48c1510
INFO: task syz-executor259:4952 blocked for more than 146 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor259 state:D stack:28848 pid: 4952 ppid:  4383 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x941/0x22b0 kernel/sched/core.c:5940
 schedule+0xcf/0x270 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:6078
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x786/0x1060 kernel/locking/mutex.c:1104
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c3/0x1110 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_openat fs/open.c:1236 [inline]
 __se_sys_openat fs/open.c:1231 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1231
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x403ce7
RSP: 002b:00007fffe48c13f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 0000000000403ce7
RDX: 0000000000000002 RSI: 00007fffe48c1470 RDI: 00000000ffffff9c
RBP: 00007fffe48c1470 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffe48c150c R14: 00007fffe48c1520 R15: 00007fffe48c1510

Showing all locks held in the system:
6 locks held by kworker/0:1/7:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc9000007fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f832220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f832220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b06e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b06e220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff8881156461a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff8881156461a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
1 lock held by khungtaskd/1275:
 #0: ffffffff8767e500 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x269 kernel/locking/lockdep.c:6446
6 locks held by kworker/0:2/2618:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc90007877db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f8f7220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f8f7220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b06f220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b06f220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff888119e851a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff888119e851a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
2 locks held by in:imklog/4301:
6 locks held by kworker/0:0/4391:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc900002c7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f897220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f897220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b178220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b178220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff888114a4d1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff888114a4d1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/0:3/4397:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc900002b7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f96f220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f96f220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b179220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b179220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff888119e501a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff888119e501a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/0:4/4401:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc90000347db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f907220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f907220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b17a220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b17a220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff8881148fc1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff8881148fc1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/0:5/4403:
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff88810a489538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15b0 kernel/workqueue.c:2247
 #1: ffffc90000337db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15b0 kernel/workqueue.c:2251
 #2: ffff88810f91f220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #2: ffff88810f91f220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5614
 #3: ffff88811b17b220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #3: ffff88811b17b220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #4: ffff888119e821a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #4: ffff888119e821a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:940
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
2 locks held by syz-executor259/4944:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88811b1cf8d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor259/4947:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88811b1cf8d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor259/4950:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88811b1cf8d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor259/4952:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88811b1cf8d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
1 lock held by syz-executor259/4971:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
1 lock held by syz-executor259/4972:
 #0: ffffffff87f79730 (minor_rwsem){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1275 Comm: khungtaskd Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x46/0xe0 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1da/0x200 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcf4/0xf90 kernel/hung_task.c:295
 kthread+0x3c0/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553

