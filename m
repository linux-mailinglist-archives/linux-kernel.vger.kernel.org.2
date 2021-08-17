Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3E3EF01C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhHQQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:21:47 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36653 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHQQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:21:45 -0400
Received: by mail-io1-f71.google.com with SMTP id e187-20020a6bb5c4000000b005b5fe391cf9so4455712iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 09:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KOqfcwDCAAyd9Yj7KuDdDJBmhJTsKykvsP7zBce1+GE=;
        b=CVTC/BKa+t2399qhlKBu9//UKAxjGeg0yFwNMRRaH9IOo6n+RtS5ojSQnPOiXhqtvP
         3pxPAdgDXScTtFSy0yM7FIkyOsIjForVPhI4xwxI+CC4/A5ikJBHZeYiMsvsQlA0qWQO
         DLOGSEg4fJTd32LBmwJNcfWjOgBSisROtmmZM6iwA/dDUgoqIqAGB5p+JyEbP1jCyHCY
         WtOB120sSyq0Zjz0sO2xeukwzjDTkkSMaoxF/4jZaBAA8y0Tw8Exj7KX2h0wMfS7ZsIc
         Y0SYKuijeOUNlf2ndtvs2CQ0FfqLdzU5IkcyJ9XsL9C4YacJ09qMDRC4nEkU8wUbNSUQ
         hteQ==
X-Gm-Message-State: AOAM533reoYAfIBps5GnN+GTg35MkveSxd0Nc0RLuRw2FXvn64+dLMmm
        T5HNl6bdzO1+mhuxzF4koynBxAvsMphpzB0AUx9v3z2uJ4rm
X-Google-Smtp-Source: ABdhPJzCSydA+1Z0J/QUplR71Dfv66P5r4SwQ+VQoMBL253DFHd/ocNOGwchcI097DHM9/2rZMH1E532vCgx7MXB77OVN8A7Zuqh
MIME-Version: 1.0
X-Received: by 2002:a92:b749:: with SMTP id c9mr2956629ilm.160.1629217272078;
 Tue, 17 Aug 2021 09:21:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:21:12 -0700
In-Reply-To: <CAJfpegv1ztaEvrSX622ru-FRX1VJYZDbRWq6_4HhF0tCY+0uHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3c97c05c9c3b4ea@google.com>
Subject: Re: [syzbot] INFO: task hung in fuse_launder_page
From:   syzbot <syzbot+bea44a5189836d956894@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bea44a5189836d956894@syzkaller.appspotmail.com

Tested on:

commit:         794c7931 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=bea44a5189836d956894
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169e4131300000

Note: testing is done by a robot and is best-effort only.
