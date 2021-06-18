Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7D3AC0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhFRCbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:31:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8ACC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:29:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g22so6551538pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfPVG5Rlds1gsdNwyYiwTk3qXAK1bjtNSBW/loIyjKY=;
        b=E2p6v27bJYXXFcPeI5HII06b35v9VeR4Y4LrX8rCAPy1EKcPKWRNCLSeoRvFB6gu7a
         20danzHU+5B4CO5YgjmOJsLR+X+AJ+glc5VcTxedFJ3oKqjyLWzZO24FXuUSB+0naqmE
         k6pwiekhhbjBwqo4/5qvEF6ACa0hCftM65IOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfPVG5Rlds1gsdNwyYiwTk3qXAK1bjtNSBW/loIyjKY=;
        b=TxrdDYaY8h0kBiyYEAoj97dYXz5Y1F99+TvA9dErdMLBainFtHL7xPcatg/nMcf/Si
         nYWklOo5l04RSWyImIrYn7DPMcg7uCDerb64T7fdUD1Pa6fFwB0Xmf1FpFmnU21/5Knp
         5uYj4sBOCgZIQ0A23m5NjlJ4ZlCezLqaMOtnWR2dXMzp78cAocPo+VW+LxXqqStQI+31
         rOrWA83CFn4NeIlWFF81XKkBIOmEBv183QNvBsfS/FHkK8idq1O+dq3ZoBQnB/wGSckC
         xwqdiMCP7tW3vclsEkM4JLJWl3Kg6cPLFqXcSA7Ar+dIvu22ABBIbQVkS67JadncuaJn
         3rVQ==
X-Gm-Message-State: AOAM531WZqmpfy02L9wmLugTRBqskIb/I827lsbWRvXTeW3YFA+fntPU
        yxtM59gvX9TD9o72OfNdnhptbw==
X-Google-Smtp-Source: ABdhPJyS6c3QGhrzjMIrW+aGUG63njKnr2ncdaOY4gTWMcv6MJ1tkZvI9BCbGpvn07MueABqKDk/xQ==
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr7829823pgm.279.1623983375774;
        Thu, 17 Jun 2021 19:29:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:51a0:fc:f202:9f8])
        by smtp.gmail.com with ESMTPSA id v7sm6368683pfi.187.2021.06.17.19.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 19:29:35 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:29:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: drm/i915: __GFP_RETRY_MAYFAIL allocations in stable kernels
Message-ID: <YMwFCoHzjnuH80p6@google.com>
References: <YMdPcWZi4x7vnCxI@google.com>
 <YMuGGqs4cDotxuKO@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMuGGqs4cDotxuKO@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/17 19:27), Daniel Vetter wrote:
> > 
> > So can all allocations in gen8_init_scratch() use
> > 	GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN
> 
> Yeah that looks all fairly broken tbh. The only thing I didn't know was
> that GFP_DMA32 wasn't a full gfp mask with reclaim bits set as needed. I
> guess it would be clearer if we use GFP_KERNEL | __GFP_DMA32 for these.

Looks good.

> The commit that introduced a lot of this, including I915_GFP_ALLOW_FAIL
> seems to be
> 
> commit 1abb70f5955d1a9021f96359a2c6502ca569b68d
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Tue May 22 09:36:43 2018 +0100
> 
>     drm/i915/gtt: Allow pagedirectory allocations to fail
> 
> which used a selftest as justification, not real world workloads, so looks
> rather dubious.

Exactly, the commit we landed internally partially reverts 1abb70f5955
in 4.19 and 5.4 kernels. I don't mind I915_GFP_ALLOW_FAIL and so on, I
kept those bits, but we need reclaim. I can reproduce cases when order:0
allocation fails with
	__GFP_HIGHMEM|__GFP_RETRY_MAYFAIL
but succeeds with
	GFP_KERNEL|__GFP_HIGHMEM|__GFP_RETRY_MAYFAIL


ON a side note, I'm not very sure if __GFP_RETRY_MAYFAIL is actually
needed. Especially seeing it in syscalls is a bit uncommon:

  drm_ioctl()
   i915_gem_context_create_ioctl()
    i915_gem_create_context()
     i915_ppgtt_create()
      setup_scratch_page()           // __GFP_RETRY_MAYFAIL

But with GFP_KERNEL at least it tries to make some reclaim progress
between retries, so it seems to be good enough.
