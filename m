Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4B3FE732
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhIBBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:35:10 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:36391 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhIBBfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:35:09 -0400
Received: by mail-il1-f199.google.com with SMTP id s15-20020a056e02216f00b002276040aa1dso129397ilv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 18:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eCBaAjhiQ9w8mLGGTf4y2S5ooafVmimcQTh9DS+sy1I=;
        b=LXWPL7WoJOBNt6Vf2hIwuNqT0nle7rwTRxttl7/QicXOPBwkBam1QmxcYsUvbpqoPu
         QqK5Bx6gNlk/KoI9o9vHXH2fQKxAaci3MqHowbR2aCB29sVZUH1AuQZYsYkLYO5AtqfJ
         XD25kq3nP/vTIFmb4oshsv3E7jILcoMcYgdscwFmgcpITakHvpeVY3vEA6wBSZam6s4z
         HNei5sLc965Nkd55xaUyepTeNRRGto+UaJACdvsvGlQkEQB639HXZeXh2LNp5b/MEWs3
         mwqesn8Yjf3HMK58wfnQYpyGePdGsNYEV+gs9GLw25ty4ukeVSzHAwfsFZvZBYuDM6ei
         55vQ==
X-Gm-Message-State: AOAM532hPskyEerCCKHaV9p75sayvODsPepFp8lCMxOD0xMLzPhoRKgS
        3YlFEtZsJZEsr1Pvw9TS5zQ22rmSXlG86Xac/a4mdXMRkrwQ
X-Google-Smtp-Source: ABdhPJy7YbQOhifggTgvwQ1ZQFRbtvh13nQVZvAK1NEPE5pzyvQ0i+/WLbSyJhTpVilAxNa9Vy7XmtqTqrokDGUVsBCjNxA6Uq17
MIME-Version: 1.0
X-Received: by 2002:a5e:d60e:: with SMTP id w14mr638638iom.135.1630546451511;
 Wed, 01 Sep 2021 18:34:11 -0700 (PDT)
Date:   Wed, 01 Sep 2021 18:34:11 -0700
In-Reply-To: <000000000000b1c39505c99bd67c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000840d605caf92e8e@google.com>
Subject: Re: [syzbot] INFO: task can't die in __lock_sock
From:   syzbot <syzbot+7d51f807c81b190a127d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, desmondcheongzx@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b7ce436a5d798bc59e71797952566608a4b4626b
Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Date:   Tue Aug 10 04:14:09 2021 +0000

    Bluetooth: switch to lock_sock in RFCOMM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f90ffe300000
start commit:   29ce8f970107 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f90ffe300000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f90ffe300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f9d4c9ff8c5ae7
dashboard link: https://syzkaller.appspot.com/bug?extid=7d51f807c81b190a127d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1630a66d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d07c6d300000

Reported-by: syzbot+7d51f807c81b190a127d@syzkaller.appspotmail.com
Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
