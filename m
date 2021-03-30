Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73334E60F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhC3LGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhC3LGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:06:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE86AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:06:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha17so7570847pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DskNrmJoVlSyLul5rgVfAIyNWef+AlzHHvEOelMyti0=;
        b=slVa6+xoi3BdoEmDA0VoVWkO8tuL/lXxZmvTYGJg7wGz1ScYaIRXrCfzU8ZDfT3ZM0
         ggp/ygaQGKJGhFRA5QW7f9U3EfpbXSMsXTYWx7p1nwBA8Ekc49nwzUS6jMME7z7gTQer
         pMAXay4GGKQ56ztl5Jx1BBEy9AL93xGYlIGeODixUv/aqu+Qb+EPVu6yig6as9K82Ctm
         Pc3Lb0tpzXuQ5QcHBiBeRUxF6g9QB2ZdsgL/8/oYQe2iFwggUqNONxGYgSPBasb/yQF+
         y9q6PFdQulOmXT/wl+s9SdMhbJRohu5/5mZE85W2ZPZCmG6ZrLW1OBmlPFp3zsxQu37T
         whJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DskNrmJoVlSyLul5rgVfAIyNWef+AlzHHvEOelMyti0=;
        b=GQjf9clBBDoz7paem3oyEiVz1SzL9fpX3iOMO4u0asCDEz88aSJFdbMg06glIYOVae
         Qs5C+E/oCgO8Yc6lChtgY+RgFu3jfp2jej6biSaL+BjQz7CDxj2CVy8iym38Whj82Q2B
         4fLH6SQWUjVMRSypEjJ2HAs5WDuYaR5FYlWnG8BLAqhoCyb9dN8Dk6/iGejXugrGEAHm
         gcmDbwhyfuupAdwHsWUNh5rG4XXiCes3huGHkhC/Cyss/0/yCex9hCvOLQ26MLqfhd+1
         Ri5z0cBhsE2gYFJaCMx+e0mraTVv5xfJFoYEvZy1koRpqFqmDkZcv1usiNg+jNHJ9vLz
         hlKA==
X-Gm-Message-State: AOAM5336vOlTF9GurosI4NBrpMlDBfMJlWI3fZwDHX4GFJdfxWagelYu
        247vd9ucvJ/KbUq/w9zzuNmySZ8Qhfnoj9nYw+JLCQ==
X-Google-Smtp-Source: ABdhPJxfOmfQB9fzlhBcQ+PyXZQEzxSloSUbr4UVE6rrRVfcHfZyWFno3tNgnDlI6rBdjWZE6AMTaSFq8fb0+pHpeFc=
X-Received: by 2002:a17:902:f68a:b029:e5:b17f:9154 with SMTP id
 l10-20020a170902f68ab02900e5b17f9154mr32285479plg.28.1617102372210; Tue, 30
 Mar 2021 04:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210326203807.105754-1-lyude@redhat.com> <20210326203807.105754-20-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-20-lyude@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Mar 2021 13:06:01 +0200
Message-ID: <CAG3jFytEUCqh6U6oG8hKqk-2bmr+qtcwg1gbWRQp_KxXTxfVsw@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] drm/dp_mst: Drop DRM_ERROR() on kzalloc() fail
 in drm_dp_mst_handle_up_req()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

This patch looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 26 Mar 2021 at 21:40, Lyude Paul <lyude@redhat.com> wrote:
>
> Checkpatch was complaining about this - there's no need for us to print
> errors when kzalloc() fails, as kzalloc() will already WARN for us. So,
> let's fix that before converting things to make checkpatch happy.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ec2285595c33..74c420f5f204 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4113,10 +4113,9 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>                 return 0;
>
>         up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
> -       if (!up_req) {
> -               DRM_ERROR("Not enough memory to process MST up req\n");
> +       if (!up_req)
>                 return -ENOMEM;
> -       }
> +
>         INIT_LIST_HEAD(&up_req->next);
>
>         drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
> --
> 2.30.2
>
