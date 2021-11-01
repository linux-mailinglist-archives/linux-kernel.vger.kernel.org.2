Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AA441CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKAOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKAOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:33:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94AC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:31:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s24so785457lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJLhZg8fgyUrWR28/t5VvMjVzdgGdzLZ7WEsafpviKg=;
        b=IuCM/zkA9w+zgj7vM1G+9lF2cqdeAOg3vv9y1Byl7DrCiV23k+GnQ4JGGsr7QyATI+
         1StNazJxafHRYdl260iMQFo4AmqjwPrsOVEsobM+Knsyjgd2xz83jHHujz9TzyOA8wji
         V73MWziifVDeKIR1KLYWw6A1KkjeD/laXqi0j0nHmTXPqILXVUIcV1nMJ7V+TvaaF7Kf
         MBzaKrCwZfGd1Xi8JjBRFwmOns5L79zNRXTGNHDtTZDW78CsruZn8e9uVFnOA/UWdbUS
         8iidVKw4qfj2b6ds/SwYhli/fuofO8cLzOOEDshbVNx5goTKMqWCYPNEQO1RvjSaSpMu
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJLhZg8fgyUrWR28/t5VvMjVzdgGdzLZ7WEsafpviKg=;
        b=4vRHkriVt+kvOc90M7RENYXEFyl/EU/DTjiOo1uqCeOUfPHn8pVKsgugpaWcurD4NC
         iIa9Nh97Q2JiNuyLQRbBKgmq3ljYpLJmSGqXk0JhL1DDGQWUMEfqquR+qpP9V9TLF9Cm
         fN+lZLtY0oWGO4qYOywz4Fft53ghxGuHYHGX3mhPxKuhxPa2ddAz4J61i7vEbEiSyThM
         fnvj5MEaN+v+E2RGgI14Y1sbuLxrAYiq4lBAkvF4y6/IM8QbPfVbKIpceryU91EBUUNU
         K5BBdiBpnybuYe4UsEZZB3Hm+7qIg172OPHF+jiIRhc4EINCYa+oefeaVVBiSHMSEsXU
         PtUA==
X-Gm-Message-State: AOAM5306FNRds9VZ3imhUXzM/RwVBOad88Fs22Xz5F5cx0dulxq6yEDz
        6YPBbdNSENWCbKOOYpIzuKbjirFabiKhBJjJepXQ8w==
X-Google-Smtp-Source: ABdhPJxoZb9NdURfvUT8GcH1I9TuGJTGoo8r4lq3ScBZPmN1Z72mGEA5Knv8Ic2/fcV/g5pp3DguNSmkdxt3rLfc/jU=
X-Received: by 2002:a05:651c:114b:: with SMTP id h11mr5220050ljo.41.1635777076656;
 Mon, 01 Nov 2021 07:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com> <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com> <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com> <27b7177c-71be-9ff2-716e-caaa5035d451@nvidia.com>
In-Reply-To: <27b7177c-71be-9ff2-716e-caaa5035d451@nvidia.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 1 Nov 2021 10:30:41 -0400
Message-ID: <CA+CK2bDb4vZYFEYf7WuanbCYFh+Kb=U3VHqRwj-YTFhzsp6ZuQ@mail.gmail.com>
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in set_page_recounted()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 9:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 10/27/21 18:20, John Hubbard wrote:
> >>> But it's still not good to have this function name doing something completely
> >>> different than its name indicates.
> >>
> >> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
> >>
> >
> > What? No, that's not where I was going at all. The function is already
> > named set_page_refcounted(), and one of the problems I see is that your
> > changes turn it into something that most certainly does not
> > set_page_refounted(). Instead, this patch *increments* the refcount.
> > That is not the same thing.
> >
> > And then it uses a .config-sensitive assertion to "prevent" problems.
> > And by that I mean, the wording throughout this series seems to equate
> > VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
> > however, in CONFIG_DEBUG_VM configurations, and provide no protection at
> > all for normal (most distros) users. That's something that the wording,
> > comments, and even design should be tweaked to account for.
>
> ...and to clarify a bit more, maybe this also helps:
>
> These patches are attempting to improve debugging, and that is fine, as

They are attempting to catch potentioal race conditions where
_refcount is changed between the time we verified what it was and we
set it to something else.

They also attempt to prevent overflows and underflows bugs which are
not all tested today, but can be tested with this patch set at least
on kernels where DEBUG_VM is enabled.

> far as debugging goes. However, a point that seems to be slightly
> misunderstood is: incrementing a bad refcount value is not actually any
> better than overwriting it, from a recovery point of view. Maybe (?)
> it's better from a debugging point of view.

It is better for debugging as well: if one is tracing the page
_refcount history, knowing that the _refcount can only be
incremented/decremented/frozen/unfrozen provides a contiguous history
of refcount that can be tracked. In case when we set refcount in some
places as we do today, the contigous history is lost, as we do not
know the actual _refcount value at the time of the set operation.

>
> That's because the problem occurred before this code, and its debug-only
> assertions, ran. Once here, the code cannot actually recover: there is
> no automatic way to recover from a refcount that it 1, -1, 2, or 706,
> when it was supposed to be zero. Incrementing it is, again, not really
> necessarily better than setting: setting it might actually make the
> broken system appear to run--and in some cases, even avoid symptoms.
> Whereas incrementing doesn't cover anything up. The only thing you can
> really does is just panic() or BUG(), really.

This is what my patch series attempt to do, I chose to use VM_BUG()
instead of BUG() because this is VM code, and avoid potential
performance regressions for those who chose performance over possible
security implications.

>
> Don't get me wrong, I don't want bugs covered up. But the claim that
> incrementing is somehow better deserves some actual thinking about it.

I think it does, I described my points above, if you still disagree
please let me know.

Thank you for providing your thoughts on this RFC, I will send out a
new version, and we can continue discussion in the new thread.

Pasha
