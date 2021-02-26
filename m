Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A93265C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBZQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBZQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:43:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:42:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mm21so15620937ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJEVlbPPvFAyDZRVvcO+54tdbNeS7EYd7BewxLTv368=;
        b=qZAoRzlNqnM4lCeuT+0qeH/osuFKDkds9fOdHbG3O55HfQhmH4G1aYpQ79hcrN+Npg
         EL08UcuZvmID7f+0EZUGsIV6h8/zpWrkSSY01N5KKfADq4y2zvftjN4Cf21TK5ensKk/
         OQgu/yH0lx5EhbR3ER6AhwYCFw6GzeBf9hAvVIybzbVuJ5y0dpS66myv5M7FqiXgLSMY
         WNG7IIjEuHfVPU1acE95up21jWXKlPwZfeBjSf+udQEX17+tlgkkp+KKO3xxhCCxLohg
         wC8fPusizxOA3O9003YKQHntLE9er5OMp85yCG2Opq9bQIfH+hQ8SFqwaVEHAeyT8TAP
         pzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJEVlbPPvFAyDZRVvcO+54tdbNeS7EYd7BewxLTv368=;
        b=gQX9ZPQs0IGoNJtcfu7MO/wrewCGT77jtIXhcxok6U5htZ3zovAa86nb17x8EDJcZS
         AegodFB35Jb5HpDYJLAWK9B8Pv7gzeQP6xJz+yO9zAlodWx69Z7KotfSaAYn9yxy2KGN
         8M9LSX3VMS0Y+OXoJOvVkwt26qx+EV5/St6hXFz/s+B1uO1XgqB6aiHwZpgwl0jRwY1e
         XDZUjoRQK9Mgfw2Bk3xXKGPCWpJMRKgugMNyWJE7W/DJT/TQ58FCdR8vVPneF6rh4W5o
         qK/HX2xehnTm1itUlpd82olQKL9VNbVjDx7ihgZMoCg3vBdVenT/2tLw1UXj+xrcpT61
         BYNA==
X-Gm-Message-State: AOAM530eefClss8ENAywSwMBnuUG2+vVl2F7DW3KndSRp662dBCCSvZ8
        BO5AH/qtHyzF9qOI85myNNu3KKLuS1Utf61uBqc=
X-Google-Smtp-Source: ABdhPJyfpJRQybvYVt2aEILrzYV6SzoOhkjtBY/y1tuM5k989hMs5JVczVQRJjKjzt2QhR6XWUNsOnkBvJmpl9M3Pbs=
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr4253944ejv.499.1614357760574;
 Fri, 26 Feb 2021 08:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20210226021254.3980-1-shy828301@gmail.com> <YDijjovHAer2tiL5@dhcp22.suse.cz>
In-Reply-To: <YDijjovHAer2tiL5@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 26 Feb 2021 08:42:29 -0800
Message-ID: <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > When debugging an oom issue, I found the oom_kill counter of memcg is
> > confusing.  At the first glance without checking document, I thought it
> > just counts for memcg oom, but it turns out it counts both global and
> > memcg oom.
>
> Yes, this is the case indeed. The point of the counter was to count oom
> victims from the memcg rather than matching that to the source of the
> oom. Rememeber that this could have been a memcg oom up in the
> hierarchy as well. Counting victims on the oom origin could be equally

Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
this is because v1 may work in non-hierarchcal mode? If this is the
only reason we may be able to remove this to get aligned with v2 since
non-hierarchal mode is no longer supported.

> confusing because in many cases there would be no victim counted for the
> above mentioned memcg ooms.
>
> > The cgroup v2 documents it, but the description is missed for cgroup v1.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> > index 0936412e044e..44d5429636e2 100644
> > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > @@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
> >         (if 1, oom-killer is disabled)
> >       - under_oom        0 or 1
> >         (if 1, the memory cgroup is under OOM, tasks may be stopped.)
> > +        - oom_kill         integer counter
> > +          The number of processes belonging to this cgroup killed by any
> > +          kind of OOM killer.
> >
> >  11. Memory Pressure
> >  ===================
> > --
> > 2.26.2
> >
>
> --
> Michal Hocko
> SUSE Labs
