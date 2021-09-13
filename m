Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9B408815
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbhIMJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:24:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39783 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhIMJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:23:40 -0400
Received: by mail-il1-f198.google.com with SMTP id x7-20020a920607000000b002302afca41bso8797015ilg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HFFQPLAJXYx4bvBZVVBupuysAIuBOZazsLsw7gSGXPM=;
        b=G59daTrNa638IFnsBr/c2HTSuHse1BMQPBTdz4iZdl5K/GMNMykuMcTtYxOS2hMb4u
         hI571ZOmBbB+pOLqIYrePYlchOUdoQ2QllyCZQtYbHAO+mgyVIGEv+03m31vd2EIJ56J
         +tOwtfwU6zpPe3tnjtu2dnGInI7tcgv2ZPZ3EtQ0wmk1agzIWufy31EcmeaiWqWjSbpw
         34IRZEQHm5J352m7YAwTiycpssrCCR2lJPJxs6F1GWjxc0ZEfmr/R1GhGpnmnPu6s1R2
         HyD3DKvcTXuZmcEO8C1nJ/sLb82j8XkIMUmLuDl9IENiLbAJVvu/lmjbNxaKz4mDKGgr
         y1gg==
X-Gm-Message-State: AOAM532zOzP1NeSK9P/1xmqSXzeeQPd4xKQ6fzC7Bq5CrSCeAkvhx7N7
        DeDgRxUXzNrskhAgbi8Z8XaDuUQd1sOOdMxyzgoU4uRbkzMQ
X-Google-Smtp-Source: ABdhPJz7iVHqBJwGMWVtkrGExpiG1/xH+YHaKqOpWGtfsh6vf6jjB1BWXgH366JewGOkGwNFwNOdUNMP/62JNgA5QSGR5CPvzAXQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1564:: with SMTP id k4mr7564234ilu.146.1631524938755;
 Mon, 13 Sep 2021 02:22:18 -0700 (PDT)
Date:   Mon, 13 Sep 2021 02:22:18 -0700
In-Reply-To: <0000000000006e9e0705bd91f762@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ab57905cbdd002c@google.com>
Subject: Re: [syzbot] WARNING in __percpu_ref_exit (2)
From:   syzbot <syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, coreteam@netfilter.org,
        davem@davemloft.net, dsahern@kernel.org, fw@strlen.de,
        hdanton@sina.com, io-uring@vger.kernel.org, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10acd273300000
start commit:   c98ff1d013d2 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c70e618af4c2e92
dashboard link: https://syzkaller.appspot.com/bug?extid=d6218cb2fae0b2411e9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145cb2b6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157b72b1d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: arptables: use pernet ops struct during unregister

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
