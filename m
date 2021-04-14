Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27135FB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbhDNTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhDNTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:05:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D413C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:05:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so3867800wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYrJlRv7hMOslZniAZd/Q50Y9bWCr5RlPObcMlcuTkQ=;
        b=hzHoiVkWIZEHVJk9H2nbZSqd2yL7vB4H89ftPNLX5CWSYzwiF/RYeI69rFC5JdnwLA
         UHsS7ckUkdL2XPeDeclyaivwKYvS9FvTlvIlhp5J1LT3v/iBhwEzc/ISgcNvQ9OjW16l
         lPWSF2KT9PTYioS8NKV/OqP6BSd6PmwZxxQLwaFr2v+g0kmybzjX9DC2McZ5dzV/2r4E
         zdtLhlIiPAOJV9G01jDnkciAXGfgoEpSJT07eBaNecUCr+f8UV2BY9zGFBeStRIA79UO
         RUp8cQfGP2+bJ3l3uIUenDrHs7o4+D7D3bBUP9MUly2cOMOD+EIZS/GBCBmmr+kEAiup
         UbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYrJlRv7hMOslZniAZd/Q50Y9bWCr5RlPObcMlcuTkQ=;
        b=OjtbMEny3DRXiY+O4pX8F6sLrHG2QZwf9ip8i8ctzxyVds+9+zmOgszqDGS+7I4Dmb
         6uSsa5tvgq3jY8Rh3JQTCUVDreobjGzgSbfJV3WJXUYT2RRf0FISLuHpKzHcKauEgOJJ
         aWWcmZFYkv5tb/2o742w3hpnan/vH2A4iPrOFXEEI8/jAb7cB6+3FCovTC9G01iuQfpm
         pCGOvVK3gZlkkgnVFuJyqS8O037nxlU+tb7EZhRMwzf74W/LyW8saZq5ql5dAtCq8OLP
         RvbBBbVkSrh8tLSfmcEbr+cO5T8FM592dcl7/0KOTBfNz0DB4I2OI4+fhWQ1iS9K6J1E
         IUrA==
X-Gm-Message-State: AOAM531Np13c+51Go0CTEZHWmaeh6KhQgJwiRrXE3fPGni0kPe6OCa48
        k/eY4xoIKA7qeLMfILlJtkzzG/C3mXu3fbD3hxS2OA==
X-Google-Smtp-Source: ABdhPJx8wYHD6o/5YkOM5SOkidUeX3KOuOvNsPwfC3FA9lg5HylEC513k8hW6k28TsAef/FayqryFtlQqZcBkHp8JWY=
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr4414305wmj.101.1618427101999;
 Wed, 14 Apr 2021 12:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com> <20210414155130.GU3762101@tassilo.jf.intel.com>
In-Reply-To: <20210414155130.GU3762101@tassilo.jf.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 13:04:50 -0600
Message-ID: <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
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
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 9:51 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> >    2) It will not scan PTE tables under non-leaf PMD entries that do not
> >       have the accessed bit set, when
> >       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
>
> This assumes  that workloads have reasonable locality. Could there
> be a worst case where only one or two pages in each PTE are used,
> so this PTE skipping trick doesn't work?

Hi Andi,

Yes, it does make that assumption. And yes, there could. AFAIK, only
x86 supports this.

I wrote a crude test to verify this, and it maps exactly one page
within each PTE table. And I found page table scanning didn't
underperform the rmap:

https://lore.kernel.org/linux-mm/YHFuL%2FDdtiml4biw@google.com/#t

The reason (sorry for repeating this) is page table scanning is conditional:

bool should_skip_mm()
{
    ...
    /* leave the legwork to the rmap if mapped pages are too sparse */
    if (RSS < mm_pgtables_bytes(mm) / PAGE_SIZE)
        return true;
    ....
}

We fall back to the rmap when it's obviously not smart to do so. There
is still a lot of room for improvement in this function though, i.e.,
it should be per VMA and NUMA aware.

Note that page table scanning doesn't replace the existing rmap scan.
It's complementary, and it happens when there is a good chance that
most of the pages on a system under pressure have been referenced.
IOW, scanning them one by one with the rmap would cost more than
scanning them all at once via page tables.

Sounds reasonable?

Thanks.
