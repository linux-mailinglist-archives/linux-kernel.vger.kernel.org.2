Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F266B3B75FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhF2P5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhF2P5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:57:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:55:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a13so26407364wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WEojPjsV3ykyxbi9z7NRgZv6sToKhUFLAsfPvjr4z+E=;
        b=kav40qXis5AYEd1L7EDM6xxJivVvxbNSKSq+CBd5s+18VHu75OqZrXoI+sY+3/1k6t
         +00O8pauIDVVjBILhvdBPu4wUErbUhmbZermGLoCv9sB5xLLeUgW9PhBNqBhLLlJd4R0
         eXT70pVBcNa+evB30t/7wTKlxa/kXzLRBdMu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WEojPjsV3ykyxbi9z7NRgZv6sToKhUFLAsfPvjr4z+E=;
        b=XvL3FcOqpVfrmnpdJzuz7c4d8tCZOTlepfwRdk1+xN4utkE1tEz1S4mcl5UceyhwyD
         yboHwhp1nlbDT5PXrOEieXfgUv7Rz7udxWU2cQqgzT8Wed2sQNFciPopARdD5MeK5inQ
         Too9HCOBhVQmC0cZc1S/5vxCkBLPYcU5ZaIxIL0K2SB8fFb9FIZieaugjRO2ngPVxOKE
         Wb29bYUvW7VBfX9mgqoCJXlwBMfi51BE41jxe5Y9l1z0RX6fhvEh32mRxl71ww/0RmwK
         Une8iwib11/VYoPcuGJBCe11vLfW6bGdTtwZ7BNA/XCU0W0gN1v0IjnuTXMZTrckEON+
         SlFQ==
X-Gm-Message-State: AOAM531dq0AUQXuSb2VYQtS6WlLqOXPskBtbxevQd5wbLTXy39RVhnPp
        U+ddqXY8I8uSZ44enkc3BrSfvg==
X-Google-Smtp-Source: ABdhPJwy//RfOpOtuDUFzUPw0qGyBWCU1xYg2FxNtD+pBORPuM1k7hT2WqXFwV1cl1tJjWezk3iDOA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr8264853wrp.331.1624982118145;
        Tue, 29 Jun 2021 08:55:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t16sm4438422wrx.89.2021.06.29.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:55:17 -0700 (PDT)
Date:   Tue, 29 Jun 2021 17:55:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org
Subject: Re: [PATCH -next] <linux/dma-resv.h>: correct a function name in
 kernel-doc
Message-ID: <YNtCYyHXOrObRUDK@phenom.ffwll.local>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org
References: <20210628004012.6792-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210628004012.6792-1-rdunlap@infradead.org>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 05:40:12PM -0700, Randy Dunlap wrote:
> Fix kernel-doc function name warning:
> 
> ../include/linux/dma-resv.h:227: warning: expecting prototype for dma_resv_exclusive(). Prototype was for dma_resv_excl_fence() instead
> 
> Fixes: 6edbd6abb783d ("ma-buf: rename and cleanup dma_resv_get_excl v3")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org

Queued up, thanks for your patch (and the handy -next signifier in the
patch tag). I think Christian had the fix for this already, but queued up
in the next branch (for the 5.15 merge window, we're already prepping
stuff there to avoid late feature additions for 5.14), so applied yours
once more to the right tree.

Cheers, Daniel

> ---
>  include/linux/dma-resv.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210625.orig/include/linux/dma-resv.h
> +++ linux-next-20210625/include/linux/dma-resv.h
> @@ -212,7 +212,7 @@ static inline void dma_resv_unlock(struc
>  }
>  
>  /**
> - * dma_resv_exclusive - return the object's exclusive fence
> + * dma_resv_excl_fence - return the object's exclusive fence
>   * @obj: the reservation object
>   *
>   * Returns the exclusive fence (if any). Caller must either hold the objects

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
