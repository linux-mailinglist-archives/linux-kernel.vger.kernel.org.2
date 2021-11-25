Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A226345D83C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354322AbhKYK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345458AbhKYK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637835865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAs+wOcrTysA9YV1Vf8sngcPa3FxWosi6YTl8VNcjbQ=;
        b=Z6udgEN84hvjSwaaTxgm/FAz2LIbOVx8N0kqipSeQLZBQC9nPbH6OLf4mkgcoeCMzJ2RJs
        ap/tKmveMPI4VEziVT2VHr5HOqt33gqnydGNwo4eJzCEyvOpQrTeBODbzwoUFxfsrVi7Qs
        y+racqxdjpKF7U3H4JGZrApOwyH5/h8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-gx8qlutAMJqo3t6WxG6WpQ-1; Thu, 25 Nov 2021 05:24:24 -0500
X-MC-Unique: gx8qlutAMJqo3t6WxG6WpQ-1
Received: by mail-pj1-f71.google.com with SMTP id x3-20020a17090a1f8300b001a285b9f2cbso2231397pja.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAs+wOcrTysA9YV1Vf8sngcPa3FxWosi6YTl8VNcjbQ=;
        b=ccJHd3XngWLrIgnT+l2hSGiIAeGWoAbMMSvgQfoc2di4ayrgNFmrHR7wroZIDLpI7f
         hxrekKyLINTQ3yxT0VkfrDEpuqYEgnORUxiA47ighOom4T1IZ5TDj7lgAD1H6S0yO3jp
         v8VsqLyZs8Dy/RFHJq9cc7jeJQNmSj9TDhIWWdOmzM+NwNHYpTCjsehUPJ61QH0K0kEM
         HMISqRSXwP7oZ6OYwz8iVceTHU3UFNEnYTHby18EjoJ2BMYrljoqZor5cPc3xoQumuDY
         TzoWw+ZYKHf4XsNFove38SRy/Modge4tNP1aobJvAPQGmOLXZ9ld50kHQDyn7Uqs9dWh
         8lsg==
X-Gm-Message-State: AOAM533PMuP9pJ+y589O6MFLDr1jGEIcFSavSFlQD4wfHOEeGymYsH7x
        ZAtSGiVtWUe3LbDB1kKbCQg4D6QUlezEIeHvprjp7WSuQ6nfFMJga75B+D9Qkc4jphNrcCYd+Ws
        lyP1fPUsyCn6IiTAVJ1bMzH/y
X-Received: by 2002:a63:894a:: with SMTP id v71mr15286611pgd.337.1637835863313;
        Thu, 25 Nov 2021 02:24:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhTSMgJfEb1p1gaKmYXk/HSshjHdQmPcVfAvtIixKoiBODtcQEZlOalgLPB6QdfLRbmM/NZg==
X-Received: by 2002:a63:894a:: with SMTP id v71mr15286579pgd.337.1637835862911;
        Thu, 25 Nov 2021 02:24:22 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id il7sm2606487pjb.54.2021.11.25.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:24:22 -0800 (PST)
Date:   Thu, 25 Nov 2021 18:24:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YZ9kUD5AG6inbUEg@xz-m1.local>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
> > Do we have a performance evaluation how much overhead is added e.g., for
> > a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> > covers the whole THP?
> 
> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> x86 for both settings you suggested. I don't see any statistically
> significant difference with and without the patch. Let me know if you
> want me to try something else.

I'm a bit surprised that sync split thp didn't bring any extra overhead.

"unmap whole thp" is understandable from that pov, because afaict that won't
even trigger any thp split anyway even delayed, if this is the simplest case
that only this process mapped this thp, and it mapped once.

For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
fast; while what I don't understand since thp split requires all hand-made work
for copying thp flags into small pages and so on, so I thought there should at
least be some overhead measured.  Shakeel, could there be something overlooked
in the test, or maybe it's me that overlooked?

I had the same concern as what Kirill/Matthew raised in the other thread - I'm
worried proactively splitting simply because any 4k page is zapped might
quickly free up 2m thps in the system and I'm not sure whether it'll exaggerate
the defragmentation of the system memory in general.  I'm also not sure whether
that's ideal for some very common workload that frequently uses DONTNEED to
proactively drop some pages.

To me, the old deffered-split has a point in that it'll only be done when at
least the memory or cgroup is in low mem, that means we're in extreme cases so
we'd better start to worry page allocation failures rather than number of thps
and memory performance.  v2 even added unmap() into account, so that'll further
amplify that effect, imho.

I'm wondering whether MADV_SPLIT would make more sense so as to keep the old
DONTNEED/unmap behaviors, however before that I think I should understand the
test results first, because besides 2m pages missing that'll be another
important factor for "whether a new interface is more welcomed" from perf pov.

Thanks,

-- 
Peter Xu

