Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307D3671FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbhDURwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhDURwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:52:34 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:52:01 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u80so9625008oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHeSLfnJ5ZLNsPHyN26b5G/s5n5dwcVoWT3huoppnRg=;
        b=cn74AcgL3gt2yHR7rJj5TbWqzQbSCg04SVgEPGhEd03xAxNHe/KMrqyneMT6qzhnEX
         7QepUwEN5+AHTqjTMQA1YmUHpL+eKmYLN8q3dJozmXPeTQWneZL1tCWJMiepfWJv1aRi
         rwLkFKqEfVstwgBLc9cBqORr82+gtCfZuZsRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHeSLfnJ5ZLNsPHyN26b5G/s5n5dwcVoWT3huoppnRg=;
        b=gOL/huQ5HSMtUA/U/KH62prSjJbxDKRO+u2/gYlAUiNfMkC7v5G8+IKrP0HW+K2Iyo
         2ELDqQfrq1Hu6k7uIj6oqns3a9SRJVlVP1DnCmwrEVQ8CRd2xdabiYnh5v2wy2d0MZpr
         n8f5K/Nr5LoBEOO0nGv2SzOFYPZq8gLLNI4+3pSyrvx5BHDk4lWywPIAFTW+TOIYmpjY
         AXNlWigZ0yYuG717PN7cBIm6g5b9OKPJtmGuUQ9bEM2vohDmdC0o2isVbiDbz4XMDrgJ
         /dXpuBfbbhbFBX09y6rQ+9rn+rfREmFj4QiTSjD/4a+YVQJNjuxEq2FlZoc9yVCOJ7UC
         fOFw==
X-Gm-Message-State: AOAM531Bu419hi7jkDfUtjznBj2mboCjCiSvwtXCRNyw7mWEfHDQhfSN
        +9iJ/A29Fu+QJfwMvnqD8zdLqpZSItfr5T+HF6cmNDmQzqc=
X-Google-Smtp-Source: ABdhPJwsIcwFk0xGrImI9Frny+JyeQhIDtOj8fN/LZ+ffvG+RbwJcr/j01WnxHKhH+Undy0TZS/LlChOPHqlkPPGTBY=
X-Received: by 2002:a05:6808:699:: with SMTP id k25mr7432738oig.101.1619027520531;
 Wed, 21 Apr 2021 10:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-75-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-75-gregkh@linuxfoundation.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 21 Apr 2021 19:51:49 +0200
Message-ID: <CAKMK7uF6sWeKX0DAaXoT9=xkD9eAAjHtkE0gn+v9YxmYAd3vdg@mail.gmail.com>
Subject: Re: [PATCH 074/190] Revert "drm/gma500: fix memory disclosures due to
 uninitialized bytes"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 3:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit ec3b7b6eb8c90b52f61adff11b6db7a8db34de19.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: https
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

gma500 is dead enough I'm not going to spend a single cycle thinking
whether this fixes anything or not and hence whether the revert is ok
or not.
-Daniel

> ---
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 129f87971002..f74041a102d9 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -129,7 +129,6 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
>         s32 freq_error, min_error = 100000;
>
>         memset(best_clock, 0, sizeof(*best_clock));
> -       memset(&clock, 0, sizeof(clock));
>
>         for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
>                 for (clock.n = limit->n.min; clock.n <= limit->n.max;
> @@ -186,7 +185,6 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
>         int err = target;
>
>         memset(best_clock, 0, sizeof(*best_clock));
> -       memset(&clock, 0, sizeof(clock));
>
>         for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
>                 for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
> --
> 2.31.1
>


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
