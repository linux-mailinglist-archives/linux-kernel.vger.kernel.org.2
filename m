Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAB42982B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhJKUeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:34:12 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34644 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhJKUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:34:07 -0400
Received: by mail-il1-f199.google.com with SMTP id b4-20020a056e02048400b0025932d71f2fso3142450ils.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=69YQAoBbQKm9TqOi57aQVSWpMMSQKYJxlql/euFSSEE=;
        b=2UPH3jE3jEjFwz6UZyKua8q+0xgZjWUXZdriRaZRJEmjtsqxFxe+tv2oDXjkop/zIU
         N41+nmVi7xbaEWD4N/nXQkhmbQPkuEqpjHztDJEmz7aYwjWJ8RpO1pbt7Mt9L2hqg9EB
         /J1Hwve2gj43NCJAuq95iiGFh3HFUYtJ7ZP7w4IY6Yx0gLIhLACFtDXNO1/tTgREy/Rb
         Dj+KO8sQALuICcTaNl2FTMk5ysOpEI0u7CqbulM990PBlxHjb+KMuEhGFarY0c8xBR33
         T3YEVscyFkarTqelEMsDPG8Phy9IVneclqLqHWnrOs6AHEfIPs5ybonosgVD9oWauBmx
         781w==
X-Gm-Message-State: AOAM530PlUvSSUJbJJk/pv9Ri//RzCIEuwaFkzNuM/2H7jWkiGpWp/xV
        frrPV90BbgPscniY9J3s9mS4JXbPo7ZWoULBSx7B2FDja9Ui
X-Google-Smtp-Source: ABdhPJzcQtZG+lbdZ7wjSwBKdxMjz5X9CWlcrhgIHjIyn0/T16KZ5S0OlvEh8lUj07w+vinrQxWe4QPS0wANaZSsUf/mUWXFEMsw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c5:: with SMTP id v5mr6885528ilj.75.1633984327040;
 Mon, 11 Oct 2021 13:32:07 -0700 (PDT)
Date:   Mon, 11 Oct 2021 13:32:07 -0700
In-Reply-To: <0000000000004bda3905cb84cfc0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c94a05ce199f2a@google.com>
Subject: Re: [syzbot] WARNING in io_wq_submit_work (2)
From:   syzbot <syzbot+bc2d90f602545761f287@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, fgheet255t@gmail.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c57a91fb1ccfa203ba3e31e5a389cb04de5b0561
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed Sep 8 19:49:17 2021 +0000

    io_uring: fix missing mb() before waitqueue_active

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143b46bf300000
start commit:   926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
dashboard link: https://syzkaller.appspot.com/bug?extid=bc2d90f602545761f287
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e4357d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1173a663300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: fix missing mb() before waitqueue_active

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
