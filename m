Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E5452DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhKPJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:23:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40666 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhKPJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:23:04 -0500
Received: by mail-io1-f71.google.com with SMTP id d12-20020a0566022d4c00b005ebda1035b1so8079879iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q6tsnDHHWOnbJO9EgMBPIUsjh6idvgNd9SMKe8lTFPo=;
        b=iRsNHM1OWF3dztUT41Fq0Obr4HVEu2lW3RFS7awDiWpOIKEXKQjWhJGhtm664QvLmV
         kuNK6/sxqB+q874CoaEqFxhSnPNbxuHhASFzRsacJNshcrWgqsofkNlRMWUqo2SHr8pJ
         SkDukiZaYSpItaIDWqTiQ5K7S3dLTZpdmFWNSdIaLZtfE/DymustWxkLHaHpJByIqfpZ
         hzWqUbMWNeR0ORR9G2ouuGqGhgkgTkk6R1WeX6DrolXSvBzXVC6spF21QDD3egkoO9vq
         XrptXrc7YJ7MuLxFhuec8pDb8Z2wLbEdwTkmrkGmqXdOoMlEc59u4Am2Hfqa8Ley2jfC
         MAcQ==
X-Gm-Message-State: AOAM530HpBsOZms2JUeMGitWcS4unC+TePLYCQMH/cJ+TiZ1WVZfaRu7
        NAvXb5qS/5VE6U+IKpia+iJiuF5yHxbdXjvny8Y1NQo/S1D9
X-Google-Smtp-Source: ABdhPJwli9eYbp+dbg68OgDD+Cx1xGF6AWwrsjg1sR3/doZlS1pwCYPg9eE0c3NzKgs7PPi9sbrIhJ/qr1ozrkiP33YBZxefuJJV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c9:: with SMTP id q9mr3620056ilu.28.1637054407492;
 Tue, 16 Nov 2021 01:20:07 -0800 (PST)
Date:   Tue, 16 Nov 2021 01:20:07 -0800
In-Reply-To: <7655311.pJQ0NNsvTN@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fc7b105d0e46ea2@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com

Tested on:

commit:         8ab77458 Merge tag 'trace-v5.16-5' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2db820d271ec6d2
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131739e1b00000

Note: testing is done by a robot and is best-effort only.
