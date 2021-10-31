Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4E441156
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 23:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJaXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 19:01:40 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55078 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhJaXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:01:38 -0400
Received: by mail-io1-f70.google.com with SMTP id i8-20020a0566022c8800b005e187639aceso3032000iow.21
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 15:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zmKZGqzh8fouPbLaed+gBxcWLHzsUh8p7n964ZC6uwc=;
        b=SnrqIrlNZC3Q8GzYiTEuca4LoZOkHtFKBHvppDouZB7AybDQvntgTWdL7X/6iUREUJ
         OpiBkJJU1XYJI7MkmLYPu4eMDtAcyGxrY8LSfyichyNlMdbnpC+j0r7iId3DXzqbG0u7
         TzrQWtc9jm3Rw9EgwB76OEmFpzcDexFfoJ+uOd/lskJdS8EjMN497i3e1/PADF3lgFiC
         5+GPqc2vWkF4IPdgiPcIyJJwRxSYJsCHUHFcghNpCch9wScrKxgPqLr34GzfmGUoTBSZ
         UmRwjOOFRA7/4QlrfsAvFgrW0CBgieAPYx2f/vYdfKv0oxznMoRXB1v4i19Mj4yo1pPj
         ZS6A==
X-Gm-Message-State: AOAM532jLPuvHak/IHYxJ0DYcjZrPRa6TjRRbABg+f+KAM3tbEHs3o4S
        PHtQk0ZF0wofg601lg7nQKWnP4eBe8ilnbpLZraUZLksnSg7
X-Google-Smtp-Source: ABdhPJywbfOpwWGX+8twysh9JnZdNyAmjt8vM3QTfSudoVwDDOBb7qmmPAVA7hKN+so8+5aTSnSyrEftThdLX7EqHh1cLqN9uIid
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d53:: with SMTP id d19mr18923597jak.123.1635721146351;
 Sun, 31 Oct 2021 15:59:06 -0700 (PDT)
Date:   Sun, 31 Oct 2021 15:59:06 -0700
In-Reply-To: <000000000000fba7bd05cf7eb8f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e143c505cfae0138@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in __io_free_req
From:   syzbot <syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 34ced75ca1f63fac6148497971212583aa0f7a87
Author: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Date:   Mon Oct 25 05:38:48 2021 +0000

    io_uring: reduce frequent add_wait_queue() overhead for multi-shot poll request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f83bbab00000
start commit:   bdcc9f6a5682 Add linux-next specific files for 20211029
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f83bbab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f83bbab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cea91ee10b0cd274
dashboard link: https://syzkaller.appspot.com/bug?extid=78b76ebc91042904f34e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cf03e2b00000

Reported-by: syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com
Fixes: 34ced75ca1f6 ("io_uring: reduce frequent add_wait_queue() overhead for multi-shot poll request")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
