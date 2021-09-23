Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBC415811
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbhIWGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:04:47 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33497 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbhIWGEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:04:46 -0400
Received: by mail-io1-f72.google.com with SMTP id g2-20020a6b7602000000b005be59530196so4988130iom.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JXvRrW1iqPMwIYRHYBPAsiAM0PkHzg5GtfxmrglxQzQ=;
        b=aX/WhxLRdSksoRNAEgCJJrCKnRbfZ/0NGcR1uMLtwaapmnWO+vLKa58jWHaPxHAqAq
         eNO74CwlxPX7KSHpjgFkySzhCiVSnD2w4DskJaW5DCgZxJ37cWDssU5kQK5Ox0hovT4L
         /CwC/BpxuRJNt1eMq5CHbkjHRzGoqnZzo6nhjNw8J2OaKWT2+j3W00Y8UXtVKUfwYdcD
         XxEJfCX4lNs8D2Xky8WuN6swQhBIrR4Gh58sF9umRx6HgJx5f/zDaC5rtMScTSpw1ygB
         l1mg1blRuhs6qxM2jdIN5lTL2aguzbqCdElJTq5ud6tq/GtkwTpTwMAWqdjtFIhlZM36
         7OZg==
X-Gm-Message-State: AOAM530VsA8gbImkvaVVTJaECqKJXhDZ2TO6brbtw+OcmeClDOFZE6l7
        Z8EFVHm2Ihhq0oDaS4oAT3EZQVtwiXEI/iVfCQlUys33Tz11
X-Google-Smtp-Source: ABdhPJwT9OjdtEE+jw3AVImKDXCzwGMdqVOLT4j2uiwu093ZOHPBREg1Xj/g9V66d630WZBAzcZXMF3cUBsYko/IRsjfaVrFtJsz
MIME-Version: 1.0
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr2455017iog.111.1632376994998;
 Wed, 22 Sep 2021 23:03:14 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:03:14 -0700
In-Reply-To: <000000000000bf710a05b05ae3f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed2e6705cca36282@google.com>
Subject: Re: [syzbot] possible deadlock in f_getown
From:   syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>
To:     asm@florahospitality.com, bfields@fieldses.org,
        boqun.feng@gmail.com, desmondcheongzx@gmail.com,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f671a691e299f58835d4660d642582bf0e8f6fda
Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Date:   Fri Jul 2 09:18:30 2021 +0000

    fcntl: fix potential deadlocks for &fown_struct.lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fa8017300000
start commit:   293837b9ac8d Revert "i915: fix remap_io_sg to verify the p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171390add00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10050553d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fcntl: fix potential deadlocks for &fown_struct.lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
