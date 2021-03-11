Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173CC337114
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhCKLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:23:16 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51789 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhCKLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:23:06 -0500
Received: by mail-io1-f71.google.com with SMTP id i19so15066971ioh.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qScJAsVqiLCAZiMkRhSrWcXvKvZ+jq59kdTDGHwxDPU=;
        b=XtcuzYqNsvjDz+toWOZP7Rca9ZDJFf+XYmi5iOPzg1ykRrpZO40zgcH+C53YP8d/21
         U7MHhDw1gfwXstQsoBNZ1iJifMchSw3lm1NumhG5tS+DytPuUBOFZwhi3ty8X7CdsO//
         +8Km7GRgHuqBQyKOBTvvFMMzn2MqYeoEPlbH7lx/mDLII5jhTP5sygiHTrN2DUoNIQrZ
         LfU26OLStBkfphTKRAPTKq/4slj/3vISkUMz3KXgtxLqdk7FdL8A2IU6LZ65y8R9Q2HP
         tpMXl6D0QR8jsIebzNEIQSaAZNWOoznemiksWIqbrBwnJbrNF3pYuCR4ruqEJRGRpNW1
         haug==
X-Gm-Message-State: AOAM530BUslIu3DX2aHxCZPvdYKo/W7RgfKmpKSpFHunrhqvGmjqv+nr
        b54AWjX20PNtoLe/Rnu+gn1yKGAKZWCXedv1YvD1275aGd4r
X-Google-Smtp-Source: ABdhPJyjp2LmvUvQqMH2oXOpmTpdsQkTiOipBhAeHXO8N0+yuACX6iHRsEFH9FkGfir2L4t+3Wx40sSWC4fMzsux2vCV59Sn2ubG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr5842573ils.39.1615461785698;
 Thu, 11 Mar 2021 03:23:05 -0800 (PST)
Date:   Thu, 11 Mar 2021 03:23:05 -0800
In-Reply-To: <0000000000002954fa05b02468d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e287c905bd4101dc@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in squashfs_get_id
From:   syzbot <syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, foxhlchen@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e812cbbbbbb15adbbbee176baa1e8bda53059bf0
Author: Phillip Lougher <phillip@squashfs.org.uk>
Date:   Tue Feb 9 21:41:50 2021 +0000

    squashfs: avoid out of bounds writes in decompressors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bfa48ad00000
start commit:   cd796ed3 Merge tag 'trace-v5.10-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=59df2a4dced5f928
dashboard link: https://syzkaller.appspot.com/bug?extid=8e28bba73ed1772a6802
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1138f80f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125e080f500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: squashfs: avoid out of bounds writes in decompressors

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
