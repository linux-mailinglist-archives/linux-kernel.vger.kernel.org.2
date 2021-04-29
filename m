Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AF836EF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbhD2SP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:15:56 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:50013 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhD2SPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:15:55 -0400
Received: by mail-il1-f200.google.com with SMTP id c10-20020a92cf0a0000b029016baf18aee1so35515369ilo.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r/V3F/1bnZMKmRFzFAEWeq/yoMvyb9wXT3VqY/klpPk=;
        b=AQ8EhmnTKfmcGUyDoGFWMLbaim1GXPhlQB80Pk920z/KjwZmUaa5nRR7VLKZ+1S9ZR
         dLcn5YRgmVHkkSiTZayfN83OE1lEwZ7Flhhzgx0wzIMulnVHOwmHJAEDyvmtA3H869/G
         Qbat1N5foZdQn9shSy60fCsMErodm3C/lX6gf1qqVi2lVe4a7SprG5ApNv1gp2tFPu47
         xcVkQws7vpOzsX2A26tT4WgiWnmrcfBfC6h6c2jXQeQ1Z/azXtgjb+02ShG3HCuGavdD
         RB30ma3SE6lllEAMfdxbTi39H4E2yCG13OAMpUg26d/lt9FJS41UE+nH5mp+aW5SRxgW
         nRAw==
X-Gm-Message-State: AOAM5309grHmZHlarE5V4nNmmUOvt13vINnIq2twgHCZNrcUbJTA/HL9
        XjDE2+B5KFM/w8dNxu0ccNhriszJ75KWkofi5zoRAMTYIXHY
X-Google-Smtp-Source: ABdhPJz3StFhNnV44iXyZPONVHe2gH61CmFOR+bR9R3jyr3oDcfWqc6XJwXqpimXGBIbR3inwZ0QiSVjwFQKvxz712vOlhvYPyjS
MIME-Version: 1.0
X-Received: by 2002:a02:ac05:: with SMTP id a5mr1042298jao.89.1619720108542;
 Thu, 29 Apr 2021 11:15:08 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:15:08 -0700
In-Reply-To: <8eec9ad4-3341-f136-0983-52f3c687f9da@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b48d0f05c1207964@google.com>
Subject: Re: [syzbot] WARNING in io_uring_setup (2)
From:   syzbot <syzbot+1eca5b0d7ac82b74d347@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1eca5b0d7ac82b74d347@syzkaller.appspotmail.com

Tested on:

commit:         0c8ceb80 io_uring: Fix premature return from loop and memo..
git tree:       git://git.kernel.dk/linux-block io_uring-5.13
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d4238f574736e51
dashboard link: https://syzkaller.appspot.com/bug?extid=1eca5b0d7ac82b74d347
compiler:       Debian clang version 11.0.1-2

Note: testing is done by a robot and is best-effort only.
