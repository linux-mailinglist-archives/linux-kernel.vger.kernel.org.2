Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2E364654
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhDSOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:41:41 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34751 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbhDSOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:41:41 -0400
Received: by mail-il1-f198.google.com with SMTP id g7-20020a056e021a27b02901663a2bc830so11522775ile.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wlOpFW8cC2s0o+5q+U/P6q7nbFjBvPS+WnuW+PP2Iys=;
        b=WGNKsFair7/pYIpPnzh91NouLEgi6nPhDy/tCDRoX7Gq+aqPfJZ/TVOwjKhKw3HQAp
         qxEUo5juLb33gz/v76EelpGE2hM3rkxZ5G2RdeFGUzVMPCDfn0Dvlxpozr7UWvIKKwm1
         ybqTqMYdlVjVEB9/9au0H8z8UNbbrhlZUdPl0iaHcMvEG7NciIucBgxxfVShISq0JP0v
         gZR/FIDQrn46cEyYf8r4gZx6VTDxea+IteT+FN6f3Ijh0V9LlenWVIl1r+Z4AG2faJmB
         nIyWpvjVC1WRbauPsTnX6gtD2JJHWSrCuMeGJIkVMwGU8sBBqQyEj8LFeHP2J+dVokGh
         z6IQ==
X-Gm-Message-State: AOAM5331dcOKaAOrXYSmr8thDCNLLlGW2VgUw9jCx1KSDYUbRH/0VyMO
        q+4Cc9IORTRYy5Y4kmdKXF28AQpBlK/nNgKy8vLr5f/ENXRL
X-Google-Smtp-Source: ABdhPJySkX4bS40j/+HsRpeprmCVSQL9BBIFWCA2S68/d629WQe84Yv8+tXJIEY7WItzNFIJ8X/WNmJUIk0x1ZLcHUKzjQ6SAoDR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10e:: with SMTP id x14mr8742051jao.116.1618843269860;
 Mon, 19 Apr 2021 07:41:09 -0700 (PDT)
Date:   Mon, 19 Apr 2021 07:41:09 -0700
In-Reply-To: <0000000000000427db05bc3a2be3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c120805c05452c0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __cpuhp_state_remove_instance
From:   syzbot <syzbot+38769495e847cea2dcca@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, ducheng2@gmail.com,
        dvyukov@google.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        paulmck@kernel.org, peterz@infradead.org, qais.yousef@arm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 470ec4ed8c91b4db398ad607c700e9ce88365202
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Feb 26 17:20:34 2021 +0000

    io-wq: fix double put of 'wq' in error path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e89cc5d00000
start commit:   cee407c5 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f67201de02a572b
dashboard link: https://syzkaller.appspot.com/bug?extid=38769495e847cea2dcca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e360ad00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io-wq: fix double put of 'wq' in error path

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
