Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8401436ACC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDZHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:18:01 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:43716 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhDZHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:17:55 -0400
Received: by mail-il1-f198.google.com with SMTP id l7-20020a9229070000b0290164314f61f5so27255712ilg.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aZoDBeOoD4HH+wnQuUDnZ6oaHuFcciPpeTQUoAg8opQ=;
        b=oXHPeYfQOqSuPhTpiIIbkm01NN5daVLYr7bc4duqW2+aI6Ds8BmWLXWAkjDmer2eN1
         zsC04EXsBc07cEfHFD+w04RE+ua10DqTd6dHMYWCRrUyt3urdnzEeSoPooXgk/aJFNbR
         tAQUFbxLAifDxHS6J/aiwLZ6oIfSbFRzlDxbx6EqE9es5oDetJnE2PtlWvWAOIo1dQsV
         +6kt8GeocyIc7296Sf4Vg6gSqs4mArGihAYymgrr+bLUkZZpuKwGjt7Fc+1PWmx3nI42
         9qFgD96+ypmER/eBmpHqkBT4TcvRI+3gLHq/Zc+mKDkdRAWjjL2xBUIvjB0/KqwptmLG
         2VZQ==
X-Gm-Message-State: AOAM533osS6wlZc6wPStO34UrccBFDUrIMXrJ5V+FhGgMf+PwQeoGWDL
        wc0jqR8DoLFq2Sp3bi9bB0j7uneT+OgOnQHLjRDoUiG8aplg
X-Google-Smtp-Source: ABdhPJyWVYJl/tvpehfpgjUiEeAuUue2OwpCuQRuYiBfz2+ofRjTq3wtsND6IIxj8EOTova385M12ftqWQvthxZ99JMhvUSJupuo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:120e:: with SMTP id a14mr12659253ilq.273.1619421434264;
 Mon, 26 Apr 2021 00:17:14 -0700 (PDT)
Date:   Mon, 26 Apr 2021 00:17:14 -0700
In-Reply-To: <000000000000174a1c05bfd45183@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054c19f05c0daef75@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in rhashtable_free_and_destroy
 (2)
From:   syzbot <syzbot+860268315ba86ea6b96b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f4ad9e4 Linux 5.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e92c5dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39164acdef826e06
dashboard link: https://syzkaller.appspot.com/bug?extid=860268315ba86ea6b96b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13438cb9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d37705d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+860268315ba86ea6b96b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:70 [inline]
BUG: KASAN: null-ptr-deref in try_to_grab_pending.part.0+0x26/0x770 kernel/workqueue.c:1257
Write of size 8 at addr 0000000000000088 by task kworker/0:0/5

CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events cfg80211_destroy_iface_wk
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:403 [inline]
 kasan_report.cold+0x5f/0xd8 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:70 [inline]
 try_to_grab_pending.part.0+0x26/0x770 kernel/workqueue.c:1257
 try_to_grab_pending+0xa1/0xd0 kernel/workqueue.c:1310
 __cancel_work_timer+0xa6/0x570 kernel/workqueue.c:3098
 rhashtable_free_and_destroy+0x2b/0x920 lib/rhashtable.c:1137
 mesh_table_free net/mac80211/mesh_pathtbl.c:70 [inline]
 mesh_pathtbl_unregister+0x42/0xa0 net/mac80211/mesh_pathtbl.c:812
 ieee80211_teardown_sdata+0x216/0x2d0 net/mac80211/iface.c:691
 unregister_netdevice_many+0xc4c/0x1760 net/core/dev.c:10953
 unregister_netdevice_queue+0x2dd/0x3c0 net/core/dev.c:10870
 unregister_netdevice include/linux/netdevice.h:2884 [inline]
 _cfg80211_unregister_wdev+0x485/0x740 net/wireless/core.c:1127
 ieee80211_if_remove+0x1df/0x300 net/mac80211/iface.c:2020
 ieee80211_del_iface+0x12/0x20 net/mac80211/cfg.c:144
 rdev_del_virtual_intf net/wireless/rdev-ops.h:57 [inline]
 cfg80211_destroy_ifaces+0x223/0x770 net/wireless/core.c:341
 cfg80211_destroy_iface_wk+0x2c/0x40 net/wireless/core.c:354
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
==================================================================

