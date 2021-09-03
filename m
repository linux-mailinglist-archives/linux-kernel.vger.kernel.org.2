Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758B4400815
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbhICXJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhICXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:09:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590DC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 16:08:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y6so1137395lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMM5rdL0JhVNmGhHJi+I1yppNIa03WByKSu62LtOtt0=;
        b=CpwnMpfWowJSDtmCfPKzmtvSNLMAt12Ouyc0fv5Coc6PY95tQ/JYWl/JnU3r/BhU2E
         YruTGApYH9baqpuvzU0L6f8aNrk61+j3o89oPqKA5ablDzTLYfxXjErMcoWtf2K4HgfT
         xgv744cFV4noWLIkBVVbibtT28Yyi48cf2Ybk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMM5rdL0JhVNmGhHJi+I1yppNIa03WByKSu62LtOtt0=;
        b=SLq0s2dLRAwj8lUG3DvDCAbd815oTum7R5Gl4to42kEAzQSwtuzYlUQYwsFC3vbbeA
         93jEZ51u9dtQix8bmfU+c2/L7cwEc02+OTStUHezI+6Wn9a34diCth9DVLXrE6vB7Gr4
         +z5+quntDWrETpalPInRXXv+nm9QXuZ2a5/JLWFTZH+lNWEJ/O93fw7g6GO+iINC1BtX
         MC/c6cO/l66X3GJREzGJdUpLXJLLkIfblmnFe6T2TDRABrG3wn3q8UPsbKxinIMEySON
         nsHBAdbYC8QZUswbKPGyGaCgjxXOSN0V3HxVF/BqSJdpjw1h8wdUPQU6Zgv4Z6glBuU7
         M26g==
X-Gm-Message-State: AOAM530pxUvmNGUcXCdwL/hfA/mnq0M4FtoqvRAOySBwsT/3UdvShE3R
        POoZLhVafeZChcT1hdyfCAAzsW0KHpJ66Rwcf84=
X-Google-Smtp-Source: ABdhPJz0AuovjbSWv7nROrxmGzG0LvuTTYaPbP8v8mjrFltSovq/KZbkcbhJ/8BTZrDd1FLSNt0tkA==
X-Received: by 2002:a05:651c:225:: with SMTP id z5mr928585ljn.409.1630710524662;
        Fri, 03 Sep 2021 16:08:44 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l26sm74403lfh.247.2021.09.03.16.08.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 16:08:44 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h1so1105836ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:08:44 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr870287ljm.95.1630710523848;
 Fri, 03 Sep 2021 16:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
 <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com> <CANn89iJ5Q-PeZ=+87DT-BY4EVhWZATtieid59W7Tq0bkCvRQbw@mail.gmail.com>
In-Reply-To: <CANn89iJ5Q-PeZ=+87DT-BY4EVhWZATtieid59W7Tq0bkCvRQbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 16:08:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwydQEhbZCkUhwbDZp_CdMJrOtRwTThA5bT5C7b+grnA@mail.gmail.com>
Message-ID: <CAHk-=wiwydQEhbZCkUhwbDZp_CdMJrOtRwTThA5bT5C7b+grnA@mail.gmail.com>
Subject: Re: dozens of sysbot reports
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 4:00 PM Eric Dumazet <edumazet@google.com> wrote:
>
> > IOW, it sounds like you can send some netlink message that causes
> > insane hash size allocations. Shouldn't _that_ be fixed?
>
> Probably, but as I said there are many different reports.
>
> If there was only one or two, I would simply have sent a fix(es).
>
> I will probably release these bugs, so that they can be spread among
> interested parties.

Sure.

Let's keep the warning in place. We can remove it before the actual
release if things don't get better, but it does look like it's
actually finding places where people should have checked limits more,
rather than apparently just relying on the allocation failing.

Because with enough memory, the allocations traditionally didn't fail
- they just succeed with completely insane allocations and absolutely
horrendous latencies (ie allocating and possibly clearing gigabytes
and gigabytes of data).

This other one:

>  WARNING: CPU: 1 PID: 26011 at mm/util.c:597 kvmalloc_node+0x111/0x120
> mm/util.c:597
> Modules linked in:
> CPU: 1 PID: 26011 Comm: syz-executor.2 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
> Call Trace:
>  check_btf_line+0x1a9/0xad0 kernel/bpf/verifier.c:9925

Yeah, that code should check "nr_linfo" a lot more than it seems to do.

It had just added __GFP_NOWARN to hide the fact that it did crazy
allocations and just wanted the craziest ones to fail silently.

I think it should just limit itself to something sane.

               Linus
