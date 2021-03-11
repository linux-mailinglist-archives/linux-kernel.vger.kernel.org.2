Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88F0337674
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhCKPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhCKPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:04:33 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5613C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:04:32 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id t16so2671319qvr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WakET1rjxsh//Y4Rmd8Mn44mJORH/q+MwdmfAIdQY+k=;
        b=uGhMxmvLjWSovhgLvlatANcpWPE3z2dbKkhlViFu1VJ7u0KZmtnoF3Fym/FUqe0gwb
         m7tTTzeVR45EvJymGG4r2eUTJb3nf7pHe3b/1KSGtf/d/Zrm2/kuzbFBA/12YgMH8fSM
         32qkgDkXzUmDpOlnVluldNcGJOVHHaRSfAAKArwRYZQa3wmheKZVyJGBO3d10kUtsZ1/
         usqaEsQU1APxfbRJl/cAe39Olo+ClwhOL1ifgNzeAMCXA6LIWb2v9PGPYlnER7CFRWKk
         tmwfk2AeLDZZUv37poGYNIP4KkuWXsXxuYS53VDdl07JLHM9MLiecevAFaGwwPAPUKAW
         jAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WakET1rjxsh//Y4Rmd8Mn44mJORH/q+MwdmfAIdQY+k=;
        b=CvHP1cHR7UFpR2xR18LuuPNgZuFDim5RauPpbq99/4KdFOxlrEWteVgmBNyexcNJzp
         bx6DkSKjmThAJmrblSufgJkYxx22oU4qvYmnG6vY6v8FJJfljB1AvMQ99CcpYr13dw96
         DLtBUlP4kmbCeHCtW3g38lC9oKrNkIpnhN30+r1bEr+ll8JhS0ea5Oxs7uoDFWinBqxN
         nf33OMAcId4M8KGZE88HgY1tf+J7YwvBKzaBAdf2V/EjLV8Xitwed1Y7V140YhcOO1eh
         grUPysQa3b1/IYzKIeL2ea77qR9GK058WVg2+11UfwlZSqPiU+2wNg84WfBdb8iiHMnp
         Zp1A==
X-Gm-Message-State: AOAM531sIVL4ZUYhFwRjgAXsd/x1starWtyS0LBumxciOZOz55MFeo0Y
        QFQ1gN9oBdTNcDKbTna8R8pRZdXiQYWitwTYZgI6uw==
X-Google-Smtp-Source: ABdhPJy6VEkgnbgU77XCqgJEiMGNGn0VanbYIb3RigS2EIMQ49bn18bPTv2jQJjdf2SYuQOvNileJ6H+AOA/9q0WrNc=
X-Received: by 2002:ad4:50d0:: with SMTP id e16mr7976110qvq.37.1615475071764;
 Thu, 11 Mar 2021 07:04:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002954fa05b02468d7@google.com> <000000000000e287c905bd4101dc@google.com>
In-Reply-To: <000000000000e287c905bd4101dc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 16:04:19 +0100
Message-ID: <CACT4Y+bH5vx_0wrFZiNWGLrX04Od0=iw+XU0ULC5a9Nh=qCQZw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in squashfs_get_id
To:     syzbot <syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Fox Chen <foxhlchen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, phillip@squashfs.org.uk,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:23 PM syzbot
<syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit e812cbbbbbb15adbbbee176baa1e8bda53059bf0
> Author: Phillip Lougher <phillip@squashfs.org.uk>
> Date:   Tue Feb 9 21:41:50 2021 +0000
>
>     squashfs: avoid out of bounds writes in decompressors
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bfa48ad00000
> start commit:   cd796ed3 Merge tag 'trace-v5.10-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59df2a4dced5f928
> dashboard link: https://syzkaller.appspot.com/bug?extid=8e28bba73ed1772a6802
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1138f80f500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125e080f500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: squashfs: avoid out of bounds writes in decompressors
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: squashfs: avoid out of bounds writes in decompressors
