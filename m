Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DE438BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhJXT5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhJXT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 15:57:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523DC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:54:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so4543605lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p8rRQhrPJGVMBevG1qLWZZPoZkUrXDNHIGpX/wf4OM=;
        b=F56m+11Ze+7cbDsWSZYCHd6j4FJGTi3YSon3cDO0lheV/b/uBtdV6+AyJ1Fv4IUrh7
         6kcOy52uvMo4FAj1dVIS1uTTSzqh6ExgkD6XYRb2rnbVXtCE3X0o0BKvYwDKJx0T7BwD
         kMZl6RLbws91GB1Nw/aQKN2Yjyt6S3F52tG+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p8rRQhrPJGVMBevG1qLWZZPoZkUrXDNHIGpX/wf4OM=;
        b=0nlXimUF+R8WomT7WGxWXzhJraR5KaGWEeYLQaa0w1osFbZrgoDDgsbGw3Gl8yyUXF
         EP06HPzzhMAohQXA/6Y/lX7dQfvxjAyz8cf/7RPE0ULuvwMuA9K4YWy+xUjBBjQ5BMk1
         A7umVTeHcMPQMY90Rfr2uzozR7tvWNycF2w9RuaDKExRjaaq+47qiOKlu4WVb2QOczTJ
         /IP+L6LzKrK4mZ2JJ20dxbIir7J17NJWNMcTPoeL2zF1vSHfWcTu2yguicyKPZBK0RH1
         Vcuy27bSykjQl49nQIoOJMWlN0MFDWhqTYXN39/R1A5tZquctZmN4SIyPFlS+ur/dmrK
         Dm1w==
X-Gm-Message-State: AOAM530OccSWCKFi36CiLWlonzc5lnGS1NlRZ6S04EQp1et0vDPcU86/
        HZBdUFLMcvSKBmvrHU+yceL+U4NshoCLjM2h
X-Google-Smtp-Source: ABdhPJxkpbjsgOWeGG2XE5P76DW8u+MSIsc1bvDgKxjI+r7TnPX37zmjL99o+xlarTrIe9GtnyHgdw==
X-Received: by 2002:a05:6512:33ce:: with SMTP id d14mr12741430lfg.76.1635105280676;
        Sun, 24 Oct 2021 12:54:40 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p9sm307965lfu.121.2021.10.24.12.54.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 12:54:39 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id bp15so6973756lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:54:39 -0700 (PDT)
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr12974048lfg.150.1635105279149;
 Sun, 24 Oct 2021 12:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064451505cf0a3aa2@google.com>
In-Reply-To: <00000000000064451505cf0a3aa2@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Oct 2021 09:54:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
Message-ID: <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in memfd_secret
To:     syzbot <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        jordy@jordyzomer.github.io, jordy@pwning.systems,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 9:35 AM syzbot
<syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com> wrote:
>
> syzbot found the following issue on:
>
> HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=115a0328b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
> dashboard link: https://syzkaller.appspot.com/bug?extid=75639e6a0331cd61d3e2
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a035c2b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae869f300000
>
> The issue was bisected to:
>
> commit 110860541f443f950c1274f217a1a3e298670a33

I think that commit is actually just buggy.

"secretmem_users" is not actually a reference count. There's no "magic
happens when it goes down to zero".

It's purely a count of the number of existing users, and incrementing
it from zero is not a probolem at all - it is in fact expected.

Sure, zero means "we can hibernate", so zero and overflow are somewhat
special, but not special enough to cause these kinds of issues.

I have reverted this commit in my tree, because honestly, the whole
"try to overflow exactly, and hibernate" threat model just isn't worth
this all.

If people really care, I can suggest

 - use "atomic_long_t" instead. Let's face it, 32-bit isn't
interesting any more, and 64-bit doesn't overflow.

 - make up some new "atomic_inc_nooverflow()" thing or whatever.

but for now this is just reverted.

             Linus
