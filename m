Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E13C19B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 21:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhGHTVk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jul 2021 15:21:40 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38523 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:21:37 -0400
Received: by mail-ed1-f42.google.com with SMTP id x12so10104944eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 12:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Lcf7pj0lQYGzDh3Xt/SAhA9pFGz1V15H7OOqaDQJa10=;
        b=uTjM/LKlT83bLSUbTuGN68xO6UEPLSXW+DsYtel9cgqrCDIbLDjwafp7319Sjq//hO
         21yqGpTAsApj4ob8F1ciysuA5sHvChipcD/fTc8PsvrIhnXaWN1GXt3c0aUdkSrXBMTy
         EkFIoymE7WcR1P/mSZPZr2bIR/Us11MeloQeWEkrB1QHoe7dtMlNox+3CoTp/lcNsjxS
         nZMJ+ee3SIG5zk0k862fzPfGKtjC1KlOSmXdtLrL67uUtUBTWm5qu/hDeZG86mvoyiuJ
         0cJENE3vsBFmjKt8P9ktqkNv3vHQScMizQufkseURzZqaCR7avjCVAK45f3c9+GQHGk/
         2t4g==
X-Gm-Message-State: AOAM532Cpjks/Uxsx6ufXJv1w/W/wTfEa08PdUZhqPdvkU7s6nJST2rx
        tjisMdJN+P70MGF54W077Bs=
X-Google-Smtp-Source: ABdhPJzTzDiPQg0MEKqX0YmNU80wQTamYWiHaJ1ONnOcCcdx+KwrglYjwavDp/GXKH43VosCsZybgw==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr40422671edt.152.1625771933841;
        Thu, 08 Jul 2021 12:18:53 -0700 (PDT)
Received: from localhost (mob-2-41-76-128.net.vodafone.it. [2.41.76.128])
        by smtp.gmail.com with ESMTPSA id b23sm1719733edy.44.2021.07.08.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:18:53 -0700 (PDT)
Date:   Thu, 8 Jul 2021 21:18:44 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/14] mm/page_alloc: Make should_fail_alloc_page a
 static function should_fail_alloc_page static
Message-ID: <20210708211648.13659bb5@linux.microsoft.com>
In-Reply-To: <20210520084809.8576-4-mgorman@techsingularity.net>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
        <20210520084809.8576-4-mgorman@techsingularity.net>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 09:47:58 +0100
Mel Gorman <mgorman@techsingularity.net> wrote:

> make W=1 generates the following warning for mm/page_alloc.c
> 
>   mm/page_alloc.c:3651:15: warning: no previous prototype for
> ‘should_fail_alloc_page’ [-Wmissing-prototypes] noinline bool
> should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> ^~~~~~~~~~~~~~~~~~~~~~
> 
> This function is deliberately split out for BPF to allow errors to be
> injected. The function is not used anywhere else so it is local to
> the file. Make it static which should still allow error injection
> to be used similar to how block/blk-core.c:should_fail_bio() works.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..26cc1a4e639b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3648,7 +3648,7 @@ static inline bool
> __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order) 
>  #endif /* CONFIG_FAIL_PAGE_ALLOC */
>  
> -noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int
> order) +static noinline bool should_fail_alloc_page(gfp_t gfp_mask,
> unsigned int order) {
>  	return __should_fail_alloc_page(gfp_mask, order);
>  }


Hi Mel,

It seems that this breaks builds with CONFIG_DEBUG_INFO_BTF=y.
Maybe that warning was a false positive because
should_fail_alloc_page() is referenced via a macro?

I proposed to revert it, feel free to propose another fix.

Regards,
-- 
per aspera ad upstream
