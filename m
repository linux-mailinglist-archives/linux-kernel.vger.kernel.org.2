Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA6360308
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhDOHNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:13:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C45C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:13:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so22190474wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozrwQiNh1pV14CRMAHtbeUSlZoQ38ER5bTlFizbb0SA=;
        b=Uh1hNCZF+0AAp+xrT2Ecos8yfbD4xsxtWZ85zcGk8XZgazP8Edts9mj6FMTPhrfhSq
         GwYGwXfmJA7tP5P07Uot3GYNqkoFeTC7eZzzSlb49fiuvy5bz4BlbPODUzDr6P3BAPAu
         PQfLzYkLjVUSQFo4Eps5jYdX9cCbSPNqcB4s0innXlEa+aZycVtMK2D75q2+iHUyiz+s
         GOzM/PwL+SFDb9O9Et+FrFHl6M3T+QY9W/YNvrw9QRJYtU12u2A7X2seQB82u5Fder6I
         qUuF8vl87+cNz5cT7N+TqSNDG1cPSiArNV/X0szy9lAX3FPU2dsrF3b0tU/p+tjnHxPB
         RJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozrwQiNh1pV14CRMAHtbeUSlZoQ38ER5bTlFizbb0SA=;
        b=t1aZfgbzad7mijKtKRqSTymcThxZ12E1Pr7Ve2Cq/ca33M2ibx0e0q9awOhfpyQ6za
         RkHHEy/EqIpVEcDBg/OVEMyM1AECIHpDtC4jfi4zQGZZjxHeDGb8MhUcpnEknD5DCDP3
         5/vKwtUL+U4wR9WzDQoVBET0tCjVZ4eV14icocvIjOyExodz+ioe6g96B44AB78PQAaI
         UQY9R+UOONRO3uTwpr3OoKMFr2wOseZrmnfmRDZbj5FfVexShz4kQaemQFOkuM4OZLVA
         TjYSEGxKmJAnoTdzG5K05Z8XG9ih5HFTH/aJ2Tupc9tcYYyCx7FGpkIT9PTZx6/wAxVc
         GsFQ==
X-Gm-Message-State: AOAM533IlG8S/QUa7idB4pdKsocywdqspKoqN66mA3iuHRhLxNCS6laH
        /SVzF7PxeoTy+TOtNUeWvDOgD6PcvUvHYB9Tqivemg==
X-Google-Smtp-Source: ABdhPJz/9mMzrblEELH7HCkVo0gkDLKXoDue3E4IAiSFjwEzmzoxIJFKyLFyD4ShOpd6KcTvUgX3sgjpZESTPtv+Ufo=
X-Received: by 2002:adf:e381:: with SMTP id e1mr1770069wrm.323.1618470805740;
 Thu, 15 Apr 2021 00:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com> <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
 <20210415030002.GX3762101@tassilo.jf.intel.com>
In-Reply-To: <20210415030002.GX3762101@tassilo.jf.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 15 Apr 2021 01:13:13 -0600
Message-ID: <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Rik van Riel <riel@surriel.com>, Ying Huang <ying.huang@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 9:00 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > We fall back to the rmap when it's obviously not smart to do so. There
> > is still a lot of room for improvement in this function though, i.e.,
> > it should be per VMA and NUMA aware.
>
> Okay so it's more a question to tune the cross over heuristic. That
> sounds much easier than replacing everything.
>
> Of course long term it might be a problem to maintain too many
> different ways to do things, but I suppose short term it's a reasonable
> strategy.

Hi Rik, Ying,

Sorry for being persistent. I want to make sure we are on the same page:

Page table scanning doesn't replace the existing rmap walk. It is
complementary and only happens when it is likely that most of the
pages on a system under pressure have been referenced, i.e., out of
*inactive* pages, by definition of the existing implementation. Under
such a condition, scanning *active* pages one by one with the rmap is
likely to cost more than scanning them all at once via page tables.
When we evict *inactive* pages, we still use the rmap and share a
common path with the existing code.

Page table scanning falls back to the rmap walk if the page tables of
a process are apparently sparse, i.e., rss < size of the page tables.

I should have clarified this at the very beginning of the discussion.
But it has become so natural to me and I assumed we'd all see it this
way.

Your concern regarding the NUMA optimization is still valid, and it's
a high priority.

Thanks.
