Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359F441042
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 19:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhJaSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 14:51:45 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55917 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJaSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 14:51:44 -0400
Received: by mail-il1-f197.google.com with SMTP id e3-20020a056e020b2300b0025abde2b7a6so8705360ilu.22
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EDfj5ne47rqVe1CydX+aYgYdcHr5k4W7I1Ib2hSVKPQ=;
        b=kZOtdCf/e++N/EZ6xXBQwwTadKQwi1Vg0GN2Wg/ncGiwxHpeHnySAJUc4j9Q5UTwnm
         sjgAVGutMwkeRIHgqKAWx76Z8lsBK7uH3sEnVoeQPQN9QETJeKZMGOvEW9Hsfg8yhTuH
         9CQRr8sPCTke6m44x1ojsQgbHSxpT8B1gUfAcLVvwsj+u0nB/2a73mgCNcoRgX9mLEUM
         5nGTDCHHohphTI1YNcfsYQwD1e7KzVR6IjCjbJcp3ObrMnjTxad5f9TNV6j8j01nX1yv
         7mgr7c5GLb6tMM3FO1yGCFjtWcR54WASESBKiOAiDYL7GRgfbsVDmd/qGXbbHzD1A1Ii
         D/Bw==
X-Gm-Message-State: AOAM530p6cw0pBaN2Cm6Z7AZz7o35f1JhdbZw9Ew9uiiVorYRr9sPVjQ
        M6Fsed2Ymcfsx6qAfPYyTOjdLKOvfklAGXlOCfMtIi4J7Zqt
X-Google-Smtp-Source: ABdhPJyOG+lTecw5XF3nfkAPSpnl6M8hQQ/dDGVasqzB2YT8aLiWoViqcJHVGaVKr5kPojVr1ebi8CChphSOdx01Y5mQi4o/Pg9s
MIME-Version: 1.0
X-Received: by 2002:a6b:650f:: with SMTP id z15mr11810710iob.27.1635706152392;
 Sun, 31 Oct 2021 11:49:12 -0700 (PDT)
Date:   Sun, 31 Oct 2021 11:49:12 -0700
In-Reply-To: <dd579644-7ef9-f005-0275-b7384ca731a5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ba17d05cfaa8446@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hci_le_meta_evt (2)
From:   syzbot <syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e3fcb9c4f3c2a931dc40@syzkaller.appspotmail.com

Tested on:

commit:         180eca54 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6362530af157355b
dashboard link: https://syzkaller.appspot.com/bug?extid=e3fcb9c4f3c2a931dc40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1295a186b00000

Note: testing is done by a robot and is best-effort only.
