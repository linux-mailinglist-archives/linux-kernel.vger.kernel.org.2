Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6348039E989
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFGW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:27:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:54259 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFGW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:27:14 -0400
Received: by mail-il1-f200.google.com with SMTP id q4-20020a056e020784b02901e2ee9a8333so12971602ils.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 15:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=b6fHq6inNIhipW1ztkPlqvY4f9MP6CcM1fFIRec2g9Q=;
        b=iAYtAmepyNBSKLfcwYQQ3b6m8sas7J8fFdx3RMP6z8nBUJGty4X93qhXgu/k5ZV700
         oI8g2pcHcipYXuZbTeNhflAU8cwr+PKGUPfuZziq8GyTvrkCdOzQY9zj5OGgUhyFhOU7
         P/HonxbizYnRLuESk6Q6WbrNHOJK6TUDEwXGY8whHiI3HZeKG88KGm/PeKfIJyHf7tWE
         sROH7yy3z6MsKszr1MW7TSQ3vGOLnXOU/tEQXJNtskTse0e+IYXpoZ42iL/4uRE6FOOq
         dPxP2NkoFZRlxG50RCrwMxxfsEig1BZlwmEF7D37kjkU06AlpTxBfj5PvX65sMz9M3wp
         X6TQ==
X-Gm-Message-State: AOAM533+JU/x+RdowaNwmJobce2YXbBFJKHgZPWdvEB3eXJTV8/CF+rJ
        +gnDc+TqwhZpuEnyOJ5Ffp4XI340p24Y8Zo8EWPbHWXxImhi
X-Google-Smtp-Source: ABdhPJwtAcTvPmWHX1yhNgZvplxVlg3Lq4Iy23LPMcdSinVbgK/jgNTPKiwR7uQG+A5JZN6RstwFjKbGZgb+FMJKPmXgZx7fH8dH
MIME-Version: 1.0
X-Received: by 2002:a92:c98b:: with SMTP id y11mr16544524iln.27.1623104707679;
 Mon, 07 Jun 2021 15:25:07 -0700 (PDT)
Date:   Mon, 07 Jun 2021 15:25:07 -0700
In-Reply-To: <000000000000adea7f05abeb19cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088dbd105c4348388@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in hci_chan_del
From:   syzbot <syzbot+305a91e025a73e4fd6ce@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, anmol.karan123@gmail.com, coiby.xu@gmail.com,
        coreteam@netfilter.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, dsahern@kernel.org, dvyukov@google.com,
        eric@anholt.net, fw@strlen.de, greg@kroah.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        kernel-hardening@lists.openwall.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, phil@philpotter.co.uk,
        syzkaller-bugs@googlegroups.com, syzscope@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 43016d02cf6e46edfc4696452251d34bba0c0435
Author: Florian Westphal <fw@strlen.de>
Date:   Mon May 3 11:51:15 2021 +0000

    netfilter: arptables: use pernet ops struct during unregister

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325d967d00000
start commit:   af5043c8 Merge tag 'acpi-5.10-rc4' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9aa2432c01bcb1f
dashboard link: https://syzkaller.appspot.com/bug?extid=305a91e025a73e4fd6ce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130152a1500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102b1bba500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: arptables: use pernet ops struct during unregister

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
