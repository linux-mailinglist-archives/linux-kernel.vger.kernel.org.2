Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFE94015B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 06:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhIFEbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 00:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhIFEbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 00:31:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019CC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 21:30:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 22so5791298qkg.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vvzWX1VxxcUHUOP9/2aXTP+rW0zKame8C1AO3Rx+r/w=;
        b=rX0Ig+wxQ0/f+2fWW0QRafOX5QSukEZf7//CW++9MwHwR86AbsTnsIlIkTRtzNiDMw
         akc9m/xzr1AhQAzP7yp8tR89YwhFbOlUK4+ndREPhcYv5YLVrbo1SMPXKTEQdEILm0qc
         stC2AkixomaestdTIUTHLUxgUNHBBJlH0hOdYE3q9DSkGBHMbiZrU36aki1WJzzXtN8A
         FZ2/L8YLQ0LrAoJuHxVTnfSwkNpIA/mu6SGmF+rrh+31a4n/P6WvO0+W4U3AihCN2xrI
         117fdYDKmtGvuhdbIw3ueWCd9aJ9L/jQ6dbEBcRBVXi7Z0x44y9KmS1nKcQS86e0atns
         eAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vvzWX1VxxcUHUOP9/2aXTP+rW0zKame8C1AO3Rx+r/w=;
        b=TvB7usuBKJHh9fqpYoa5S42vVVd2mO02MlEelsFcBSNhqjTo43gRxDgRv0WSq+fWTW
         SC5YlFubbodIgR/9+31sS5BqlvjBcP+Dz/OBSzyUhGtmdP5VkXUXe6iLD0z3/6WOor8c
         lGSXXcNvHrqXuUOp7jsxufhKoOP7R7Dnsk504ZIQ23I+TPOK0RBRS+nNvE/9xg6Q+uqA
         0cG1snwWVt4GRhmF5hzCJF7SVOi84K/fOeVkJQeKCrEqW/nUHrzmo1ybuvCVcU6wgM1u
         vUeBEm0LkCsVU0uRvfQIHvMccqF2u0lLRVCZhY4ZaWzPlf9pIC75cFNbmswpIW1YSbm4
         oHdg==
X-Gm-Message-State: AOAM5311K6XlveLUMUEuqWAKPr/KvV6kdxD+OAnImpIqbsxlGtl+0i6x
        YIwVDFqtlTOnioSkFUKCIaFLww==
X-Google-Smtp-Source: ABdhPJyjPDFmglS6I6kGROXHnrT+IRxprFjndS3w+nZ8O1VQ2ufB7xV4g3s87MHqaFdAJd1qHlx25w==
X-Received: by 2002:a37:6253:: with SMTP id w80mr9632856qkb.237.1630902618264;
        Sun, 05 Sep 2021 21:30:18 -0700 (PDT)
Received: from xanadu.home (modemcable108.170-21-96.mc.videotron.ca. [96.21.170.108])
        by smtp.gmail.com with ESMTPSA id v24sm4587011qtq.17.2021.09.05.21.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:30:17 -0700 (PDT)
Date:   Mon, 6 Sep 2021 00:30:16 -0400 (EDT)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Len Baker <len.baker@gmx.com>
cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Prefer struct_size over open
 coded arithmetic
In-Reply-To: <20210905144054.5124-1-len.baker@gmx.com>
Message-ID: <65q16p1-7o22-pq77-38s8-9rr27p56s16n@onlyvoer.pbz>
References: <20210905144054.5124-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2021, Len Baker wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>


> ---
>  drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
> index af873a9be050..2990ac9eaade 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/dma.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
> @@ -223,7 +223,7 @@ static int hci_dma_init(struct i3c_hci *hci)
>  	}
>  	if (nr_rings > XFER_RINGS)
>  		nr_rings = XFER_RINGS;
> -	rings = kzalloc(sizeof(*rings) + nr_rings * sizeof(*rh), GFP_KERNEL);
> +	rings = kzalloc(struct_size(rings, headers, nr_rings), GFP_KERNEL);
>  	if (!rings)
>  		return -ENOMEM;
>  	hci->io_data = rings;
> --
> 2.25.1
> 
> 
