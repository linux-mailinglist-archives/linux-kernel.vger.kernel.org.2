Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D1383B14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhEQRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbhEQRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:19:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6232C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:17:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so10980wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pY3ANxAOBaVfEjUQZg4WgknFV4zz3Y66bluELUvePBo=;
        b=wJ7BKxpIkvCl3vv7D2rP9P4/S6abZ5jx5Trw0yq7fUf/E6lRtPvSxq2JFJv3Q8YZIb
         XnDZwd6j/pdFKV2DLh1Ec82rQ5mCvmj2ZONRd02+AV0sQHPpQDXd3/pisqOq7BAGXjqm
         KnrApS4TO106wWB0qOZS7QAs81lQMqQiKmCCacHHpTEuA/LZesD+ArPiwZQF3HsHt0ul
         Qsf5f1tVdAUOCZ7DtYxZnD4BpNtP3u2eeSyQY3aASO8eJfV0NopgxAc0TxwynBJjWRky
         bW3tWKW4ETDowJPTydL71k61J2zlYVWY6rzxVlaqsUgqDje6e1y/mzztSkk+rEvWsLld
         mTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY3ANxAOBaVfEjUQZg4WgknFV4zz3Y66bluELUvePBo=;
        b=srIyWOgFrHVOuFL9Z9ghUWYTk58RgAGqLnMwe9wjKy4DiZnRxoTkXj2sNjXeZzguIU
         HULvwgk6c2jU1QZMHhezh4CVMcE4tFqVYIg2dZmwB+aUSTX1h/fHQq0pOtY5BFCaVhd6
         90zKOKEnexsPdw2b/60FC/ihbOld5UYqbgUdZmiUrpdpl2fOKt0JcAt+eLXfmWXiUL7J
         4nkFQ4TGhxb/NXfVLM+gN+LcgYvzSNUxil47LOqIkY6tmSWpF+ipr2Sp2tfSxOKYOAtt
         JM2jxSO4Y50RbI/qXiI5+vRQ1Tswb3OqnBQCcXCfdQHeSOrDF8XIpA8H+kcI7ze+QajS
         poLg==
X-Gm-Message-State: AOAM530KvgJQ9Ko4gOhXPMZML7KQXDw8DKNFGzanpHZV3AaVjIdT7r4Z
        5K3WFACMmS+we83OGHbUfJ47fd7UtPmZmETY2a+tWQ==
X-Google-Smtp-Source: ABdhPJyk31Drh7yiZ2RIF4bUOXhd84GLfFrtpDSqmQkh2RAbGt22wOr+2d0AETWWZaS0ob5YAriNmez40X1eQYiL1mo=
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr129680wmi.149.1621271875546;
 Mon, 17 May 2021 10:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-2-aisheng.dong@nxp.com>
In-Reply-To: <20210517112044.233138-2-aisheng.dong@nxp.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 May 2021 11:17:43 -0600
Message-ID: <CAOUHufabmeUedgOvxWB+Xy_W8rnqZssvjOR+QVt0VxWHuyLq2w@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: correct SECTION_SHIFT name in code comments
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 5:21 AM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> Actually SECTIONS_SHIFT is used in the kernel code, fixed the code
> comments. BTW, also moved the code comment to where it's defined.
>
> Also fixed a checkpatch complain derived from the original code:
> WARNING: please, no space before tabs
> + * SECTIONS_SHIFT    ^I^I#bits space required to store a section #$
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  include/linux/mmzone.h            | 2 --
>  include/linux/page-flags-layout.h | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9cdc88d09f2b..fc23e36cb165 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1198,8 +1198,6 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
>  #ifdef CONFIG_SPARSEMEM
>
>  /*
> - * SECTION_SHIFT               #bits space required to store a section #
> - *
>   * PA_SECTION_SHIFT            physical address to/from section number
>   * PFN_SECTION_SHIFT           pfn to/from section number
>   */
> diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
> index ef1e3e736e14..aff616855492 100644
> --- a/include/linux/page-flags-layout.h
> +++ b/include/linux/page-flags-layout.h
> @@ -26,6 +26,9 @@
>
>  #define ZONES_WIDTH            ZONES_SHIFT
>
> +/*
> + * SECTIONS_SHIFT              #bits space required to store a section #
> + */

IMO, we should either make the original comment helpful or just remove
it. Moving it here doesn't improve readability because it's stating
the obvious.

>  #ifdef CONFIG_SPARSEMEM
>  #include <asm/sparsemem.h>
>  #define SECTIONS_SHIFT (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> --
> 2.25.1
>
