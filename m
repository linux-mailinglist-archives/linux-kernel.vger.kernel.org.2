Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348303E1740
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbhHEOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:46:40 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42701 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbhHEOqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:46:23 -0400
Received: by mail-io1-f71.google.com with SMTP id l2-20020a6b7f020000b0290439ea50822eso3806739ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 07:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M+CG0V/JI/8dSO9GWQyntpikCmP0PrauSUlgadFbtcw=;
        b=jNl0dP5ZD8zCC61h/y8/+unp2IzJrRYwlN/2dgERgCiAKcU6AudC5ooGOYFc+i6l9X
         vj0dkyxNifPZO7THYDmeDWxj5e4xvi9dmB+iPBUo64l2Ew6iXEmS4tCKBGu3hfzTchd3
         Drj6zmm8nWTD+rhBP5lC36npSxWP8UPb/Fc7qG6KvCokeGXFcIJRnn/MVyzB+ncZOnaf
         zA5waEL1GRyEj3pLrQihEh/KhWu5L+lrngym2RpZtqbeaduvDkCf3KRQ6dC/F2mGE7+e
         76Z3XQ/vpWyNsZpVf7uyB52SqxN2wXCTGB1mcwwohVVXcLSjGuGnEaWbMmegqodsA4hA
         EpuQ==
X-Gm-Message-State: AOAM531YWmEhD2b36W74ZgXVZcWvIsHYgHsknoFguJAg800N/DWTCaQY
        QOJdxI1XMcg/FH5NzL+8SsAGIkFYh2+XpuAxOSUaeglWqps1
X-Google-Smtp-Source: ABdhPJz8IPp08WqV02D4H6gE7y7ffaPfZAftqTCnXJyRCYESE0r6TvHsonBfJMMGgx494836Yn3kg6UdOlg+p4zGbRss3T1Hh4o+
MIME-Version: 1.0
X-Received: by 2002:a02:8807:: with SMTP id r7mr197145jai.35.1628174768557;
 Thu, 05 Aug 2021 07:46:08 -0700 (PDT)
Date:   Thu, 05 Aug 2021 07:46:08 -0700
In-Reply-To: <1e291320-3ad3-aa21-77c6-c71da9d32fdb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6692805c8d0fae6@google.com>
Subject: Re: [syzbot] INFO: task hung in ext4_fill_super
From:   syzbot <syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com

Tested on:

commit:         251a1524 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=166c8f6532dd88df
dashboard link: https://syzkaller.appspot.com/bug?extid=c9ff4822a62eee994ea3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160a3301300000

Note: testing is done by a robot and is best-effort only.
