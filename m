Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01F4015E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 07:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhIFF0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 01:26:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50805 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbhIFF0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 01:26:13 -0400
Received: by mail-io1-f69.google.com with SMTP id b202-20020a6bb2d3000000b005b7fb465c4aso4376811iof.17
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 22:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZvVDoBv3IAH8y1S0lXBguVVm08g+13BDGKyt9/bor9Y=;
        b=KAGpSAn/kTxree7d3SQs3RYaWwOaJAFXy1uKIqzjJjWx3OTioMsaHBUAdhXmV/k47Z
         iAnIxfvv8RhlgfEzrZIi4WiZ8ZYbHfQJ8NMOaMGdP3fSgevbMK1KpEg4ptmRAPYBNTnU
         2+ef+3qrex7NH1uDi63aypHFlq7EqWV9O0Swi2LZKsCcwzjbk5x86N1k7xk7SlVkBm52
         cOFNfbj3gp3znZ1GYG6hvrWujRa+hSCwtfxbF71ODxml/NyNb541RR9VZ5+7+X7e/XzA
         jq7GX2helrjPKnnL72ikZdQJL2h2sray32fYfoV5utZd46Gbq1V4NOBzcqfJlywyMHGq
         P7kA==
X-Gm-Message-State: AOAM530DNlZPPT3VWIORxOIvRXrrNs78fXOrFmNmO/OdDRmNiG7w6pBI
        ad/uKayRM+vH1KlnhhnZCMfbSBlhVp9ZY7SDzXVOtsgzmf+B
X-Google-Smtp-Source: ABdhPJzd449QRHh060sSTuNCXAhTIrwXmTA69htRCTu+gj5HcaUCJCrRFnuZykGCC4UYH518hB/hhMO85JbepGiR6Qh7k2AHNNjo
MIME-Version: 1.0
X-Received: by 2002:a02:294b:: with SMTP id p72mr9242294jap.0.1630905907569;
 Sun, 05 Sep 2021 22:25:07 -0700 (PDT)
Date:   Sun, 05 Sep 2021 22:25:07 -0700
In-Reply-To: <000000000000ed8c0a05cb1ff6d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000486b8b05cb4cdf5c@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in nf_tables_newset
From:   syzbot <syzbot+cd43695a64bcd21b8596@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f767b1300000
start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f767b1300000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f767b1300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7860a0536ececf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=cd43695a64bcd21b8596
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13281b33300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1077b4b9300000

Reported-by: syzbot+cd43695a64bcd21b8596@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
