Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5245F273
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhKZQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:52:27 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56223 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhKZQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:50:22 -0500
Received: by mail-io1-f71.google.com with SMTP id y74-20020a6bc84d000000b005e700290338so12154430iof.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=E3SZU77OvG0V43pQYfeC1jMV8oQXDfgfTFhN98Th00Y=;
        b=WDPAFPjOW0s9Rq1nxx32ulge4jOxjxUrapJDozuOut7yJfgAijaV237gBihaGsBLKH
         i4otHf2s5jcJZjIuJxiTtwrqsLhOCIQIKCoDEf9acJFGzosM2yrmgCaDS93miy0cRGZM
         F+HzK0ku5fttooz4G2/NkoCJR/TDbuSX3dChUWopCBcwfuy5UCoVrcdz+gSbgaCBLKSZ
         qbwqiVnGmHgpsJ2J9XTv7qpd2sNlfiNDPDj6vBUcJ65o/xG0h1P4FU1eoWLxH2jPGXUp
         0MWJlSoAvs5yHbRJA9pk0creQXEwsR39E9xwfC1XTxJvRzsCTqH+3fFyAwpjNpZM41Ky
         gZsg==
X-Gm-Message-State: AOAM530ERWE4r6TITf9gyoDgFcH/JUtDaBc9ujFDcYQUufd80pxRl8d8
        l0yn2t7endEB3rgrZJ1rK4YFVquDRnNPg+VizXT3K31otrEb
X-Google-Smtp-Source: ABdhPJxa08KUq2MMDJ1aTzNQi/UsWNU0/4EepC/SG32d6AnThd3Chiw0oY+CcomOpKqgzD1VRBsYBUGPiOmiTWCB1LYJXM42xT0m
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2103:: with SMTP id n3mr43636451jaj.25.1637945229555;
 Fri, 26 Nov 2021 08:47:09 -0800 (PST)
Date:   Fri, 26 Nov 2021 08:47:09 -0800
In-Reply-To: <0000000000000a389a05ac5a9864@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091c45705d1b3d7ea@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in l2cap_chan_put
From:   syzbot <syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, bobo.shaobowang@huawei.com,
        cobranza@ingcoecuador.com, davem@davemloft.net, ducheng2@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
Date:   Wed Sep 1 00:35:37 2021 +0000

    Bluetooth: fix use-after-free error in lock_sock_nested()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141cfa45b00000
start commit:   c70672d8d316 Merge tag 's390-5.9-5' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
dashboard link: https://syzkaller.appspot.com/bug?extid=452e9465a3b2817fa4c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f31f9900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
