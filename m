Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A83E2D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbhHFPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:21:31 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:33537 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHFPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:21:30 -0400
Received: by mail-il1-f198.google.com with SMTP id i15-20020a92540f0000b0290222feb23cf5so1188817ilb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tu7Kevvl3zuTnuTFnD3tZ2U7expM8FEkIre095hhtro=;
        b=pntH3S40jiqOCOtPzGcWnvXAfSHMqlRvhbeVI4nTDdD3vBaUt4s4iTTQW+TG1lXDhF
         hpwuEhksmEcFYUxQPRF+RvpA6qcWO5R5PekFO5uVBKkz0E2jBrbaLPZfSX6Z0PUGZM58
         V8qfTlsMJPSscrSB/ahU6nzGsy55dPXwXYl5CxZ38U/LhCZPuiGPyGD7ujAch4CDwOWW
         2CHa09stWXhRp0E9amcA7d5YVoR2ttoFqQDIrhj48BioP9H7xZHSbW4/muLL8MingUkQ
         QaEFSPf0QZ3aUJR2tPJutm0R1cnUMWdgrzGnBPOkpPWo/PW3Ua6eZb2Pl27Miv+Mr4OX
         WGjg==
X-Gm-Message-State: AOAM53287W+wicy2J0ueHNbgpoxubWln9VozzHA9DIUqF8m22AnYqqhX
        VzWe/v7Hbn3PVasdEitdEIVIi+DDiGpc2XNejiaHSpRuapVx
X-Google-Smtp-Source: ABdhPJzRyaRqX3bqJM1PUFwXIk5cTd4rpXA8+uJtjupvW4ZoQyD7Kk3vsUjzUlKGyNdoAvTiT+iOT7Cnjbsxim5TH68BMhXjdPlN
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f09:: with SMTP id q9mr1312428iow.196.1628263274697;
 Fri, 06 Aug 2021 08:21:14 -0700 (PDT)
Date:   Fri, 06 Aug 2021 08:21:14 -0700
In-Reply-To: <0000000000005225a605bd97fa64@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016db0205c8e5967e@google.com>
Subject: Re: [syzbot] WARNING in io_ring_exit_work
From:   syzbot <syzbot+00e15cda746c5bc70e24@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6c2450ae55656f6b0370bfd4cb52ec8a4ecd0916
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Tue Feb 23 12:40:22 2021 +0000

    io_uring: allocate memory for overflowed CQEs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138a96e6300000
start commit:   8d4b477da1a8 Add linux-next specific files for 20210730
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104a96e6300000
console output: https://syzkaller.appspot.com/x/log.txt?x=178a96e6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4adf4987f875c210
dashboard link: https://syzkaller.appspot.com/bug?extid=00e15cda746c5bc70e24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d5cd96300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1798471e300000

Reported-by: syzbot+00e15cda746c5bc70e24@syzkaller.appspotmail.com
Fixes: 6c2450ae5565 ("io_uring: allocate memory for overflowed CQEs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
