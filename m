Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068445CD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbhKXT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbhKXT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:28:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:25:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so15169773edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=873SPxeNA6JXInk6khcBXN9ezsJz8m714DvHOFVFS2M=;
        b=kabwsTT/rFSwL3dAYZjimjtvmywcoxqcKgug4Wup2CrsB4RMRxzdONr/GYQr8PVpRy
         7qErPsOrJXkyktDwdog9v70J9sm2S/Bq6zcIUyHwnaZeJGv8bEhJFCXKBy8rWmAfzTpD
         +XPye37nTw8mFmfWDsz7MwYweHTUhcPkGuVZofDUJ6xK7IwYHfbGFPuPgAU8jkyxZFtg
         dn2oCNuY8gQ+1ATtvRUCDhbaQmAPEvvHonsJbt8KVaMwqXn9aq9QKQDGY0k9ExkDIt8k
         +rx9OnfPeG070urnYn4M8Z6PDgCLfkIZuzN5ZcXOoNBdt4VIqbvoD5IalwYrAUBI7fcz
         6ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=873SPxeNA6JXInk6khcBXN9ezsJz8m714DvHOFVFS2M=;
        b=YDGov2X3LUVEHBCYR1vBPsff3samgu+4rRwvrQZ7dJSB9naVCOG5I0EGw/5o0f3aWd
         qIvNJPS/OWyxcKjYUo/XPyF4AXOu4squ2F7t1abeF8Ac1xNJjnFOot/ykGimXWTSpVSK
         ghl5Bgn2FWmg7Gv3FbGT2OLLXZanmR1Kp/KlQcwVN9XpP5+HP2WnmlzhDD3qlH+gGaGM
         1NE4b/XpZpR1YeM/aR3T0L9qYet3xnTmOMkiJZ0aS8kRFYpv0DarEJxu+kgfZ1SXf+cV
         rRvl7LIIZABd7YiHwFugdcAdhVrIoCchDpz7EGVkrhfcfeOU+IZyfIvMEL2bhmyUfAdr
         jTkg==
X-Gm-Message-State: AOAM533+7fuIYu2Tv9nBUGo68KwX5FC3nb9Zd3IGTaI5GSOo30JccFOy
        wHtU1XxFiLPj0EyL09MaP3rcznOZTWzarxcH2g5kGYkx1UQ=
X-Google-Smtp-Source: ABdhPJythNnDIo19l+ICorPmwMLGk6J5jYSiEig7KISjE0UnvrBGxvNRd7grnujykNRUIlratFWfp/Yk4puWS0BTeBg=
X-Received: by 2002:a50:fb09:: with SMTP id d9mr29102779edq.283.1637781947799;
 Wed, 24 Nov 2021 11:25:47 -0800 (PST)
MIME-Version: 1.0
References: <c31d36bd097c6e9e69fc0f409c43b78e53e64fc2.1637766801.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <c31d36bd097c6e9e69fc0f409c43b78e53e64fc2.1637766801.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 Nov 2021 11:25:36 -0800
Message-ID: <CAHbLzkr5sTz7w=SXjAwDBu77Fog2LuiXV7STY4nZ4j2o+LpAxw@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: Add more comments for selecting target node randomly
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, zhongjiang-ali@linux.alibaba.com,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 7:17 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> As Yang Shi suggested [1], it will be helpful to explain why we should
> select target node randomly now if there are multiple target nodes.
>
> [1] https://lore.kernel.org/all/CAHbLzkqSqCL+g7dfzeOw8fPyeEC0BBv13Ny1UVGHDkadnQdR=g@mail.gmail.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8d39720de4eb..d9af89248196 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1209,6 +1209,14 @@ int next_demotion_node(int node)
>                 /*
>                  * If there are multiple target nodes, just select one
>                  * target node randomly.
> +                *
> +                * In addition, we can also use round-robin to select
> +                * target node, but we should introduce another variable
> +                * for node_demotion[] to record last selected target node,
> +                * that may cause cache ping-pong due to the changing of
> +                * last target node. Or introducing per-cpu data to avoid
> +                * caching issue, which seems more complicated. So selecting
> +                * target node randomly seems better until now.

Thank you.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>                  */
>                 index = get_random_int() % target_nr;
>                 break;
> --
> 2.27.0
>
