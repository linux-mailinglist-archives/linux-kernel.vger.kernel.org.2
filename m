Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C053EF900
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhHRELr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:11:47 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56023 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhHRELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:11:46 -0400
Received: by mail-io1-f71.google.com with SMTP id f10-20020a6b620a0000b02904e5ab8bdc6cso454406iog.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 21:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ySJqMrhH8WPO+7kpnz2+D8+5zReHEFdpSlSOpxpjwLI=;
        b=kP4f303EevzSm80tuE7NUEHOYgK3EghiCVd4j+j2RgZLPoDbYQwohPTpN6BU+ZSXTr
         RLkLwuIDr3J9chITGepgDykKUq/uhl6W407DE1Z+9MaPp4YDFnGG7/nShXzzBCKCiQh1
         ecrvPWybghcgxm1QLpQvpsKstHmK8ztYTa/Ri/tmHQ5xkIZ1wyFGO5N6LOtA9iyejh+h
         jzmMklu1tfoTJL2OyY8g4+IGxaFFyAsafFdLgxrGz32a9LpilEx8xbKmmgChPN4YExXc
         ksJl1qirhIM7QV6X5AdeH78avMbVVmj0xwZEwVSWnFXRdXp530dq/FI4/SwGYSiZIHCF
         YObg==
X-Gm-Message-State: AOAM530YVsjOKn2fQrQCVu57glyJnAMEv7BOxHv53ZA0Z12zkYRLwH0z
        3vR5jw68nBzJdj3ddoq3M/VerHBZIbn0Lko1j75X3IzacDol
X-Google-Smtp-Source: ABdhPJzuickf+KcG1kqjEnfk4xWVEeB0bkhdr3Ysu06HFtfgCcFs40ciAD/SBJy6tfWWU1KAEh1yUv9qi7YPDDTLKHD8CZCE59lg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12b3:: with SMTP id f19mr4919379ilr.234.1629259872253;
 Tue, 17 Aug 2021 21:11:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 21:11:12 -0700
In-Reply-To: <1ced323a-6d83-3d2e-c974-71ee3b425519@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eec05805c9cd9f6f@google.com>
Subject: Re: [syzbot] kernel BUG in remove_inode_hugepages
From:   syzbot <syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com

Tested on:

commit:         a2824f19 Merge tag 'mtd/fixes-for-5.14-rc7' of git://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=67654e51e54455f1c585
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128e12c5300000

Note: testing is done by a robot and is best-effort only.
