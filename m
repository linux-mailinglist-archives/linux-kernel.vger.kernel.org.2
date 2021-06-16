Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6884D3AA5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhFPVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:15:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:13:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id my49so6032691ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEgFwvG0aEYffAJwnwi/wSvP3mnzTq32F9Igb0VeJKo=;
        b=czhMl45rFwdrs0pcekybM2QQZCWZb/gXfUU/tObs7oUmAfWaFzGqU3ncQtuzzBoGEp
         6TNZuZHFOTzoLk3Kk4ftLDU0XygKDGA3j5horD9drSGEElyEC2cdjMrMkbWUZqNsOMEo
         d36CyJJhlk3IB7sj2YK9ivIRzIE0TuPNJ1Ugs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEgFwvG0aEYffAJwnwi/wSvP3mnzTq32F9Igb0VeJKo=;
        b=Pix4SqEbdK9HIPm9cnUxornWY0hVJ0h65m6YhI0K9dn8rk0A5QTD/mbhaW0rHwSzLZ
         DG4o+5cCw2lJ1QWIBmhn9/6MTjuGTCAHcAqP7fvEmbRwo6/7+htVwnMyDwTJpWfycvTV
         jQj/eXunyNf0R9ZvweSUSQplCDsUSDrjiFFfmGvPl+8NcIXfTnBS0lk2C6AVwPFUyEKv
         LMfHrsOyiVfCVBequeIhiwZmPKt/lYAoXsad3el2FCMHGMGvsYygMfJrVfou8TVvsoR3
         HyZdg/d+vD1LQoVlQgsXF45PSj3nKwTV+PUyFYehA4HL1a8zjqMBvyX1bmDryNwmQY4z
         b4ug==
X-Gm-Message-State: AOAM531zfTE8RN0v7+uissniQY0MJ14Ak8jZPkyc4JZLnP3KbVb4so3V
        QW835E+OavuYfrsEGoAVDp5M31It1ebOnH+Qc+E=
X-Google-Smtp-Source: ABdhPJwhtS4SzL3Q2wa7lbYQLU96gPUpMCCj91rvsbai4QRNA69GXruZwH/MZKGraEpGKaoK6bUWqw==
X-Received: by 2002:a17:906:f6d7:: with SMTP id jo23mr1567052ejb.302.1623878003467;
        Wed, 16 Jun 2021 14:13:23 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id e22sm2708352edu.35.2021.06.16.14.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 14:13:23 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id c5so4167210wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 14:13:23 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1503699ljh.507.1623877698306;
 Wed, 16 Jun 2021 14:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133> <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133> <87k0mtek4n.fsf_-_@disp2133>
 <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
 <CAHk-=whvNaYffE8Eaa4-jjYbF_r1u1sh5LF5zXFhdEP8hxySMQ@mail.gmail.com> <878s398r4g.fsf@disp2133>
In-Reply-To: <878s398r4g.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jun 2021 14:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwqjetFoyPLehd0_qGbtmKHjibayFrdKC=g3FWYKzu4Q@mail.gmail.com>
Message-ID: <CAHk-=whwqjetFoyPLehd0_qGbtmKHjibayFrdKC=g3FWYKzu4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of switch_stack
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 1:57 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Do you know if struct switch_stack or pt_regs is ever exposeed to
> usespace?  They are both defined in arch/alpha/include/uapi/asm/ptrace.h
> which makes me think userspace must see those definitions somewhere.

Yeah, that uapi location is a bit unfortunate. It means that user
space _could_ have seen it.

Which probably means that some user space uses it. Not for any kernel
interfaces (the alpha ptrace register offsets are actually sane, and
we have that "regoff[]" array to find them) - but I could see some odd
program having decided to use the kernel pt_regs and switch_stack
structures for their own reasons.

Annoying. Because we don't really expose it as-is in any way, afaik.
Only incidentally - and by mistake - in a uapi header file.

Maybe a flag in thread_info->status (or even a new 32-bit field
entirely in thread_info) is the way to go like Al says.

            Linus
