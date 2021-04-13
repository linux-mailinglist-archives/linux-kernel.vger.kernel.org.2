Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0635E482
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhDMRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhDMRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:02:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:01:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z1so18903377ybf.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIb8IwNOZepXabt6WVaLaJtN2aj5BmW49uF20/Ejxbo=;
        b=by5WlLVcOZORyGd/g5wQBfbbtWans0+3l+XmttHOX0fMxtej5hmYT2PFzP13MggXRN
         1dM6PpsrVbmxpQ6pZvZSjffKn1i4kMjfr//SMb4N0zVt47WwmA5AyfYFrng8hV9f7tP8
         q5t+rn44wBrXyS5QZWaPuCulpeBrR8mg/wLiwfBWd39Ayj+mFW7st9Sy+qaIHeVtoK8Q
         LWALjVvcg/gSc2vJ7w9mK/LsGrFR1dnt4EcRtXD2bq7PqFXPhctWmvX/CN4mYeU6S05I
         my2IlhsiYJIlm0P+aHm6W9HWKUCk03GXoBrAq0q8/B0nfFnQRMEJfkiaJm61fNwNz+eQ
         68sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIb8IwNOZepXabt6WVaLaJtN2aj5BmW49uF20/Ejxbo=;
        b=nxET2UKhf5R8BLqt7iYEALJEWO+2GHsmrPHXYvrEojqa7SZB0VD2nvScrBB3ul4Nz9
         8k15X20bSFriuwHyN2Ok+s8LuK56idSGJ3gxfW/u01HIsY2mHMuX3shFHHeem2al0qV+
         U2UMrLrJua7Pb1umLJrq7naLikpOlRY1WPtP39tp0lTpd2J7uEcuXxOcQP/4TRxj9D/l
         96iprvwnFjPGNY0+M3353X31hv9XAIy4G2u+B9qn3TJio5n/VHJpZ9HEFxhVhvbbS6ki
         v2X626U1e/MEIoKCun/sJG/FR7iSDWakXAj70RgcOUhT0r4PDAnWzEu6m3wIgRQuV77/
         zE0A==
X-Gm-Message-State: AOAM533IAdbX5BLIxpvGIWgJ40EXxKVho/v1nz+fR5f2PyrjLJQetAcn
        S2gE4aGJmcLQmavJYHl4l04XilGCOGpMdAF3xH3TFg==
X-Google-Smtp-Source: ABdhPJw3Ku4sidGmHTbo4JkUh9gOnvof+MtbHjtka2H/Qfkr5LawR2YDAAUxsyWUHdMJyBJgLfEL4XJ3EcUC+BEJzm8=
X-Received: by 2002:a25:cf08:: with SMTP id f8mr10283550ybg.132.1618333308825;
 Tue, 13 Apr 2021 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
In-Reply-To: <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 19:01:37 +0200
Message-ID: <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 6:57 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
> >
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> > > update includes") added regressions for our servers.
> > >
> > > Using copy_from_user() and clear_user() for 64bit values
> > > is suboptimal.
> > >
> > > We can use faster put_user() and get_user().
> > >
> > > 32bit arches can be changed to use the ptr32 field,
> > > since the padding field must always be zero.
> > >
> > > v2: added ideas from Peter and Mathieu about making this
> > >    generic, since my initial patch was only dealing with
> > >    64bit arches.
> >
> > Ah, now I remember the reason why reading and clearing the entire 64-bit
> > is important: it's because we don't want to allow user-space processes to
> > use this change in behavior to figure out whether they are running on a
> > 32-bit or in a 32-bit compat mode on a 64-bit kernel.
> >
> > So although I'm fine with making 64-bit kernels faster, we'll want to keep
> > updating the entire 64-bit ptr field on 32-bit kernels as well.
> >
> > Thanks,
> >
>
> So... back to V1 then ?

Or add more stuff as in :

#ifdef CONFIG_64BIT
+       return put_user(0UL, &t->rseq->rseq_cs.ptr64);
+#else
+       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
+#endif
