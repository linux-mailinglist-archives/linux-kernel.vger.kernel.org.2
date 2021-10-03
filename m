Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561642007D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJCHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 03:36:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33429 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhJCHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 03:35:55 -0400
Received: by mail-io1-f69.google.com with SMTP id j14-20020a6b310e000000b005db4ba30be6so13274751ioa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 00:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c7Hhg1HS9ONwmBtdl/+gEC6wT21nlHlGkIEyTDo6QXw=;
        b=7+PFsIQf3W0XK3rC/yAAZwoJ4Gz1v5652qYJiHxLRaOZp3gtpzeBDtxeIwKBFy08Vr
         fp4JBPtN+EEb8mog+AtYgD7ny7omYFd/Q3TGsI9uf7Em3XkZLmmE/invw81kQ8S4Elyr
         tnPCVopNi9v73HZy1cHldM+XJNsPZMOLLmopwVTYN4L1dWmPdcdH/5d8eTn9Kja7H6Qu
         Mq1sMdHVkYzaYqBJZRAJnybEipwfsTQJGW+Lk3KDocBNPXWBJsrnbmEd3bQOyiEEn/Rx
         dlWeZkXdPbHFGlQMMZSRVcF0ACJ4QaXh83ip42rWCOEtcc0Z0FAHSiEJPov3OvXLuLrA
         r21g==
X-Gm-Message-State: AOAM530J7qxVfAs9meWQLMq5w5rpydBJRCLt76KKxjw7Q+uwC6MTBldc
        kUwbZGtdLfwj6UbWzMlYQ2Cdyz8yoKf9LzSw1f85ohtM22dL
X-Google-Smtp-Source: ABdhPJxqZIyLyb2GCKV1AwEY4i18NOKnl8EziN7c1CJrRf52GnzfgmaxpkDY00mNnhUSIeev2Hfg4nqSERwqf/mhBGnmraIIITRW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:: with SMTP id z10mr4904868ilu.249.1633246448379;
 Sun, 03 Oct 2021 00:34:08 -0700 (PDT)
Date:   Sun, 03 Oct 2021 00:34:08 -0700
In-Reply-To: <0000000000000d4da305cb1d2467@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062ec7d05cd6dd2f6@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in kiocb_done
From:   syzbot <syzbot+726f2ce6dbbf2ad8d133@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b8ce1b9d25ccf81e1bbabd45b963ed98b2222df8
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Tue Aug 31 13:13:11 2021 +0000

    io_uring: don't submit half-prepared drain request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b14b67300000
start commit:   4ac6d90867a4 Merge tag 'docs-5.15' of git://git.lwn.net/li..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3a5498e99259cf
dashboard link: https://syzkaller.appspot.com/bug?extid=726f2ce6dbbf2ad8d133
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124a3b49300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142e610b300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: don't submit half-prepared drain request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
