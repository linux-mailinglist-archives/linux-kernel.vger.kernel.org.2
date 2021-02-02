Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDF30CF26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhBBWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhBBWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:35:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:35:13 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id sa23so16208405ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDIEFbGB+Z7Bn8D9m+hjMBU/S6ekRDtx1605yvM6W24=;
        b=rvjMeg4Wt3xH9v8WYsMzwnJa492nEMHSslmICRIJml17tx15n70Ow3wC+e779rf4TW
         b39WCNad2oIcvP3YcOWHI7CfrRcJx3au2dwb4E6rTW3dvJ6z/3tF2IJenRYZsoAohn5U
         bc6HB2TmH9fYqzlZjpic/nBqDO+E8C0rNH3k6/OHYmP7q7QdqNHU5oK1ZjGCrGa+K7dx
         Mn7eZcJ5cBQZ853EzmoHLUgv1phBCrR7oVwry1xq+seJGSsbreKg4K8/ThDXGOQ8mvf4
         1x7s/GYDaCUKco71C2m90RUvLIIbom9ps7zbQ/5bpLPh3ns7EEiIzkjVRqLN2rBvMHXD
         ft+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDIEFbGB+Z7Bn8D9m+hjMBU/S6ekRDtx1605yvM6W24=;
        b=WMjYLUWAFFUwh9h5y2Vnb76fXZsvy3xNgbm6wBbx/w/n/6wgtIkUlBmsrmVG2r7Ick
         lApbalnemKuJuBsbDqHkwzd6LV8HMGd/bItx83be9L1+DL9v4D6I5lRPMTjmGYVUylpH
         WrfPJMCdHjToCeyBgpfoimuSYN1NYTwERiNAiuHXHi4Bt8yaA4zTBkw9LU3s2LCCVdoF
         RITKVRmYk+FsVJ1ArVNv0gjSlC8E2WLH+YgUv//lhoB93w9t7WtvhmNndhNwTKqcvOoD
         y9+DZPvp7DSONsvLRMCcvGQxTlKdQDxLMRRiOf5WcAd2C4VlKxKRqEoEj8CghJc9cda9
         YCvA==
X-Gm-Message-State: AOAM5319OD59JcsApX3uBgoCClf5DJjogizywVxNvS8iQPTu8oACYuez
        CVDXpO7zSh/4NakwQTrzF5LNPZs/X6JgLSOTU14=
X-Google-Smtp-Source: ABdhPJzWJan42RtYOqBFlZYEeOtLMaMs/xKo/NE8t5jKz+FGiUy4upEXvijk9zHEOL+PNnt8fXwkjetgE3hrnemP2w8=
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr202863eje.514.1612305312460;
 Tue, 02 Feb 2021 14:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003432.6E88B570@viggo.jf.intel.com>
 <CAHbLzkp+PXOUBmKg-4z3-6kUePnwcO65L3W51UvYiT1g8uYh5Q@mail.gmail.com> <21785ed9-9591-e070-0941-6113999fa69e@intel.com>
In-Reply-To: <21785ed9-9591-e070-0941-6113999fa69e@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Feb 2021 14:35:00 -0800
Message-ID: <CAHbLzkoziAjggkufOx5avbYiYGS903kpMyPmQzv_2bwK3snNxw@mail.gmail.com>
Subject: Re: [RFC][PATCH 11/13] mm/vmscan: Consider anonymous pages without swap
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kbusch@kernel.org,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 1:35 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/2/21 10:56 AM, Yang Shi wrote:
> >>
> >>         /* If we have no swap space, do not bother scanning anon pages. */
> >> -       if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
> >> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
> > Just one minor thing about may_swap. It may be cleared by
> > nr_boost_reclaim. But demotion should be fine for boost_reclaim.
>
> In other words, this if() is here is to avoid generating suboptimal I/O
> during boost_reclaim.  But, since demotion doesn't generate any I/O, it
> *should* be fine for boost_reclaim.
>
> I agree with that in theory.  Although, I'm tempted to put it in the
> TODO list as something to look at in the future.  Do you think it's
> something that's immediately necessary?

No, I don't think so. We could tweak this later on.
