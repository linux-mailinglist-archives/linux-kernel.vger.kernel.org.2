Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BF3F3814
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhHUC3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:29:46 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45937 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhHUC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:29:45 -0400
Received: by mail-il1-f198.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso5444658ilq.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iHf8LUR6Ovn1Eydbqz2P3rlkkwnXm6QsDeIBC7GD3Qg=;
        b=RRv00xlCEl0U4JUgrd5pj9V9qWsRJAgJnsH/eVar+zf07FH2mvrdkrbiJQQMvrvcsL
         naappkSuEzuBfxGeobm6Vq7a2IlGKqqx5mpT9ByvCxHMcUyzQWwp1oe7SW+pxdqomQLh
         4vwS989cE3/lJQKIeru5vFu17VaiK7KQPSWhg8+xiUVoLWf9OktHNRQ4YmRrq9rueGPS
         U92nf85uhvx8M7e805rOXNv1o6tFtxgEK2470K2pKgzaZA9zwR/hTrsAPOGjuck5E0ME
         DBjHsrdDnbZHY6ZittU5kQp4KW43tVrdPPNnOhaalmeOzaQZc9+xKUFIQ/w+oXE4Asf3
         5VUg==
X-Gm-Message-State: AOAM533a+68TWOiQHa6PnQWf6jTDIW1zhsLbD/8NKt6X8PZQE6rnL3I8
        USuqsXEO/iArgYMmg3eOjw+U+8eLvVI6S8cK/csWL91Phk9g
X-Google-Smtp-Source: ABdhPJzK0a8DAE41lfsQEjn583iPFBrbzLkXnZnYep9X4S+LuDPXekPfSUKswjhPhf9qYgtRx0WLpEqRtx7gWnRPEARQrCKJT9xa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr16040022ils.282.1629512946491;
 Fri, 20 Aug 2021 19:29:06 -0700 (PDT)
Date:   Fri, 20 Aug 2021 19:29:06 -0700
In-Reply-To: <00000000000000410c05c8e29289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000552aaf05ca088c20@google.com>
Subject: Re: [syzbot] KASAN: invalid-free in bdev_free_inode (2)
From:   syzbot <syzbot+5fa698422954b6b9307b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, balbi@kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lorenzo@google.com, manish.narani@xilinx.com, maze@google.com,
        netdev@vger.kernel.org, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 63d152149b2d0860ccf8c4e6596b6175b2b7ace6
Author: Lorenzo Colitti <lorenzo@google.com>
Date:   Wed Jan 13 23:42:22 2021 +0000

    usb: gadget: u_ether: support configuring interface names.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155abcc1300000
start commit:   d3432bf10f17 net: Support filtering interfaces on no master
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175abcc1300000
console output: https://syzkaller.appspot.com/x/log.txt?x=135abcc1300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8075b2614f3db143
dashboard link: https://syzkaller.appspot.com/bug?extid=5fa698422954b6b9307b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174ebaf6300000

Reported-by: syzbot+5fa698422954b6b9307b@syzkaller.appspotmail.com
Fixes: 63d152149b2d ("usb: gadget: u_ether: support configuring interface names.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
