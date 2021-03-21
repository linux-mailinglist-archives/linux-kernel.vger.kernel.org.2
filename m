Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30EA34328C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCUMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:40:28 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38730 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:40:05 -0400
Received: by mail-il1-f197.google.com with SMTP id o7so37845475ilt.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 05:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Du7jbAAe3dZDXGgzm0EhuVuhWQs9ocY52TW7Eb3PJSI=;
        b=O02TVaj66tsfcvBUqYnIFXLkp0BIEjlUTKS5ohLU5HbQNY34Yn0gEXmOlABDIwcARM
         hcwZhjLG1SnmJZIWFye8SDfSzZFSepO0xrvrTTU/2mKgT2pNAuRmzJTK7Sl+2FfwfyGV
         Q+e3F0tAZS38xaSdMiief6xtfLy5sHSlMWiJQMAYMh1DZa6yYM5ill+D4hLbXmFhbcJC
         1eQJf+WwN4PqOJD5Rr/NU/MjQmm8a74CAdHWtASEmVgLZ/sQApzS57CB5Kjp/GFVsKZl
         Jp1TbBNqSxg7SCgrl3PqLytkLv/Zto7DiMeCKq7zdJYqzX/SMrB5sdxw3ptRI5lVTghE
         xIww==
X-Gm-Message-State: AOAM5303n8QT89vCjz/4E1oswNQ2UZEsmbLfrTXl4x6epFu72xEezeQI
        FJsKJq4aGZj3kB2N4kelSltwei7qABZ445QEayQ7pG2hU09S
X-Google-Smtp-Source: ABdhPJwLUId8Sas9RSZ3Jj2SPQjCYzKqv5Gs8fATOIuPtXwbqn1x3RcTQQiwdqKz10rHDN98oBhipUM12tdzeJmdaeVp+nWELDAY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1351:: with SMTP id k17mr8707489ilr.204.1616330405017;
 Sun, 21 Mar 2021 05:40:05 -0700 (PDT)
Date:   Sun, 21 Mar 2021 05:40:05 -0700
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17fb305be0b3f38@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a33df75c6328bf40078b35f2040d8e54d574c357
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Jan 24 10:02:41 2021 +0000

    block: use an xarray for disk->part_tbl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17989906d00000
start commit:   1c273e10 Merge tag 'zonefs-5.12-rc4' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14589906d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10589906d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dfe8bed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155a117cd00000

Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
