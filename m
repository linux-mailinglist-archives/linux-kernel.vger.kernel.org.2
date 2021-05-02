Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260033709A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 03:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEBByB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 21:54:01 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43918 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhEBByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 21:54:01 -0400
Received: by mail-il1-f200.google.com with SMTP id l7-20020a9229070000b0290164314f61f5so1792741ilg.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 18:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OaqvyMlXg8wGXZRGMIboAMoucZyr0AtXUbwHcvsJTxQ=;
        b=ig4uJdSSx5f0nprC+wZF00W8Z6v/vc2EWGXsAU09VLGqt0R1izDuAfj9uyPCH6VtOS
         yl+wcD4etRBtcz5bz1+/djbK10TwHBllc86Agok9MKLeVBADEp0jJLfJYR4zL9eVFRTz
         VYaEF56J7dCLJnxYzdt08k4LwMAGRBZEPArzv2usaF3JTawlDJBDa8FRbYEi26ysuM7g
         BWR5FXa5dmiiGhSvDzLbaxJ9ajZ8jm7Sk0rzYp968OQFoxfT54EM+IFA6bIO9Eg4mfu6
         YgmrJss7dEYNih0sHxL4ZChaAiokKzP65GonTvk36yiNET1XXUlw9Z2qFy7ZL3/YMpBz
         cONw==
X-Gm-Message-State: AOAM533PURsRyLYnXMBrErzz60AqVrunlMDMlLt2r5oKxihxOrpmmMbD
        1txFwifK8ywBcJTqSRZa8vDQHfb8vhfQ+9wqR00PQ6FFA5b8
X-Google-Smtp-Source: ABdhPJzrDS4BZ0APncrMikVvdmVtL8AzN4r8IHRznwTpDU6fklt7kjPqWFHr3kUlkvmZAB5ysDk/ZrgPlZh+HISi5V3Ywm/O/0co
MIME-Version: 1.0
X-Received: by 2002:a6b:7413:: with SMTP id s19mr9056934iog.151.1619920390173;
 Sat, 01 May 2021 18:53:10 -0700 (PDT)
Date:   Sat, 01 May 2021 18:53:10 -0700
In-Reply-To: <00000000000086452c05a51da504@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bbd0c05c14f1b09@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 vga16fb_imageblit (2)
From:   syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, colin.king@canonical.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, jani.nikula@intel.com,
        jirislaby@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 988d0763361bb65690d60e2bc53a6b72777040c3
Author: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date:   Sun Sep 27 11:46:30 2020 +0000

    vt_ioctl: make VT_RESIZEX behave like VT_RESIZE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15633759d00000
start commit:   d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17633759d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13633759d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
dashboard link: https://syzkaller.appspot.com/bug?extid=1f29e126cf461c4de3b3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d9ff43d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10981693d00000

Reported-by: syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com
Fixes: 988d0763361b ("vt_ioctl: make VT_RESIZEX behave like VT_RESIZE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
