Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776633291D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbhCAUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbhCARH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:07:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F9BC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:07:17 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jt13so29615408ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxFWs0oSU3V/NwnpfCvBJ5DgtOSVkYwO/FOfviidy1k=;
        b=txCf4l4pnUYHnMMbaJ+nwcAmrJ5ZF3Esp9SrwyXS8fquZcYAjnVSuLO5lqp2yhPo7t
         Fb2XxDHLr1OOoKy2dU6xNfvpb3FJZg3g+h5R4NHmkbqjpT3+jke2SORlpIISKFF89bld
         aHlGlQqv4jd3L7V8+5PiwCZNL+6ENSAsrI1C6DDqO/O5CLEKFNgYyEeFMpn0tiUdUt75
         IK2vBaChZcFbexfDJ2jLW1yDvgY4IdG2Ezb7pPzNkTprW+PabRns1J+fEuElHuDijrW/
         9TpomORJI745VH06++izgLQa+/AqeHCQOdOIjU1pOBrl9trrPGFQ28egcJs+ltmQPbq2
         5QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxFWs0oSU3V/NwnpfCvBJ5DgtOSVkYwO/FOfviidy1k=;
        b=lzkbX7SS5FM+9OH+Jr/rXsNfBuRixU83GT3GsBs6LB/Gc7B6lu3jet4iDTcOrDnYGH
         tZD+co5rMqxu89yBh19Ztudwecp9tOHuqHM7L8dh9Set1NWL7SKvTabZ62+O5aqaW/Ll
         QtafKA3CQ0a8p4dJs9Alm4bWEwjLZ+KwRVXCN4NP+6S2YHK5b7mzioJEmxw0AF411VRc
         YDpcJgsnom+7giMrjwjpc22DjBl1RadxU2IumNn2dceVlTTKLIB205DcPChvkljSXm46
         hJYTNU+8B+FgE/7yX+ZCn1zzyqD5gbYcgh/VbB4ysLVcNWyeTZv5F3BAEgPoACix/M3Z
         gtvA==
X-Gm-Message-State: AOAM531shmbjNxkwuVHKllOFiVIZI1DuQ2UKQDrcduBxfdgxMwKRC3PN
        69wJG0waCuhPFrbAwO6+rHnzOEgL3x7aPu9Kfzw=
X-Google-Smtp-Source: ABdhPJwbLEh+sPaoVJInF1JOPo6OGCi/xw159FENojhi6Ypp8UP3BIItWWpqAZ6/5OuoDO2WXQ+Z7t0ggHSbBM50uT0=
X-Received: by 2002:a17:907:2bf6:: with SMTP id gv54mr17291479ejc.514.1614618435996;
 Mon, 01 Mar 2021 09:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20210226021254.3980-1-shy828301@gmail.com> <YDijjovHAer2tiL5@dhcp22.suse.cz>
 <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com> <YDzaxi91fTg1ww6H@dhcp22.suse.cz>
In-Reply-To: <YDzaxi91fTg1ww6H@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Mar 2021 09:07:03 -0800
Message-ID: <CAHbLzkpvWJn3dOrLLPvtyKY6qEs5Nv57rc7K+_+eL35eCDnywg@mail.gmail.com>
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

On Mon, Mar 1, 2021 at 4:15 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 26-02-21 08:42:29, Yang Shi wrote:
> > On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > > > When debugging an oom issue, I found the oom_kill counter of memcg is
> > > > confusing.  At the first glance without checking document, I thought it
> > > > just counts for memcg oom, but it turns out it counts both global and
> > > > memcg oom.
> > >
> > > Yes, this is the case indeed. The point of the counter was to count oom
> > > victims from the memcg rather than matching that to the source of the
> > > oom. Rememeber that this could have been a memcg oom up in the
> > > hierarchy as well. Counting victims on the oom origin could be equally
> >
> > Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
> > this is because v1 may work in non-hierarchcal mode? If this is the
> > only reason we may be able to remove this to get aligned with v2 since
> > non-hierarchal mode is no longer supported.
>
> I believe the reson is that v1 can have tasks in the intermediate
> (non-leaf) memcgs. So you wouldn't have a way to tell whether the oom
> kill has happened in such a memcg or somewhere down the hierarchy.

Aha, I forgot it, that's bad. Although we don't have tasks in
intermediate nodes in practice, I do understand it is not forbidden as
cgroup v2.

> --
> Michal Hocko
> SUSE Labs
