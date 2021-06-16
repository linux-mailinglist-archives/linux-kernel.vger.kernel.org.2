Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0689F3A8E15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFPBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:12:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA074C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:10:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q20so1333734lfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkZWfoezrzK3YqSvjNFpximYFS+zPFkT6j8u2nQEHxw=;
        b=dnZC354fu9ggFFPybBFkrAKpJ+prc+VjiMY0E47wXoZTl70lO0k7nYMjJU+ZV3XOnM
         cSojlxv0PEOIvvodP7EyyNVyBIDb6VpotqSOH8P7zgKeN99TPu2eM8jtTC5q9GkVMOOm
         b8n1LUck5mzKRNIURbRp1PAEmcfLJJ6Oofoato99TY3lGZHKhH5BKFQ7LpvdQaSiY3ks
         8XqJgWXCw95vBde+156oMa/0O8Vezdj3dFRqsmV65VcAY4q1g4/XaEXHKGuGGv4cDCk7
         k59WzkDTvJnW4oE/NZKDqIjt26ezzGMMFYRpxTy8HV6zFdzzlgpdJBhwNO3hKG5oBQ2q
         Zfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkZWfoezrzK3YqSvjNFpximYFS+zPFkT6j8u2nQEHxw=;
        b=Ows4YthhIhU3NozNaBWYLM9d0QozUvOJTMMj/7KK21DEwvWH7bEjW3c+c+RJQQ/2PX
         34/uulwdwr1+v3LiafxUrgozUbgtY3i+Lp/Wy50xN0MmVMJ5gXw4AQfxtThS6T+gDsyk
         fCrdx6gJHOFpk4Q9ElSya6ykhPrBU8Tt+r03kACg7qH8p9f6+eMcZ9FHha25KAUwmhGK
         FQ9HN2UyfHyZuJgR0mTleaMqXX57+PtT8pSWmlugUF8RpIRTY0+9zWKMZdtopcICnsDE
         qFMtC0lFkwpvOc7H7KKq9QaN9ZmVbwyKnsQGuW11XcfRDSIbXIqZ2tiqaJnlvIlM79nw
         c3fw==
X-Gm-Message-State: AOAM530gd2TIwU085ze+MLC67OFkgNAojyyag/Uwu7j9zU12D4RO/7No
        OUELtEwBVLDZ+D31O0JjQkKslEP8PikRYjqmiWEka/HNd/M=
X-Google-Smtp-Source: ABdhPJzf4qJT4TeIuhj5pb3/BNFUHv6br3mhdn2UFHbIAcsSFEWV1evx9ybM06Xaj2HksP1lPhVlQir+fHv+GF9WmyE=
X-Received: by 2002:a19:7015:: with SMTP id h21mr1630748lfc.299.1623805800760;
 Tue, 15 Jun 2021 18:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <20210615113222.edzkaqfvrris4nth@wittgenstein> <20210615124715.nzd5we5tl7xc2n2p@example.org>
In-Reply-To: <20210615124715.nzd5we5tl7xc2n2p@example.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Jun 2021 18:09:49 -0700
Message-ID: <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 5:47 AM Alexey Gladkov <legion@kernel.org> wrote:
>
[...]
>
> I made the second version of the patch [1], but then I had a conversation
> with Eric W. Biederman offlist. He convinced me that it is a bad idea to
> change all the values in meminfo to accommodate cgroups. But we agreed
> that MemAvailable in /proc/meminfo should respect cgroups limits. This
> field was created to hide implementation details when calculating
> available memory. You can see that it is quite widely used [2].
> So I want to try to move in that direction.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/legion/linux.git/log/?h=patchset/meminfo/v2.0
> [2] https://codesearch.debian.net/search?q=MemAvailable%3A
>

Please see following two links on the previous discussion on having
per-memcg MemAvailable stat.

[1] https://lore.kernel.org/linux-mm/alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com/
[2] https://lore.kernel.org/linux-mm/alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com/

MemAvailable itself is an imprecise metric and involving memcg makes
this metric even more weird. The difference of semantics of swap
accounting of v1 and v2 is one source of this weirdness (I have not
checked your patch if it is handling this weirdness). The lazyfree and
deferred split pages are another source.

So, I am not sure if complicating an already imprecise metric will
make it more useful.
