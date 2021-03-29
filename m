Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6E34CEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhC2L2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:28:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45804 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhC2L2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:28:06 -0400
Received: by mail-il1-f200.google.com with SMTP id x7so5342051ilp.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 04:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rQvHuQoW7fvtp2Ftp9kpJnXrU1a0vQLohh1FTEc0jDU=;
        b=Dnqu3fw6nKlKWCW2B9rxv8z6zMwOLYMYxbex4c68h4fDv6S84dblUZmNx4E0So04B5
         CnXTWWAKP59zKcQcIxXEhK9W09nYocyXaQRnd+htt3kMIfTWuzTiNtWP7y3uYf2I98Bb
         ie+lQb2ntdplfXHDcMrUc7VBF3emsLGJDwpZR2BC+gTRYZhFU4WdgFA1wX8uTHWKDv9l
         NWjHZPEi1qT4TCcALgyBI9D2pVIPyVJ+PM39aDgtlkN/3KuFVImML2jH2AOqRatTiuyQ
         dEz9ongWgtM2TONg1s6AiC7HQ1SrudZPjJvDq8t8wQCfXsxC7LKImeQx/hPXBnfSL9jt
         gsEw==
X-Gm-Message-State: AOAM530I9tijLpoHx1tuXj98+WqbDgwDNuurmM5UjdSCJLKrXG9lpSG/
        Fw2EFtfmD3D2QrF3csU99FVK/TFp0Z2ZyP9vh55Fl8g5nUH5
X-Google-Smtp-Source: ABdhPJyVGPg1iqr/7NbcMuFQoOzNXIrVaBElCoeGpE0yyT3Q1rRFN8O0BxysKrgcUI8F0NUDr3gsxqYBJV5vkbJE8UoNcZEn92PU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr22892618jav.60.1617017285612;
 Mon, 29 Mar 2021 04:28:05 -0700 (PDT)
Date:   Mon, 29 Mar 2021 04:28:05 -0700
In-Reply-To: <000000000000cefea605bea7e8c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7989c05beab2c46@google.com>
Subject: Re: [syzbot] general protection fault in io_commit_cqring (2)
From:   syzbot <syzbot+0e905eb8228070c457a0@syzkaller.appspotmail.com>
To:     alobakin@pm.me, asml.silence@gmail.com, axboe@kernel.dk,
        davem@davemloft.net, gnault@redhat.com, gregkh@linuxfoundation.org,
        io-uring@vger.kernel.org, kuba@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit f9d6725bf44a5b9412b5da07e3467100fe2af236
Author: Alexander Lobakin <alobakin@pm.me>
Date:   Sat Feb 13 14:11:50 2021 +0000

    skbuff: use __build_skb_around() in __alloc_skb()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11934b3ad00000
start commit:   81b1d39f Merge tag '5.12-rc4-smb3' of git://git.samba.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13934b3ad00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15934b3ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
dashboard link: https://syzkaller.appspot.com/bug?extid=0e905eb8228070c457a0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e0ed06d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144754ed00000

Reported-by: syzbot+0e905eb8228070c457a0@syzkaller.appspotmail.com
Fixes: f9d6725bf44a ("skbuff: use __build_skb_around() in __alloc_skb()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
