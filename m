Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701840080F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhICXJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:09:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37853 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhICXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:09:10 -0400
Received: by mail-io1-f72.google.com with SMTP id h3-20020a056602008300b005b7c0e23e11so390147iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=N5d093UwZv3h4qJ5IEJdxCx1t3C+wte7ngv0XxPDuyU=;
        b=TcP7xEqyH4ae+7gPyX2nTttjIuYgiLU39OQv6NAj6gRTZB5I7FF+biShIDIpygAy5J
         NJWFv+U6vPnU0g+EvtVT6gKLeHOQ+vUFnyUs6HuZfZ6r+e7Dp2rQI4Xof3stEZQfeNzF
         lNInDYWFNWFcL/68eZeikJDipHZwHg28aabpWT6nFV8j1J2PBpYvFAzMq58VxIbPnS1a
         kgTRT7pASNpJR8ehrXeiQL0McisC18bDFY6NwULLSGpm/n0KF2FxuPvw5osyuf2J4ygc
         I7fZuNXuQuLX89WP/WBBmz/TSE5SB/rUUEyi1kTZAPEhlxfWvEAxMcBQlniZ3sSVsfsC
         DCEg==
X-Gm-Message-State: AOAM531QFKfj9Zs5wrVBUmAS02MgKd7fr4mENVhLs9dnh+EDwpCg5WRm
        eoQBhmLqJT+lvsFtu6wtb5LmuiK+H4s92ZqNHwi/3jwZ23Tq
X-Google-Smtp-Source: ABdhPJwc7eZ+XDxlXIWj9wtCGs/WMLS+ApAM+Q60oiBtj0cht9k5RDlrRhqVvFCAanCbKgrGN5gUcz90yu9AHhgymHP7ZUqHOJak
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr902366ilf.319.1630710487901;
 Fri, 03 Sep 2021 16:08:07 -0700 (PDT)
Date:   Fri, 03 Sep 2021 16:08:07 -0700
In-Reply-To: <5a93ff90-98be-b5af-29e9-a2f8cca82458@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ceb2c05cb1f5fad@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in kiocb_done
From:   syzbot <syzbot+726f2ce6dbbf2ad8d133@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+726f2ce6dbbf2ad8d133@syzkaller.appspotmail.com

Tested on:

commit:         31efe48e io_uring: fix possible poll event lost in mul..
git tree:       git://git.kernel.dk/linux-block for-5.15/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa8e68781da309a
dashboard link: https://syzkaller.appspot.com/bug?extid=726f2ce6dbbf2ad8d133
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
