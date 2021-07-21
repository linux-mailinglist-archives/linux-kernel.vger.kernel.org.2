Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5B3D14A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhGUQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:12:40 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40827 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhGUQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:12:37 -0400
Received: by mail-il1-f199.google.com with SMTP id a18-20020a92c7120000b029020757e7bf9fso1921760ilp.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gxyqQvbXalzs54ThUrwETt9kFkgligD2HIuxmfdETBQ=;
        b=hYuh1exVRKsWbmjLO3mi6FPMgxVcjvzb0Xgwe0+KMnW9YirSOZV1KPSwuGHumw3QN9
         Lm2GrgzEHqdqZiMQ0Afsm3fwgIUClGYoHcTgxEa9AnobbG0NT4ojt1BjOS4g7NxFXXs2
         JLEF0B+1j+35kG2CnMUWWOGvnjmO0q8XzyH0QgGG1OhlcmgK8lNudCnqzvEgsf/G6Ao/
         N69xx8dNShq/nvi/3qesYi410BrjXsd7Mg3dgwOuUJLtM+dAAK334gL9s6nWj1OldCNe
         2sdwGQVcJTRhOGnWTVXdrypMMB3VBibEe3Lp3c5UC7wtGim2jgFkITH4SlwBwizyt+ng
         w++w==
X-Gm-Message-State: AOAM533w9cT0A25L989Fo2MgznX2zbVKtJr0/6dH9VJi+yNMX1YtyG/L
        zRaQbK2MBc6Lc1sTkk/GQ8dyAmlJK/L3qmr2VbIvMud84Pov
X-Google-Smtp-Source: ABdhPJxs3YL4DMoh9YXP6oKHGFZzawFBVEXzfEdTgQWajC/iEbeG9HpwgfC30tgN/zbRaL9qcDCGYWliT+MBKtJAOlkNt/LCBF2o
MIME-Version: 1.0
X-Received: by 2002:a92:b111:: with SMTP id t17mr25820868ilh.208.1626886393308;
 Wed, 21 Jul 2021 09:53:13 -0700 (PDT)
Date:   Wed, 21 Jul 2021 09:53:13 -0700
In-Reply-To: <20210721125710.1a1c041f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000902d5d05c7a50171@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in do_wait_for_common
From:   syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com

Tested on:

commit:         8cae8cd8 seq_file: disallow extremely large seq buffer..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=300aea483211c875
dashboard link: https://syzkaller.appspot.com/bug?extid=cc699626e48a6ebaf295
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1174d0d4300000

Note: testing is done by a robot and is best-effort only.
