Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81432BFA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579937AbhCCScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234158AbhCCQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614790366;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuafV9iaKeRCuCbrDXsJ7dHnd1BZ5WTGR38IgEon89s=;
        b=f/vvQO9d5Q6qEum8PRWDxOhpnANqL09N6gAOxGRQY2mQvFPInRubzzGEJW0qN9R7w+21Cs
        1p/7aok7OM9doTdz1dfZo/a+Qq8YwbhjEto06hkzIHX9GRhzhImhzocofVhoy7+jK1rwbe
        ugasa0g5FatTjf+WDVO+Lt7USqF1sJM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-lCMoUuoROCSvrdgXuj2ezA-1; Wed, 03 Mar 2021 11:52:44 -0500
X-MC-Unique: lCMoUuoROCSvrdgXuj2ezA-1
Received: by mail-qt1-f198.google.com with SMTP id o7so16455596qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=vuafV9iaKeRCuCbrDXsJ7dHnd1BZ5WTGR38IgEon89s=;
        b=Lf4TWFgqNC7Yp+ycZHFKJxRuWXuBBj0gc01D5VRUVSaWs+afKiD5CgJXOpRId6r/EW
         NKzTRf5puoUQQ87+ixglSCxU86MXSyq0apuwUO8YuS23qHHIEMM3xNrcanQACg/Xiglo
         8BWBS+meTOu6jGA+HeXijDTV+vc1Iwz/AtHjQ2eUukz1lN69Qe8yeQSJrdt6Sjw6/SBi
         Sn8djs/150izAa7fVxFy+DyZTG6eqi+hT6CsJPoHCiF/JeYeOaUoJTuU9jKxdbX9PSM2
         jY6n77HL/2FHP3emhWaU5ucRDRmAEXgR8RSfcIx702JF/GFfIBkk02iyzWY+k05zjhG6
         1I7w==
X-Gm-Message-State: AOAM533EQ3K2olobP/rW2zvHRNCDwsTk6mGBfAC7WndMug22xyigivLM
        Gdtj9XN0vPJAnKaMbVzMCB1VMyknfD0Td7MviPdMa6RK+ISBs4Hl0qwJABzr6BjCcUe+FZrcXmA
        nCknaURQuHQXFQKBgx5fPLpeu
X-Received: by 2002:ac8:7392:: with SMTP id t18mr88272qtp.104.1614790364433;
        Wed, 03 Mar 2021 08:52:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRWwQPHZiKC09PdyNhlbkJTWeTtRw/uphRdlzLLWHMQESdVZfoUpNN0OnE7ymkuHZToRDZ0A==
X-Received: by 2002:ac8:7392:: with SMTP id t18mr88256qtp.104.1614790364277;
        Wed, 03 Mar 2021 08:52:44 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id h12sm16962779qko.29.2021.03.03.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:52:43 -0800 (PST)
Message-ID: <fb624c779ff09228e8bf4ac31a8bcf9edca658cb.camel@redhat.com>
Subject: Re: [PATCH 17/53] drm/nouveau/dispnv50/headc57d: Make local
 function 'headc57d_olut' static
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Wed, 03 Mar 2021 11:52:42 -0500
In-Reply-To: <20210303134319.3160762-18-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
         <20210303134319.3160762-18-lee.jones@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks!

On Wed, 2021-03-03 at 13:42 +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous
> prototype for ‘headc57d_olut’ [-Wmissing-prototypes]
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> index fd51527b56b83..bdcfd240d61c8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> @@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size,
> void __iomem *mem)
>         writew(readw(mem - 4), mem + 4);
>  }
>  
> -bool
> +static bool
>  headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
>  {
>         if (size != 0 && size != 256 && size != 1024)

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

