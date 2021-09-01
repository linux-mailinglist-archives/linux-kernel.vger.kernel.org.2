Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22B3FD3EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbhIAGmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:42:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36522 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbhIAGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:42:05 -0400
Received: by mail-il1-f198.google.com with SMTP id s15-20020a056e02216f00b002276040aa1dso1244841ilv.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/IMCvQrvg+8vgiRvuUq0CwJ8bLlyNbWMfPV5tYVEzM=;
        b=Qc52Z7cjj6llHFieHBZhHYlqtD7YdZBjSgilEOjxG1tPcHHELI+dyMid/VvZeB4sS9
         I94vA6FwZkWFxro+tV+xYU/ZoKTV4+Xa0shC8tl5ncyHqWFajkL2Q3kUHSsezijoWUvm
         1pAwilKZquiPlJhg7kf48hN+DOD98z+LEAzTD/V3mTXkJiICrYpCGRVARBH9q5EKXT95
         8psPstcbpToTXZ02bE1DNrlySquPcHZHKOOiCdgLfxzO2FU3T8XRAI4jZTVc7jxFTSKc
         W5lE6kvekngL4Nw7c7FSrUmhI2NO2Y0O9bcIb4TcOKY3oY/DrMPjLKUlYTx0DxYGu+3K
         Ovwg==
X-Gm-Message-State: AOAM532LUK/uDWycnMI0k8/7EqI8CSkL7ygWFMgPg5upt0U+gJmYmNqt
        UjEzQOldtY4nkD64o2EpoHsEVElLgP3mpLybCIxbJ2ogDgDS
X-Google-Smtp-Source: ABdhPJwjbVl36PRGrxPo3VWFpYPdF3rcxUyLcJL+kpHKRktKIhGPoUpcjjA/JpOC4UE7iVT+Raz2Xf8nGOR5VzvFVVs5vlXj6ozj
MIME-Version: 1.0
X-Received: by 2002:a6b:f908:: with SMTP id j8mr25814233iog.22.1630478468594;
 Tue, 31 Aug 2021 23:41:08 -0700 (PDT)
Date:   Tue, 31 Aug 2021 23:41:08 -0700
In-Reply-To: <0000000000006d354305cae2253f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef423f05cae95929@google.com>
Subject: Re: [syzbot] general protection fault in __io_file_supports_nowait
From:   syzbot <syzbot+e51249708aaa9b0e4d2c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a8295b982c46d4a7c259a4cdd58a2681929068a9
Author: Hao Xu <haoxu@linux.alibaba.com>
Date:   Fri Aug 27 09:46:09 2021 +0000

    io_uring: fix failed linkchain code logic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147a8045300000
start commit:   b91db6a0b52e Merge tag 'for-5.15/io_uring-vfs-2021-08-30' ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167a8045300000
console output: https://syzkaller.appspot.com/x/log.txt?x=127a8045300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=961d30359ac81f8c
dashboard link: https://syzkaller.appspot.com/bug?extid=e51249708aaa9b0e4d2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a91625300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12512291300000

Reported-by: syzbot+e51249708aaa9b0e4d2c@syzkaller.appspotmail.com
Fixes: a8295b982c46 ("io_uring: fix failed linkchain code logic")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
