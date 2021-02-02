Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC630CED0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhBBW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhBBWY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:24:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9AC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:24:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b2so30454223lfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNAOPiZhBvntC8C14bTzDHN942diSkXcNrN3eK3rI1U=;
        b=py//dvYEibEFwVmLb4PAzjrsTA3YCydFXpiKsTfJi98dIVrg7qVsUn1zCwPK/765J/
         xrxxSxQX34Z5IqSMuCDIcyPNpFXaT6T/zkIQIiYAC7f+RArYPsUtyQj8fLsxWvPGFJQ6
         Yl40cJATocGMAb/9yXMC7R1+HkxigN0/ks8Zgc91TApzoAVqBSnBZjmIZiKauDYWUF1N
         OMrxP2/N93d7LP6Pz8DOpiBEGq4iTW3u84Q1agudNIm3TaixbI+oz0WhuOXFiGxVlbyI
         n4KOlzRwFVBigG+zifCDblUVxu256mnuXXn89LsK4p3TXqjTFNn0xo+btKP8wd57wFTK
         cZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNAOPiZhBvntC8C14bTzDHN942diSkXcNrN3eK3rI1U=;
        b=bQ3JoEGNW1ZU9BduV3T4wNGeNYFXCBZByM+LI318gG5RKOM1ig9+GV4YS/9BFIpeZj
         +osepJ4u4dSou+fjfBboMJeBj7AmRNo5RmGP9eqfc01cgSrR88Ix6g6Ih5GATv4sDU4S
         H/qr6maBWD5pAkO/fdPvQpFq6vkAWu+/5BCFMFw9VbmuIeCHIbCT1zeMEcwMWzTK0MZ/
         AlOw2JmpSDPdXyYicROGAw29tOsODC2PhdlUK+sG4ZN1LFFoIF7BnTHTZvOdFz9s+jIq
         ShQtIfO8DdQPucSMDaoXEacll0tOI+gEGFQOVWRq6ENBYMZIrgTmR8eJt+zSKjMZDhkI
         rfew==
X-Gm-Message-State: AOAM5311h+CNAa90Pmek0SRf4IB6gkVa51RYqXich+WV1xU61O0M6OrJ
        M2sWHE+Z3Vlm11pmpAqqwKEmkVMVg7nUUXTW+yMumQ==
X-Google-Smtp-Source: ABdhPJxDKyG3Si6gHUp6yAdVzfGVlKmjgT+cjTkuQvXlB6iWVZokLvFIiH+94cQ/ka0xQ52TT6xd3w4eTNBbQYoHFlI=
X-Received: by 2002:a05:6512:79:: with SMTP id i25mr38591lfo.549.1612304649273;
 Tue, 02 Feb 2021 14:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-2-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:23:57 -0800
Message-ID: <CALvZod6fHOhGN2exBSsRS4+KMzXE=1O7ALF2Hq4ehjvVFW6+ig@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 12:18 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The memcg hotunplug callback erroneously flushes counts on the local
> CPU, not the counts of the CPU going away; those counts will be lost.
>
> Flush the CPU that is actually going away.
>
> Also simplify the code a bit by using mod_memcg_state() and
> count_memcg_events() instead of open-coding the upward flush - this is
> comparable to how vmstat.c handles hotunplug flushing.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I think we need Fixes: a983b5ebee572 ("mm: memcontrol: fix excessive
complexity in memory.stat reporting")

Reviewed-by: Shakeel Butt <shakeelb@google.com>
