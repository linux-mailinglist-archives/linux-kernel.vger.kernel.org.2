Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1243F6515
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhHXRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229670AbhHXRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629824831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+EkvRCjisgW9/FJYFVpuRO5Po0oLsZ90ivwhF4hpSs=;
        b=emz6HIB+Vflaz4WsVYZgyBBTcsbgEWW7YBDJgeH/d3/2yth8dMgzkLrJm1Ci9fY/fKPOw5
        nigoKHpyIyPfgnANFD5uqbBUnrSoI5ivq9VzLcBFxtwStR/8gCvfZkusqF5Oyorq9RKp+g
        n8qhrMwVbrQoxK47UTG6tnCrf+wgjLk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-d9capykdNbCzyMtz1M8WZA-1; Tue, 24 Aug 2021 13:07:08 -0400
X-MC-Unique: d9capykdNbCzyMtz1M8WZA-1
Received: by mail-qv1-f71.google.com with SMTP id w6-20020a0cfc46000000b00370b0997afeso4299188qvp.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=M+EkvRCjisgW9/FJYFVpuRO5Po0oLsZ90ivwhF4hpSs=;
        b=PTc2KNsBLCqIVmoiXF/bLqqawQ1Ank9+tNJ7/rx+u1K18Lr+AP6bMOB0Gl9m4Esrcl
         befkk4mUXMTufhrBoimy1R2js+mM/9uZ7h1xOlhFZxE9F/ZD8cOb/b0bFabq3M/5aXyd
         SFi8xf7ZtoE0lojvzi6nw7QpLMRh0Lq6/IlWAiUKzGgB1z88TAgdDclL8UwSEvqbu5LI
         QAPwyeQQvo7FvSuEVwG0yqLsJwsCnWeNpvLCvs1popBIQnrVSBozPCmlPsTBYlrJsW42
         4M2oJAbvFZmY5OjmLJO6pnFr+3SupJu7HUal3G3IPicJAO0URSeZjOv3KltuOYcJpfNX
         0oag==
X-Gm-Message-State: AOAM533kXpsvfKtEACVSS0HZNqcCwS1ypIT2zxmEoFt4iIMV+qeabx6G
        4Fn2kQeWyFW+XijS7YZE38424up9HbJeW+tKjVaU41IDDkE9ClT2H5ussqEAiw8Y9iQzo9S7w8r
        FDCHin0yV3OfkgsZtPdZpg50C
X-Received: by 2002:a05:6214:621:: with SMTP id a1mr40120500qvx.12.1629824827956;
        Tue, 24 Aug 2021 10:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjEBLm63jRc4t/L6dw09TUKBT09yP3DkBvnII/qB+rct8Z9iqhYH6ZriYAEHIEzCukdlMCSA==
X-Received: by 2002:a05:6214:621:: with SMTP id a1mr40120476qvx.12.1629824827749;
        Tue, 24 Aug 2021 10:07:07 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id h6sm8211913qtb.44.2021.08.24.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:07:07 -0700 (PDT)
Message-ID: <1bd0bb90d6367307ad375d692563c6ba1fc43d50.camel@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.10 16/18] drm/nouveau/kms/nv50: workaround EFI
 GOP window channel format differences
From:   Lyude Paul <lyude@redhat.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Tue, 24 Aug 2021 13:07:06 -0400
In-Reply-To: <20210824005432.631154-16-sashal@kernel.org>
References: <20210824005432.631154-1-sashal@kernel.org>
         <20210824005432.631154-16-sashal@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, do we even have Ampere support in 5.10?

On Mon, 2021-08-23 at 20:54 -0400, Sasha Levin wrote:
> From: Ben Skeggs <bskeggs@redhat.com>
> 
> [ Upstream commit e78b1b545c6cfe9f87fc577128e00026fff230ba ]
> 
> Should fix some initial modeset failures on (at least) Ampere boards.
> 
> Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 27 +++++++++++++++++++++++++
>  drivers/gpu/drm/nouveau/dispnv50/head.c | 13 ++++++++----
>  drivers/gpu/drm/nouveau/dispnv50/head.h |  1 +
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 5b8cabb099eb..c2d34c91e840 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2202,6 +2202,33 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state
> *state)
>                 interlock[NV50_DISP_INTERLOCK_CORE] = 0;
>         }
>  
> +       /* Finish updating head(s)...
> +        *
> +        * NVD is rather picky about both where window assignments can
> change,
> +        * *and* about certain core and window channel states matching.
> +        *
> +        * The EFI GOP driver on newer GPUs configures window channels with
> a
> +        * different output format to what we do, and the core channel
> update
> +        * in the assign_windows case above would result in a state
> mismatch.
> +        *
> +        * Delay some of the head update until after that point to
> workaround
> +        * the issue.  This only affects the initial modeset.
> +        *
> +        * TODO: handle this better when adding flexible window mapping
> +        */
> +       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> new_crtc_state, i) {
> +               struct nv50_head_atom *asyh =
> nv50_head_atom(new_crtc_state);
> +               struct nv50_head *head = nv50_head(crtc);
> +
> +               NV_ATOMIC(drm, "%s: set %04x (clr %04x)\n", crtc->name,
> +                         asyh->set.mask, asyh->clr.mask);
> +
> +               if (asyh->set.mask) {
> +                       nv50_head_flush_set_wndw(head, asyh);
> +                       interlock[NV50_DISP_INTERLOCK_CORE] = 1;
> +               }
> +       }
> +
>         /* Update plane(s). */
>         for_each_new_plane_in_state(state, plane, new_plane_state, i) {
>                 struct nv50_wndw_atom *asyw =
> nv50_wndw_atom(new_plane_state);
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c
> b/drivers/gpu/drm/nouveau/dispnv50/head.c
> index 841edfaf5b9d..61826cac3061 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
> @@ -49,11 +49,8 @@ nv50_head_flush_clr(struct nv50_head *head,
>  }
>  
>  void
> -nv50_head_flush_set(struct nv50_head *head, struct nv50_head_atom *asyh)
> +nv50_head_flush_set_wndw(struct nv50_head *head, struct nv50_head_atom
> *asyh)
>  {
> -       if (asyh->set.view   ) head->func->view    (head, asyh);
> -       if (asyh->set.mode   ) head->func->mode    (head, asyh);
> -       if (asyh->set.core   ) head->func->core_set(head, asyh);
>         if (asyh->set.olut   ) {
>                 asyh->olut.offset = nv50_lut_load(&head->olut,
>                                                   asyh->olut.buffer,
> @@ -61,6 +58,14 @@ nv50_head_flush_set(struct nv50_head *head, struct
> nv50_head_atom *asyh)
>                                                   asyh->olut.load);
>                 head->func->olut_set(head, asyh);
>         }
> +}
> +
> +void
> +nv50_head_flush_set(struct nv50_head *head, struct nv50_head_atom *asyh)
> +{
> +       if (asyh->set.view   ) head->func->view    (head, asyh);
> +       if (asyh->set.mode   ) head->func->mode    (head, asyh);
> +       if (asyh->set.core   ) head->func->core_set(head, asyh);
>         if (asyh->set.curs   ) head->func->curs_set(head, asyh);
>         if (asyh->set.base   ) head->func->base    (head, asyh);
>         if (asyh->set.ovly   ) head->func->ovly    (head, asyh);
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.h
> b/drivers/gpu/drm/nouveau/dispnv50/head.h
> index dae841dc05fd..0bac6be9ba34 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.h
> @@ -21,6 +21,7 @@ struct nv50_head {
>  
>  struct nv50_head *nv50_head_create(struct drm_device *, int index);
>  void nv50_head_flush_set(struct nv50_head *head, struct nv50_head_atom
> *asyh);
> +void nv50_head_flush_set_wndw(struct nv50_head *head, struct nv50_head_atom
> *asyh);
>  void nv50_head_flush_clr(struct nv50_head *head,
>                          struct nv50_head_atom *asyh, bool flush);
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

