Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B93BAA3D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 22:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhGCU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 16:26:45 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37379 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhGCU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 16:26:41 -0400
Received: by mail-io1-f70.google.com with SMTP id p7-20020a6b63070000b029050017e563a6so9916401iog.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 13:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oyrJ1CYTeS6MI65QD+5aH2xTPa/Zi++jYcDRaJu7lsE=;
        b=Kk7ll2U4XZczMH9hvtZYo4nJBjyU3GmwKzdsVs1aP/tDRrYWe3vDD0JhyzmTkdq6wg
         ok5AaP2cvxeYiJyq+2Bw/IqHypbw8ipLiYKdP4lxFycv6Lh5gUo59Fnmdds88f275wAr
         4j17G2khrru6+A1B9vPcW+waD/s8yiSjfmFnDQUie6ZqxLuakGqLJJicIIXg41FbYpDN
         RvY9KBZM7M8fl2ppz6dgBbXuZONdla8ol3LcW+Jy80sR799+Uh5BCnH3GhF6vqv5BinV
         knJZwdbbfD6z00XPrpfaccpJPv3jFYKwLPLlt6b44pJxbaSUZDBPl9v8eFfDbdGgcvpG
         GbvQ==
X-Gm-Message-State: AOAM53141WsoIhCgePuyRzGh2tGQesRiEQMrISQmEuNOs0/hhrrjVpW2
        8jgZnySPJAGx4aRK21kGeRUnXHc0TtvcxpZ7OWUxx+JhfjEL
X-Google-Smtp-Source: ABdhPJy1Obdwmm7FKx1IVLqaSnal8I6oxGn9waWDa+O1RRMVRjRDjIm1ulkHkgK++L/LgyxwpUDP8XdYflUhSgnZQiC8byMy1t9R
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr5042352jat.105.1625343846678;
 Sat, 03 Jul 2021 13:24:06 -0700 (PDT)
Date:   Sat, 03 Jul 2021 13:24:06 -0700
In-Reply-To: <0000000000000cafda05c639e751@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e89e205c63dda94@google.com>
Subject: Re: [syzbot] general protection fault in try_grab_compound_head
From:   syzbot <syzbot+a3fcd59df1b372066f5a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mark.rutland@arm.com, masahiroy@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, rostedt@goodmis.org, seanjc@google.com,
        sedat.dilek@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vitor@massaru.org, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 997acaf6b4b59c6a9c259740312a69ea549cc684
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Jan 11 15:37:07 2021 +0000

    lockdep: report broken irq restoration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fbcec4300000
start commit:   3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15fbcec4300000
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbcec4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=a3fcd59df1b372066f5a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a856c4300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1582c9d8300000

Reported-by: syzbot+a3fcd59df1b372066f5a@syzkaller.appspotmail.com
Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
