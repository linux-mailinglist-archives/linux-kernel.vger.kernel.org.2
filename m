Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35945A9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhKWRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbhKWRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:20:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1563C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:17:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b40so92944655lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRJYbAOMl4yq+oKHujSPycwNua95Irf6sHCjaFIgmNs=;
        b=DLxZDsA2cqPy9/18+P1387n4BSb4+l8Kz1+wHrEyjGk4+2ZcGt6Ihue86vMzQohzCH
         4FAfzMdQGVi/6T8Go3oFMGK+4i3b/Z+tV2agG89gXC07jPoqbecYnVEdLPvfyG+Y1V4a
         alUDeEU4vUsn9IpsK1VuHVvUliV7Oq3McWIiO5msC8idRqmk4v91vglGUqSzkO3e5BIa
         +3u1gN7gt/656oZb5/bgH/fYkcQTytanrcDNFm1vRNIDJpX5i0XhPiUqjO6VYsrlRPko
         +1+N9Crdc6RQ9E2A07jJdMoi7xVhKjWp1NowhQVuXaOIyxQ6wWn2bWqKhttaaQZigNju
         yz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRJYbAOMl4yq+oKHujSPycwNua95Irf6sHCjaFIgmNs=;
        b=VwI/wfibZ8ysLa45oLW0Po3hB/v7GewHvCMvdW4UIRW2jtZ9K2lborTjdlRAkdcgN6
         eEh8BepyVQD3mzdE1lVu2UfihB4P82VVFS9H9NUlw+RSYb1tH7r1qiAvWVMGnn/Nkact
         oWVMONBAJqoP4DFst47DbdXFkCI4GKL05dV05UAwsWSfLVE3iEwCG8TmR2W8RGCbMhal
         QimOMlSg/ILHYBH1H5yy8sLireAPj4deGnW94FEJ7yoI0/jGJMKULpprZjaF1T2ITfxu
         fqsqfq7ovO7t9zWmgv8UqS/QPI3V2oXbnIuMY5FvwubTi6peuMwCWjaZg9A/Bje+OykB
         xQLA==
X-Gm-Message-State: AOAM531v/USAOXXyJi3YnQRizhJAOJJP+xZqUa21n+c2aQKLqENVKRYk
        YrgRpiC8buWFeUQ4yk94ibM2wwJYy0NYv09Sy23caw==
X-Google-Smtp-Source: ABdhPJxDJDfdaWIdd6LYTEnc768rpM1TuoJj9qR8hKwwqHz1F8twoMwoRI4lCmNRU3mLrA/QhjUAfftSh1LFA1abbU4=
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr6753456lfr.264.1637687847964;
 Tue, 23 Nov 2021 09:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com> <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
In-Reply-To: <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Nov 2021 09:17:16 -0800
Message-ID: <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
>
[...]
> >>
> >> I do wonder which these locking contexts are exactly, and if we could
> >> also do the same thing on ordinary munmap -- because I assume it can be
> >> similarly problematic for some applications.
> >
> > This is a good question regarding munmap. One main difference is
> > munmap takes mmap_lock in write mode and usually performance critical
> > applications avoid such operations.
>
> Maybe we can extend it too most page zapping, if that makes things simpler.
>

Do you mean doing sync THP split for most of page zapping functions
(but only if that makes things simpler)?
