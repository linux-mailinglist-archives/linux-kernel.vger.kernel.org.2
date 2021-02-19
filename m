Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E831FFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBSUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 15:25:52 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:52799 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBSUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 15:25:49 -0500
Received: by mail-io1-f69.google.com with SMTP id x17so4607159iov.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 12:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hjZbSKSdJoVbeXQb2cKTUlfTuBF1xCsCTBC7HaDhAqc=;
        b=Po/seFMtzg1v4lrqm96HoioubhHCJKZAdmvuIl8oo8AVxNaZ62hCmbmLWUQjWcQIWL
         sAZZRp9yZlm2Vs8fftAGbpfdnI/X+dSS5ve3RWhdahEHqmKV1SH7qzieKXFOpxzAwQJc
         SiNQ2FRI6ueVyYTU43qaJ/Nf7BcU4jBUVjMS3NC7KrowM/9GgyeaWvyqZq6qrkxyBuER
         Q4tekZNAR3/MsqFF0MxNKQLf5+xTOuusgiGk7zkiVwW8AbNq210GbuPGU/r9x1+Lxa7t
         IDAHs9w//UauT8wK+s+X/gCoxIPavIYinFJBRr7jHB4H+kCYzmKMI7HEEA0SMlhF99fs
         BuuA==
X-Gm-Message-State: AOAM533dhuWvgfT55K1Y3m6KW0hMtRXb7AR5jKMk0SKxpOnjOYMUFqXC
        2g/4btq6LsHpPnvPiT4U7m6NZoNruM2fTyKvaetZbwgQEt1P
X-Google-Smtp-Source: ABdhPJzaNZrVsv/ryRJA4dYhFRa7Wl7b8vkqC9i7fTKA8LG8K0bIRf6d4VRk5Ctco+HNQXG4iijusTwsrvVnvfJWIrj+T4KamXcH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d0d:: with SMTP id c13mr5543282iow.51.1613766308788;
 Fri, 19 Feb 2021 12:25:08 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:25:08 -0800
In-Reply-To: <000000000000e29ec405bb8b9251@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096022805bbb63f35@google.com>
Subject: Re: general protection fault in mptcp_sendmsg_frag
From:   syzbot <syzbot+409b0354a6ba83a86aaf@syzkaller.appspotmail.com>
To:     davem@davemloft.net, fw@strlen.de, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mathew.j.martineau@linux.intel.com,
        matthieu.baerts@tessares.net, mptcp@lists.01.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 40947e13997a1cba4e875893ca6e5d5e61a0689d
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 12 23:59:56 2021 +0000

    mptcp: schedule worker when subflow is closed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1541a434d00000
start commit:   773dc50d Merge branch 'Xilinx-axienet-updates'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1741a434d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1341a434d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc1ca9e55dc1f9f
dashboard link: https://syzkaller.appspot.com/bug?extid=409b0354a6ba83a86aaf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16548404d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150c2914d00000

Reported-by: syzbot+409b0354a6ba83a86aaf@syzkaller.appspotmail.com
Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
