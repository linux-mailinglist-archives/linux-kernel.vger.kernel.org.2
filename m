Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72491400A62
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhIDIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 04:24:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39601 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhIDIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 04:24:12 -0400
Received: by mail-io1-f72.google.com with SMTP id a17-20020a5d89d1000000b005c2233d0074so1089939iot.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 01:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M3toUYP73wjtZjjuGZaluiFGnzByzbicamvbzl2GU/w=;
        b=ShV2KSg42PcJW4v3wXdSv9+gmw0vieve0LtYnQ9fd+5/c/94dadFy1cVuYx0ShrEOi
         kB5ugYwKEgZp4BMOVbVrEGb0gtyFq7sUKu0AC672bzsUvwMD+FgbQUhsrjAlu1ewXrk6
         6a47tLW12HkjiH2hThRPR+xqIPs76Myb6zz0jO7IBVcnOSb6A/O5kWvCBkEYdX+8Z8Zf
         kudJXGIHKwnUVI6cM2SC2SmGcE+cdR95BDa1pJEVja62fV9UTIyu99mFeEg8Mq50wDoZ
         3TaIDdQn2MQKbGVqaNFdcHnPCgws2CPt2aqsoHyxDxRTeXJtKZBepQP8u0gdUT8AfB+Q
         YhNw==
X-Gm-Message-State: AOAM531RDhycJlm6PNqG3yrwbimdQGdmMjogv0EdwguzGlDjpjdWU33f
        4KwsiAi1Rwc3BoRHYxRY+xQjimNiBGKZJrOPlShfSxZ4ohB4
X-Google-Smtp-Source: ABdhPJz3nU0+9fHDM9jpojjeZT6ijTGdbtoJlUBtgSHEtb4+BB6TZlWcNDnkyxKIOI/Pw8b3cTxJ3iM9/EBYgvrmkdZYQKhrS7Y4
MIME-Version: 1.0
X-Received: by 2002:a92:d282:: with SMTP id p2mr1977515ilp.259.1630743791386;
 Sat, 04 Sep 2021 01:23:11 -0700 (PDT)
Date:   Sat, 04 Sep 2021 01:23:11 -0700
In-Reply-To: <0000000000003166f105cb201ea6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067c79605cb2720bb@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_netport_create
From:   syzbot <syzbot+3f5904753c2388727c6c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, eric.dumazet@gmail.com, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113125f5300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133125f5300000
console output: https://syzkaller.appspot.com/x/log.txt?x=153125f5300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac29107aeb2a552
dashboard link: https://syzkaller.appspot.com/bug?extid=3f5904753c2388727c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14581b33300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13579a69300000

Reported-by: syzbot+3f5904753c2388727c6c@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
