Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF132675A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBZTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZTUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:20:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:20:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c23so5869500edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAgRNmsGOdl3/cgNTgckimnaWEgU9jQUQCrsL7tdGio=;
        b=F1YoAeR9FAM+1UpF++eXbPXOyDleQgQIJdYrUNA6Let3x//1AiwIJSWD7pxtFT0vZM
         NIaDUywKwuqGKv20X+MY40UhdKSXyjjasOV9BnSfdT5MVDX2t3P0cKCCNci2BXD0PMW5
         UVO4tqS8pHBZQrxLCrh/VePbmmM7/rKDqEkBYDC1EOOYBW7MzPW5Ou+814mdiQGNiU1K
         4xYoFHu2X7v7Vu0R2HyADlRS1Ohivsk2TKqWtHaixzQwID4kMWCCInNhkDIXKXihzeU6
         otdd1Aqr/oTWTl7ESxd/VGrgJZswC6fxO94tmhbm6hzh29dGbljlOeoMCwdJP7A0S7IL
         YRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAgRNmsGOdl3/cgNTgckimnaWEgU9jQUQCrsL7tdGio=;
        b=R26tJW9vVAFx2tmjDa4y35X2WrRwZL8TwTo7uV09MR8kX9b70ePQIqegPGxF48ufOX
         4nHC4IRwGv2yEWS6AycDHmcWACrtAwkI/i9b3OA1xiOFVKD3/faCZUo/2tDDF//qM3YJ
         6msBi8W1gcdDOe+knE9wcoTh25JwDTnBhg/ikN976OPeDghZe2hXn51fMJCcP2M7wBL+
         VMj0dnrIpAUne+fXA7lSwBe9UK6rjL1ogwUAfs4lRq2/mFP4cx1LyzhNOdVjHFFBTM8y
         Uj7GzEw6Wi0AD8P2dvoftIdybrS3n3heIxYI54g3CiPj+Ck7iVa6m7bh1UHEZlsMKNuS
         zCrw==
X-Gm-Message-State: AOAM533dwJj4KCq2tasPPD6xC6sxSDdfnTUWmqkfwX2mUXxSqVv16Qof
        3P2wJG3GLPCdIleWT1H0LZM+ei0kIfj/Ze8IDpsYAnQK
X-Google-Smtp-Source: ABdhPJwyIGx+Yr3meZzdDNV+mbQOAEIbg9OJktwdmHZEQg5KEhJoQx+crPdWgBDj4Mj/HN/DwWl6v4zMZSIK+z49AQQ=
X-Received: by 2002:a50:bec3:: with SMTP id e3mr5102234edk.290.1614367204017;
 Fri, 26 Feb 2021 11:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20210226021254.3980-1-shy828301@gmail.com> <YDijjovHAer2tiL5@dhcp22.suse.cz>
 <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
In-Reply-To: <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 26 Feb 2021 11:19:51 -0800
Message-ID: <CAHbLzkrgtbR1o3pTSh_hqPhrkugXBnB4uwdHh+uK6Ndp-u_fEw@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 8:42 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > > When debugging an oom issue, I found the oom_kill counter of memcg is
> > > confusing.  At the first glance without checking document, I thought it
> > > just counts for memcg oom, but it turns out it counts both global and
> > > memcg oom.
> >
> > Yes, this is the case indeed. The point of the counter was to count oom
> > victims from the memcg rather than matching that to the source of the
> > oom. Rememeber that this could have been a memcg oom up in the
> > hierarchy as well. Counting victims on the oom origin could be equally
>
> Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
> this is because v1 may work in non-hierarchcal mode? If this is the
> only reason we may be able to remove this to get aligned with v2 since
> non-hierarchal mode is no longer supported.

BTW, having the counter recorded hierarchically may help out one of
our usecases. We want to monitor the oom_kill for some services, but
systemd would wipe out the cgroup if the service is oom killed then
restart the service from scratch (it means create a brand new cgroup
with the same name). So this systemd behavior makes the counter
useless if it is not recorded hierarchically.

>
> > confusing because in many cases there would be no victim counted for the
> > above mentioned memcg ooms.
> >
> > > The cgroup v2 documents it, but the description is missed for cgroup v1.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > > ---
> > >  Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> > > index 0936412e044e..44d5429636e2 100644
> > > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > > @@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
> > >         (if 1, oom-killer is disabled)
> > >       - under_oom        0 or 1
> > >         (if 1, the memory cgroup is under OOM, tasks may be stopped.)
> > > +        - oom_kill         integer counter
> > > +          The number of processes belonging to this cgroup killed by any
> > > +          kind of OOM killer.
> > >
> > >  11. Memory Pressure
> > >  ===================
> > > --
> > > 2.26.2
> > >
> >
> > --
> > Michal Hocko
> > SUSE Labs
