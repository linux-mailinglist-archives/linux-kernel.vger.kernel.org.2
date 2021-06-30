Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99993B84AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhF3OIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhF3OHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:07:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636DC0613A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:05:14 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t80so3147039oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2uiTpNersMN8HJUWHLpDYZtWDK8S9orWhI2Zo6WiGs=;
        b=oayVw5cjlZgx6zdpVUV/6ceXodfrKK37WnFyxV6ofinTSexATHYcZMeMEYfgO94S38
         LrIuKOU15J44jXucd9mHWIUvABQlWuBZ1uFrsoJJ8i1WSNDjxaFJP86bNVPHJfsWkfzk
         W4/ztA0rGxKru1iizX9yserjaIrTr5+v0fvZEzPNwXF/8LVwK7kwf3vlsqwATPd3zRRo
         diANT295/Wx0s0BtrSqvRYSDdyvksduwJ6ixANG0nXLnMzndD3zGqIWNVPnHvuvqH6Lk
         ZGZZwi3sE/8n0ehh5CAc3AqjWv/q06FAmQMzTAtHfdPn3FuhIAN9+nHKolVJCAPVIFk5
         +dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2uiTpNersMN8HJUWHLpDYZtWDK8S9orWhI2Zo6WiGs=;
        b=MjCVLaBx6mDQOChHAEB5Ah5kZGVHHAcpGOCCeZV7CePJGUezRcAaV3hsZwlroZYSbF
         k7knQWaeq8X7jjbaLNu+wLb5gnTxjcPJytoFk5vJYMbHr9zvVfIEM4oach13LcQIFV1+
         tGkymBk8BuLvaUcDJZG60DRGDYmfa+D/XTLoCAb2snjjxJn8GfaCoBeiy4+KfdWrv2lZ
         98el2OZnSUE186Vnlyq3nCpJ8Rjhc8NJ9I55MBGPmdqtawx00Pf/lPBqk+e785ZRNJgS
         cKcXUhwBqDAD1OhrRnMSP9fW7evMW4zlwxbpITAOKAx9/QkX7mhqRDHq71BAj6l/KoKR
         IFVQ==
X-Gm-Message-State: AOAM533ChhFPPHwcXcvqddb2xptXnKb6YYec65FtUJqM0oPvMgCcO6Ug
        G628FD1XqNCLr4VIS/mDVX6T3aGm6hJ61oz8zGOtTA==
X-Google-Smtp-Source: ABdhPJxXxHM73q0alhjLm92ujxh0zyleB4LmD3cFkecIwgewq4J+x1hrDugM3DPKVsWS2IjCw4cghadZ0kF/VXmM/hk=
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr13788175oij.121.1625061912970;
 Wed, 30 Jun 2021 07:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210630135313.1072577-1-glider@google.com>
In-Reply-To: <20210630135313.1072577-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Jun 2021 16:05:00 +0200
Message-ID: <CANpmjNNWjks8fH6FBgjryEFm4z5vqn-ehyjXbcBj7x90hZpTjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kfence: move the size check to the beginning of __kfence_alloc()
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 at 15:53, Alexander Potapenko <glider@google.com> wrote:
>
> Check the allocation size before toggling kfence_allocation_gate.
> This way allocations that can't be served by KFENCE will not result in
> waiting for another CONFIG_KFENCE_SAMPLE_INTERVAL without allocating
> anything.
>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org # 5.12+
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kfence/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4d21ac44d5d35..33bb20d91bf6a 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -733,6 +733,13 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>
>  void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  {
> +       /*
> +        * Perform size check before switching kfence_allocation_gate, so that
> +        * we don't disable KFENCE without making an allocation.
> +        */
> +       if (size > PAGE_SIZE)
> +               return NULL;
> +
>         /*
>          * allocation_gate only needs to become non-zero, so it doesn't make
>          * sense to continue writing to it and pay the associated contention
> @@ -757,9 +764,6 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>         if (!READ_ONCE(kfence_enabled))
>                 return NULL;
>
> -       if (size > PAGE_SIZE)
> -               return NULL;
> -
>         return kfence_guarded_alloc(s, size, flags);
>  }
>
> --
> 2.32.0.93.g670b81a890-goog
>
