Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080CD45CB53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbhKXRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:45:34 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50987 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344775AbhKXRpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:45:20 -0500
Received: by mail-il1-f198.google.com with SMTP id i3-20020a056e021b0300b0029eceae8532so2364670ilv.17
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 09:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h0kvn1BdxoP46i2HNoKMazuHRf6SKPJskeY6V4kDJOE=;
        b=nv+hnc/qp97ULsFEyL6QRNZs2lL1S1O0zlngAl3JgRvSHMHWdPPC2YSndQdAPy1O2J
         cbNAb3OUKl7mQqUgTphn+PAiL1L6MOJtRoX/b7yQodAGoVd5+2srVYRKiHYmN3KKfLZN
         xueINB2TqHVhfB7cXwqgsFqN7o223nQOz6fqzhu58zn6TSQXZv7XjPtWVKRLBouNXkjX
         ohNl31OrTCQGvMFsTFh3f77LoirXAPWnyN5xf6Ha7kliPV2E0SgysBVFTteTOyXbBGee
         U5JbdIBME7oklf60b5INt/4hgpGCQnRhq7D6IRTOYT/ZJRWIX0x0gFtzVhAcmx+65kCj
         T0LQ==
X-Gm-Message-State: AOAM531tVRG4114zmaTNhneq8aGyAR5fXj6Vjzsg02clmcEjyWe7nezb
        vTTC7fOpY8LeL9oKxKDVWoOjCHactGoe+5tEt64NcF1UmEXd
X-Google-Smtp-Source: ABdhPJwb7HvyUqHy3UoRecfI82f0bvHWHU2TDeSHzrJEyGEuUEO081UcqCkKr9ePW6QOXrKgj7ioth7zzj1e0gFO8okXtgY78HTC
MIME-Version: 1.0
X-Received: by 2002:a5d:9cd4:: with SMTP id w20mr17292523iow.178.1637775730232;
 Wed, 24 Nov 2021 09:42:10 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:42:10 -0800
In-Reply-To: <000000000000ba80b905cdcd8b19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f52f205d18c60a7@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in batadv_v_ogm_free
From:   syzbot <syzbot+0ef06384b5f39a16ebb9@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, a@unstable.cc, amcohen@nvidia.com,
        b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, fw@strlen.de,
        idosch@OSS.NVIDIA.COM, justin.iurman@uliege.be, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, paskripkin@gmail.com,
        praveen5582@gmail.com, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, willemb@google.com,
        yoshfuji@linux-ipv6.org, zxu@linkedin.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 6f68cd634856f8ca93bafd623ba5357e0f648c68
Author: Pavel Skripkin <paskripkin@gmail.com>
Date:   Sun Oct 24 13:13:56 2021 +0000

    net: batman-adv: fix error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114e3c16b00000
start commit:   cf52ad5ff16c Merge tag 'driver-core-5.15-rc6' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9479508d7bb83ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=0ef06384b5f39a16ebb9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17af7344b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dc02fb300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: batman-adv: fix error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
