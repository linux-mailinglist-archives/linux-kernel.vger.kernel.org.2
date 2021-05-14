Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0638016D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 03:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhENBGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 21:06:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35751 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhENBGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 21:06:22 -0400
Received: by mail-io1-f72.google.com with SMTP id l2-20020a5e82020000b02903c2fa852f92so19191193iom.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 18:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WyhwVb/2nAKSCjZePQHr7y74mXP0pKdra5nG2NU9qyo=;
        b=Bd7MrcAI4pSD0Ovx9SA497LIP1ZsTHJx3rLZr2gqT0TM4IO6xkZTwREB6ooq5wx+zn
         j5DX8F83FR6dpkmVWVzcpMULkvbN+z7RJe2nQO9/wWqQswODxI/HIcAMMnDfX5Wn0oeY
         8x5VrIpo8XWeiorJDmO+rTcbiMsKWaNlhs3Vrties7YvqqltP10TjDbBp8o5542qb5ZU
         3mpbG7Yv1eZjk2KLvIyHSbDCrGxdgwzfWE3Orl3nY0NpIPXUggR3G0huRKC4WHQgp1GZ
         GrSHWfpFu0aTXsLH/JEmomPHgX7NtHEAYBoeHkM/rmq5n5Bdg9SqJ54QFYD5XjHBzo7c
         td/A==
X-Gm-Message-State: AOAM533m0XfF/lYLSOD9jxbJ21Z5zv5Dm5D1xtpRjzdGy9/9HeyNTxn1
        f1+rAO7l/dupJRy4KN0EPeqlDwQgnZ6nPP/B0qSQlclilwTA
X-Google-Smtp-Source: ABdhPJzQ/Z36cpwXZM75ay+7M7e7JrJdMP6eFRSLZrA/471M4WuQmbzCyB4PZILkNutR+YB8DeBbVbSICSoaUPSnk/lGLMld8n6k
MIME-Version: 1.0
X-Received: by 2002:a02:cac6:: with SMTP id f6mr40166255jap.118.1620954311158;
 Thu, 13 May 2021 18:05:11 -0700 (PDT)
Date:   Thu, 13 May 2021 18:05:11 -0700
In-Reply-To: <314c4ece-d8c1-2d13-804b-3652488d09de@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f47605c23fd526@google.com>
Subject: Re: [syzbot] WARNING in io_link_timeout_fn
From:   syzbot <syzbot+5a864149dd970b546223@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5a864149dd970b546223@syzkaller.appspotmail.com

Tested on:

commit:         b580b3d6 io_uring: always remove ltimeout on cb run
git tree:       https://github.com/isilence/linux.git syz_test8
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae2e6c63d6410fd3
dashboard link: https://syzkaller.appspot.com/bug?extid=5a864149dd970b546223
compiler:       

Note: testing is done by a robot and is best-effort only.
