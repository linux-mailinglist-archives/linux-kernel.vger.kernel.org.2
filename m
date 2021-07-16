Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C113CB5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhGPKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:20:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49711 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbhGPKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:20:04 -0400
Received: by mail-io1-f72.google.com with SMTP id h7-20020a6bb7070000b0290525efa1b760so5698996iof.16
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=37NWRujtMEhr4Bm0IxX/U/zG+egBRbX0strpGbjTPV0=;
        b=R5FO6HGlg1P9rEoZMb8Uyk+8vKP/MkRc81Ftt3NqG3PWyiHGtvdz8QfrT3QHlLBSyK
         D558gK7PqkwKSxVLqe3OLGzT/yI0ryyDkc5IWxrqf2SHx0WDbi4tksSMvSH1fF8gq27a
         NUYFXOS3idL/gKnjAogV7wLXKMHVcdKfcEaSoVRA27rCV92xCCNJFft4p2OA1HcmE5tI
         BV9I6kopiSVV6lwQjvyNQVEY0jaj4ntQuoK9wcD28LMcGLalNWjT84JkjPTyyMsjhBtD
         KU6ATSlZRkF13E+2TAbE/gnENhmjHZ0fkHlikTbU3AZeQbvjtpj1GEUVnJEM3ffxhVGt
         +pyA==
X-Gm-Message-State: AOAM531BjtqoxqzBBLx4qMCMCInq11Cz8WQhfIhCPMIo8jcrrkr7pnR8
        /43fM9L/RzgGlCsrecpFRCAH3e7CiZ7HR68HQVOZb+89zbOt
X-Google-Smtp-Source: ABdhPJw1VYps1jJXzEKdIMV9Nj/IQM5qpYhuzZIsWIwP0MaXaKqqCxCV1mrx/G7vATrqo5cuZ0wrHYLDW9s1OK/z7DNSECK5Xw50
MIME-Version: 1.0
X-Received: by 2002:a92:6412:: with SMTP id y18mr6344072ilb.158.1626430629964;
 Fri, 16 Jul 2021 03:17:09 -0700 (PDT)
Date:   Fri, 16 Jul 2021 03:17:09 -0700
In-Reply-To: <0000000000006f809f05c284e0f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f36f9505c73ae373@google.com>
Subject: Re: [syzbot] INFO: task hung in ext4_put_super
From:   syzbot <syzbot+deb25600c2fd79ffd367@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 618f003199c6188e01472b03cdbba227f1dc5f24
Author: Pavel Skripkin <paskripkin@gmail.com>
Date:   Fri Apr 30 18:50:46 2021 +0000

    ext4: fix memory leak in ext4_fill_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ebaa22300000
start commit:   2f7b98d1e55c Merge tag 'drm-fixes-2021-04-16' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=398c4d0fe6f66e68
dashboard link: https://syzkaller.appspot.com/bug?extid=deb25600c2fd79ffd367
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d645ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a03a2ed00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: fix memory leak in ext4_fill_super

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
