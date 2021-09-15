Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E340BF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhIOFPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhIOFPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:15:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:14:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a93so3301312ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CF74Yy09ClhLuQTzbR9oIh0ANFqfI+RovIt9FVjZU8M=;
        b=YydHsKtc2nRCMjBlofbd4kWZwkvTqfEzbOYvMyfUjlDziVSsp8MdHctboT5XDDu7Kc
         moAFIz9Slmf2DaTUGKLGfbEcP6qJRnqxbj686Mh9vkXsPyIr2+plC44PIJRFGTwwvYEd
         +rbvfpJpBBJ+zqs21RpOZNSIXxsGA5JAUxxgAiGLfE5iskd4k7tMMive1IRHYGJiY+0c
         4VneWo38AdWkBRJj/8w0K58Z21b0MHt/vUKncgUF3onoos/b8LUZbFEFOlGMnVjp4bO0
         +DefDCTDBD4oZAYYvFjVWDa1AfSG3SwPEQyTzhDhiXL6cNU5paUgKxIx9zm8Iyc19W79
         AqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CF74Yy09ClhLuQTzbR9oIh0ANFqfI+RovIt9FVjZU8M=;
        b=iSeExpQfH9sCSVRszJ4TR0lj2KGdj9NBq3P4ors1jbVbYSnEVWz+jgeJh+1ZgDxPWW
         lfRK3adAPkbPlk0qLvDX1hjxxk7kRjaNz7Z0oDCxKRccUjbPbFWswBoybmnmh3sKdNhb
         EQQ+WbUYJOezOLceZ5vlC+0FafZdtYy6JD6D7qN0f/3w/Gce666MlbNKzb7t9CFyWyLw
         0P+22EU8J86tvMSxuPY7x84CmDBEN2e3te9RBPA4aNJMDkWYo01/hPM2az129Q4+rxq0
         7G/BwrpBK8kyoExaanCpnoUWEKcp2mkJBWJRjFi4TQvVNLLAL62h0hiAR/M0t6QPlLDt
         DCaA==
X-Gm-Message-State: AOAM533oVsX4uIlpNiBe9vFOD7/SpvuV57lGpHc0MfnrlqqNmYmT2Tbd
        HejBNycd6gA2jpOTz5ZP7bAWyNwMThl0ZG+5BMe+mA==
X-Google-Smtp-Source: ABdhPJym1lIRRfCxjklwLPldc+0MWuyUI0SfMG5HFOjT9g/vsLQOrcYKgajOiXsBc7JPjrEP8VDS2fnUHMj3HM+G/6A=
X-Received: by 2002:a25:b09d:: with SMTP id f29mr3600845ybj.257.1631682839197;
 Tue, 14 Sep 2021 22:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003166f105cb201ea6@google.com> <00000000000067c79605cb2720bb@google.com>
In-Reply-To: <00000000000067c79605cb2720bb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Sep 2021 07:13:48 +0200
Message-ID: <CACT4Y+Zs0Q_dWTRgsu+z_g_41uEp+66r2peSy_P5WyHeagtymA@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_netport_create
To:     syzbot <syzbot+3f5904753c2388727c6c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 10:23, syzbot
<syzbot+3f5904753c2388727c6c@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 7661809d493b426e979f39ab512e3adf41fbcc69
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jul 14 16:45:49 2021 +0000
>
>     mm: don't allow oversized kvmalloc() calls
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113125f5300000
> start commit:   a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=133125f5300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=153125f5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac29107aeb2a552
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f5904753c2388727c6c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14581b33300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13579a69300000
>
> Reported-by: syzbot+3f5904753c2388727c6c@syzkaller.appspotmail.com
> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz dup: WARNING: kmalloc bug in hash_net_create
