Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00193F72AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhHYKKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:10:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A086C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so51760963lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doAscKAZMde+fqaT6ZYuxO600bMz4mciSK6zFvt3wvk=;
        b=cz1g74cyClGF7Oe8zFGEIz14Ui1uUbp8bXGIbhvmCzPO3l+nnERpDyTrTKy0AY+jDA
         0q8RtDXiJMdi2NGeHrPFymtrXhHEK9ykEk7U4sMbCocrePe8hKAY/UN7nzrxfOi5TK5p
         5WM6R2pWzgj6OFdwr0+iSFVsX60a1mx8xN7xwponsV/ty6unne0VtYNCUz5cUpIxTRxo
         ABmVHLOH2YT0dfDQTz+JmxUCNL2YNv4GqNazsSsmysyOx9X5g3vUUAhqXCUcXv+5HKl1
         g23Dt1TMFneSs2+XMNYfx0w6/zkjG8fItouHXmvAUT+Vg97SE2RYFYkaRmJUZcUAt4Pv
         /WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doAscKAZMde+fqaT6ZYuxO600bMz4mciSK6zFvt3wvk=;
        b=IsVE4vVFyf92Yw1ci7oCfS8EsZTcxjxFEzCRVHe8f+Onf3Vyopc2uHWn6UjFzesXWN
         rDfIzsJkjvnS8QyHJoMjDDa/0O8eLgD62GmL8vm7rOzmESI/ZBX3tsv6k6bpmqd0SnDA
         zm0vaH4h21eUKVsLSMm8+SH2rAveS36qVL8IxI2O4DZ5seFoUj+kSRuuUA+QDjdW4tSf
         rbgm4n+sJbjNvsbWedR37SE9JL+a0m7vC5x6AUXl7QBZxj79/G/h445Gr9ZH6DF6qPZ3
         MKIYmd1Q/tIeugGu2lo1CPaVyujrcqvWuww8c54DY9v87kM35VprhydOGCQMHAVpKAnu
         EzFw==
X-Gm-Message-State: AOAM531Y3mwMmwJqIygI87ccFn2wW+Sds2vlTksPyqZrxuAj+2EplW0e
        IZOBmBb9V+dT/9a3n/KqRnfLw/9tvBD6WJ8iN3I=
X-Google-Smtp-Source: ABdhPJyd5k/O9/kmpZ4feSAFyVETBdhEMc1RVJOK3JIWo1RkX6tu0mWMyI28hJFkXqADfeYnXoWo+3P0+usF6QRCBx8=
X-Received: by 2002:a05:6512:468:: with SMTP id x8mr2482800lfd.369.1629886173681;
 Wed, 25 Aug 2021 03:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210430122521.13957-1-cainiao666999@gmail.com> <87czqlsatw.ffs@tglx>
In-Reply-To: <87czqlsatw.ffs@tglx>
From:   Mingzhe Yang <cainiao666999@gmail.com>
Date:   Wed, 25 Aug 2021 18:07:13 +0800
Message-ID: <CAAY4BKNv-nqHDcXhHt0dF5VP+SRBMHLFOf_NYCC7hesDOXuDCQ@mail.gmail.com>
Subject: Re: [PATCH] tasklets: simplify code in tasklet_action_common()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        yuxin.wooo@gmail.com, becausehan@gmail.com, huan.xie@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tglx,
Thanks for your review!

Sorry, I didn't think carefully enough about this patch.

I want to simplify code in tasklet_action_common, because it has more
than 3 levels of indentation. Let me try again without any new functions.

diff --git a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -777,16 +777,16 @@ static void tasklet_action_common(struct
softirq_action *a,
                list = list->next;

                if (tasklet_trylock(t)) {
-                       if (!atomic_read(&t->count)) {
-                               if (tasklet_clear_sched(t)) {
-                                       if (t->use_callback)
-                                               t->callback(t);
-                                       else
-                                               t->func(t->data);
-                               }
+                       if (atomic_read(&t->count) || !tasklet_clear_sched(t)) {
                                tasklet_unlock(t);
                                continue;
                        }
+
+                       if (t->use_callback)
+                               t->callback(t);
+                       else
+                               t->func(t->data);
+
                        tasklet_unlock(t);
                }

--
Thanks,

        Mingzhe Yang

On Tue, Aug 10, 2021 at 9:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Apr 30 2021 at 20:25, Mingzhe Yang wrote:
>
> > Use tasklet_is_disabled() to simplify the code in
> > tasklet_action_common.
>
> This changelog is not really helpful. Use a new function does not tell
> anything. Neither does it explain why there need to be two new functions
> and worse
>
> > +static inline bool tasklet_is_enabled(struct tasklet_struct *t)
> > +{
> > +     smp_rmb();
>
> why there is suddenly a new undocumented SMP barrier in the code.
>
> > +     return !atomic_read(&t->count);
> > +}
> > +
> > +static inline bool tasklet_is_disabled(struct tasklet_struct *t)
> > +{
> > +     return !tasklet_is_enabled(t);
> > +}
> > +
>
> Aside of that there is no point in exposing these functions in a global
> header.
>
> Thanks,
>
>         tglx
