Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754413DF445
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhHCSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhHCSBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:01:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46149C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 11:01:30 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d22so1903425ioy.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSgoZaAM9VgXcC1Hrs8ckrp1k3/7KUr3SiJsCaEXetc=;
        b=Z4v4AiDHaHTqqraFKHHLdvrPsRbBG9F7ytf00tCteaLiZOuNknNYMPJzznS18Bm+Pr
         460vDxF+9logldqTlDGpzQNbpMC5RqWLbOkmBquRDPqywa1NK9sGFE16blXlA4ZdRZxp
         Uj5ALHXj0kVNy1adYB+GWPYeiIbyRHDMxUGh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSgoZaAM9VgXcC1Hrs8ckrp1k3/7KUr3SiJsCaEXetc=;
        b=mitMCWiXjX4O+n4NQd6B76+C2K8N/HVi1DZ+q4E0AoYAf4jTH1V1PTg+4qZikkmyqY
         krl2bWZDj6yITwWlA2iyy9+GEhvNMoKc5+C3cN+ERsYpDRI3g1xauXHnYc3mPMpDIEoj
         sQ2+fhZwPpQg6bGvtVOwqQ6u5tYk9hwhribPq9WaCuL81x3QptbPwLI8xVBWdp9wrsaq
         TN8TBFE42LiPL2dNx4pNOKmM9bYWUNlUAnJORM+HpvQJsK0EZTqIOE6AhADyN84KuB68
         hKHxdsOtO7f2LmgJX3Qf5l8SQr5ki8ir1UOcCERrFqUoTZbDGZtib/nvO/UMjaxqMhnI
         kSHg==
X-Gm-Message-State: AOAM531MegzN/K7jVlZqSfiN6uJelkW6Rr4afp8eXayNvtMaOkJwZkn1
        TXhHSz53Z+QhTph2JYCVo9oroaxOvVCorg==
X-Google-Smtp-Source: ABdhPJxgkInbcnZL6YuiAAHeSyp61HBnoO4GuutTKrb9eq9DFObqyq4keiO5+vnACan75CP7JQOWqQ==
X-Received: by 2002:a5d:938a:: with SMTP id c10mr637899iol.0.1628013689626;
        Tue, 03 Aug 2021 11:01:29 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id w4sm6802988ior.2.2021.08.03.11.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 11:01:28 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id a13so25236497iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 11:01:27 -0700 (PDT)
X-Received: by 2002:a05:6638:cba:: with SMTP id x26mr16380694jad.98.1628013687178;
 Tue, 03 Aug 2021 11:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com> <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
 <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com> <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
In-Reply-To: <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 3 Aug 2021 11:00:51 -0700
X-Gmail-Original-Message-ID: <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
Message-ID: <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Tue, Jul 27, 2021 at 2:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 27 Jul 2021 09:31:33 -0700 Evan Green <evgreen@chromium.org> wrote:
>
> > > Pavel just mentioned uswsusp, and I wonder if it would be a possible
> > > alternative to this patch.
> >
> > I think you're right that it would be possible to isolate the
> > hibernate image with uswsusp if you avoid using the SNAPSHOT_*SWAP*
> > ioctls. But I'd expect performance to suffer noticeably, since now
> > every page is making a round trip out to usermode and back. I'd still
> > very much use the HIBERNATE_ONLY flag if it were accepted, I think
> > there's value to it.
>
> The uswsusp option makes your patch a performance optimization rather
> than a feature-add.  And we do like to see quantitative testing results
> when considering a performance optimization.  Especially when the
> performance optimization is a bit icky, putting special-case testing
> all over the place, maintenance cost, additional testing effort, etc.
>
> I do think that diligence demands that we quantify the difference.  Is
> this a thing you can help with?

I'm wrong about the performance. Uswsusp is just as fast, and possibly
faster in my use case than kernel-driven hibernate. What's more,
uswsusp also helps me solve several additional problems I hadn't
tackled yet that were looming in front of me. Thanks all for your
patience and thoughtful review on this.

Patch withdrawn.
-Evan
