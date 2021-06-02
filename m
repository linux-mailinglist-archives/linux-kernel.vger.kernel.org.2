Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D139901F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFBQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:39:20 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39616 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhFBQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:39:10 -0400
Received: by mail-io1-f69.google.com with SMTP id b1-20020a05660214c1b02904783f688a11so1952494iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cF7ayDf+Ts1jZfgvnRObEnmRdhXet0IgINJELNWfuiE=;
        b=ZMG/AgXRWuTgqUdt3jQoupWDdME0htbsCZSkl8/vS41MeZ+91G64/LdQR6sXkl/Cul
         qcpwvizriupRuBMZNqYfpMDiXnDK2tSbiLmZ0gQlN+q+9UqQA8CP8q2FWAUFQrffAPR7
         eKo0M17vydbCZdN3LVkKuGOq3qUXaXvd3IsBOkmGePQa/L16oKtod/qOkXReLjf2srHc
         +2zL8VdkDeAHP1aE5MK9LcJCLBQe6JbLtNJRZ5+osPuRw/zCLUo3coeQ14LTOuiFwMhz
         FB+0DzVMI5C/pQYQ2wo8QSsPQXpv2rVqNPUpyJGE8OaGLsmvz/cFFm6R1dmwJeMFG0Ed
         1yvw==
X-Gm-Message-State: AOAM533gA84t7pYqRAqAUxslEUVqMGuIO4EKHfxZyPH1Pghie7Im+bdl
        XfwLTuXEvpzGI7pcZFM1zCA/mcwDS/mpVPdNuJghTcmKxH0W
X-Google-Smtp-Source: ABdhPJx4bmf/t6/ZLYN8JvIKGX3pFznCArM1dR0UnyPm7FWAtUvZa2UnDBPnH7PIzp6I9y2U0dOSOudbBfff98P6P4JPmEntn53R
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2285:: with SMTP id y5mr15870114jas.19.1622651847454;
 Wed, 02 Jun 2021 09:37:27 -0700 (PDT)
Date:   Wed, 02 Jun 2021 09:37:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f632ba05c3cb12c2@google.com>
Subject: [syzbot] memory leak in cfg80211_inform_single_bss_frame_data
From:   syzbot <syzbot+7a942657a255a9d9b18a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b90e90f4 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bd382fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8c23f7848d1c696
dashboard link: https://syzkaller.appspot.com/bug?extid=7a942657a255a9d9b18a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131ce883d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a942657a255a9d9b18a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888119584780 (size 96):
  comm "kworker/u4:0", pid 8670, jiffies 4295047890 (age 8.810s)
  hex dump (first 32 bytes):
    fd f0 0a 3d 90 c3 05 00 00 00 00 00 00 00 00 00  ...=............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff83e52709>] cfg80211_inform_single_bss_frame_data+0x139/0x640 net/wireless/scan.c:2376
    [<ffffffff83e52c5b>] cfg80211_inform_bss_frame_data+0x4b/0x470 net/wireless/scan.c:2437
    [<ffffffff83ef1d43>] ieee80211_bss_info_update+0x183/0x470 net/mac80211/scan.c:190
    [<ffffffff83eff43b>] ieee80211_rx_bss_info net/mac80211/ibss.c:1126 [inline]
    [<ffffffff83eff43b>] ieee80211_rx_mgmt_probe_beacon+0x60b/0x950 net/mac80211/ibss.c:1615
    [<ffffffff83effe8c>] ieee80211_ibss_rx_queued_mgmt+0x23c/0x6e0 net/mac80211/ibss.c:1642
    [<ffffffff83f01d76>] ieee80211_iface_work+0x476/0x5f0 net/mac80211/iface.c:1437
    [<ffffffff8125f9d9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2276
    [<ffffffff812602c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff81267bf8>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888119584680 (size 96):
  comm "kworker/u4:0", pid 8670, jiffies 4295048012 (age 7.590s)
  hex dump (first 32 bytes):
    f4 b0 1d 3d 90 c3 05 00 00 00 00 00 00 00 00 00  ...=............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff83e52709>] cfg80211_inform_single_bss_frame_data+0x139/0x640 net/wireless/scan.c:2376
    [<ffffffff83e52c5b>] cfg80211_inform_bss_frame_data+0x4b/0x470 net/wireless/scan.c:2437
    [<ffffffff83ef1d43>] ieee80211_bss_info_update+0x183/0x470 net/mac80211/scan.c:190
    [<ffffffff83eff43b>] ieee80211_rx_bss_info net/mac80211/ibss.c:1126 [inline]
    [<ffffffff83eff43b>] ieee80211_rx_mgmt_probe_beacon+0x60b/0x950 net/mac80211/ibss.c:1615
    [<ffffffff83effe8c>] ieee80211_ibss_rx_queued_mgmt+0x23c/0x6e0 net/mac80211/ibss.c:1642
    [<ffffffff83f01d76>] ieee80211_iface_work+0x476/0x5f0 net/mac80211/iface.c:1437
    [<ffffffff8125f9d9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2276
    [<ffffffff812602c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff81267bf8>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888119584400 (size 96):
  comm "kworker/u4:0", pid 8670, jiffies 4295048012 (age 7.590s)
  hex dump (first 32 bytes):
    f5 b0 1d 3d 90 c3 05 00 00 00 00 00 00 00 00 00  ...=............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff83e52709>] cfg80211_inform_single_bss_frame_data+0x139/0x640 net/wireless/scan.c:2376
    [<ffffffff83e52c5b>] cfg80211_inform_bss_frame_data+0x4b/0x470 net/wireless/scan.c:2437
    [<ffffffff83ef1d43>] ieee80211_bss_info_update+0x183/0x470 net/mac80211/scan.c:190
    [<ffffffff83eff43b>] ieee80211_rx_bss_info net/mac80211/ibss.c:1126 [inline]
    [<ffffffff83eff43b>] ieee80211_rx_mgmt_probe_beacon+0x60b/0x950 net/mac80211/ibss.c:1615
    [<ffffffff83effe8c>] ieee80211_ibss_rx_queued_mgmt+0x23c/0x6e0 net/mac80211/ibss.c:1642
    [<ffffffff83f01d76>] ieee80211_iface_work+0x476/0x5f0 net/mac80211/iface.c:1437
    [<ffffffff8125f9d9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2276
    [<ffffffff812602c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff81267bf8>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff8881196dda80 (size 96):
  comm "kworker/u4:1", pid 8689, jiffies 4295048023 (age 7.480s)
  hex dump (first 32 bytes):
    e4 40 1f 3d 90 c3 05 00 00 00 00 00 00 00 00 00  .@.=............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff83e52709>] cfg80211_inform_single_bss_frame_data+0x139/0x640 net/wireless/scan.c:2376
    [<ffffffff83e52c5b>] cfg80211_inform_bss_frame_data+0x4b/0x470 net/wireless/scan.c:2437
    [<ffffffff83ef1d43>] ieee80211_bss_info_update+0x183/0x470 net/mac80211/scan.c:190
    [<ffffffff83eff43b>] ieee80211_rx_bss_info net/mac80211/ibss.c:1126 [inline]
    [<ffffffff83eff43b>] ieee80211_rx_mgmt_probe_beacon+0x60b/0x950 net/mac80211/ibss.c:1615
    [<ffffffff83effe8c>] ieee80211_ibss_rx_queued_mgmt+0x23c/0x6e0 net/mac80211/ibss.c:1642
    [<ffffffff83f01d76>] ieee80211_iface_work+0x476/0x5f0 net/mac80211/iface.c:1437
    [<ffffffff8125f9d9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2276
    [<ffffffff812602c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff81267bf8>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
