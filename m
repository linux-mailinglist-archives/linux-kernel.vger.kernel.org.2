Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB97B3E3000
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhHFT6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhHFT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:58:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0EC0613CF;
        Fri,  6 Aug 2021 12:58:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e13-20020a056830200db02904f06fa2790cso10204528otp.1;
        Fri, 06 Aug 2021 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44uVScQ9Gw/XAJ45c0vruto85d4GkUi4W4Jmj+tsVH8=;
        b=UlGtN2N+/E7iiZYxJKvzovkSO19giQwJd+k/KHky2IbaJkpv1Uak4W1uJn6H8BFiiU
         G+xiGSKGeR+7ThNnHhDMmpUIROTHWo5oXjIWRUmY1IlldNyqs4V6G/GWO3ysIoNqa/wh
         vZAarLxtlCu5ja19o3NIDmGyWxIf19NLbIbmwNmasbzJMDcsvWFSFYCy2+ClNx8Ih4Ok
         UNa5v/n7S/SzlZ9icFqH6a/jd+XiAssHlSLipwEbvxLmhNu2dvEgmGmd3HVhMjzgP6kz
         zIcc9/unMPkbQvBMHMGRoAJ9tPRVbr85crNJUdz8tSqqO9veN61s/GoH2EoQWrkESm3B
         0E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44uVScQ9Gw/XAJ45c0vruto85d4GkUi4W4Jmj+tsVH8=;
        b=HpcEuA7O8LUvbwVP7Db+pUZq8L/qtZSlIX89HV0TV2gBZon4KrgJak8z1kQd2tdkg+
         xVBG/al7IJfTrcPnLzHqhz0lsKFyh/eVsPkeFJJgeZp8aA8qVDieVqpMeyJhKg4h4ado
         oba8rAwvhqhlDXC1FF1ascepn/eWIYl6RZOqicT1ltSPkE4Zzn9PekHv/6CMwz5bDBze
         25/VIPwKxGvfEIMnPqh3xsBJbnHpnYykQl63MqOx09J1ken3w8OZlApqlO3iTEJB0WpI
         I9+04klqWAFzSoGLBWoOiC2DkoBhESXBRa1uZRuZhRDdxtoeXAW63zRdfRjb6zxNK3k+
         78SA==
X-Gm-Message-State: AOAM532GZhl1Dd0FNpMq8tFGxuCFq0r+n7MwL/BfuUWgBfC4HLWMrBNC
        GoGpI5eP5NYmIfqCktHa6n52STZp//F2bAR5VIU=
X-Google-Smtp-Source: ABdhPJzE0kiTi3tio0eqHLhmqmarjNSaTtD71nxdFJt5HsgC+bAt6RW84ZuEyZFn6YnA0ktX645N1rir1CpUrop9OAI=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr7881368oth.132.1628279906863;
 Fri, 06 Aug 2021 12:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210806111615.11803-1-colin.king@canonical.com>
In-Reply-To: <20210806111615.11803-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 Aug 2021 15:58:15 -0400
Message-ID: <CADnq5_Nh57mfc+aXCGxy9+V2DFCEH0wO0Lcj1B9Qk93otY_t3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant initialization of
 variable eng_id
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jun Lei <Jun.Lei@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
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

On Fri, Aug 6, 2021 at 7:16 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable eng_id is being initialized with a value that is never
> read, it is being re-assigned on the next statment. The assignment
> is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> index 1a89d565c92e..de80a9ea4cfa 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> @@ -305,7 +305,7 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(
>         const struct dc_state *state)
>  {
>         struct link_encoder *link_enc = NULL;
> -       enum engine_id eng_id = ENGINE_ID_UNKNOWN;
> +       enum engine_id eng_id;
>
>         eng_id = find_first_avail_link_enc(dc->ctx, state);
>         if (eng_id != ENGINE_ID_UNKNOWN)
> --
> 2.31.1
>
