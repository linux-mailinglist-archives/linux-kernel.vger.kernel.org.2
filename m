Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1A3B2C65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFXK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhFXK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:28:59 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BFC061574;
        Thu, 24 Jun 2021 03:26:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f16so2997328qvs.7;
        Thu, 24 Jun 2021 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=aYxEESGYd+nGspsnDUf9V/geC8TjcsBr5faZa+wAtFE=;
        b=n9332Kyljg+bQ1InWHjSaOf0m9gf3rTgTFgm5k+drGmtNO3PQiPF1r9NMqgk2AXMMQ
         RDIgan1nerVcawH0Ckn9m3xuLFmklqx2ofXnt5daFr4KEwvkii/ockvzVEAaioWTbUQp
         thvR56eg5DywSPDD0ShiJ4E9Yl4aJjM/DimbPvX5H8PJJrGAd2vwbNMhTGrosnc/PcRc
         gxtSnCVCnjf7t5lXUY21QuGdlpjBmLQaea4Vbj+MP4PT3qc5yxoGGgw2WF2xa2hnyItZ
         /bbYyxXB4LQ6zwDv3C/+EAR/NO7QDTWNn/OtzUr/cF8ZJeOWFuiDpeCQKur/8oaVwfAY
         mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=aYxEESGYd+nGspsnDUf9V/geC8TjcsBr5faZa+wAtFE=;
        b=JPUgGCMTCG9bw0yuYYQCAVyJDjPCNcbtDoIr5YVZzisimYAcUIXoVSyIGDKv4GWRS3
         zNvMwoOSeC7ffXzxq/BQ39caNP9WI6nJbYzUsXJnkGcFd5X0Oeew1zVgnJqXui3Q3w3r
         TozMzcawOjYwybm1ekExhVPznYk14G/0SsiM+UnoRraJIPxCnpphv9unng6Im6JGC9sH
         MgQj99n2J31u2oZOch+0B1v1XWa6gHWEkSQBwYYa04aAOPuNJqrzEm75Av70TV3c6Wk7
         Dy7GQGzdWJL+0Td6oocnv3tpEhEz3JpFGhaKLngkr9REotj2p1ysLgYPlNjlBwR2VZSH
         QIRg==
X-Gm-Message-State: AOAM532N4j3L8RZVxQnhLKJbBp0rdzA+0KrGdW6wpwG93WX6Awmvxuy4
        N1dGmtzRg/p+r04DF17EtVk=
X-Google-Smtp-Source: ABdhPJyU5LD8rG7vCa9ttZlMnPgh8R+WCpKy60nE6cbt7hIJmsntdRw97EyHr2g0jg+/gmrzTrQ53Q==
X-Received: by 2002:a0c:fdc5:: with SMTP id g5mr4263859qvs.15.1624530398844;
        Thu, 24 Jun 2021 03:26:38 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w195sm2132842qkb.127.2021.06.24.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:26:38 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v31 03/13] mm/damon: Adaptively adjust regions
Date:   Thu, 24 Jun 2021 10:26:20 +0000
Message-Id: <20210624102623.24563-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624102623.24563-1-sjpark@amazon.de>
References: <20210624102623.24563-1-sjpark@amazon.de>
In-Reply-To: <CALvZod7uzDuWAMnnxubv7=vx5Qktmw5o=2ivS-tUa2YA+5QzzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 22 Jun 2021 07:59:35 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Even somehow the initial monitoring target regions are well constructed
> > to fulfill the assumption (pages in same region have similar access
> > frequencies), the data access pattern can be dynamically changed.  This
> > will result in low monitoring quality.  To keep the assumption as much
> > as possible, DAMON adaptively merges and splits each region based on
> > their access frequency.
> >
> > For each ``aggregation interval``, it compares the access frequencies of
> > adjacent regions and merges those if the frequency difference is small.
> > Then, after it reports and clears the aggregated access frequency of
> > each region, it splits each region into two or three regions if the
> > total number of regions will not exceed the user-specified maximum
> > number of regions after the split.
> >
> > In this way, DAMON provides its best-effort quality and minimal overhead
> > while keeping the upper-bound overhead that users set.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
> [...]
> >
> > +unsigned int damon_nr_regions(struct damon_target *t)
> > +{
> > +       struct damon_region *r;
> > +       unsigned int nr_regions = 0;
> > +
> > +       damon_for_each_region(r, t)
> > +               nr_regions++;
> 
> This bugs me everytime. Please just have nr_regions field in the
> damon_target instead of traversing the list to count the number of
> regions.

Ok, I will make the change in next spin.

> 
> Other than that, it looks good to me.

Thanks,
SeongJae Park
