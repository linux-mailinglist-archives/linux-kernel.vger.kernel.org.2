Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E5D352432
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhDAX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAX5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:57:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2928C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:57:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so1809567pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy2/xTXVJKlkuX9BqfC2ojvTowyICVdT5fVdC2LqXu4=;
        b=rS2UYcUSrJaE3MfeEbSFYQGFNF/Wk4Jp/ZKQAosuUoSDAWVf+/zVgmo5BoMw6Mi4Tn
         XmuAtrLExkN6Vt+sBWwFHQ1JAv/NhHm1c9Qq4gXViyDp9g2gT2st+s6+K+y5YiPwBq9s
         L1UtID066TnWA+8TWsoUBADRz7xAUpcs2mRt7rtIIqWfeeIpoF/P8jUvkC+96fBbREOH
         iuqjMTMz38CUWepvVNQKTw0DhE1ONOKsmJh9q0jbV6q32poX8QgYXineYYP0RjVYnQuH
         FKu5gjHHUqPX+2b2lNixUjCwcnG+iF1Bh32UhvqQjcAyB0PC4iCluwqvkmrUuCNtmynb
         d81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy2/xTXVJKlkuX9BqfC2ojvTowyICVdT5fVdC2LqXu4=;
        b=mQyjL4VKO40FePQdpXuNiOWnvrIdK12lwzGlAQTgtj0nu/0OK60DaAoo6CHgZCwtKo
         D4dOPEcXa6f4dmcJZbdvlAR5m23yYG/9PQVJCZJN+cYApBaPdBIkBBElW7x388NteWGk
         f8JqPIF1TVi8SIkdy0QII8LOKIHn7LYw31zQi4gjWTfu+ClADAMeIZQwMACI7pYu5Sre
         7FzQKMG1jAYCf3FEBCCrtsxkTeURysggOuak8onnKLrl/lAfiBys7F1N1ks5HmLRdQaf
         ul7Crnqz3arMimCPSCUuNoJoopyp84xSrS7XLhzWVorsoC5XjXYocm1thT1ou53I9xyw
         IA9Q==
X-Gm-Message-State: AOAM530ShH3mO6DdxhZdGrkqbPWrthHvW84ta+F+AvOV/eA/l/Y+HPIc
        r8QpqDHX5+v1Ul6RIuJOw3zdgDL3QD74SSCUQFvYTg==
X-Google-Smtp-Source: ABdhPJzR0ydavgUoTRVpydEa351dtEGQYJSRhhF2NtrovKyJnkwtyEvuIX79CGWFgZkyxplfWD2RkhTfjXBuMJh2PF0=
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr11244551pjv.23.1617321453020;
 Thu, 01 Apr 2021 16:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401021645.2609047-1-varmam@google.com> <YGUv5yIBTFbwuTxB@zeniv-ca.linux.org.uk>
In-Reply-To: <YGUv5yIBTFbwuTxB@zeniv-ca.linux.org.uk>
From:   Manish Varma <varmam@google.com>
Date:   Thu, 1 Apr 2021 16:57:22 -0700
Message-ID: <CAMyCerJeZ0R4W1CjCRQQ5c_NhEUTyyH_xWism3YBhnzOJJkgXQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Improve eventpoll logging to stop indicting timerfd
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Wed, Mar 31, 2021 at 7:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Mar 31, 2021 at 07:16:45PM -0700, Manish Varma wrote:
> > timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> > it names them after the underlying file descriptor, and since all
> > timerfd file descriptors are named "[timerfd]" (which saves memory on
> > systems like desktops with potentially many timerfd instances), all
> > wakesources created as a result of using the eventpoll-on-timerfd idiom
> > are called... "[timerfd]".
> >
> > However, it becomes impossible to tell which "[timerfd]" wakesource is
> > affliated with which process and hence troubleshooting is difficult.
> >
> > This change addresses this problem by changing the way eventpoll
> > wakesources are named:
> >
> > 1) the top-level per-process eventpoll wakesource is now named "epoll:P"
> > (instead of just "eventpoll"), where P, is the PID of the creating
> > process.
> > 2) individual per-underlying-filedescriptor eventpoll wakesources are
> > now named "epollitemN:P.F", where N is a unique ID token and P is PID
> > of the creating process and F is the name of the underlying file
> > descriptor.
> >
> > All together that should be splitted up into a change to eventpoll and
> > timerfd (or other file descriptors).
>
> FWIW, it smells like a variant of wakeup_source_register() that would
> take printf format + arguments would be a good idea.  I.e. something
> like
>
> > +             snprintf(buf, sizeof(buf), "epoll:%d", task_pid);
> > +             epi->ep->ws = wakeup_source_register(NULL, buf);
>
>                 ... = wakeup_source_register(NULL, "epoll:%d", task_pid);
>
> etc.

Noted. I will fix this in the v3 patch.

Thanks,
Manish
