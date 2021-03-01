Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E138B3293B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhCAVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhCARTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:19:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C49C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:18:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so29648077ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vv6t5g8xmRQrU3t4nwEI1adaYgpKEkMqFy3Pe4ng6DE=;
        b=LG5630hxJ/RU1Vhwdq9zzm9Y94EvZi4itREzN4F+bHXi9ZMDLn5fk/NhUoOeDQ92Yd
         RaaVkDDZrgitJ1gYmrJY2fzvTGU7Yce18FWzKGE3qN7xR6jbrM075E9XrvWw6uxbcugF
         tOuTJAs4Cdn9QeZeeWqMo+NCDRdTcnAy4OpLY8JEZBNV+vBRxgxIdxxbVB+/NyeSOkAK
         dqR4Tysj/lpoLQFDfgLSJX5NO7k4WclYROWTo7zIW2vc9YNr81iWx4/QiQF5yzt8iErt
         uvMQz0b5eomR+5ZominYN7ZcTEn8/+v9o7CVF6au5HruHQC0wkWXdZoGyqpQOefiwUI9
         2Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv6t5g8xmRQrU3t4nwEI1adaYgpKEkMqFy3Pe4ng6DE=;
        b=hFuit7mLros+Ck7WIZcKa9WR6U0+VlxgT2wsytDRtb4gnwI2af45i/HMIaScmkqm98
         JowbQVR68ak53pXy97Z622sMrymf+o6i0sa3Xad8evzepcFeMV0PMubSixzy+Lm/HuhI
         Lvm3CIN4Xxub7mFqkjDb+yihntVJcTsL6d/LhgJPXE7RCeAPMVOBSv3W+HDY0RkvwaUZ
         tONf5NLUF4Vmrv18VcHodxkzkE3d9bY7+NlZxGgTmHi7S9TaqNWSyJyO6vToMcBc6V9A
         S6MTSTbjUnWAXPPqamjrN2ASBEDqwwxYjCU8jYKATH//Cr2mxE7BkSPcXFLGAVAi5bF/
         SK3A==
X-Gm-Message-State: AOAM530kt61OECLRgThZDlyPWy6UEvtdBP0BJ223HEv6FGRiPMaRUlpY
        DBZLjC/4Z05n0xuljMQ+YoZqgG4c9oG9uIJpxOo=
X-Google-Smtp-Source: ABdhPJx31N4JWJjQv43bkttTGqAs8q4uS7GeLxKU4ia9HhxWJv7MDghBLNRkrkoxDyZL1rgsGhbvTg6XleVLGNjVwe8=
X-Received: by 2002:a17:907:2bf6:: with SMTP id gv54mr17343031ejc.514.1614619082651;
 Mon, 01 Mar 2021 09:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20210226021254.3980-1-shy828301@gmail.com> <YDijjovHAer2tiL5@dhcp22.suse.cz>
 <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
 <CAHbLzkrgtbR1o3pTSh_hqPhrkugXBnB4uwdHh+uK6Ndp-u_fEw@mail.gmail.com> <YDzdB7RtLex+8VkA@dhcp22.suse.cz>
In-Reply-To: <YDzdB7RtLex+8VkA@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Mar 2021 09:17:50 -0800
Message-ID: <CAHbLzkrpLOf4kwKNNetYwFBcmci8VNf7ULQifei-iqivAB1ipQ@mail.gmail.com>
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

On Mon, Mar 1, 2021 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 26-02-21 11:19:51, Yang Shi wrote:
> > On Fri, Feb 26, 2021 at 8:42 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > > > > When debugging an oom issue, I found the oom_kill counter of memcg is
> > > > > confusing.  At the first glance without checking document, I thought it
> > > > > just counts for memcg oom, but it turns out it counts both global and
> > > > > memcg oom.
> > > >
> > > > Yes, this is the case indeed. The point of the counter was to count oom
> > > > victims from the memcg rather than matching that to the source of the
> > > > oom. Rememeber that this could have been a memcg oom up in the
> > > > hierarchy as well. Counting victims on the oom origin could be equally
> > >
> > > Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
> > > this is because v1 may work in non-hierarchcal mode? If this is the
> > > only reason we may be able to remove this to get aligned with v2 since
> > > non-hierarchal mode is no longer supported.
> >
> > BTW, having the counter recorded hierarchically may help out one of
> > our usecases. We want to monitor the oom_kill for some services, but
> > systemd would wipe out the cgroup if the service is oom killed then
> > restart the service from scratch (it means create a brand new cgroup
> > with the same name). So this systemd behavior makes the counter
> > useless if it is not recorded hierarchically.
>
> Just to make sure I understand correctly. You have a setup where memcg
> for a service has a hard limit configured and it is destroyed when oom
> happens inside that memcg. A new instance is created at the same place
> of the hierarchy with a new memcg. Your problem is that the oom killed
> memcg will not be recorded in its parent oom event and the information
> will get lost with the torn down memcg. Correct?

Yes. But global oom instead of memcg oom.

>
> If yes then how do you tell which of the child cgroup was killed from
> the parent counter? Or is there only a single child?

Not only a single child, but our case is that oom-killed child
consumes 90% memory, then global oom would kill it. This definitely
doesn't prevent from accounting oom from other children, but we don't
have to have a very accurate counter and in our case we can tell 99%
oom kill happens with that specific memcg.

>
> Anyway, cgroup v2 will offer the hierarchical behavior. Do you have any
> strong reasons that you cannot use v2?

I do prefer to migrate to cgroup v2 personally. But it incurs
significant work for orchestration tools, infrastructure
configuration, monitoring tools, etc which are out of my control.

> --
> Michal Hocko
> SUSE Labs
