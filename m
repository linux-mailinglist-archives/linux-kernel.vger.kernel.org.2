Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FC3F2424
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhHTAkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:40:46 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53052 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhHTAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:40:45 -0400
Received: by mail-io1-f69.google.com with SMTP id n22-20020a6bf6160000b0290520c8d13420so4339444ioh.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 17:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GropDxqf+CptwvOKGVu50IkRe2l+vNSfWE61IL/QJM0=;
        b=IlQEsiE0SW7SI/cq+p6OKFP/hzGRCCYzG6D6IAdjRsHe06fK84rPisUnm5VFWvf0yT
         djixN7VHIrZVkUZjyXPIwmiZbV9XDjKL3SropGlz9Ojz8Pz/7PVL2UYq2FNOPsO+Aq4C
         YZs3ZKHmJ3jFk1FSMj0uohmC15WEw/D89zoZc7SJ8T1wHoLT5s/JhrrDKWEb9amJ2X0L
         +2CExWGpixjz2c3rSLJ7luRAJY+h2O/2MbZbV3LnpEazM8JfbQzo78e/A9KsHqjAS8qp
         r9B8l8NSWGumo0nlkgz1SpJXTzi+jtosIU1j8YPsWNLbEZoi+P6lh64Ei/i7UY05MY5q
         cHQA==
X-Gm-Message-State: AOAM530btjl4jLSa14GhUo8oRzoP8o5E59qq7p0sulX4ZbYrgSH1iOJ8
        azKY6GL5HpN9U19XNbPzQvEVuGNE9yU0xjithSVO8gbleDJw
X-Google-Smtp-Source: ABdhPJzkNzvPryhTmpMtYws/Z3kk/RN/BNefgUkDRA/53dPPU6iCfwk+gB4EEQakdAPwZKcApZCOSV5zO6LtsvAlnIaFZlWC1D5U
MIME-Version: 1.0
X-Received: by 2002:a5d:9486:: with SMTP id v6mr14019457ioj.163.1629420007923;
 Thu, 19 Aug 2021 17:40:07 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:40:07 -0700
In-Reply-To: <20210819195300.GA8613@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c322ab05c9f2e880@google.com>
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
From:   syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mkubecek@suse.cz,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com

Tested on:

commit:         794c7931 Merge branch 'linus' of git://git.kernel.org/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=9b57a46bf1801ce2a2ca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119cfb31300000

Note: testing is done by a robot and is best-effort only.
