Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2B4045CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbhIIGwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:52:24 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33785 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhIIGwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:52:23 -0400
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e020d4a00b00227fc2e6687so1243089ilj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kDkmBLWaDYRnrQjU0pW08RiRXMeXOiOOb1COf/LFO7U=;
        b=V2z5L4SF8DZwLumdPff97fBzIYmsnroU6Q/bXe6IWncpeLFgHy6FN4XyErZt+Q3cyJ
         M0M8zDoa4n0hk5YCPBr2P3imkascCCN2AInV+VVRomZucCs/sxK4OyrloQ5ILda857g7
         RMh9AJlj8Xrbz1/kcAgVjiles0Qwv+Nk+q+6LwpWMMcfx17z07nF3hussYFc2NRAF5a3
         Rq0luAdzkCPYAtuFIxp7r9zP0+VenEJa8nezFG5lrwf6TJY2BTZPlMDgNf7xVWS9mt0T
         bSDF3nX3oxraHm0Ue55O0D38SZQzdsjuezGl4B47wy+SX/rQPrEh2NxGNKmgucsQo3qg
         gwwQ==
X-Gm-Message-State: AOAM532Ap9yBEnrGFS66Gtg2RYmNO1W/2PfQ1hEp+X/HfW33yuFMa3qh
        jTwc/kB44bEn0/MWuyY50yemuqsG8ruHLCo0ltw1O3NIJTOW
X-Google-Smtp-Source: ABdhPJzho46HFyo1dlf+WBjkzC2MnzGIgmkh9OHBrq8p1x32bpn2LBRKLLO/LQo4mQcInwQuDpOYrWCqCZfG3+LQIYK7sb2Q7O5E
MIME-Version: 1.0
X-Received: by 2002:a6b:e616:: with SMTP id g22mr1371654ioh.67.1631170274006;
 Wed, 08 Sep 2021 23:51:14 -0700 (PDT)
Date:   Wed, 08 Sep 2021 23:51:14 -0700
In-Reply-To: <9bef8d9e-7378-62e6-b78c-af3fceab2e46@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c01ddd05cb8a6ca0@google.com>
Subject: Re: [syzbot] INFO: task hung in io_wq_put_and_exit
From:   syzbot <syzbot+f62d3e0a4ea4f38f5326@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f62d3e0a4ea4f38f5326@syzkaller.appspotmail.com

Tested on:

commit:         3b33e3f4 io-wq: fix silly logic error in io_task_work_..
git tree:       git://git.kernel.dk/linux-block io_uring-5.15
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bfda6f9dee77cd
dashboard link: https://syzkaller.appspot.com/bug?extid=f62d3e0a4ea4f38f5326
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
