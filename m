Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7439FF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhFHS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhFHS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:28:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 11:26:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g6so16383394pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ndln2EuNlB+CP5mLiP3hdXT+nVwUYUAuTcfdG/dVXpU=;
        b=JL0mYsIjZFqW0K0buK/ZoqO8gB6RoLQ1xk0cIT0uvFwpxp0HDL0jLR647mH4HWhXWK
         7yGLyni/v6LOZwD66AOwZsqEf1AqrwLX+thpddZOS198keGEBHxxvv3ftPkMCrf+gHO+
         v3Hid4jVRPXCkteont5eNR9OzdANVZqDTlqHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ndln2EuNlB+CP5mLiP3hdXT+nVwUYUAuTcfdG/dVXpU=;
        b=odFiwR/WcwZ9g+oMxLqWs+cIZ++VlrPo40WgfkjhnJBaqI4z6A3uYU4Lm+VF0PlZOf
         nI+AEAD2XaKotpbE308pKs8lxgvMensMvpoBg82J81ZoV9gfzuKw94OD7wDhtG3VA6DZ
         jQHylq3gTFRdpq7vfPyZ4xk8AXpQ2IKavg6zr+X6nezPVdmiZBfHlrG8M8J5I0DVt0yF
         g2jsCZj3npSgHwUDyxIPjVwr9vj0Sy5qEjyZMu33DiiBjYHEu0jcJ90oFoY49oQp2zla
         myinUHWfjF2spvmvhaN+9QZeAxEuXMXO7annjHTSr35FNXHv+hf2crNlXhL0oVlFL3B2
         UyPw==
X-Gm-Message-State: AOAM530IeHhfzDAgPD1bnJQL0E/Ei0FtKcmYmx2S+AQLOXl5c9toj4b7
        SMKczArbgvtryISgDSB0PNqMBg==
X-Google-Smtp-Source: ABdhPJwTV2ZRR+J0IP/czfDPzPV669yVdHAMzM/WGvcXMbGOKH9gqjfxZrHbaKtAgI6WYhPrnRrgBA==
X-Received: by 2002:a63:ff22:: with SMTP id k34mr23730897pgi.336.1623176812105;
        Tue, 08 Jun 2021 11:26:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm11635762pfo.25.2021.06.08.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:26:51 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:26:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Lin, Zhenpeng" <zplin@psu.edu>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: choose the right freelist pointer location when
 creating small caches
Message-ID: <202106081125.E2DA4DE8@keescook>
References: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6746FEEA-FD69-4792-8DDA-C78F5FE7DA02@psu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 01:58:13AM +0000, Lin, Zhenpeng wrote:
> When enabling CONFIG_SLUB_DEBUG and booting with "slub_debug=Z", the
> kernel crashes at creating caches if the object size is smaller
> than 2*sizeof(void*). The problem is due to the wrong calculation
> of freepointer_area. The freelist pointer can be stored in the
> middle of object only if the object size is not smaller than
> 2*sizeof(void*). Otherwise, the freelist pointer will be corrupted by
> SLUB_RED_ZONE.
> 
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Fixes: 89b83f282d8b ("slub: avoid redzone when choosing freepointer location")
> Signed-off-by: Zhenpeng Lin <zplin@psu.edu>
> ---
> mm/slub.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3f96e099817a..cb23233ee683 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3704,7 +3704,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> 	 * can't use that portion for writing the freepointer, so
> 	 * s->offset must be limited within this for the general case.
> 	 */
> -	freepointer_area = size;
> +	freepointer_area = s->object_size;
> 
> #ifdef CONFIG_SLUB_DEBUG
> 	/*
> @@ -3751,7 +3751,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> 		 */
> 		s->offset = size;
> 		size += sizeof(void *);
> -	} else if (freepointer_area > sizeof(void *)) {
> +	} else if (freepointer_area >= 2 * sizeof(void *)) {
> 		/*
> 		 * Store freelist pointer near middle of object to keep
> 		 * it away from the edges of the object to avoid small
> --
> 2.17.1

NAK, I'd prefer this get cleaned up more completely, especially since
there are no objects of that size in the kernel currently:

https://lore.kernel.org/lkml/20201015033712.1491731-1-keescook@chromium.org/

-- 
Kees Cook
