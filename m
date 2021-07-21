Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E523D14E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhGUQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:31:34 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38523 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGUQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:31:33 -0400
Received: by mail-io1-f70.google.com with SMTP id s203-20020a6b2cd40000b0290528db19d5b3so2043340ios.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Y6Y4vaAAE0NKEq1EsKmEUMtdOo6howUC6ShUJPK7rvY=;
        b=gEPZx3wgyVJtWZicnNCGxR0ztn7ngEtpa6m6bqzVui1VMA/KY+71CbPtIiyWddIL5y
         m6iQUV1NvDlLLdsORSy1NF063tPUeb9mmcsHljqSpEyLLPj37nnpcNzUJ+9qcL/IvYbN
         Zm49jYdGbDQedc5iZ+9BmX5QXc6Izp50a+gm8csnsiF7kadTZ/y6ynJb4Pr7MdBp4tII
         gdInJg99Yshy3lSpvMbc+H7YH9SYeMrK1Ve7vbxE+jiUrnXsAKiXf5oVPZgODgr5lgPk
         gfHPX3EUl76lFlr0ZcYOoEeNWvtWvF24P6i/4Wi7FSfo7jukmPY0pkgVM8lTuagywDWO
         WlbQ==
X-Gm-Message-State: AOAM5331sGcGReBetTgDXkmA7bTvZUKNhrOnhTDaVZ0IH+VcjHklp+F9
        13v4j/AnakftZCIn3mdHxpiS/Exd/FZxTy2KsHeEqAvP2XFh
X-Google-Smtp-Source: ABdhPJwOcoCWNrFNs7X5bO4INkmOxb/0VbZ+2JV+gC5QQQzrnTq80EKiEfN0a6IyAyRs0n40t/rA5mYatxazN77t71VCI4vUJf0b
MIME-Version: 1.0
X-Received: by 2002:a05:6638:538:: with SMTP id j24mr22358891jar.59.1626887529635;
 Wed, 21 Jul 2021 10:12:09 -0700 (PDT)
Date:   Wed, 21 Jul 2021 10:12:09 -0700
In-Reply-To: <20210721130143.396c1626@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b212a05c7a545a7@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
From:   syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        paskripkin@gmail.com, rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com

Tested on:

commit:         8cae8cd8 seq_file: disallow extremely large seq buffer..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7dfeb6dfc05ea19
dashboard link: https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11291aa2300000

Note: testing is done by a robot and is best-effort only.
