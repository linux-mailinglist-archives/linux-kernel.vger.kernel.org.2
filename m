Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FF3205AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBTOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 09:25:52 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:57076 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBTOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 09:25:51 -0500
Received: by mail-io1-f71.google.com with SMTP id e12so5967327ioc.23
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 06:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=a91c5n0ii9aP4HgGhtETSQKNnFL6/0EJudj3NNorr2s=;
        b=T/cfPaA62I4tIuRvknufWyYlqCPvOONEEwz7B6pEqjsJoc6DshDA87N14fINr1smTs
         1skq0Al5ByaUWjpSY/8coGvBg+3R/oqPkr5cXGl/CBk8+GG7WxghrMciUQmk0NqM/jcT
         9f9tunE4PlMaiLI4xYhysi4JXOEsodc6EQenI7EKrpmk4GKI+2ty5UNYOoDZlgOzqDe2
         Hmtsfhi6MhZDrbG2iUzhEJQXyq/PSGxk9QtVDIA77EvSN1RqIFZJdf9DimWzHO9NphFR
         ydB2l5ox1Rx51ZT9kjxRGRkwVDr3YPwhVdAGwlZP+3qPrlifWaz04Bw/Mn4NGoTY0uK+
         VGYQ==
X-Gm-Message-State: AOAM530+VnvHMgkMGOuEcxunbaR+nngaZ1hNSRXToKF4Y1K0nCe4Q3j2
        Ey6ex6R2atMMIpK7ChfTwdBQFRpvrJcvisXbXDh8Yog8aKHl
X-Google-Smtp-Source: ABdhPJzz69vvOCX7SlZs7Bo/yLxkFUPjMwgpwbS5nX6FYFVGDvIQKzX7XItkxnV3ANQ5J6ZDJomv1AjEFTW3v8kMnhJqI7gu0FpH
MIME-Version: 1.0
X-Received: by 2002:a6b:8b83:: with SMTP id n125mr1787866iod.35.1613831110168;
 Sat, 20 Feb 2021 06:25:10 -0800 (PST)
Date:   Sat, 20 Feb 2021 06:25:10 -0800
In-Reply-To: <0000000000001fb73f05bb767334@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ca18b05bbc556d6@google.com>
Subject: Re: WARNING in iov_iter_revert (2)
From:   syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9bb48c82aced07698a2d08ee0f1475a6c4f6b266
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jan 19 19:41:16 2021 +0000

    tty: implement write_iter

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1009a9f2d00000
start commit:   dcc0b490 Merge tag 'powerpc-5.11-8' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1209a9f2d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1409a9f2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1106b4b91e8dfab8
dashboard link: https://syzkaller.appspot.com/bug?extid=3d2c27c2b7dc2a94814d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1346ac60d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123eae4cd00000

Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Fixes: 9bb48c82aced ("tty: implement write_iter")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
