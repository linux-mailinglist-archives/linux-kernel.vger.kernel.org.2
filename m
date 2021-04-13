Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1B35E285
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbhDMPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhDMPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:20:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2338C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:19:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y2so16439051ybq.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lORjDL8TZwju8FkMkS1xoy3jNtsU/U7pDO8b7Ls1URA=;
        b=MD/6fUiMK2xrWhp5MmJC1WxetyltowMzjP6wTrZSwAlyqPJNIJsUiIPRQwnknHVQuQ
         fiBcrHlf4XvkIJrBMxfv+Ozda0CTgXKboL5uLKY1+r6QxFBvYBfvgJxoOMDZdIt8enOe
         nMcsYnQYq7eDPUDzaf0qFV5zvbjeBmKjEmcqR7x05f86dPKtkXYbIO7OLtm4piUYdYJz
         m0yUId5784aoeOQf9IO/aYNGzvktJF5vve5CU8R416ET2fBAdcFkRyGUD0oHgkX2IOd4
         ZgoTJGras8b7thXxGUoQGRSwZ5fvtb7hNFwoXLGBKPn4v4QGcHSYrJvWRrdcj15uY88C
         /Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lORjDL8TZwju8FkMkS1xoy3jNtsU/U7pDO8b7Ls1URA=;
        b=uLEePAbRvllworQ0YiUbXRZPv6KkgOTrm5YMNETJnejwAeEKM8OVO/aUn/6izbXAa5
         TNcSdd0vcbtVfDCoToodE8co3oxSgps6+yinnpy9nEhfy+8r0Fev9n1IgpaYqZ6rpaj+
         SADO1r28hdELkfUzfSyvnGdNci1uZrPmEhFr7NNwWwdTgatIsmCLeFXx36MNLu/fXTLt
         DDb/p4bj4y11Gr0GZ3UdipEm2ynsjT0E9Zt07wQ4ljtbcq/OypVhCn4B9ldk0tfCxQyA
         5n4mHI3Z32G2KIS/R7tA2AW0l3trLCx+GLdzLGFkgCT23vfqqKPuHyxrbY/aKq669/8m
         AZiQ==
X-Gm-Message-State: AOAM531p4KSaq/hmuMvwf3vcuukY2yXt+uxAUivdZ6iGRafX/ptt4Xzo
        FclhKzSPl/hZQBfczbwLBDCXxE8uVDHEdZhixmIyHQ==
X-Google-Smtp-Source: ABdhPJwHCQmVKPZzC0sBju5fbtbZmJ6fk7dFn9q0ewtDi3XMCFcRiW4HdXMX0RAr3F+U278Od+Kl0nsiorIbjfMUUrY=
X-Received: by 2002:a25:7e01:: with SMTP id z1mr48429014ybc.253.1618327187560;
 Tue, 13 Apr 2021 08:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
 <20210413073657.2308450-3-eric.dumazet@gmail.com> <1578770214.71411.1618324461988.JavaMail.zimbra@efficios.com>
In-Reply-To: <1578770214.71411.1618324461988.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 17:19:36 +0200
Message-ID: <CANn89i+8NPFwqVANzdYNmiSgsJ3fUL7Sk4akJUk1zpnKR5B-mQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rseq: remove redundant access_ok()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 4:34 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 13, 2021, at 3:36 AM, Eric Dumazet eric.dumazet@gmail.com wrote:
>
> > From: Eric Dumazet <edumazet@google.com>
> >
> > After commit 8f2817701492 ("rseq: Use get_user/put_user rather
> > than __get_user/__put_user") we no longer need
> > an access_ok() call from __rseq_handle_notify_resume()
>
> While we are doing that, should we also remove the access_ok() check in
> rseq_syscall() ? It look like it can also be removed for the exact same
> reason outlined here.

Yes, good idea.

 I was focusing in __rseq_handle_notify_resume() paths but
rseq_syscall() can get the same.

> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Arjun Roy <arjunroy@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> > kernel/rseq.c | 2 --
> > 1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index
> > d2689ccbb132c0fc8ec0924008771e5ee1ca855e..57344f9abb43905c7dd2b6081205ff508d963e1e
> > 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -273,8 +273,6 @@ void __rseq_handle_notify_resume(struct ksignal *ksig,
> > struct pt_regs *regs)
> >
> >       if (unlikely(t->flags & PF_EXITING))
> >               return;
> > -     if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
> > -             goto error;
> >       ret = rseq_ip_fixup(regs);
> >       if (unlikely(ret < 0))
> >               goto error;
> > --
> > 2.31.1.295.g9ea45b61b8-goog
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
