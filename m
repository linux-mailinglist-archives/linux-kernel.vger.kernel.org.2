Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F067C4305A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 01:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhJPXeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 19:34:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53101 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbhJPXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 19:34:14 -0400
Received: by mail-il1-f197.google.com with SMTP id h6-20020a92c266000000b002590d9f7d14so6016752ild.19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 16:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wnuC2jfmRKZbiKnJzBxyDjqgI+D2ZB0+y3fOM/x87AM=;
        b=dskABVvppPdGigHlLB2J9hmHlkyB4AETx+yBBmA5GOTWMc2wUBleIOpBpep/Ga/8ki
         6CbAm8iBqXuf9v7KzfLxztiPiqHa9RXqPiRWBIW413P1qOPQ9OSf0hVXf4DODfRIBvVR
         Rg+p+XP1A9PP7jffbzHPij1cIiGO7gqEMjG2Rw26qUTHvv+LoRu3dQlzYXZXop1ScwYk
         Bleoog2e0KBOS3f80Yojhw/wSeog6Cdpd0us96v0vm6y1QKM+l5TeA5JA+HFZytbcd6L
         zCMDR9v2bPoaj+CSRRpm1v+L39TtQR4DhneaUjkECx7vg/Zbp/qdpbUhQLGhj0/xCoCa
         fQKA==
X-Gm-Message-State: AOAM533LWcgmGJilth0Cn8f6LGu0LjQIrisx3ee+9fs0a2JMJZpr0WhS
        C6pA2AAQ5yngF66pBSR3MBQ148/5D5Lpjn7bSZpj3E7YQXmu
X-Google-Smtp-Source: ABdhPJzj/Na0ZjhV6HLcRWRCruLqzRS7fv64inlhQqqVrHbOQ05YDV3piUnTEBm5cZTiLGVaha1DQYNs7ytMyGAvOFr5LmsYkFKN
MIME-Version: 1.0
X-Received: by 2002:a5e:9b18:: with SMTP id j24mr9447650iok.202.1634427125977;
 Sat, 16 Oct 2021 16:32:05 -0700 (PDT)
Date:   Sat, 16 Oct 2021 16:32:05 -0700
In-Reply-To: <000000000000cf252605ce67014a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041567305ce80b8af@google.com>
Subject: Re: [syzbot] possible deadlock in wake_up_all_idle_cpus
From:   syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, gor@linux.ibm.com, jgross@suse.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, mingo@redhat.com,
        namit@vmware.com, peterz@infradead.org, rdunlap@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 8850cb663b5cda04d33f9cfbc38889d73d3c8e24
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Sep 21 20:16:02 2021 +0000

    sched: Simplify wake_up_*idle*()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117802fb300000
start commit:   7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137802fb300000
console output: https://syzkaller.appspot.com/x/log.txt?x=157802fb300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=d5b23b18d2f4feae8a67
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e920fcb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b83d80b00000

Reported-by: syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com
Fixes: 8850cb663b5c ("sched: Simplify wake_up_*idle*()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
