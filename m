Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99263376ECA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhEHCcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:32:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7097C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 19:31:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso6472543pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fWuonJ/sGZf5Jk8oW8OrEUg0GSOChqbnCAr3zaIgyM0=;
        b=P3OTxBO7rND0IXkMc2KhkmILDxW8AKcI2CpsQNMQvHVnmjP/WOqo+7hNA7ZVk371XE
         xgKKKN6e0CyzRycERtd5p77jJEcz3S8i585nvN1MID9LmV8Of9dXfeitbH8KnzqmAbak
         CMonA6GPhnjGiixBy58v0ZBcOP0XKmEi5esCeC3pvQ4Qws+bbDqdIxsN/hIxMALxnyiF
         DdyCYJhrStkZRyseXCKcwb0FLDU1uHkFpJT7EaOWSmKRHOAnntrhjCscykNr+etJwrJp
         Iva3SLbi3uOQN2I3bW8wggOh926wDqtKWWW7f0yeMHLIKQLn6QSDDCiIcMEF60yC80VE
         J3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fWuonJ/sGZf5Jk8oW8OrEUg0GSOChqbnCAr3zaIgyM0=;
        b=WE5rywHt4H9r8a5SmLD0ijf2snMX7t7crxajjoTPWz9cZrE5xwZZIH+V8x6feYLLF8
         oNssxB5XbxedXXVIv8nfQ6MKbay0yV3NgW2oy4IuwnwpFJFeiz6lbYtkz8dfgTzo7WxX
         TNHqyMMvCRnjZ+/CLbCC3GxtkmJP7xAKOgoAOlJ2bAfZQyruXHXFiJLnIyXyIGgmtM/a
         tFQBCLrVv6HwwFnmDzL6q7XqMbId8DBGJP51eAwVMJlAHqKmPywUy47rdviVlexRwJGF
         bZzoIAAGzq2WPWkXVIUIQ84KIhjtVHW4os/BJ9s+9gFMDF1ISeZkQLhVnDKnXirzWvtI
         1unQ==
X-Gm-Message-State: AOAM530X7LjDTr5ZS1t9djTNaXSftHbUCp7rnMjjpjjZxB3th+ga4egc
        QJb9nEGKDooceJ39zTLZwSufnFciFcr227APhNI=
X-Google-Smtp-Source: ABdhPJxTlzCUCDRIP4PdknnFvbYo7pCXA/Yd7JREVk+VLcmnzV+b8GvmiBf3cpK61QlOn3ltacGUOpNHO0WJeSn2kXo=
X-Received: by 2002:a17:902:6b02:b029:e9:8e2:d107 with SMTP id
 o2-20020a1709026b02b02900e908e2d107mr13217211plk.61.1620441096210; Fri, 07
 May 2021 19:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210428225046.16301-1-wuchi.zero@gmail.com>
In-Reply-To: <20210428225046.16301-1-wuchi.zero@gmail.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Sat, 8 May 2021 10:31:25 +0800
Message-ID: <CA+tQmHBmgG0LK2yF6DbfwLN79H0w8soLNcx5j4d6v3Wp64HcnQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Fix performance when BDI's share of
 ratio is 0.
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

Chi Wu <wuchi.zero@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8829=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Fix performance when BDI's share of ratio is 0.
>
> The issue is similar to commit 74d369443325 ("writeback: Fix
> performance regression in wb_over_bg_thresh()").
>
> Balance_dirty_pages and the writeback worker will also disagree on
> whether writeback when a BDI uses BDI_CAP_STRICTLIMIT and BDI's share
> of the thresh ratio is zero.
>
> For example, A thread on cpu0 writes 32 pages and then
> balance_dirty_pages, it will wake up background writeback and pauses
> because wb_dirty > wb->wb_thresh =3D 0 (share of thresh ratio is zero).
> A thread may runs on cpu0 again because scheduler prefers pre_cpu.
> Then writeback worker may runs on other cpus(1,2..) which causes the
> value of wb_stat(wb, WB_RECLAIMABLE) in wb_over_bg_thresh is 0 and does
> not writeback and returns.
>
> Thus, balance_dirty_pages keeps looping, sleeping and then waking up the
> worker who will do nothing. It remains stuck in this state until the
> writeback worker hit the right dirty cpu or the dirty pages expire.
>
> The fix that we should get the wb_stat_sum radically when thresh is low.
>
> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
> ---
>  mm/page-writeback.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..bd7052295246 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1945,6 +1945,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>         struct dirty_throttle_control * const gdtc =3D &gdtc_stor;
>         struct dirty_throttle_control * const mdtc =3D mdtc_valid(&mdtc_s=
tor) ?
>                                                      &mdtc_stor : NULL;
> +       unsigned long reclaimable;
> +       unsigned long thresh;
>
>         /*
>          * Similar to balance_dirty_pages() but ignores pages being writt=
en
> @@ -1957,8 +1959,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>         if (gdtc->dirty > gdtc->bg_thresh)
>                 return true;
>
> -       if (wb_stat(wb, WB_RECLAIMABLE) >
> -           wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
> +       thresh =3D wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
> +       if (thresh < 2 * wb_stat_error())
> +               reclaimable =3D wb_stat_sum(wb, WB_RECLAIMABLE);
> +       else
> +               reclaimable =3D wb_stat(wb, WB_RECLAIMABLE);
> +
> +       if (reclaimable > thresh)
>                 return true;
>
>         if (mdtc) {
> @@ -1972,8 +1979,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
>                 if (mdtc->dirty > mdtc->bg_thresh)
>                         return true;
>
> -               if (wb_stat(wb, WB_RECLAIMABLE) >
> -                   wb_calc_thresh(mdtc->wb, mdtc->bg_thresh))
> +               thresh =3D wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
> +               if (thresh < 2 * wb_stat_error())
> +                       reclaimable =3D wb_stat_sum(wb, WB_RECLAIMABLE);
> +               else
> +                       reclaimable =3D wb_stat(wb, WB_RECLAIMABLE);
> +
> +               if (reclaimable > thresh)
>                         return true;
>         }
>
> --
> 2.17.1
>
