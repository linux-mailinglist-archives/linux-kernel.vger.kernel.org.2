Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4061F3E02FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhHDOXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbhHDOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:23:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8BCC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:22:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g30so498651lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWlPdL6DwUB6mJRKo0+xi01KggPqUO2/jhQbASI+2FE=;
        b=QE89PTFODc67XC5H0kcbNIHy9cHlhvZkaAEzK2h6T5fIoEU3d/4E71kndL/f8s0tX+
         JJ2IIyqzYAV0j2e/4ewwAvS4XIxTlCfeK/XRJ/YxRCkeu+mNPzOr1xke1fPqRbdyAR4B
         HpxGTKCP36gIfxXsUcVm/lgcHiih0hCBskkrIwgV3F6DfSmJA40eJiRToQYPcUYR0eyT
         RCbPpYju7Y4YRRRqtxU07ogL97sP0o4V1NsUx2pYjrfcgP0VetrNVpj/ytQszajPV9MH
         6wty0FiHYQ32pTJpHGrmLfDORsARUr2M1ZV8qaW76tJn4/ZHo3J7Cc8u8NvjL/6y+gTn
         ZYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWlPdL6DwUB6mJRKo0+xi01KggPqUO2/jhQbASI+2FE=;
        b=apuW8jf2Y39Xu9SxfOP5ldDxus8iHj0GiQL2lEXkWN7doaz4zYowkIHRqkdXHvomef
         IBlEJiFvtEe6+1r5VRkBG0vPqqtfD8ubB5f6LsGEdDUV3383Vw72OZt9+7ZIjpY5bCzO
         hdtLxdBpnlOdD24MtGpv3B7aa/pOb0oZaliZCjiRO29mQGOarl1m65kyilotLWy1ffcy
         ZO728y6WNlaT2TE3n+uiCYWNfbYFYBg0rEIidZiHf+/+7gKiK3Y6HS28nrLBd8wxcDyk
         SLdQ9PE6UomXQd+Q9BR19ueX0xSA+sjMXR3b7qvIGIoqwrORqhkC7Z2ZOYXBSHmOifoz
         Wxeg==
X-Gm-Message-State: AOAM532HB0DKvt3Ris+nmqfR2Uv/CZkZJFEnp3JRJMg1FuZX40JWa79m
        aFpqj8RcTG7BFGeEWR1jMO3BLQ==
X-Google-Smtp-Source: ABdhPJwmL8YC08a1GHI5b6vVSDE4TmS9HGaEeEH0JAy+4KfiRyfMQ4fATRlflfmdnGgIK/c1Hjc6kw==
X-Received: by 2002:a05:6512:3481:: with SMTP id v1mr3277279lfr.325.1628086973453;
        Wed, 04 Aug 2021 07:22:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o10sm211359lfl.129.2021.08.04.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:22:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 00CD6102BC1; Wed,  4 Aug 2021 17:22:57 +0300 (+03)
Date:   Wed, 4 Aug 2021 17:22:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH 2/3] mm: free zapped tail pages when splitting isolated
 thp
Message-ID: <20210804142257.tsgzpfc3zq7um7iu@box.shutemov.name>
References: <20210731063938.1391602-1-yuzhao@google.com>
 <20210731063938.1391602-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731063938.1391602-3-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:39:37AM -0600, Yu Zhao wrote:
> @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  			continue;
>  		unlock_page(subpage);
>  
> +		/*
> +		 * If a tail page has only two references left, one inherited
> +		 * from the isolation of its head and the other from
> +		 * lru_add_page_tail() which we are about to drop, it means this
> +		 * tail page was concurrently zapped. Then we can safely free it
> +		 * and save page reclaim or migration the trouble of trying it.
> +		 */
> +		if (list && page_ref_freeze(subpage, 2)) {
> +			VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> +			VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> +			VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> +
> +			ClearPageActive(subpage);
> +			ClearPageUnevictable(subpage);

Why touch PG_Active/PG_Unevictable?

> +			list_move(&subpage->lru, &pages_to_free);
> +			nr_pages_to_free++;
> +			continue;
> +		}
> +

-- 
 Kirill A. Shutemov
