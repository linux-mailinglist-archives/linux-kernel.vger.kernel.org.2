Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD83D2B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhGVQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:44:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:25:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r17so4733073qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEFq+AoRTm11R6uCVQcmvnevcQX1q6Q/z0Ka5ymSSsI=;
        b=PxC+1qAM+LiGC9/AqtUM9wFshgBXJ7k34p5t9jtIY6MU7Gz56O3Ews8ITNFwZPwuQV
         rrymVFx3fLPqJ9YttbM1AavDvQ7ibkE1EBE2qOUR5iw+Tzgej9OhLlDrjVEiTGU7BswJ
         ic45iKRQyyPrQ0+6VsrwaCgcGigcAf1WMlm3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEFq+AoRTm11R6uCVQcmvnevcQX1q6Q/z0Ka5ymSSsI=;
        b=PlgQxmolHRaQtXMtR29qpgF6S7P7Hx77PThE/ugY9QBVy77zm8gUx9YRnrLdPg8F1J
         apTc9XhG8qdD1SYtl0S76nXsVmNfu5Ze1y+qbf/ZrU4fMlHt5ZTaQnjuqjHqbq5i3t2E
         8Xv7dLfFE5Ioc4h+sTiFEvyg/Hf8Jrt84KOTxBC2TR/pySsRnpqnnZaJqRdNy0G0Bs/o
         A0TyXyBvzsRI7hna1VPu+andUVKOL3vaFIDKXvucKrG2YdRpyhryYywSKIrXar20S01u
         Pzo6AF7MHy7uaCVLYI7enEFy4LKkKlw19wz+LHhhq72TliAxkOAqxgIH7RLHCDO8GsUm
         uGig==
X-Gm-Message-State: AOAM531XDQpY9opEKAJqyUb7g2GkkUTRftetQBFwSDg3YvDIvlepi9e+
        GfhTCAlNuPxV6387tDpEXdjxUp3CUlrJ8g==
X-Google-Smtp-Source: ABdhPJxdy+1iehcXgRbFyL922LpbQpCGAUBU4KaFLuiqxUpirXbU3zZ5kqg3TcO89IPxMq+YLntpJA==
X-Received: by 2002:ac8:5e91:: with SMTP id r17mr668526qtx.48.1626974706832;
        Thu, 22 Jul 2021 10:25:06 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id z23sm8588605qts.96.2021.07.22.10.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 10:25:06 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id j184so6111132qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:25:06 -0700 (PDT)
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr526246jaf.44.1626974215148;
 Thu, 22 Jul 2021 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <20210721150926.ce56fb8b5fa733d9727bd37e@linux-foundation.org>
In-Reply-To: <20210721150926.ce56fb8b5fa733d9727bd37e@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 22 Jul 2021 10:16:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft783EmL=vZuLC6Zr-hW08ij-Xn=n_6Vt2RX_HX0r-K6Uw@mail.gmail.com>
Message-ID: <CAE=gft783EmL=vZuLC6Zr-hW08ij-Xn=n_6Vt2RX_HX0r-K6Uw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Alex Shi <alexs@kernel.org>,
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

On Wed, Jul 21, 2021 at 3:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Jul 2021 14:40:28 -0700 Evan Green <evgreen@chromium.org> wrote:
>
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities. Swap and hibernate also have different security/integrity
> > requirements, prompting folks to possibly set up something like block-level
> > integrity for swap and image-level integrity for hibernate. Keeping swap
> > and hibernate separate in these cases becomes not just a matter of
> > preference, but correctness.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it. This flag will be passed in by utilities like swapon(8), usage would
> > probably look something like: swapon -o noswap /dev/sda2.
>
> Will patches to swapon and its manpage be prepared?

Yes, I'll work on that today. Thanks Andrew!
-Evan
