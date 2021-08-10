Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16F63E8510
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhHJVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhHJVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:16:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD80C061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:16:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c24so663409lfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvFV/sPpSnD57KASBlWu5g1n7aznLr5LbeGWzUFeD5E=;
        b=sBtl8D/ERsUsFcZL/DSOhagTs/HHF9rXwbhthcrPlVwsFYZxjbc2Akh+fMeCQbbRF/
         oleiPAHFWd6YEzrc6Qc5kczFgQDdunmQ49ANRJWdKU36tTzoeybe0SsFwSWcTgXbPuf/
         xfGmfVUoTFwhmgaB+fGRj9TzNy0X1Ywr21KXcQpArBsu7Ld/pzqzcOx27hytC4gkKI5z
         PUzBfOvPqiunGRDn/MkRohZOZQS4nwcy44RAoBIeapGzWjrXND1BrSpLKUz5WJdKW8Pq
         /FEkpC4BetAQBU5lqlx6v3blTMu1WvlycEy3pdYeb/Y9mjFZl1e9h5RPCZTewvuoExqQ
         B8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvFV/sPpSnD57KASBlWu5g1n7aznLr5LbeGWzUFeD5E=;
        b=kEcAOr7JCZ89Vtu48ugawM8N0Wu7wiHU9M/yunKx8MDfuQFYpQwWJbGaEDPyH88WhD
         de0PONRb9FEg54ZZumWNwfoEVtZxnOJ8DPJIprbHVszNSban+U4b9BlbP5i9fpDO4Eoj
         4B4yQ35JRkF1ic3jfnWuUjcWBlgOpjnxopbBRx9b26zc7yU/yN1AejyaAaHlsdlHzSdn
         9vMk21pNFOHmVoDj8Gz2R8Cr/QHCNKQUHz42NwoEF9FA+fR6IcKiNRn1r9vumQA/U3ox
         Omvvnc+SBSTBEt/kEqoIShPFaRGKCMwWshxCb7QKdcRL2ccQqvUXXFu3oFnRXxWgy2As
         Z4mw==
X-Gm-Message-State: AOAM533qqO6TlC88/8Ik37yTqrQyEPh6L+hjbKDB8mjH+mhNdAy9uQM6
        Tt8dkJNBq3yBBIu7GgL3BlQxO5GvHVkWIDimUYzbSQ==
X-Google-Smtp-Source: ABdhPJzsGFnxcfx1wPp4UqsG78qF9NxE+WXImqmw44K30El9umyJ46EkWno8/KQYjD144O99zuI/BMm5+u+nLEGHnQ0=
X-Received: by 2002:a05:6512:10d4:: with SMTP id k20mr12502520lfg.299.1628630183441;
 Tue, 10 Aug 2021 14:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210809223740.59009-1-npache@redhat.com> <YRKa0yzEDALtvSZO@cmpxchg.org>
In-Reply-To: <YRKa0yzEDALtvSZO@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Aug 2021 14:16:12 -0700
Message-ID: <CALvZod4MEU24X6kST7BwsbdDPOQGN2LZhCN294PJj+hgmGbWTw@mail.gmail.com>
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nico Pache <npache@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@suse.com>,
        hakavlad@inbox.lv
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Aug 10, 2021 at 8:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> One thing I think we should do - whether we need more on top or not -
> is allowing file reclaim to continue when sc->file_is_tiny. Yes, we
> also need anon to meet the watermarks, but it's not clear why we
> should stop scanning file pages altogether: it's possible they get us
> there 99% of the way, and somebody clearly wanted us to swap as little
> as possible to end up in a situation like that, so:
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eeab6611993c..90dac3dc9903 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2477,7 +2477,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>          * If the system is almost out of file pages, force-scan anon.
>          */
>         if (sc->file_is_tiny) {
> -               scan_balance = SCAN_ANON;
> +               scan_balance = SCAN_EQUAL;
>                 goto out;
>         }
>

Another thing we should do is to re-evaluate the sc->file_is_tiny
condition. Currently it is:

anon = node_page_state(pgdat, NR_INACTIVE_ANON);
sc->file_is_tiny = file + free <= total_high_wmark &&
!(sc->may_deactivate & DEACTIVATE_ANON) && anon >> sc->priority;

First convert node_page_state() usage to lruvec_page_state() for
common source of truth.

Second, in the commit b91ac374346b (sc->may_deactivate &
DEACTIVATE_ANON) implies inactive_is_low(LRU_INACTIVE_ANON) but commit
170b04b7ae49 changed that. Was that intended?

Third, the comment above this code says "Consider anon" but it is only
considering inactive anon. Do we need to change the comment or the
check?
