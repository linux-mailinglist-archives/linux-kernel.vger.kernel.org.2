Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB04256B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbhJGPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhJGPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:37:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFCC061570;
        Thu,  7 Oct 2021 08:35:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v10so9463571oic.12;
        Thu, 07 Oct 2021 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RarZC0DyhhLg13GOrYFDr8NcXK9FIufYOOLFZU9wHfQ=;
        b=ZJ2AS0ZVbS9jA+Hqwj82ytWYWsaLS1Ns4HObbEH4BVgIpMa8Kwlefv3KZCRKKzZwR7
         MylpjwRAC1Td5bO19GNTMwBAzaoDNWIOWCCUhpVTwMCLU6etTo1UdZt5oJn60YhF1J7m
         kKfTdESIEWTIVwtYcTa47J3ZwXkaTcH1upbAIwkCytGR111jwfC5Pp6U6A2mRdWZZTz2
         g+xDHiRWtHFT3y4v5sCIslqZC12fMQsZFdjfPdispfmg5XP7NwzFk99iJtcr6g4WIkMN
         gyau5vmetfTUpR2IWyMuwdqK8nScwXIA8tmesfF4Q53s7G+8Q+Tyk1BgqWWSeo1QWbyG
         Dwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RarZC0DyhhLg13GOrYFDr8NcXK9FIufYOOLFZU9wHfQ=;
        b=klzZXRoM2vito8rJoU/3xGZaAfJTnAAWtLH0t+rBCDjpWFtLxRRu7QDzDeysbIiFHO
         81AT2OReLbI6Q8izeyX461+Z4o7Ij6+V+huY6Qi00C9V4sbYr0q19MCaYjkz1IwZRYCq
         dpe7HgDPxQqsvoCqxBO3uqnuK4VUx2wqq0a8gqcnLUBg3eY8lpkRUKeDYQUr31w9Itlx
         CO0WvIIrPHpbValtqJut+Q1Yfx7rZi2mIRy8Cfi26qPvC19C/gvQFjqkUH+wQwd1XFEu
         Vv/o9Top1Y19PQMvWdYv+86x/H4uGLrGQqvBnck/7PDK66EVarGyW1dTPrvvKwxarEkT
         38Jg==
X-Gm-Message-State: AOAM531x5oVmt9VeNK+W9nFLAg1/Tqe7lcCK+rozjH8Wqo2eBUB6tGt7
        vUGkDbKZibvIqZFhlQPsYZM8TJPmsBFvnmkJUwo=
X-Google-Smtp-Source: ABdhPJzm23B4aJ7u+6jK/b6qYYLaIYoEve1Wt62fj0JIjH1+3WpkM+TdDRftw8V9bE4WpO40YcaOYdCD+KQKLlnZMVE=
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr3640714oiu.123.1633620921765;
 Thu, 07 Oct 2021 08:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211007120637.14459-1-colin.king@canonical.com>
In-Reply-To: <20211007120637.14459-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Oct 2021 11:35:10 -0400
Message-ID: <CADnq5_P2ZC5oaDZYPZixxH6BLoPZfvwWQqiGM2msQAcA3ebL8Q@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Remove redundant initialization of
 variable result
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Oct 7, 2021 at 8:06 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is never
> read, it is being updated immediately afterwards in both branches
> of an if statement. The assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> index 6936b9d549e5..8387767ec1b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
> @@ -774,7 +774,7 @@ static enum link_training_result dpia_training_eq_phase(struct dc_link *link,
>                 struct link_training_settings *lt_settings,
>                 uint32_t hop)
>  {
> -       enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
> +       enum link_training_result result;
>
>         if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
>                 result = dpia_training_eq_non_transparent(link, lt_settings, hop);
> --
> 2.32.0
>
