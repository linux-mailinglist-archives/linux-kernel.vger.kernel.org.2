Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47D34B16F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhCZVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616794869;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KYq2FimxUUOirhAHH7Y6K62w8Nvf75VdOPqqjNoVNY=;
        b=P568CWIASQHyVW765vVDWKQJdZRpEbzxzylzNY8K7gejdzKWiUWAm9bMHRo1/zIObfzsoI
        6ZKKgSeeZQAw+44y0SpcN9usokON9TFKb38WtC9MoB3xLGLTKEHT2W+v0IR22f6S4iEimo
        6cxEiL60B+iKaY+zp+7a6x12mMAZFfA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-lTENdUMjNESBc0CIb7npVQ-1; Fri, 26 Mar 2021 17:41:07 -0400
X-MC-Unique: lTENdUMjNESBc0CIb7npVQ-1
Received: by mail-qk1-f200.google.com with SMTP id y9so7139206qki.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 14:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2KYq2FimxUUOirhAHH7Y6K62w8Nvf75VdOPqqjNoVNY=;
        b=HmuJZOFzE624Frm0K0rDZ9cknYVRVUsxOD33T5lRqWnSFQqfEER6BLN3smxnw6GC+q
         4rc8YOQDaoJb0pS+ywIswgS7/D8cs1aSVFxtSgKj5DvQ2Dmn7wDReRpbA5nmjLzTdGSl
         gGTv83Sq1Hilzwxp8jDWEIWpyF+JZ6h6Ospq1E6OBNLogo4BSFYaO8xqQ6BD8S+g2/qB
         FOw/giZ9Ziuc77fGp7M9wEXocCFmB3w44kjUGeXGFFc9ekevM4bnHXH7+WxSsS6ke67k
         f109+IXPvT7nVON7gd4U1yrkVWccVE9OMPg3/Ikjj0iVYxpoK9Krju2h/GWi5OlRO10/
         Ki4Q==
X-Gm-Message-State: AOAM530Zx2YY5AZC/x35wdU4KFKaNlkpBbL+dZbNaNyI0DGrXUOY2o2E
        2T2RDWhEWKcn7tKTmuMnd0HRgTMS0GaTY0ukT2zKNlPrb8EoTpGDdUmNEiVTM0Ft2vDbN9QNfe+
        saiYgPNbcy4szfOZLr01v7lwN
X-Received: by 2002:ac8:6789:: with SMTP id b9mr13776310qtp.103.1616794866613;
        Fri, 26 Mar 2021 14:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc8vW+QMW0U4nq1pb7zDYcwAwcJWPPX3yqc5y79GrncUcdi02PbcBkqm4COvoGtyLpXgXAgg==
X-Received: by 2002:ac8:6789:: with SMTP id b9mr13776303qtp.103.1616794866456;
        Fri, 26 Mar 2021 14:41:06 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id l9sm6725962qtv.65.2021.03.26.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:41:05 -0700 (PDT)
Message-ID: <7f51dbe3dac85f692e01bb5cecdf4454a40b1893.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: avoid a use-after-free when BO init fails
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <treding@nvidia.com>
Date:   Fri, 26 Mar 2021 17:41:05 -0400
In-Reply-To: <20201203000220.18238-1-jcline@redhat.com>
References: <20201203000220.18238-1-jcline@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2020-12-02 at 19:02 -0500, Jeremy Cline wrote:
> nouveau_bo_init() is backed by ttm_bo_init() and ferries its return code
> back to the caller. On failures, ttm_bo_init() invokes the provided
> destructor which should de-initialize and free the memory.
> 
> Thus, when nouveau_bo_init() returns an error the gem object has already
> been released and the memory freed by nouveau_bo_del_ttm().
> 
> Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
> b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 787d05eefd9c..d30157cc7169 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -211,10 +211,8 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int
> align, uint32_t domain,
>         }
>  
>         ret = nouveau_bo_init(nvbo, size, align, domain, NULL, NULL);
> -       if (ret) {
> -               nouveau_bo_ref(NULL, &nvbo);
> +       if (ret)
>                 return ret;
> -       }
>  
>         /* we restrict allowed domains on nv50+ to only the types
>          * that were requested at creation time.  not possibly on

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

