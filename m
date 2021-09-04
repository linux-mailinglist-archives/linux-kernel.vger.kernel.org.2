Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28067400940
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhIDCHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 22:07:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51965 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhIDCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 22:07:12 -0400
Received: by mail-il1-f199.google.com with SMTP id r5-20020a92d985000000b002246fb2807cso625121iln.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 19:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zRIZHEuwoWOZaFEYOhQYWbRsZA/HnSh/xL4xkgPXzcc=;
        b=ih2ORGMz7qzYhlx+shTLVhLEif3KBHBLKxc2pvbNHPlWkqSJC7dXST8zxPvszjBgY/
         cKNSdcB8NeFow3EEciRjwpThowXnQjVd3vSHoD9mC8hCycyXqPp+FNXKUXDR1IPrg7p3
         qfpqN8/yzmrXNqmuFF6AJUg04D6V5/B4P7TlixxT8GIOZ7Hv+V3wAQLfYRTKobkJiVy1
         o+BvST6l/W8Xk9BnECcA/l6tIi8UeIJoj4ARirRILLFO5bbOq7c+yhH6z7JwsN9QTJ3N
         CUjs13Mo+xfAzQ/6FoFa5YqMm8AKLLlvXPqghTrbd8bog71hcN7Mkefske/X8sSfKOP2
         tIig==
X-Gm-Message-State: AOAM533bOavAs1WHnzdMol9z5U0Tjk3EauVXToUksZAbWWeuCYUeCIPD
        bOnjpO93avbvmDD3CLDauvyKZOHj9qHw6OPdLGwECG49G2cT
X-Google-Smtp-Source: ABdhPJw9Np9RoKEz/LYgjUEKyZW1euqFQbMviBTa0A8MNSn66Y8d6bK+OvzYK041vGvMfoC0VmTIIndIbGS42wYFBjUHFOu/w5Dq
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:: with SMTP id g4mr1287797ild.236.1630721171596;
 Fri, 03 Sep 2021 19:06:11 -0700 (PDT)
Date:   Fri, 03 Sep 2021 19:06:11 -0700
In-Reply-To: <000000000000f0cdb005cb1ff6ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000292cce05cb21dcd8@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_net_create
From:   syzbot <syzbot+2b8443c35458a617c904@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com,
        coreteam@netfilter.org, davem@davemloft.net,
        eric.dumazet@gmail.com, fw@strlen.de, hch@lst.de,
        ira.weiny@intel.com, johan.hedberg@gmail.com, kadlec@netfilter.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, martin.petersen@oracle.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e6e7471706dc42cbe0e01278540c0730138d43e5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 27 05:56:34 2021 +0000

    bvec: add a bvec_kmap_local helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d7ad33300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d7ad33300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7ad33300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac29107aeb2a552
dashboard link: https://syzkaller.appspot.com/bug?extid=2b8443c35458a617c904
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fba55d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd2f49300000

Reported-by: syzbot+2b8443c35458a617c904@syzkaller.appspotmail.com
Fixes: e6e7471706dc ("bvec: add a bvec_kmap_local helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
