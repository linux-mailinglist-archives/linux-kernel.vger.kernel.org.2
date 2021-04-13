Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960CB35E4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbhDMRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347068AbhDMRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:07:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:07:23 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 82so18937546yby.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJHF0osKvn2AgrK263fZu9m94RvlODd3F5XjAgRNrtA=;
        b=N4zv5dtjKQpA+b2IE/+D+lAMeVWso7NsaeiCCrn0+DZd5XUpe712IOiO7HI3+vNCdo
         9FH5U9ZPUXxhnasWmc7C7PfJGd0hOCON6jBxZGR70mG/jdxaGHZ1kfFHmYCeIqavJkHp
         9hcZg6PiEo3GLTlS36Ox1AOozVDkUr7NU1pIjSNu5SBLkhbGFZVOPeVf/4nvdF8gFlqg
         rkSsadSWHvCDiLeiHoG6SSV1gY2foKU7ZShoSMXS/ACGPjYigF2Ux/yf5UQmg7dfeN8c
         m/ABEF0h/T+FFkk/trmbrjoNKgtX18GXI8qFbhazY5GWn445ZU5PkhgQIPkhcJA65WZS
         q4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJHF0osKvn2AgrK263fZu9m94RvlODd3F5XjAgRNrtA=;
        b=PgA0WELoDPvdHxDA3SMlW6QAaE9LhfzWyz8FoaHXVNOHX5i1mySDqPVO0gnMxoVr5v
         /s7yF4WdX5IodxwhozGlXa8lA5k3uDxM3xDOwdgz77g/pDVaWXodN73DvAsGRASUymZL
         F6EavFfy/GEwQdMYZcNVWKCHhTfOaaPeUiD3KRMEigoCIlvyjJjyrtKAL3LHCkdh0fY8
         q1++HCQbgyAbNMXmsxuqiFpq6ap3W61axSxaLTJWdqtgiU3Wxp6rdcZJD1WJy1m4NNdS
         2ODwijlv+K6GPc+/lVlZsCDedeISCqlO5RfxtlzKcgIFTnqKTc4n2e+wkEifCuCo0HHg
         YE0g==
X-Gm-Message-State: AOAM530rFq7gWs3I2gzCh1lc5CstWd7/tAvhbz35VqpLz3Zdx+yj6ExO
        vHmisZVPmcCAEkaRwy4K+c2F0VEZhrRNqYkIqI96gw==
X-Google-Smtp-Source: ABdhPJyWf+TFFxWWQ1LTrc1cQ2AjlIxf5nEHWgmd84nTnN68n2guN/62Tvm+nlt7Fp/IEOPcfidWkCjhjwPN6QPE0MA=
X-Received: by 2002:a25:7650:: with SMTP id r77mr19042681ybc.446.1618333642288;
 Tue, 13 Apr 2021 10:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com> <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
In-Reply-To: <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 19:07:10 +0200
Message-ID: <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 13, 2021 at 6:57 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > > ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
> > >
> > > > From: Eric Dumazet <edumazet@google.com>
> > > >
> > > > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> > > > update includes") added regressions for our servers.
> > > >
> > > > Using copy_from_user() and clear_user() for 64bit values
> > > > is suboptimal.
> > > >
> > > > We can use faster put_user() and get_user().
> > > >
> > > > 32bit arches can be changed to use the ptr32 field,
> > > > since the padding field must always be zero.
> > > >
> > > > v2: added ideas from Peter and Mathieu about making this
> > > >    generic, since my initial patch was only dealing with
> > > >    64bit arches.
> > >
> > > Ah, now I remember the reason why reading and clearing the entire 64-bit
> > > is important: it's because we don't want to allow user-space processes to
> > > use this change in behavior to figure out whether they are running on a
> > > 32-bit or in a 32-bit compat mode on a 64-bit kernel.
> > >
> > > So although I'm fine with making 64-bit kernels faster, we'll want to keep
> > > updating the entire 64-bit ptr field on 32-bit kernels as well.
> > >
> > > Thanks,
> > >
> >
> > So... back to V1 then ?
>
> Or add more stuff as in :

diff against v2, WDYT ?

diff --git a/kernel/rseq.c b/kernel/rseq.c
index f2eee3f7f5d330688c81cb2e57d47ca6b843873e..537b1f684efa11069990018ffa3642c209993011
100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -136,6 +136,10 @@ static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
 {
        u32 ptr;

+       if (get_user(ptr, &rseq->rseq_cs.ptr.padding))
+               return -EFAULT;
+       if (ptr)
+               return -EINVAL;
        if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
                return -EFAULT;
        *uptrp = (struct rseq_cs __user *)ptr;
@@ -150,8 +154,9 @@ static int rseq_get_rseq_cs(struct task_struct *t,
struct rseq_cs *rseq_cs)
        u32 sig;
        int ret;

-       if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
-               return -EFAULT;
+       ret = rseq_get_cs_ptr(&urseq_cs, t->rseq);
+       if (ret)
+               return ret;
        if (!urseq_cs) {
                memset(rseq_cs, 0, sizeof(*rseq_cs));
                return 0;
@@ -237,7 +242,8 @@ static int clear_rseq_cs(struct task_struct *t)
 #ifdef CONFIG_64BIT
        return put_user(0UL, &t->rseq->rseq_cs.ptr64);
 #else
-       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
+       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
+              put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
 #endif
 }
