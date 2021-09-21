Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E34131F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhIUKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhIUKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:53:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:51:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w206so17453730oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8im2OS98fNlJW2Ij6zQsDpm5TLK4cuMawMCjuGiTZU=;
        b=RR3cWHZ7Pw8yzusQe/R4SgSdvdSokVrUN1ScMzm8Low2Rp9NdUT/hMEzxFMF2nyhoD
         MZzrjwBiFKM9KDWtQ2ca6aNVcuzWC3B+Div+rkPUelnOGhf6sF2ltiY1VS1YQkCAY/O6
         7hAzDV9UBpTMR3HWey0UrUsOsvWpsP8hyQ3FmznVziVH9+4hLqPwKxZMHHQu+80rQn0R
         eMjzGCNby8+kvvir55KtM/RdBpgwdVycCcPLQfxb8u8T7gI1n3cc81239/YY8lWDSZlk
         dAkiGsYiBTgKVF/XSqcKaI7ON9208ReerBrU6IZ4Qsb0G6Lepw7yaX/GFs6noreOq8ym
         +1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8im2OS98fNlJW2Ij6zQsDpm5TLK4cuMawMCjuGiTZU=;
        b=0axVG3V5hYi7IcPM/YXzrvFIdEJXKRffmRMfcDgZkDH/xS8k/nbr+WgYkGxPx23Y1Y
         yVL0aXbS6VLnfrwqVKj57Xmy2OL/48tIU+4QhawRZuyBTqXcYHejRFUcmEaz8J6/Cbn3
         rzaUHaKsc1F8GJqvP/kFBcDIsF+lqAmohsBANw2JQnuWunXzQWJr1YoFQHUBEZtt6NBb
         SnqxkodL91ldKCWjWa+YnrUshTvuGPk5KHeKA52F0t0rBabeTw34m8cI0feV3ES9UnnN
         D5tuSNcQTqEJaqV908kcA31OAsiX2JM4QoP51id+/UqtgGPEhVkGuBLJHTn0kBlTCL9Q
         OCOA==
X-Gm-Message-State: AOAM530bxsr1zsNTBALcxpZct+XunyI1JS/VsB9kVYBIt5DpuhuGHIic
        NJo8yrifeVKFz5lzHscXMGYzcWyU+1RC8oo2aO5EGw==
X-Google-Smtp-Source: ABdhPJzHhMZvBpunQ9yksrBPafO+qk6Wq8WAzorP2+VXo94nhZjFWf2ZcLqY+NbwApLV7gcHfWQ6J0SIkkglMBmVT7Q=
X-Received: by 2002:aca:3083:: with SMTP id w125mr3028189oiw.109.1632221492218;
 Tue, 21 Sep 2021 03:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com> <20210921101014.1938382-5-elver@google.com>
In-Reply-To: <20210921101014.1938382-5-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 12:51:21 +0200
Message-ID: <CACT4Y+aUUNFvVsA86D280e4JqaQ4UdesMnG-+DVc=9v59_ZsJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kfence: add note to documentation about skipping
 covered allocations
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 12:10, Marco Elver <elver@google.com> wrote:
>
> Add a note briefly mentioning the new policy about "skipping currently
> covered allocations if pool close to full." Since this has a notable
> impact on KFENCE's bug-detection ability on systems with large uptimes,
> it is worth pointing out the feature.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * Rewrite.
> ---
>  Documentation/dev-tools/kfence.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
> index 0fbe3308bf37..d45f952986ae 100644
> --- a/Documentation/dev-tools/kfence.rst
> +++ b/Documentation/dev-tools/kfence.rst
> @@ -269,6 +269,17 @@ tail of KFENCE's freelist, so that the least recently freed objects are reused
>  first, and the chances of detecting use-after-frees of recently freed objects
>  is increased.
>
> +If pool utilization reaches 75% (default) or above, to reduce the risk of the
> +pool eventually being fully occupied by allocated objects yet ensure diverse
> +coverage of allocations, KFENCE limits currently covered allocations of the
> +same source from further filling up the pool. The "source" of an allocation is
> +based on its partial allocation stack trace. A side-effect is that this also
> +limits frequent long-lived allocations (e.g. pagecache) of the same source
> +filling up the pool permanently, which is the most common risk for the pool
> +becoming full and the sampled allocation rate dropping to zero. The threshold
> +at which to start limiting currently covered allocations can be configured via
> +the boot parameter ``kfence.skip_covered_thresh`` (pool usage%).
> +
>  Interface
>  ---------
>
> --
> 2.33.0.464.g1972c5931b-goog
>
