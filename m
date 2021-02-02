Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C530C618
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhBBQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhBBQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:34:46 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A8C061D7D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:29:18 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h192so23377068oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJafALgRjHnc3pk4hWG2YLPFbbjfz2R2r/DUy/DagQA=;
        b=M3b+5gYuwmWiwcuRwWu9yE1WbQlWnIAFHOm0WJADOqnXCbnOsyffd86x8zBpQSgiDe
         BPQ7gWocTOjgVb5EcLZiiu/eX1c4bwyCQ7EN0AadE4jYz3gTJSHFfDQ2rWcqG+peltAV
         nklaHzB11iQslk7FL7nRFqWQ8oRZ43C3Dj5T992pf31NOyq3Y9l6nlYWcGwqf7UTMH7D
         VpzvOeiqV0YI+ggIbOCVFCrNxAgbdCSuvLzvlKB828Tnu51fJf1rAslWQMtaNDig614q
         mxLgBbaiJ/B7IQe1py410oM/+wgsKMgT/i+Oy6B73sRkDp1uD25y861chJVWVUlhV+HW
         QayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJafALgRjHnc3pk4hWG2YLPFbbjfz2R2r/DUy/DagQA=;
        b=hYB6F+4ZUohSfjds9RRysxOgTeHj1Hv3IVXK6KpWq3iHxSVk+/LLiaJVjxrXLj1Wgv
         bQiDG74Q3m1u41NX6e8IR7Ea9TpS32W+cWGpt9iOasoTnEVPRNNTzTJYLPJbf7pryFPc
         KGysIhTAMM+mz+kVLkiA5XPDwz0zxbN1mAcnN9lMd9sHlrESd/b70BVLEbjNbcf9YCpa
         Xn89O+Bm5sl96ArNMTmZ66zUn7ZrVeBOs8W6Pn7aTiux4BF1BAz4z7BGSQPaFW1SMmfF
         2EjKYx8WyxJOoscfoYc7ymtwFuilk92LcbfQ4+9qS8RN7GeG/A1Qk2H+hImeHTvpBIzL
         dH6w==
X-Gm-Message-State: AOAM532Bl3aJ4HfYE5EPFE1wXriZrytTOaHwmSoyoincdTVWuDqWGvIl
        GycJx9oB74/1THdi1PJ7HBMoJmPSs904L0e208cx+LTg
X-Google-Smtp-Source: ABdhPJysEZOG4JRJWX+nV4fwnRxi6Wx0pQLxM+oUJ1lOxtXbI1+iXokBRtqfmL0fXou8VFKqjf5m3eAjO31cN6P5J5E=
X-Received: by 2002:aca:f5d1:: with SMTP id t200mr3189277oih.123.1612283358299;
 Tue, 02 Feb 2021 08:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20210202121927.15153-1-bernard@vivo.com>
In-Reply-To: <20210202121927.15153-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 2 Feb 2021 11:29:06 -0500
Message-ID: <CADnq5_NLV1PrR2YLQQqV2CO2oqB3yr1KXLWKJz=Aju+6MMdkzA@mail.gmail.com>
Subject: Re: [PATCH] amd/display: remove unneeded variable: "pattern"
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Vladimir Stempen <vladimir.stempen@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 8:31 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Remove unneeded variable: "pattern".
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index f95bade59624..d77ae58210f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -126,9 +126,7 @@ static void dpcd_set_training_pattern(
>  static enum dc_dp_training_pattern decide_cr_training_pattern(
>                 const struct dc_link_settings *link_settings)
>  {
> -       enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
> -
> -       return pattern;
> +       return DP_TRAINING_PATTERN_SEQUENCE_1;
>  }
>
>  static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
