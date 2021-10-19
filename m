Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB243402B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhJSVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:11:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52972 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhJSVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:11:21 -0400
Received: by mail-il1-f199.google.com with SMTP id h6-20020a92c266000000b002590d9f7d14so10981862ild.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zv4Ff+EvirxD9Sti+DPatT77gsB6mvVIfAn+44z0Cf8=;
        b=YogKYXsoxMeo3udsYxjMvT/NoJMV9yho021ZHQOUNeFLXAWmR1l4e+faOKVxevg/Zc
         y2emZBIq+D5Ewa7yTdFPJ/CTMOXyvsrOm8Vj7bRjspJqZZfGgY56zcOmIGe6uBtfhO/2
         Rg8roGWIeptUo91cCITAScfFyvjxS7pVHyPzEhTODEDjik/Ysq9ajp/lDwFc/zWwfVdU
         A0IS2JYFH9Jyvxdbwlbgug+o+duNBrRZDYzY/35BQT9llJ3uNXgNhQi6is9xVS5kemkE
         vdMazAssUJFty/l99HxBwxB2O3US6a026NcM733KCQPQkVdtLgyBcEX4nnJQzGRz/kCK
         QhxA==
X-Gm-Message-State: AOAM532htOLH7TtyTqJPTUKT5b2RIH7s43nb5dMwChoOCuh6ko2H2MU0
        aZf/mkFnrZsjBRinGCvv9QsH5f9/5gud+HA85dnbvpuuKKiw
X-Google-Smtp-Source: ABdhPJzLYFSTrQZlVF6KtsED28EZgP23hSEbF0h5Qnz5TuhAwjS5tV/Ty7UnPxCZ1gy7WhBDFIjl/kQ6ls1FrBpBH7aREnB92H/K
MIME-Version: 1.0
X-Received: by 2002:a6b:fe05:: with SMTP id x5mr21247279ioh.201.1634677747302;
 Tue, 19 Oct 2021 14:09:07 -0700 (PDT)
Date:   Tue, 19 Oct 2021 14:09:07 -0700
In-Reply-To: <4617c408-b7f6-8861-4307-ed0ec24283ea@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073441e05cebb127c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rtl8712_dl_fw
From:   syzbot <syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, agamkohli9@gmail.com,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com

Tested on:

commit:         8ef1e587 usb: typec: STUSB160X should select REGMAP_I2C
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=c27d285bdb7457e2
dashboard link: https://syzkaller.appspot.com/bug?extid=c55162be492189fb4f51
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164527c8b00000

Note: testing is done by a robot and is best-effort only.
