Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5E418D22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhIZXpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:52 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47863 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhIZXpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:42 -0400
Received: by mail-io1-f70.google.com with SMTP id t4-20020a056602140400b005d60162d0c4so18591930iov.14
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tLzYMHFQU54QxspQLo1Nvo+4ajUKXuHTVr1Hmohf8xk=;
        b=3qAVZlkdWdF8NXY6P8tGW36+ly3lDRJhbm7Y5zgu6NzNjNfsHIrz+xG8KpE1lQjfFy
         vml9ZSJWwjI1ySohjd+cSEC+TbP/408XGHXneV2tAXDGpIFiQjDxHHzFytVxbJEymbp7
         6lUmoX1vfg7XL+vnrWQi+j4dUK11b3DnBkouNMQpH5lo+31clt4k1JIC5bFxWmyyl4Ol
         QynY/Ntnvvi14cwfDNWftmAlsPC/jpq9hTgrcS0hYd1MDp/8oxFxz4ZOj/rSd6KmUs20
         FDFKC5UiC1rxVfxJ9wjfqxvuH7ZHAWIcbxvhxf08hIS6W5PMX3PuXgCB1C/MAxwdn89b
         8Yjg==
X-Gm-Message-State: AOAM532wvWekNLdMkw2QUVEQLtD6c4uq2Nu0er1ww3hiCeVpa50iOa5Z
        wBt3upImwzRmxj6JUoeVpw3Wu1pSjWDBSIUm7Gz/3lN+YJax
X-Google-Smtp-Source: ABdhPJwX8M/NC4qXMTO3R9f7IvI8Lo8yPMy1b0BE5mu0VRuawoyAM9O4BbtLw89xMXJDN870pGsgdPmWIMHE60Bcz5DSfXktU1wQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408f:: with SMTP id m15mr19065852jam.94.1632699845593;
 Sun, 26 Sep 2021 16:44:05 -0700 (PDT)
Date:   Sun, 26 Sep 2021 16:44:05 -0700
In-Reply-To: <35d0ddc1-41cd-16fb-41ea-5529d19c04d2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005252e105ccee8e1b@google.com>
Subject: Re: [syzbot] memory leak in __mdiobus_register
From:   syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com

Tested on:

commit:         5816b3e6 Linux 5.15-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41799858eb55f380
dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1147b840b00000

Note: testing is done by a robot and is best-effort only.
