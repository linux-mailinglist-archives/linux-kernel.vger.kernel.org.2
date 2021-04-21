Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3A366E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhDUOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbhDUOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:33:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:32:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id l17so11269675oil.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4NdzpZfqirPp0gvR813Ah3uNgfBFiqBDJuyFPyGu1E=;
        b=Kjz9TxZBQw4kQOiJ6hp0eg94TUg7BhRw7HZ8u74uB33gpDmRY6KAQzDoDFyY9qiFDU
         0rqSNQr7DET8P3ubXLIabb344MfpQ/1AxVSeePgjKBgtjwzU3vl+QIi3xmXZ083gD0/9
         LQhoP5fRUPucz1zsAF4aXtw1RiIZpoROr55O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4NdzpZfqirPp0gvR813Ah3uNgfBFiqBDJuyFPyGu1E=;
        b=dFHM43K0pnCm5l6ZnsTOcImMKN/y6Wf3y0pu+63HblwXJPY8vkdP8yMrePkNfsI0I6
         Fp74PILIabO/tV9UDIXr+GxwHgG0dE3leG14s6m1hj23QgrCiMzqQwMtGWptPLHFxkHx
         Ic21SZwsKUMX09FM9XzEP1yHxVuea6OQTIpYMd47GrHugKR29UV1rfQK4EfFSu0YcIYo
         btaSThy+OqonhTWsZtexwEKueOTu1C7W5TxnubfcDjRAd7OI9w5At0oqojiyJ/go3XW8
         pe8KeWBZHsAN0QTS/MCWHld2FWS9KRoUBiHWwdUI7L20HJiDhVpKpHMYUfHLmfyIio/o
         204A==
X-Gm-Message-State: AOAM533gXMvSEjCeXtNkEXjVGT+4wKqvoGloIiY7wXnwIFqV3ek3Suqd
        t/cmPMEEZDDMV2N/B9ZpVRkwcTOIKK6UgrvagrSdw6QIQlA=
X-Google-Smtp-Source: ABdhPJzplxjGkMkE3Q1aIt+OfIn0aKTDJphbICRrJaG7SWlq7lWbgO/UnV/T4onLOoKBjH6XsduDUlgmuHX60sLxXw8=
X-Received: by 2002:a05:6808:9b0:: with SMTP id e16mr6459393oig.128.1619015571169;
 Wed, 21 Apr 2021 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421120938.546076-1-maarten.lankhorst@linux.intel.com>
In-Reply-To: <20210421120938.546076-1-maarten.lankhorst@linux.intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 21 Apr 2021 16:32:40 +0200
Message-ID: <CAKMK7uF51AyrqydPVwy4u=H9h2apk2uYhnvUFRijDCY4Y2OKzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Fix docbook descriptions for i915_gem_shrinker
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 2:09 PM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Fixes the following htmldocs warning:
> drivers/gpu/drm/i915/gem/i915_gem_shrinker.c:102: warning: Function parameter or member 'ww' not described in 'i915_gem_shrink'
>
> Fixes: cf41a8f1dc1e ("drm/i915: Finally remove obj->mm.lock.")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
> index 7545ddd83659..f4fb68e8955a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
> @@ -72,6 +72,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
>
>  /**
>   * i915_gem_shrink - Shrink buffer object caches
> + * @ww: i915 gem ww acquire ctx, or NULL
>   * @i915: i915 device
>   * @target: amount of memory to make available, in pages
>   * @nr_scanned: optional output for number of pages scanned (incremental)
> --
> 2.31.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
