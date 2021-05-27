Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAE392DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhE0MNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:13:44 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42960 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhE0MNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:13:43 -0400
Received: by mail-io1-f70.google.com with SMTP id v21-20020a5d90550000b0290439ea50822eso119209ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=46mVEuJH/YuNKj25ujtfNRaINuWhkbWMehm7Zy9vBuE=;
        b=Uia1yDUzV9ITVb+Csq8mm1Ly3Npv1lIJYSC6VXn8IkX99eGwRiBoYX3TfPds+wN9Pu
         mWPsSUFUNoekWlN6ymnha0RFm0U4VlWwLiOCMie1MuNEmCU9dMr6mYXI8oQK2v8pTcWO
         vQnBtq7S5gXUgj6WasLu3pbEc6dXtuv+JcHDMIePYDKiQ4uS3tcaaAirYaeHpYzRlHD/
         lmSYSux3fNz8veqnoEnOGRUQ3Iyw6C1l1jvN+S02PGlT/aRt8UGOSrcfJAdeOdhqTVnM
         npdGx2iHG0O05pTJq15R6HQNJwjC8QFJXEnfflnBdEt9tOSqFm8Ce83RcOL8nsDxR8u8
         nHqA==
X-Gm-Message-State: AOAM5304L+n+U4C2pjUWAEeCvsIgAyVu/7TaAnZmiRVQy82d4SzZZfpt
        IXExJpLK+NzJaa7RD+7Z01+AqzdKck62zopKz1MKdNP13YVZ
X-Google-Smtp-Source: ABdhPJzicngFIhcR3y7yyEzuzR3OswrH6+bi3jHdWU5Ff7csPGpfT7+kunHdl2ah7f6px7VT9I9RpYInhqM4U//vUHOLIhH23JnZ
MIME-Version: 1.0
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr2544565ioj.53.1622117529759;
 Thu, 27 May 2021 05:12:09 -0700 (PDT)
Date:   Thu, 27 May 2021 05:12:09 -0700
In-Reply-To: <000000000000b808c705c345b35d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025334e05c34eab2c@google.com>
Subject: Re: [syzbot] unexpected kernel reboot (5)
From:   syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>
To:     dvyukov@google.com, gregkh@linuxfoundation.org, hch@lst.de,
        joey.jiaojg@gmail.com, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, sidgup@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit f2d6c2708bd84ca953fa6b6ca5717e79eb0140c7
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jan 20 20:46:31 2021 +0000

    kernfs: wire up ->splice_read and ->splice_write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144ee113d00000
start commit:   7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164ee113d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=124ee113d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=6fb8ff5211d3e821398f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8703d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171382d3d00000

Reported-by: syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com
Fixes: f2d6c2708bd8 ("kernfs: wire up ->splice_read and ->splice_write")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
