Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312AE4153DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhIVXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:25:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:23:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 72so15634858qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4ve+kgYx5Oh6rv9BoUmZuBfQgYXTlo8LTFBOqY2AyN4=;
        b=Z72Fms7CWCB72nP1xxetL05b7bwOYEMmUrTOOfwWgKLaJZ74N4FyRNI6mouezE9v6r
         luAjE5vGyRbNwU/YNQ0tohp1hGlgrhqBh6MTjXWTklydXmmnXNnPQEm6Iwvvp0PTAm5K
         p2wj4gb4PM3grml26lDxrFP1f23UF1BJcRtlbLltsTBhLLz8xMU6SLKCTKSTSJw6uvg/
         6myvNFr691ZYXHNtJMftUP3hQKxmdiqTU1Hk6LUIh+OSntzSLWZx6uWZZoC+eozrS4FT
         3MMuozalKAQChnaXP4cHrl9lReKY6mnw8XkYTlg3cyclke+C7EpgMSCPPavcBA0c9/He
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4ve+kgYx5Oh6rv9BoUmZuBfQgYXTlo8LTFBOqY2AyN4=;
        b=x0OCHM4K5xIf2LraqLQfevywDpF/wBk8nP95gTc4GdpMB/6LihAxxlFntx2ONLKAOF
         VOVObfJJhh9mbxyNAUrUwZgSuVr44D+pJPJM1hdfCm1WS8O/ideCXcgGPY4byUWkqpdy
         lAFBZ4zZD0Er4s7J4uv0Ufgf2DU5x6PcfHyXpv4e2edvzAN5c7LtKvurmtNs9f1k38pg
         D6wf78j4UdN4QtuZPas954BHhhxjThOIRI1HM7zlZqGoXrUPQNnDqUkdZ3boANoD2JGC
         V9zp5BkEZRmiY9PCiuRLpsbGkTyX/CIFOlMnqGTHG3v/rflbYutMGe25b2JTPsAheg7h
         cvjQ==
X-Gm-Message-State: AOAM532/ZUo+jWNxyxrD/FBQR/sQCP9JFgYtoj/99W0PooYf+dS+hTHX
        vvFhV0lc4LE71VPLKanUltsojA==
X-Google-Smtp-Source: ABdhPJwhEulK8miS6e3SH3seE2dA5SPup+dUF7L8NGyrwxE2FpXPIpWksTpODFyLzRCFFtcXW5Ux+A==
X-Received: by 2002:a37:681:: with SMTP id 123mr1925615qkg.508.1632353023903;
        Wed, 22 Sep 2021 16:23:43 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c17sm2560312qtq.42.2021.09.22.16.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:23:43 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:23:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Eric Dumazet <eric.dumazet@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: do not acquire zone lock in is_free_buddy_page()
In-Reply-To: <20210922152833.4023972-1-eric.dumazet@gmail.com>
Message-ID: <26db20dd-8e18-e68a-adb-adf171d62bf8@google.com>
References: <20210922152833.4023972-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Grabbing zone lock in is_free_buddy_page() gives a wrong sense of safety,
> and has potential performance implications when zone is experiencing
> lock contention.
> 
> In any case, if a caller needs a stable result, it should grab zone
> lock before calling this function.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Hugh Dickins <hughd@google.com>

Yes indeed, and you have already explained it well above: thanks.

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/page_alloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e115e21524739341d409b28379942241ed403060..cd8a72372b047e55c4cde80fe6b7a428d7721027 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9354,21 +9354,21 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  }
>  #endif
>  
> +/*
> + * This function returns a stable result only if called under zone lock.
> + */
>  bool is_free_buddy_page(struct page *page)
>  {
> -	struct zone *zone = page_zone(page);
>  	unsigned long pfn = page_to_pfn(page);
> -	unsigned long flags;
>  	unsigned int order;
>  
> -	spin_lock_irqsave(&zone->lock, flags);
>  	for (order = 0; order < MAX_ORDER; order++) {
>  		struct page *page_head = page - (pfn & ((1 << order) - 1));
>  
> -		if (PageBuddy(page_head) && buddy_order(page_head) >= order)
> +		if (PageBuddy(page_head) &&
> +		    buddy_order_unsafe(page_head) >= order)
>  			break;
>  	}
> -	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	return order < MAX_ORDER;
>  }
> -- 
> 2.33.0.464.g1972c5931b-goog
