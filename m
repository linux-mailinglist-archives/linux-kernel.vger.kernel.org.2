Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E93D7B38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG0QkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0QkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:40:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D3C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:40:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p21so9068428edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjzeUVvJswvcHGT2fbToSFt2ojNAWbzdCIBHmZESzEA=;
        b=Zi0pWiQP3DUB+TIDfmSW2Vzimjnj6sQSfgbliH9BOWJ1PnGcT0BhpKm/lV9iDTk3XW
         NTSsg0DQACe+l/jGdeBGe6mlp+wW4X7YozLHvV6cYfHcP5xCEc6My3/QdtrrkoSfna9u
         Gzcw83SoCyk30haw8/ONsjvc7VHwgcpcglQYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjzeUVvJswvcHGT2fbToSFt2ojNAWbzdCIBHmZESzEA=;
        b=eeyIXqFv/hKqGKernEc+ODvhACaZuihdDXR3EWMvQ7lgoJ9yzWwL7kRgitTCJHuYz5
         z3AaUV5B9Pt1xKOaT6gVoyEEWc/QAfp04wpO2liEm+EgBowJeoR+QVc0RJ4af4rwX06I
         eaqDCS4AO0ue00VmXUTRpHKFXraBKvQvAnaYJMzr4Stzs7pO+puhe6Ybw0pKGC5RrGW4
         caE+/eYJe6POaKOdl1Gs1gcPPje5sDXCLooOK0oMID/FwKK3wdTPrRMJzAsT3b3+RCi4
         wOaaZ83utzhmPwI6envMluyQS2dvsjldxsbyYv9OhFjLFSmIItr/95eoJekfP0ZtzYJW
         ks6A==
X-Gm-Message-State: AOAM532J+XsCJjzqYhrozQBLSHiIAe1nBtej6uI26oNIqTdXpAG7XHBx
        deLRdwix1gPY8rPDYd5LAVY4ATc1j7hv3BdS
X-Google-Smtp-Source: ABdhPJzAmbktJLB2cugz9HzVvwpQnGKRWFm5lnpyVLazNBv+E8VsIgV7N/fu1OY/JFUqjbSNNpi+OQ==
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr28661085edd.361.1627403998394;
        Tue, 27 Jul 2021 09:39:58 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id gx11sm1076013ejc.33.2021.07.27.09.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 09:39:58 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id u12so16198375eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:39:58 -0700 (PDT)
X-Received: by 2002:a2e:90c4:: with SMTP id o4mr16333375ljg.28.1627403529209;
 Tue, 27 Jul 2021 09:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com> <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
In-Reply-To: <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 27 Jul 2021 09:31:33 -0700
X-Gmail-Original-Message-ID: <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com>
Message-ID: <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 5:21 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.07.21 11:48, David Hildenbrand wrote:
> > On 27.07.21 02:12, Evan Green wrote:
> >> Add a new SWAP_FLAG_HIBERNATE_ONLY that adds a swap region but refuses
> >> to allow generic swapping to it. This region can still be wired up for
> >> use in suspend-to-disk activities, but will never have regular pages
> >> swapped to it. This flag will be passed in by utilities like swapon(8),
> >> usage would probably look something like: swapon -o hibernate /dev/sda2.
> >>
> >> Currently it's not possible to enable hibernation without also enabling
> >> generic swap for a given area. One semi-workaround for this is to delay
> >> the call to swapon() until just before attempting to hibernate, and then
> >> call swapoff() just after hibernate completes. This is somewhat kludgy,
> >> and also doesn't really work to keep swap out of the hibernate region.
> >> When hibernate begins, it starts by allocating a large chunk of memory
> >> for itself. This often ends up forcing a lot of data out into swap. By
> >> this time the hibernate region is eligible for generic swap, so swap
> >> ends up leaking into the hibernate region even with the workaround.
> >>
> >> There are a few reasons why usermode might want to be able to
> >> exclusively steer swap and hibernate. One reason relates to SSD wearing.
> >> Hibernate's endurance and speed requirements are different from swap.
> >> It may for instance be advantageous to keep hibernate in primary
> >> storage, but put swap in an SLC namespace. These namespaces are faster
> >> and have better endurance, but cost 3-4x in terms of capacity.
> >> Exclusively steering hibernate and swap enables system designers to
> >> accurately partition their storage without either wearing out their
> >> primary storage, or overprovisioning their fast swap area.
> >>
> >> Another reason to allow exclusive steering has to do with security.
> >> The requirements for designing systems with resilience against
> >> offline attacks are different between swap and hibernate. Swap
> >> effectively requires a dictionary of hashes, as pages can be added and
> >> removed arbitrarily, whereas hibernate only needs a single hash for the
> >> entire image. If you've set up block-level integrity for swap and
> >> image-level integrity for hibernate, then allowing swap blocks to
> >> possibly leak out to the hibernate region is problematic, since it
> >> creates swap pages not protected by any integrity.
> >>
> >> Swap regions with SWAP_FLAG_HIBERNATE_ONLY set will not appear in
> >> /proc/meminfo under SwapTotal and SwapFree, since they are not usable as
> >> general swap. These regions do still appear in /proc/swaps.
> >
> > Right, and they also don't account towards the memory overcommit
> > calculations.
> >
> > Thanks for extending the patch description!

No problem, thanks for all the brainwaves directed at this.

> >
> > [...]
> >
> >> +    if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY) {
> >> +            if (IS_ENABLED(CONFIG_HIBERNATION)) {
> >> +                    if (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS)
> >> +                            return -EINVAL;
> >> +
> >> +            } else {
> >> +                    return -EINVAL;
> >> +            }
> >> +    }
> >
> > We could do short
> >
> > if ((swap_flags & SWAP_FLAG_HIBERNATE_ONLY) &&
> >        (!IS_ENABLED(CONFIG_HIBERNATION) ||
> >         (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS)))
> >       return -EINVAL;
> >
> > or
> >
> > if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY))
> >       if (!IS_ENABLED(CONFIG_HIBERNATION) ||
> >               (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS))
> >               return -EINVAL;
> >
> >> +
> >>      if (!capable(CAP_SYS_ADMIN))
> >>              return -EPERM;
> >>
> >> @@ -3335,16 +3366,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> >>      if (swap_flags & SWAP_FLAG_PREFER)
> >>              prio =
> >>                (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
> >> +
> >> +    if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY)
> >> +            p->flags |= SWP_HIBERNATE_ONLY;
> >>      enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
> >>
> >> -    pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
> >> +    pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s%s\n",
> >>              p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
> >>              nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
> >>              (p->flags & SWP_SOLIDSTATE) ? "SS" : "",
> >>              (p->flags & SWP_DISCARDABLE) ? "D" : "",
> >>              (p->flags & SWP_AREA_DISCARD) ? "s" : "",
> >>              (p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> >> -            (frontswap_map) ? "FS" : "");
> >> +            (frontswap_map) ? "FS" : "",
> >> +            (p->flags & SWP_HIBERNATE_ONLY) ? "H" : "");
> >>
> >>      mutex_unlock(&swapon_mutex);
> >>      atomic_inc(&proc_poll_event);
> >>
> >
> > Looks like the cleanest alternative to me, as long as we don't want to
> > invent new interfaces.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> >
>
> Pavel just mentioned uswsusp, and I wonder if it would be a possible
> alternative to this patch.

I think you're right that it would be possible to isolate the
hibernate image with uswsusp if you avoid using the SNAPSHOT_*SWAP*
ioctls. But I'd expect performance to suffer noticeably, since now
every page is making a round trip out to usermode and back. I'd still
very much use the HIBERNATE_ONLY flag if it were accepted, I think
there's value to it.

-Evan
