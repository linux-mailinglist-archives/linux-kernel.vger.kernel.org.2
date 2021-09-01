Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7483FD1D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhIADfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:35:03 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:56295 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbhIADfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:35:02 -0400
Received: by mail-il1-f200.google.com with SMTP id c16-20020a92cf500000b02902243aec7e27so914642ilr.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ruk1eNA61TEh1q3FM3cLWHsGyGqg/VpTBs16qFZP0nA=;
        b=ZDjUgRjaJtzI2nrLKJfpW16rmUbtF5X5i6f4ROPNYop6/aANkZjWeJuoRxlX4FhVOQ
         pyu2iSRXdccI4qoAKHIaZ65S+G4gT4xKdDwZ4rE3evxNKzwPwQOdC+aMDrEBbhEmLnWm
         M2XIFA0qOlMHkcsC8OXJJmCQ5qcCETMOpWr1QHVWPUqR+2+hSA13VKEEkKvAQH0vTdpM
         X+7BbeIItLLXWqBYyy0z6Pj50PL2c9UtZT73z9+VgsNzGGGO2NASnS/+Y220Vfj1Dl3D
         sYKyCOClbwIAe+unz9eRDdExVKTBxV0r+3HngQ9IiaLeSyVU9m5eulGQXQ0wTCdinbb4
         ycXQ==
X-Gm-Message-State: AOAM533KPZ5aNMM6G6T2Jive84IRg3RYeMPAWW2k/+VaQYzBjkGfcHhq
        tvbvupc8+lnG0VZNztN1ppvqYMjQvgMpoEQbhlpNY+Yg6B9d
X-Google-Smtp-Source: ABdhPJxQOY9wix7ZpJL/KvZsxmj0PrK5sksw1XSgKwr6SC5NM7n0xv3FKu683GMXeJ7sEK2iB+oEduv9uMiPd3dXRDqifN6lcB5B
MIME-Version: 1.0
X-Received: by 2002:a5d:9da4:: with SMTP id ay36mr10369641iob.153.1630467245981;
 Tue, 31 Aug 2021 20:34:05 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:34:05 -0700
In-Reply-To: <b4305afc-ff25-8388-1ba2-e761129a509a@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003c81405cae6bdfd@google.com>
Subject: Re: [syzbot] general protection fault in __io_file_supports_nowait
From:   syzbot <syzbot+e51249708aaa9b0e4d2c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e51249708aaa9b0e4d2c@syzkaller.appspotmail.com

Tested on:

commit:         a64296d7 io-wq: split bounded and unbounded work into ..
git tree:       git://git.kernel.dk/linux-block for-5.15/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=765eea9a273a8879
dashboard link: https://syzkaller.appspot.com/bug?extid=e51249708aaa9b0e4d2c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
