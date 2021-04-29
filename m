Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000AB36EBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhD2OA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:00:58 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47637 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhD2OAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:00:54 -0400
Received: by mail-io1-f71.google.com with SMTP id f14-20020a056602038eb02903efc2bddb33so27176750iov.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RGZQlqYRDcws6lKbGiNkhAc8TLY6zhzM1dhv48k3sxc=;
        b=r6eRz+Vjnkfv005tSILT6BbEehbn1ZmPa7ratgghCw0gNOpeywZk3BaMvTbPSlHRsN
         5ALfrmGuPx1FBlRBJrQp9UoSbWGmnPFrXPiA7J+TiXF8yznnu9DMfyR0X/M2YaA3303m
         QFP7/UZY6oaod/3D2aSbrF6jDB2V4FXEMz/AoIYE2z9RYWLFlh8uPGpxLEajpDqUjWZR
         40SLMlT1HlbGugvuijsEVfo17/HDL+e7iSY0Gcy8Max81Nsbm+0ffuRXObG5bUP12sBB
         rjWAtLr+MoAvJ+jk2DUZeC+X3ZaFRQneTXZYzMyjdafilHK23hA/okjDPeSEmDPmxQ0+
         kJRw==
X-Gm-Message-State: AOAM5319MstRHQiGOuxGrapqyFiEUnUm15Y7eF/rTdYNZYF0o4+isbWA
        q7giIfmGC8QRsCIs0YQWwEPhics+gyNaX+IPMNajKFdOfYMx
X-Google-Smtp-Source: ABdhPJzuadjvDEHr9FHFGBzYheTEwO+GMWuYnAix7ZVEK/4HZPPAE5I0GJqznk7dtb2LAXrPUSmq6sKslvhgmpGf5WVREMCYuE7p
MIME-Version: 1.0
X-Received: by 2002:a02:3406:: with SMTP id x6mr6293704jae.137.1619704804712;
 Thu, 29 Apr 2021 07:00:04 -0700 (PDT)
Date:   Thu, 29 Apr 2021 07:00:04 -0700
In-Reply-To: <000000000000b23f7805c119dee8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086cb9005c11ce9e8@google.com>
Subject: Re: [syzbot] WARNING in io_rsrc_node_switch
From:   syzbot <syzbot+a4715dd4b7c866136f79@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit eae071c9b4cefbcc3f985c5abf9a6e32c1608ca9
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sun Apr 25 13:32:24 2021 +0000

    io_uring: prepare fixed rw for dynanic buffers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14498f59d00000
start commit:   d72cd4ad Merge tag 'scsi-misc' of git://git.kernel.org/pub..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16498f59d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12498f59d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=a4715dd4b7c866136f79
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11893de1d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161c19d5d00000

Reported-by: syzbot+a4715dd4b7c866136f79@syzkaller.appspotmail.com
Fixes: eae071c9b4ce ("io_uring: prepare fixed rw for dynanic buffers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
