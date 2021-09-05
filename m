Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30526401213
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 01:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhIEXWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 19:22:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45695 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhIEXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 19:22:13 -0400
Received: by mail-il1-f197.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso2982594ilq.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 16:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t6KGl5qGZOKwjA8wYNjhxOdRHpEUEUmyOHtgq+CbC7c=;
        b=alBVk7xLLWm0/wk/Fb4wNAFPTIknLjl3Ybitnc+Gt8XwY1swJdo93M5tHpDIXHP87d
         Yw8dD7fVPY78tNJvmlGT+5SK6+WFrTCauo2FVdJp6NUy/FkAUKomGVI7YqUEoCFjFn61
         Uh7kBF2MJaHBtRxZEw9wZ+vOiSesqhh+FLdpzodccpalxDK8YVy5Yx/T1+MFFQQgL2RM
         y4DvVz8Jlwe6/drpoMobRpBdn4wkHUXv5lFYjy69fv03Tjuvs7h+OkZQKNs7k4KVFJLL
         JFngIa9CZ0P1BJNJadzIMu64rUEM9rFbCqvcz0g6v/aolc4rXZbRuhYEpbJf3UwcI61T
         2Udw==
X-Gm-Message-State: AOAM530Z5FXNe9pMuRMlaD/Yfuh5p0H4sULzwjpM7D4XxcwpLlCjrO7w
        EVgAp259M2X6ru816GsMBcoNbHzrlcO0r9glTi1jyLZUP1u2
X-Google-Smtp-Source: ABdhPJwd3TYEWNuMTgpkZAvirmsn+/SrAn8Wwh9OqmKijRfViKorf/rzRe7Kmqs3U6G0U4D5VgDmmChYa9ZQ83uEoiOkJtAR2DKB
MIME-Version: 1.0
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr7782287iov.62.1630884069876;
 Sun, 05 Sep 2021 16:21:09 -0700 (PDT)
Date:   Sun, 05 Sep 2021 16:21:09 -0700
In-Reply-To: <000000000000ea2f2605cb1ff6f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7a8de05cb47c9b2@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ip_create
From:   syzbot <syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com,
        coreteam@netfilter.org, davem@davemloft.net,
        eric.dumazet@gmail.com, fw@strlen.de, hch@lst.de,
        ira.weiny@intel.com, johan.hedberg@gmail.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, martin.petersen@oracle.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e6e7471706dc42cbe0e01278540c0730138d43e5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 27 05:56:34 2021 +0000

    bvec: add a bvec_kmap_local helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17468471300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c68471300000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c68471300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7860a0536ececf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=3493b1873fb3ea827986
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11602f35300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8fbf5300000

Reported-by: syzbot+3493b1873fb3ea827986@syzkaller.appspotmail.com
Fixes: e6e7471706dc ("bvec: add a bvec_kmap_local helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
