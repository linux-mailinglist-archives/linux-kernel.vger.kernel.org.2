Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A872434DC86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2XdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:33:25 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50555 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhC2XdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:33:08 -0400
Received: by mail-il1-f198.google.com with SMTP id b14so12945555ilv.17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lMlioT72BHXScbFHNZMJLoPdODEiwb40F9vPrqeqLoM=;
        b=cM4M6EnLAqB+BDV7/9am65C3lZV35sIIPfsHXaWrBBQnMr32F+sxG1neBWUF+omYmB
         7qUXYmyU1eiXbmLcyVmHoBveooK1nUGWRHKEOhzyiQdy8XTtf2zyp+FPlgJhcQWxJ+/y
         iwnLqv0Ga50yOktR6YVvbrIycdr+JcL3ZmciVwkHw3fFbueSGb4DLsi/+LfIzkZP60tu
         pBVYV4pZO2g25LQ7Ju9De6YYTN0jjpKuwwqJqJ77f8rOTWrJoBP1Ruv7ivQimsIFS4u4
         +Y8VHovUrDfAJ4u6Kd9ru+CeDz3rngrSrtTMhZqGqx7or3zn4vZ7BMnILhaQweojOXZ8
         0AVQ==
X-Gm-Message-State: AOAM5318ZKSXxNc2pJIUc3EowocXo82Vjzz1Ik7KE+Z7NCjneKmY/qGl
        G0tXuTNI+8Q9cS0zEpvNrSzn1vg3edcNpMd0gi+bMfaLunDM
X-Google-Smtp-Source: ABdhPJwbpo1qBtqFDEAozEtKpv7+6pbc039Tmkz4JX4dPkyQ4fE1JV42MwydMp0mlXFrwMNWtxLegYbPzDkz6Bc18A4ABmxVHB+9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378c:: with SMTP id w12mr26304998jal.127.1617060787957;
 Mon, 29 Mar 2021 16:33:07 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:33:07 -0700
In-Reply-To: <f96bff2f-bcd5-a04f-4130-1c3a933f97a2@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8bb1905beb54dcf@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in create_worker_cb
From:   syzbot <syzbot+099593561bbd1805b839@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+099593561bbd1805b839@syzkaller.appspotmail.com

Tested on:

commit:         24996dbd io_uring: reg buffer overflow checks hardening
git tree:       git://git.kernel.dk/linux-block for-5.13/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbb3af9ca0d22f7a
dashboard link: https://syzkaller.appspot.com/bug?extid=099593561bbd1805b839
compiler:       

Note: testing is done by a robot and is best-effort only.
