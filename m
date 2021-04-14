Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E935FB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353222AbhDNTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353126AbhDNTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25099C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:15:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so17177641wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFk9xs2GNfkAG4LwFGmGU5idTsGe49u9Ar1GX/8V8R4=;
        b=RHqW+I/cdvDL4vkAOSqhD4lvQxt3Y5Aa2VhgrbK6C+OJl5+wZd6bQkVczV0xZIKYS9
         CkwU9hFDSKBDT44C7J6Cu9afnSpN6elhc8X8S3fGXNH9nJTfR6s4n0NvBqtz8KuBxI+I
         +bJJ1UVLMFov2AgHIMn3ug+4k9cvnqitCgqgE6d5tcC7fDRX0EtLXqlSp5/Up3l3tFUt
         /3togF4vDLRZI/LOabvlLAIuRwBcxwudDEjURLOKGPoZpQAYF4/VzIibnHzPknIL2+th
         8pmdkf7VCYgZN4Q0lkxoNNj1+2/Kqbzky0ZoGnBkCQDRArbWG2kfgE9MXadAuP7UiupJ
         CpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFk9xs2GNfkAG4LwFGmGU5idTsGe49u9Ar1GX/8V8R4=;
        b=qV78aGMPuFmli7c8M8yP878wQufzVrLkiZk5XPPGI8cQ2e9axkYIR2WAoCKijzBdIE
         PjX0eiguABIAJrbR/9UHKwwIwT8oscNM71wZBgIm+uAtB7J7CwL5vVYSNo7BCtUSNMWZ
         iorrnmThSnSyqufqvrtMiN59ObtN7WUrywd+aq9gcNVHnvfNExiimUxnuEIZdhVF7xzI
         q1H6FRy73vxZBiSgescke3i7fWMW9CELmy3pHEOLQ8utL/vEOY+vAb8oce3Ou3FREUeY
         wSvkMd4gnNpaDIvqeO6uUrNcbFUD5da53iyIKzouhc6sFxzMaApy/c0ygmfARoyTxYFT
         hPLA==
X-Gm-Message-State: AOAM5326FHVSATPtOaZPEY6VaM+WpEyq95FRe/e2PUqiY2hFfEIkf30h
        AFU7ztFsksJOdqeru5lg0ZTfF35LGrPsUTApBxsdKA==
X-Google-Smtp-Source: ABdhPJyQL4wEyStvGfDKX4aHEFscf5giZOOpJHx1+tdKcPWnQs4kfikFxy5uEletU2lADZ+akHYan2B7qw89puI99Q0=
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr35949194wru.92.1618427707498;
 Wed, 14 Apr 2021 12:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com> <e0ad1b48a1ad0b6d3a1e79129f397ddb6c32fe35.camel@surriel.com>
In-Reply-To: <e0ad1b48a1ad0b6d3a1e79129f397ddb6c32fe35.camel@surriel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 13:14:55 -0600
Message-ID: <CAOUHufaRXbDHbEro1uE1CHvpWB4U67iroj0hT8CkUEOSAddzYQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Rik van Riel <riel@surriel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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

On Wed, Apr 14, 2021 at 9:59 AM Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2021-04-14 at 08:51 -0700, Andi Kleen wrote:
> > >    2) It will not scan PTE tables under non-leaf PMD entries that
> > > do not
> > >       have the accessed bit set, when
> > >       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
> >
> > This assumes  that workloads have reasonable locality. Could there
> > be a worst case where only one or two pages in each PTE are used,
> > so this PTE skipping trick doesn't work?
>
> Databases with large shared memory segments shared between
> many processes come to mind as a real-world example of a
> worst case scenario.

Well, I don't think you two are talking about the same thing. Andi was
focusing on sparsity. Your example seems to be about sharing, i.e.,
ihgh mapcount. Of course both can happen at the same time, as I tested
here:
https://lore.kernel.org/linux-mm/YHFuL%2FDdtiml4biw@google.com/#t

I'm skeptical that shared memory used by databases is that sparse,
i.e., one page per PTE table, because the extremely low locality would
heavily penalize their performance. But my knowledge in databases is
close to zero. So feel free to enlighten me or just ignore what I
said.
