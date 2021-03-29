Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EA34D677
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhC2SAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:00:17 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41591 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2SAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:00:05 -0400
Received: by mail-io1-f69.google.com with SMTP id n1so11472026iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FVXCBOA19N+8Cvll8rclzhhBLyzXsPQ/MO+es+WHLpQ=;
        b=aXIesN+he9O+aFgrE66T6e1YpoKLG51t/Q+tyibaMi/ztKqmMhhMCzhwDfFK6sxN70
         zNbSOe9ywtpiKLxqGGzcHXdW9FQ2wyKD2iDYaEvu996VpBYtVal6bACi05yYsqyUNm7n
         +3kHXYtqxCQY/doUBb4tEd4O84ybEaIwgqVutBN9pDy+ABdrhjHNByghtMqHnmreKuwk
         lWNtekWlQJySzWUJRbDUkEgG9L0Dhix1jdz0v4yVd2tHxy5MRx05A4OfdnDSDb7FaOQj
         IUFF95OuKL2f2vS32htwCJx+LmrRi933CprW7cd/ByramWbKVboyGEcxsEMx2jqFM6/l
         EExw==
X-Gm-Message-State: AOAM532vZgzSIF4MNJk7lJ8nTsuggv4Oq0UjUz4Qz7iFzUNmldm4/3cZ
        lYHL4nv7/FXWSVgqdVjAYXXJ0kGcPoC0aBIe2QjldQeXNXMs
X-Google-Smtp-Source: ABdhPJzA0LAxPGtiKmML9IoNwD88JU3yBTm0rMsiXA81RF9MUpeqfJLWyeqqtAtj1XKb9BtLojmu4DuLYkgDJ+wiZRE5MyhpYnd+
MIME-Version: 1.0
X-Received: by 2002:a02:ccd9:: with SMTP id k25mr24914140jaq.43.1617040805381;
 Mon, 29 Mar 2021 11:00:05 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:00:05 -0700
In-Reply-To: <000000000000cbcdca05bea7e829@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cacb2205beb0a63e@google.com>
Subject: Re: [syzbot] WARNING: still has locks held in io_sq_thread
From:   syzbot <syzbot+796d767eb376810256f5@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, bp@alien8.de,
        hpa@zytor.com, io-uring@vger.kernel.org, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c8cc7e853192d520ab6a5957f5081034103587ae
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Feb 9 08:30:03 2021 +0000

    lockdep: Noinstr annotate warn_bogus_irq_restore()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152deb3ad00000
start commit:   81b1d39f Merge tag '5.12-rc4-smb3' of git://git.samba.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172deb3ad00000
console output: https://syzkaller.appspot.com/x/log.txt?x=132deb3ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4e9addca54f3b44
dashboard link: https://syzkaller.appspot.com/bug?extid=796d767eb376810256f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d06ddcd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150764bed00000

Reported-by: syzbot+796d767eb376810256f5@syzkaller.appspotmail.com
Fixes: c8cc7e853192 ("lockdep: Noinstr annotate warn_bogus_irq_restore()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
