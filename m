Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47610324110
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhBXPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhBXPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:12:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FACC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:11:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p21so1615064pgl.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYuft9T8+iiS2kPYO3FPRm/5PFCY+Od9P0ROP2gwwq4=;
        b=QreuBD6QEEmntTpXNybVSONpyCYwDsnIqQA1MvlcCSwM7j8GAQjdzTbPzHPqhubByi
         akb4UvxbTPfarwd87WBU2eDTxeR0IZ3ZX+0pmkLbptmpgu4NikXKzdzIzWHl1jOf08Zj
         mJWf9zSfLwbjfY30Puc2rceSfDEAmA9Bk21d0TNbG9Cnk6salTiVjEk5e6MxsYUbFT9a
         YFQjCxfB+ts92GrJeNpJJv0I6+GsmZ009DNX0H/gsRMRQ0vz8Nwhg8A6jkf/VI+0sYXu
         8OcguNzYvHFb78o7tNR0C7YwSB9an9uVpakLwrOjes/WMfukJtqMDbeizPP4T2ro8sqB
         oEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYuft9T8+iiS2kPYO3FPRm/5PFCY+Od9P0ROP2gwwq4=;
        b=MTPtsPUIxxkpVCzn4KBE/h6gAr1HUAVEa9MYPanMz+7dqCLMGfhTNpBRVTNYggjKjO
         JZf8IxLabW3AlzjcseIiUkEJ0rQ1Jdt44kS1VjxsdD5X2Mao3Z5JH0rvljDIyA2e/GEZ
         uRU8ByE2nzeplJB0zA4xCghYtRtsvwS4F2hS06S5TsUmPelE4CDijUGjHzuU1AgnAvSD
         mbfSKPfaieRQu8orrLJQAvv3frmOvlIh5VBm3nLPlXqAzf8ja7iaPJqqiDYspuvDxeVD
         mZa0KKLMebPcihWrmTc0LcXGkROqnB8P/zyYN7PPBskqSBQABXpkqTHnsULeQj8cbwuZ
         Owfg==
X-Gm-Message-State: AOAM532dRGfEmbeD0l/tabCuDiXH0ol0uK8ticH4wPK/vvItQjkHezoE
        UDUn3tLPeAtqfB+56TRfUrVMgWzN3JvFgdxpgQ+LCw==
X-Google-Smtp-Source: ABdhPJwjqv/ak3kub2KfMZ2m4sHCyV0FxEtD8toZwVGWBf4RrqOsTjb8G/g1r2dAvg1oeQ6q9l8XfmWq+kd7Px1BFYk=
X-Received: by 2002:aa7:91d2:0:b029:1ed:b10b:5a7 with SMTP id
 z18-20020aa791d20000b02901edb10b05a7mr7807894pfa.2.1614179502707; Wed, 24 Feb
 2021 07:11:42 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005ccf1b05b7665adc@google.com> <0000000000002e14c105bc14962e@google.com>
In-Reply-To: <0000000000002e14c105bc14962e@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 24 Feb 2021 16:11:31 +0100
Message-ID: <CAAeHK+zh4eOwmXqOJ4TO2wauyYfTqcPshuS2dXYo4nbLNDzo4A@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in call_rcu
To:     syzbot <syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, longman@redhat.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:58 PM syzbot
<syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 97593cad003c668e2532cb2939a24a031f8de52d
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Tue Dec 22 20:03:28 2020 +0000
>
>     kasan: sanitize objects when metadata doesn't fit
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106689b6d00000
> start commit:   614cb589 Merge tag 'acpi-5.11-rc1-2' of git://git.kernel.o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126689b6d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146689b6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf519e1e96191576
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d3ede723bdc58553f13
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11830e93500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d92057500000
>
> Reported-by: syzbot+9d3ede723bdc58553f13@syzkaller.appspotmail.com
> Fixes: 97593cad003c ("kasan: sanitize objects when metadata doesn't fit")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: kasan: fix null pointer dereference in kasan_record_aux_stack
