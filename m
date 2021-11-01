Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953524415AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKAI4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:56:46 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49738 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKAI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:56:45 -0400
Received: by mail-il1-f197.google.com with SMTP id e10-20020a92194a000000b00258acd999afso9633208ilm.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=caNXgt7Kc1qn8nnLpDYnPHU93otN4N3yrFwscbLo5q0=;
        b=VYvknEME7araRHGT6sgzIB0iMRejKunSNK1wzUNvanbI3RdGt/Y3c1m4FKLDzvwQdF
         jiN8GROH19A8CTCs3PJrYmNfP1G16D1xbb3fDyPF89hsSe/pC+JlWrcoX8vGxEJlJdOk
         UgO8JG6Qurmo2ip4B3/I6fl5lj+8ZNAHuDiWrlRX7eyuTZ1aC6gdpYe90xPpK4tRCLGq
         E01+FqNJHfOei0xpIypHbUgCY8YCLm3SPsgx+LTmZH7xF/NmyOD/l5auFCtXBskH6ol+
         dQEvAWDIBkJLKZ2/Q9O+YtZVUj6xhgCuQgTrG5SyY+rMTNZWxEw+gfwjdQMIj7aPpzP+
         gaTw==
X-Gm-Message-State: AOAM533VtEQNyj4Otw1xVBv1nYt5aqQCc7JiU7k2a5A3oidhZzHItWy+
        00dYO14acuwWrvr1GUvCU9k/qQ2xyqAof7+7XNH8+EMyYtWz
X-Google-Smtp-Source: ABdhPJwJnLVFdxIsT5DFIZuJgKYh0xI/0gCd9f3p4kkpCj491wpUEzR0T1McGTLEQHmLtIs8Y3m3f0kfi6SO7QW5O+MmpP4JGKC+
MIME-Version: 1.0
X-Received: by 2002:a6b:f614:: with SMTP id n20mr20187633ioh.134.1635756852197;
 Mon, 01 Nov 2021 01:54:12 -0700 (PDT)
Date:   Mon, 01 Nov 2021 01:54:12 -0700
In-Reply-To: <000000000000b4786c05cfa94612@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d3d6905cfb652d5@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in snd_seq_write (2)
From:   syzbot <syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, pmladek@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1a7243ca4074beed97b68d7235a6e34862fc2cd6
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue Nov 10 11:38:47 2020 +0000

    kthread: Move prio/affinite change into the newly created thread

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b30e6ab00000
start commit:   bdcc9f6a5682 Add linux-next specific files for 20211029
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b30e6ab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b30e6ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b504bcb4c507265
dashboard link: https://syzkaller.appspot.com/bug?extid=bb950e68b400ab4f65f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e913bab00000

Reported-by: syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com
Fixes: 1a7243ca4074 ("kthread: Move prio/affinite change into the newly created thread")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
