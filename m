Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F13E8729
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhHKATH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhHKASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:18:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD11C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:18:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z20so1695195lfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkFE6Z56Mr1EKMwPtDhJ4HsMjjvC1ODc/Bi7DtZL3y4=;
        b=KjMIw7uHjs9/YFLEilGT6TLdaKipi6iIbPCY43mmgLVcnbQgJph4S5OZ7tmYL0z102
         ASyygdAuIVEWbPB+5xylWE8nG874v/uIuTBOPiH+ZvgyoAzHAdmKTrK2t/lqz3aW5zzI
         k4cK1w/KhthEZqa9FydIVOnNXA1pZBZCfINF19J0oFDF1kQrnvw1TLg3uh1b9xMBXh9m
         Ok/7PeN9IsfUD8s+QtEEktIB3hafsmo1ZVpoEGxsbh/z6YWAK06ACu+mWkLhcXkgs4Tz
         y8lGeKym94+EFHQv3ZucB+1rEFd7TQk0B6oWb6EVhOexgOdOAF+dt9jKIuFuKlvSwFWP
         IjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkFE6Z56Mr1EKMwPtDhJ4HsMjjvC1ODc/Bi7DtZL3y4=;
        b=Jz8rYw9alWRFY0B8GxmuGVrsL7atQyTKi/Tv4cuFgBxgsm6m/yEcQ02ZUXgB2yqHs2
         7jlwRXnKbnFU0QPUw/Q8qZN4k8Gj59d/DMAl0aB1Zxvf4wwAZMWpSAIIlFlR2b9K3PhK
         Kmd1FWgVSpIs0YV9j/Aok+q2cXtKCVY2CgZnwmnJd5gHFJC5eXrzA4GFafGDpvgy/zic
         GZfG9uP00hq9OnIV6iU06qWCRNmrmGhiLFps0YhaEhhBCeOS7rOaTNAdb334kY9Bd+BQ
         dYUSmc6qlRc/cHK6GColz+RP+VmkeuvkLLplARQG8p350wx/Wcbt0YTd1EQABkUCs0Zk
         rc+A==
X-Gm-Message-State: AOAM530XcWOX8iF9qMyxI19yzJKSql300IGjpa46cMU2Cz15Z49SAF9q
        sitnitkatpNeuTgEJlgQRKvNTw5sIbCjOMHI9upzsQ==
X-Google-Smtp-Source: ABdhPJxhBg2LH2EJ+Bu3ELKjg0fU85Or2rS0VRsoUVvFWCifWBcbkWW428Z555bCdngbTg8uYMmFkuES5F+iS75w8XE=
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr24099569lfo.117.1628641086038;
 Tue, 10 Aug 2021 17:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <ef00ee9e0cf2b8fbcdf639d5038c373b69c0e1e1.1628639145.git.andreyknvl@gmail.com>
In-Reply-To: <ef00ee9e0cf2b8fbcdf639d5038c373b69c0e1e1.1628639145.git.andreyknvl@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Aug 2021 17:17:53 -0700
Message-ID: <CALvZod6d=Ri1K-cZMi_6MXuDnoRPdz5mCPN6DXRB8YyotV6d2w@mail.gmail.com>
Subject: Re: [PATCH] mm/slub, kasan: fix checking page_alloc allocations on free
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:47 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> A fix for stat counters f227f0faf63b ("slub: fix unreclaimable slab stat
> for bulk free") used page_address(page) as kfree_hook() argument instead
> of object. While the change is technically correct, it breaks KASAN's
> ability to detect improper (unaligned) pointers passed to kfree() and
> causes the kmalloc_pagealloc_invalid_free test to fail.
>
> This patch changes free_nonslab_page() to pass object to kfree_hook()
> instead of page_address(page) as it was before the fix.
>
> Fixed: f227f0faf63b ("slub: fix unreclaimable slab stat for bulk free")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

The fix is already in the mm tree:
https://lkml.kernel.org/r/20210802180819.1110165-1-shakeelb@google.com
