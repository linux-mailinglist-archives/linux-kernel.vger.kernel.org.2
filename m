Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE6390F12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhEZEHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhEZEG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:06:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 21:05:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso154307pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BSUH4FuVxkufE1DOQYaSypRB1C5PlZHQOf7I5N4qm0=;
        b=aJQNDouTB3w+wgh3Hd+Jk4J0GaQw1qwLDAhO40TzZVJvWseeC3o617s3lWDg6cLs+c
         HLn/anb5XFSekt11I9BhnpJEBGkso3sUd03oVLiB4DP0AkcmC2TOIH/hnpluvpkhKvYm
         4pjIUu3hm+ZT/KLw0xOePxUETZUPD9Ysj2SmNuyMPI36aVCRFmJPlqq2R5LrjgaUYyu6
         LLs6xl/0z0T1HUWK80sHV3PsEbh50pvIDQ8Oif5dRNqWPgXAXyQoLWew7dhh2U5Ahgg7
         2g0FWVjs2CKIhPZbfjQkIixOcljDlQJcfnv9mJ2y09IT/Nvp7mJPvORHqAgg68xVNuxc
         czqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BSUH4FuVxkufE1DOQYaSypRB1C5PlZHQOf7I5N4qm0=;
        b=QFnCUTD7JnWPyYmJROjHYZ8oMaj6T/aRV125taLox+fJTtBrJHlzGeLd2PVN5KaT2U
         +34Kj61ktq1xRsHaQE79lfwGzmdmQ+GjOYkKyMUEioR5Zni0KXgGE3YPli1dkdeZQKT+
         SkE8jBUUv0C7hCyM6/tDC1/zQl9fdCz10OI9t+w6DFOAoat4wuw73e4lEOqnoQS+cmuy
         cJ3CYilUUNTM7BXUL+BZ9A1XB8VN+XVWKg/hyIFaaGLdWPuTItlSjos5R019hQna0V50
         2FkvbfZ6UabQeN21iH1A9kd0ZYjT5gS3+Wgzq8asltSXaaJUXnF/NQuhRw/qjyhflCsL
         M5hQ==
X-Gm-Message-State: AOAM531TZyZ9Kzm6//01VIiu+7E2vf9AbxNueN5LiwCfyG6nKW8qpLs8
        +pLzGkqLKSB8vvsDNC4ZZAzIFHhNSxBD4ay6p+sEtgGCfIRF7AhZ
X-Google-Smtp-Source: ABdhPJwbh22bNdc31Uwfexj6GfFDlu+AgjcqrwJ82u9T8hZyfZrPtsBU8WI6o+cOar12wlXYaJS6KTgfi9jbUz84ZZ8=
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr33782211pjr.229.1622001925808;
 Tue, 25 May 2021 21:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210526025625.601023-1-swboyd@chromium.org> <20210526025625.601023-2-swboyd@chromium.org>
In-Reply-To: <20210526025625.601023-2-swboyd@chromium.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 12:04:49 +0800
Message-ID: <CAMZfGtVdzwjJLuUvcmgivKZNU1TK+ePFH9wgcm6jH86FWFHbJA@mail.gmail.com>
Subject: Re: [External] [PATCH v2 1/4] slub: Restore slub_debug=- behavior
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Passing slub_debug=- on the kernel commandline is supposed to disable
> slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
> where the default is to have slub debugging enabled in the build. Due to
> some code reorganization this behavior was dropped, but the code to make
> it work mostly stuck around. Restore the previous behavior by disabling
> the static key when we parse the commandline and see that we're trying
> to disable slub debugging.
>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")

Is it caused by the commit ca0cab65ea2b ("mm, slub: introduce static
key for slub_debug()")?

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 438fa8d4c970..2f53e8a9c28e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1396,6 +1396,8 @@ static int __init setup_slub_debug(char *str)
>  out:
>         if (slub_debug != 0 || slub_debug_string)
>                 static_branch_enable(&slub_debug_enabled);
> +       else
> +               static_branch_disable(&slub_debug_enabled);
>         if ((static_branch_unlikely(&init_on_alloc) ||
>              static_branch_unlikely(&init_on_free)) &&
>             (slub_debug & SLAB_POISON))
> --
> https://chromeos.dev
>
