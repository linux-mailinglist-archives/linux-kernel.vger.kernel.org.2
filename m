Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42733370149
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhD3TdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3Tc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:32:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06DC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:32:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z6so10496990wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L0GYf6baFnb9u6edRpidG5ads8GNWpz6pco+MMOUP/0=;
        b=Lw1Ob5m10OEyioZRZM1wOdM2YDbcvuo2L3Pi2PFLvwvhC1mViXQNPjaWMkQjPJt7j8
         NPd8HVvoSyI7OJ1uE/OAyXfSLT5eLwnE9E7k8y2dJZdpUMjp673IwteYD+MChb3PJR5l
         9ZzURM1bkuwkXT/EpnYT7o+69+uwxN1dXzfQFPskW76rREYzXgTQ9bHvXMVk2PYtzxUN
         7pOAUI+9BcjSL6N74b7Nht7RcCcKpt+GuRfnVp2WPy0fgAYDgMbjkYqqMacKWYoHWNcG
         Yy8mdUkI20Mxw9FTgmbohbYg+fPsRS6dnvVp8pN8ceOs3q9TfW89/d8LGAz8oH7tNvRd
         nUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L0GYf6baFnb9u6edRpidG5ads8GNWpz6pco+MMOUP/0=;
        b=YDDTO5F0dHCxpAO3XSzTb26W3nKDtCc7BkOZd0ZHOlrkSL446T9BXAgfZldfCQunuC
         3A7TpWTuNlGzcqZv6nssdYA35Ob4SSYKHaCneS1GSAO2uPgV9d/c+4YVAglEm9CpuGav
         12Xq7hCmw9pC1vVv2pH+aHxyRGk1UqQ/OtJNeIeb0U61egeWdoeA1tJxCQCtkj2P94fj
         Rg0SSBbud5LKOlNFfu+tMKeB04EKvDOHgXbvfSqV7UaSYHRa6S28VCVsFcrUR4T1yPR1
         0Kv2stvgJkv1oimyiRED1DNITFno5P4chke0VkRIJJ+Ov6K+9hxnTQ7iGrEd2Fvu9gio
         LrWA==
X-Gm-Message-State: AOAM531frwyjZB8cafdPkKSZ4YVdks8VsgqtjdStJ29mrO8Bh5Fag9Dq
        nXYZREQpCz9EbPyE5ZYIEQSXqOdnCCGM/GhFce5wfA==
X-Google-Smtp-Source: ABdhPJyLkjX7J7cxhEKCYBjEKTwu/VHiNSFjiHxos+0U7mbdiJXF+wsjLM9Azfw8v/+N948+NzejVpToxqi6tdpFrJs=
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr8807856wrn.323.1619811129737;
 Fri, 30 Apr 2021 12:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065633.2782273-1-yuzhao@google.com> <140226722f2032c86301fbd326d91baefe3d7d23.camel@yandex.ru>
 <8ce5be3df2137e975d7333024b6120b71b214617.camel@yandex.ru>
In-Reply-To: <8ce5be3df2137e975d7333024b6120b71b214617.camel@yandex.ru>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Apr 2021 13:31:57 -0600
Message-ID: <CAOUHufaoGe1=Vigp7cHbvx0G1=zvHQrNc_et4C9UTw4bYOSY8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Linux-MM <linux-mm@kvack.org>, Alex Shi <alexs@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:38 AM Konstantin Kharlamov
<hi-angel@yandex.ru> wrote:
>
> Btw, I noticed a fun thing, an improvement. I don't know yet if it can be
> attributed to 5.12 (which I didn't try alone yet) or to the LRU patchset,=
 but
> I'd assume the latter, because 5.12 seems didn't to have had anything
> interesting regarding memory performance=C2=B9.

I appreciate the testing and the report. They mean a lot to us.

This improvement is to be expected, and it works both ways. There are
cases that swapping is not a good idea, for example, when building
large repos. Without this patchset, some of my browser memory usually
gets swapped out while tons of memory is used to cache files I don't
really care about.

I completely agree with you on the memory cgroup part: theoretically
it could work around the problem but nobody knows how much memory to
reserve for Skype or Firefox :)

I will keep you posted on the following developments.

Thanks!

> I usually have Skype running in background for work purposes, which is on=
ly used
> 2-3 times in a week. So one would expect it to be one the first victims t=
o
> memory reclaim. Unfortunately, I never seen this to actually happen (till=
 now,
> that is): all skypeforlinux processes routinely have 0 bytes in SWAP, and=
 the
> only circumstances under which its processes can get into SWAP is after
> experiencing many SWAP-storms. It was so hard for the kernel to move thes=
e
> unused processes to SWAP that at some point I even tried to research if t=
here
> are any odd flags a userspace may have set on a process to keep it in RAM=
, just
> in case that's what happens to Skype (A: no, that wasn't the case, runnin=
g Skype
> in a memory limited cgroup makes it swap. It's just that kernel decision =
were
> lacking for some reason).
>
> So, anyway, I am delighted to see now that while testing this patchset, a=
nd
> without encountering even a single SWAP-storm yet, skypeforlinux are one =
of the
> processes residing in SWAP!!
>
>      =CE=BB smem -kc "name user pid pss swap" | grep skype
>     skypeforlinux            constantine  1151    60.0K     7.5M
>     skypeforlinux            constantine  1215   195.0K     8.1M
>     skypeforlinux            constantine  1149   706.0K     7.5M
>     skypeforlinux            constantine  1148   743.0K     7.3M
>     skypeforlinux            constantine  1307     1.4M     8.0M
>     skypeforlinux            constantine  1213     2.1M    46.1M
>     skypeforlinux            constantine  1206    14.0M    10.8M
>     skypeforlinux            constantine   818    38.5M    34.3M
>     skypeforlinux            constantine  1242   103.2M    46.8M
>
> !!!
>
> 1: https://kernelnewbies.org/Linux_5.12#Memory_management
>
> On Fri, 2021-04-30 at 02:46 +0300, Konstantin Kharlamov wrote:
> > In case you need it yet, this series is:
> >
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> >
> > My success story: I have Archlinux with 8G RAM + zswap + swap. While de=
veloping,
> > I have lots of apps opened such as multiple LSP-servers for different l=
angs,
> > chats, two browsers, etc=E2=80=A6 Usually, my system gets quickly to a =
point of SWAP-
> > storms, where I have to kill LSP-servers, restart browsers to free memo=
ry, etc,
> > otherwise the system lags heavily and is barely usable.
> >
> > 1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU patchset, =
and I
> > started up by opening lots of apps to create memory pressure, and worke=
d for a
> > day like this. Till now I had *not a single SWAP-storm*, and mind you I=
 got 3.4G
> > in SWAP. I was never getting to the point of 3G in SWAP before without =
a single
> > SWAP-storm.
> >
> > Right now my gf on Fedora 33 also suffers from SWAP-storms on her old M=
acbook
> > 2013 with 4G RAM + zswap + swap, I think the next week I'll build for h=
er 5.12 +
> > LRU patchset as well. Will see how it goes, I expect it will improve he=
r
> > experience by a lot too.
> >
> > P.S.: upon replying please keep me CCed, I'm not subscribed to the list
>
