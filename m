Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75C6457DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhKTMUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 07:20:21 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54200 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbhKTMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 07:20:20 -0500
Received: by mail-io1-f70.google.com with SMTP id a12-20020a056602148c00b005e7052734adso7459577iow.20
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 04:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xyq0QSySE68UkDTiuAsAsDYEDsVRUJX9riQ2BCR/zGw=;
        b=5lxN9ppRW/G+ea0QnwCCqMbloHq5W9QYwDEd0QiZSrRp3JYCvnfeg/NaoXjJTmoaq3
         XlfdD46t0Q7z6IoeijEu95Q3a8951PMcKCI081oJcDJ0A0tV1YI/9SbxcRTLnDqwPGTd
         KHySmIcqae4TXVgfbIYx5sx3HxgQhQoqZ8aGYsmeLQNT+zsLRcAsVoQKX5YfU9EQi8mO
         6OH4Re+KOkmkO+CV8YjC++LI0o6q+5m/E8FQ/K1as8/7DGHwH8oppNO0d7+3znsZxaK2
         3qGwriGzg5Ke98AKPg9A0eqUrpTnl1bg6RIhcs4tZ5tRy3mdpb5Zo11CjYDrtp0Xhih1
         iuDw==
X-Gm-Message-State: AOAM533xyhAz4Y4TKV2o80zl9A267AS4qYbjwnKXt1EoQ98YrmvaMUaH
        Q0gnTRDWNMf5o2BOg3EdlSSSJwJf9tHxi/7xa7Y2DwUWPL8A
X-Google-Smtp-Source: ABdhPJzubzlF6y5hnHTddFIV7WJKraWN6owNSW0KHHe9xN2dkwpkBWsLzgLMa0S3pfC/vdxvR0GCXuMcRWI5pHagan8UKg5BRd35
MIME-Version: 1.0
X-Received: by 2002:a05:6602:134d:: with SMTP id i13mr11145325iov.164.1637410636761;
 Sat, 20 Nov 2021 04:17:16 -0800 (PST)
Date:   Sat, 20 Nov 2021 04:17:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b12b805d1375f4a@google.com>
Subject: [syzbot] KMSAN: uninit-value in ieee80211_sta_tx_notify (2)
From:   syzbot <syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    412af9cd936d ioremap.c: move an #include around
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14d990eeb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
dashboard link: https://syzkaller.appspot.com/bug?extid=614e82b88a1a4973e534
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+614e82b88a1a4973e534@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
 ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
 ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_tx_status_ext+0x11f0/0x54d0 net/mac80211/status.c:1147
 ieee80211_tx_status+0x221/0x270 net/mac80211/status.c:1090
 ieee80211_tasklet_handler+0x30d/0x380 net/mac80211/main.c:239
 tasklet_action_common+0x5dd/0x810 kernel/softirq.c:783
 tasklet_action+0x30/0x40 kernel/softirq.c:804
 __do_softirq+0x1c9/0x6ec kernel/softirq.c:558
 do_softirq+0x120/0x1c0 kernel/softirq.c:459
 __local_bh_enable_ip+0xab/0xb0 kernel/softirq.c:383
 local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
 __ieee80211_tx_skb_tid_band+0x297/0x3a0 net/mac80211/tx.c:5672
 ieee80211_tx_skb_tid net/mac80211/ieee80211_i.h:2185 [inline]
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2194 [inline]
 ieee80211_send_nullfunc+0x535/0x630 net/mac80211/mlme.c:1095
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3227 [inline]
 __kmalloc_node_track_caller+0xa3b/0x13c0 mm/slub.c:4962
 kmalloc_reserve net/core/skbuff.c:356 [inline]
 __alloc_skb+0x4db/0xe40 net/core/skbuff.c:427
 __netdev_alloc_skb+0x48f/0x840 net/core/skbuff.c:494
 netdev_alloc_skb include/linux/skbuff.h:2877 [inline]
 dev_alloc_skb include/linux/skbuff.h:2890 [inline]
 ieee80211_nullfunc_get+0x2c1/0x870 net/mac80211/tx.c:5386
 ieee80211_send_nullfunc+0x132/0x630 net/mac80211/mlme.c:1077
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
=====================================================
=====================================================
BUG: KMSAN: uninit-value in ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
 ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
 ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_tx_status_ext+0x11f0/0x54d0 net/mac80211/status.c:1147
 ieee80211_tx_status+0x221/0x270 net/mac80211/status.c:1090
 ieee80211_tasklet_handler+0x30d/0x380 net/mac80211/main.c:239
 tasklet_action_common+0x5dd/0x810 kernel/softirq.c:783
 tasklet_action+0x30/0x40 kernel/softirq.c:804
 __do_softirq+0x1c9/0x6ec kernel/softirq.c:558
 do_softirq+0x120/0x1c0 kernel/softirq.c:459
 __local_bh_enable_ip+0xab/0xb0 kernel/softirq.c:383
 local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
 __ieee80211_tx_skb_tid_band+0x297/0x3a0 net/mac80211/tx.c:5672
 ieee80211_tx_skb_tid net/mac80211/ieee80211_i.h:2185 [inline]
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2194 [inline]
 ieee80211_send_nullfunc+0x535/0x630 net/mac80211/mlme.c:1095
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3227 [inline]
 __kmalloc_node_track_caller+0xa3b/0x13c0 mm/slub.c:4962
 kmalloc_reserve net/core/skbuff.c:356 [inline]
 __alloc_skb+0x4db/0xe40 net/core/skbuff.c:427
 __netdev_alloc_skb+0x48f/0x840 net/core/skbuff.c:494
 netdev_alloc_skb include/linux/skbuff.h:2877 [inline]
 dev_alloc_skb include/linux/skbuff.h:2890 [inline]
 ieee80211_nullfunc_get+0x2c1/0x870 net/mac80211/tx.c:5386
 ieee80211_send_nullfunc+0x132/0x630 net/mac80211/mlme.c:1077
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
=====================================================
=====================================================
BUG: KMSAN: uninit-value in ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
BUG: KMSAN: uninit-value in ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_ac_from_tid net/mac80211/ieee80211_i.h:2216 [inline]
 ieee80211_sta_tx_wmm_ac_notify net/mac80211/mlme.c:2450 [inline]
 ieee80211_sta_tx_notify+0x3b8/0x950 net/mac80211/mlme.c:2482
 ieee80211_tx_status_ext+0x11f0/0x54d0 net/mac80211/status.c:1147
 ieee80211_tx_status+0x221/0x270 net/mac80211/status.c:1090
 ieee80211_tasklet_handler+0x30d/0x380 net/mac80211/main.c:239
 tasklet_action_common+0x5dd/0x810 kernel/softirq.c:783
 tasklet_action+0x30/0x40 kernel/softirq.c:804
 __do_softirq+0x1c9/0x6ec kernel/softirq.c:558
 do_softirq+0x120/0x1c0 kernel/softirq.c:459
 __local_bh_enable_ip+0xab/0xb0 kernel/softirq.c:383
 local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
 __ieee80211_tx_skb_tid_band+0x297/0x3a0 net/mac80211/tx.c:5672
 ieee80211_tx_skb_tid net/mac80211/ieee80211_i.h:2185 [inline]
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2194 [inline]
 ieee80211_send_nullfunc+0x535/0x630 net/mac80211/mlme.c:1095
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3227 [inline]
 __kmalloc_node_track_caller+0xa3b/0x13c0 mm/slub.c:4962
 kmalloc_reserve net/core/skbuff.c:356 [inline]
 __alloc_skb+0x4db/0xe40 net/core/skbuff.c:427
 __netdev_alloc_skb+0x48f/0x840 net/core/skbuff.c:494
 netdev_alloc_skb include/linux/skbuff.h:2877 [inline]
 dev_alloc_skb include/linux/skbuff.h:2890 [inline]
 ieee80211_nullfunc_get+0x2c1/0x870 net/mac80211/tx.c:5386
 ieee80211_send_nullfunc+0x132/0x630 net/mac80211/mlme.c:1077
 ieee80211_mgd_probe_ap_send+0x6e7/0xa30 net/mac80211/mlme.c:2544
 ieee80211_mgd_probe_ap+0x4ee/0x6c0 net/mac80211/mlme.c:2620
 ieee80211_beacon_connection_loss_work+0x1a3/0x420 net/mac80211/mlme.c:2753
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
