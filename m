Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2B453628
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbhKPPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:45:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:41704 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhKPPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:44:13 -0500
Received: by mail-io1-f71.google.com with SMTP id k6-20020a0566022d8600b005e6ff1b6bbaso12980148iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yEoiAOZNXI+7ziHDgUkTx2Lv3WSs9sv/eVLYHQ4c5qs=;
        b=BrNoaEaGOXcDN2ERNqW7L1nGcpZywPsvQ3yFGAfzaqnBMYVWO3aVksZDDOGdLKUYEH
         cKlhC+St8S5RVMgolooC+ZW21XBZEDGdguE/fcfNi1Ib7zbK8k8d6Dawg5tUl3bFvNnC
         K/4uHWQSKvYIZRBzK8nvh0lTnERMFWpKjnWmE7PtR6/xQ9Zv0awZK00jMQJvGKoe7fP5
         lC0ZfqGGEjIgGkgaJFl3olL4X95AwTrD/NpVqi/ouWxGj4bIbqtLUCwHBJ/wrFqVALAG
         SQGfYC1nY0Pgrk8KLruJ35nYcqnwAo6ieRbSFDhfqN5iJShqUq+1KDtE0sJRcq68V5AT
         iNBw==
X-Gm-Message-State: AOAM530+ekEYjqJjvLA0aXg5VXnf5xxHd3IQY6j4tBdW85KDiLTEkL9h
        6c+EGN5NPSF+I0GxHAiKbUCOvP45tARGcjB2PoAC+oGcjzVa
X-Google-Smtp-Source: ABdhPJz2QvP079zeX/CSMbBjUQ4yB0Z21xR5DrHse56nG8ecxlTTNjG5d/4SrtAzw+M2+watkTiawRFrq6/9vJ1WSz68jkvpCbf8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr5243399ilv.102.1637077275827;
 Tue, 16 Nov 2021 07:41:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 07:41:15 -0800
In-Reply-To: <00000000000009a2c505bbcaed68@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ee63e05d0e9c172@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, fweisbec@gmail.com, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b60876296847e6cd7f1da4b8b7f0f31399d59aa1
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 15 21:03:52 2021 +0000

    block: improve layout of struct request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137f2d01b00000
start commit:   f40ddce88593 Linux 5.11
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a81012d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1282b6d2d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: improve layout of struct request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
