Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E53FFBBB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbhICISb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:18:31 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39782 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348215AbhICIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:18:27 -0400
Received: by mail-il1-f198.google.com with SMTP id y8-20020a92c748000000b00224811cb945so3029450ilp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tfvtLiUT4IaCn9QAU0VwLMarYZMVolpROY2rWNmu4G0=;
        b=hA91rVFwfUJfCr276RxLipbyXxZMesyTb6Zoq8/6WZX7km0lhu7L8CwsubCzYnt13A
         uNIcfbHA/fP4SISly6BnGSuq0Btnoyuf7Ce7zIQkbHOjzKuvNicPLceCtELW2WVxRXyv
         uRzllmd0dd8sUu1CGIy/MisLtBc8HVHXmuJyt7j5DOXos5oaBjf50v8eoMj9mSVwWEcO
         5MZEgrUVrsygB9Xc2Ukn4VgBiW5O/skzW4TYA980RSJurCw4MRDHiZadRt98gfEii1Zd
         BE2DzgLbudTs+ugPlKFzptrpT/TgffuIkSqTxGx0+D6OMcPYhN6wsXYHO5vYndFDs5lU
         8TjA==
X-Gm-Message-State: AOAM533PTJIkF5cOy3FiWkLF5XaIULxh+3gyPvIiSrR6v9yg/1gYVHJB
        KxrO47vcpGL2G7sXxXyb43VT1qivgVTS97lyIvfoNI5bsmPp
X-Google-Smtp-Source: ABdhPJzfz4gaPKUc7jyEWIObv1NCfiEng1vK8nMopIe/KDvv1fazo9sDXzFEtbVjPakjBTjUuTGWYYPaVdDDS6wFn3vVjeKgmy0Y
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:805:: with SMTP id u5mr1658101ilm.223.1630657047580;
 Fri, 03 Sep 2021 01:17:27 -0700 (PDT)
Date:   Fri, 03 Sep 2021 01:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001256e405cb12eed9@google.com>
Subject: [syzbot] INFO: task can't die in mark_held_locks
From:   syzbot <syzbot+fe9fdd59a80d52730e2a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e63226c7228 Add linux-next specific files for 20210827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a143a9300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c03a8fdabc6b3ae
dashboard link: https://syzkaller.appspot.com/bug?extid=fe9fdd59a80d52730e2a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe9fdd59a80d52730e2a@syzkaller.appspotmail.com

INFO: task syz-executor.1:6384 can't die for more than 143 seconds.
task:syz-executor.1  state:R  running task     stack:27752 pid: 6384 ppid:  6576 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4955 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6302
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:4194

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8b97fbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/6244:
 #0: ffff888024b2dc70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
3 locks held by kworker/1:5/8059:
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:474 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1319 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1622 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x236/0x26f0 kernel/sched/core.c:6216
 #1: ffff8880b9d1f9c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x39d/0x480 kernel/sched/psi.c:880
 #2: ffffffff902c2780 (&ssp->srcu_gp_mutex){+.+.}-{3:3}, at: srcu_advance_state kernel/rcu/srcutree.c:1177 [inline]
 #2: ffffffff902c2780 (&ssp->srcu_gp_mutex){+.+.}-{3:3}, at: process_srcu+0x31/0xec0 kernel/rcu/srcutree.c:1325
3 locks held by systemd-udevd/10966:
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:474 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1319 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1622 [inline]
 #0: ffff8880b9d31a98 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x236/0x26f0 kernel/sched/core.c:6216
 #1: ffff8880b9d1f9c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x39d/0x480 kernel/sched/psi.c:880
 #2: ffffffff8c142c18 (tomoyo_ss){....}-{0:0}, at: tomoyo_path2_perm+0x20a/0x6b0 security/tomoyo/file.c:952
1 lock held by systemd-udevd/10995:
1 lock held by systemd-udevd/11008:
 #0: ffff88807ee30460 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3339 [inline]
 #0: ffff88807ee30460 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x25c9/0x2740 fs/namei.c:3556
4 locks held by kworker/u4:8/20266:
1 lock held by syz-executor.1/6384:

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
