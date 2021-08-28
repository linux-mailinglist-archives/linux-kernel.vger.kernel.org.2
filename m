Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C784A3FA77A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhH1UGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 16:06:03 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47041 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1UGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 16:06:02 -0400
Received: by mail-il1-f199.google.com with SMTP id f20-20020a056e020c74b02902243d481d97so6324331ilj.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 13:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=F3lnrFhJJI9jjY2l9iXzYnttpQ+V2txwHoUaiy15Azg=;
        b=E147nlA3CEXHgQ1X74zeGD/m6N0ASgCa+UY2Ft6dSCXCFV37L1HeNkSBykaA6W7t2X
         VTeOK2JcPlfQZmUzUZk/lX5Kn4W/uJ07n/4pXGydJD/uUg4bHljGm6Z5HLUs7Vrtl5/V
         CylJdMmSs5UjxfqcCbUua6C6XPHALOz8FLGDF03w0Ar7orgis28muBjIfxSAo099tcf5
         Hu+SnKzrNW1/uB1ksLPLJpbVznwN5zSgPsLmRY0CQBOGbdnaQihLnB9xlrJ+FcK/Whqr
         SQuhDFfrhV7znymUouse0YxFQm7gavpwr0Fvl3p87lJ0A/xFqoriO/b8okSvT69dqBqs
         PRrQ==
X-Gm-Message-State: AOAM5336s8mVuVVfcpX0Izt4r5QI95mldz9oLTDdXKNdYlv1sHE2n1OK
        Ddz31aIEQ8IPRZFwT+AI3jMI+cRJSDFug3s96mjqXF3l+nRV
X-Google-Smtp-Source: ABdhPJzHStHr46SCKuO25wOHU94CBgaQa0P1z5qBGKQRRah2nWHjLg3YkzMkQt6Pz6IO+rZsgDqLS+lRh8wqJzQoaZeu4lLfXEHy
MIME-Version: 1.0
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr10793586ilh.131.1630181111312;
 Sat, 28 Aug 2021 13:05:11 -0700 (PDT)
Date:   Sat, 28 Aug 2021 13:05:11 -0700
In-Reply-To: <20210828180358.GA291431@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f37f405caa41e79@google.com>
Subject: Re: [syzbot] INFO: task hung in do_proc_bulk
From:   syzbot <syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ada0f7d3d9fd2016d927@syzkaller.appspotmail.com

Tested on:

commit:         d5ae8d7f Revert "media: dvb header files: move some he..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
dashboard link: https://syzkaller.appspot.com/bug?extid=ada0f7d3d9fd2016d927
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c2799d300000

Note: testing is done by a robot and is best-effort only.
