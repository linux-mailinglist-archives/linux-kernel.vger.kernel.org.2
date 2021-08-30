Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB73FB4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhH3LfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:35:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39607 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhH3LfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:35:05 -0400
Received: by mail-il1-f198.google.com with SMTP id y8-20020a92c748000000b00224811cb945so8837723ilp.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8yu2qDi/W61ruhvfPtnck6J11ryx5e7EXsUOpCFvzG4=;
        b=FMPLq0rurkWIKShYurAi4QquJe9r6WDYG+eevDq9IR6jZDkVsg1mZt2VqL8Q9fdwBZ
         vtDbItGeFo2K1Cef9lky2g+08ledakdzqM6Ip454kcnuBXXmSjnsHEMOSybktKtic45A
         P7ZDrr3/gDdeaeFQtHJwoT5c/828h6DtgJJEBACjgIl7xAtjE9ienlqk+nsLw+50WTHu
         AvvcwsXdG9OFvrtBDw+O0MoLT8i/TD09aVWv3jEIwD3l8GO/zakHztdiugmVyIcPTbYr
         u/FbIUrYihpSeeOKLsKw+SmZfeDpTNL8u0wdlFirWH3z+Xbl9yJj8oa6D7ZrA0J7N6Hn
         5x1Q==
X-Gm-Message-State: AOAM532c6ePuDCzTVTV0yGoo9Mkd1VPeqvThm5Q4CGQMGFO4xRyoHd7b
        +7A6pM9wCAsMvEkTZNeWnHZKVIUnEFZc+/R217AKXMmGZJwA
X-Google-Smtp-Source: ABdhPJw8R8S4wtILrC6Pgi4rcp0GnFmahcRcIzqC11+AgCnvk1l/mVz8zSjhYlwRKul0FOFQlHJqw0U8ywdoT7sMIsTAZe4Odi3M
MIME-Version: 1.0
X-Received: by 2002:a6b:5911:: with SMTP id n17mr17250394iob.180.1630323252380;
 Mon, 30 Aug 2021 04:34:12 -0700 (PDT)
Date:   Mon, 30 Aug 2021 04:34:12 -0700
In-Reply-To: <00000000000022acbf05c06d9f0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053c98205cac53625@google.com>
Subject: Re: [syzbot] WARNING in io_poll_double_wake
From:   syzbot <syzbot+f2aca089e6f77e5acd46@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        hdanton@sina.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a890d01e4ee016978776e45340e521b3bbbdf41f
Author: Hao Xu <haoxu@linux.alibaba.com>
Date:   Wed Jul 28 03:03:22 2021 +0000

    io_uring: fix poll requests leaking second poll entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d8819d300000
start commit:   98f7fdced2e0 Merge tag 'irq-urgent-2021-07-11' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=139b08f9b7481d26
dashboard link: https://syzkaller.appspot.com/bug?extid=f2aca089e6f77e5acd46
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11650180300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1510c6b0300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: fix poll requests leaking second poll entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
