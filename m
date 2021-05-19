Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AD3891E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354809AbhESOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348629AbhESOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:50:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:49:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id eb9so6894847qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1cKAWledUKzuSk9jerfXLCilJo3n8tNR9Bz+0Q0Vh4=;
        b=te0/qxL9TcrFvl1dO4HGMr+lXCD26GOdpn+KYDCZbm8ciHnla/km/LauSremC2iJvb
         Q0LcXNJyQp01XRb+HKV73QLLC75DiZPJwr+WGnlwAfV8+/sQVQLc71Oa0xOLg6NgB3w5
         zDPzBf2eu3hzSuyyNB4B+vAxQpoy102mdklXqhkU21Zw12cm0KFeZY9gT20JEgZ28lep
         s4qReOOk35qhBKaENcGMQGApnLlGDLBI9PAKpqePbXEm+BDqFufLJaMJnDj48xoZuGiZ
         +w/kXclpVAmCEKz8dJf0V0WA86kJAttGVbNRv1G6mqWkbzbslnFdZRzWMekbTZtJ0dzc
         s4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b1cKAWledUKzuSk9jerfXLCilJo3n8tNR9Bz+0Q0Vh4=;
        b=OG64oWftIf17dZeH53tocOvx6ol6PhxhJyu6KjASQrYQ0DwujK29OKSkU1qGqYWImn
         dH7gBhP15Wj3G7zOd5fAEGGf/hunyCzSWArtm/iKlVfhbHrIsFGTuuJL+/IcbYenOkKS
         TgI7yFyRyUSp79ICwKeh4ekjaDril89x25IkeJlxudhPGDgyvRK2BRI0HC9WXM1fJHqI
         kCDJYScMJEY/+UJ5w4bQwLHKUJyCqCAsnw913gV0dlJE6ENAQHY++jmpqcb8OYk+Iyqp
         QR9/nBVaIXh4FgEwuHefliIvs4V6UYxxMM3Md2QJwwaZMLdvv6cPtcjgI5/bH6uMshEv
         PcIg==
X-Gm-Message-State: AOAM533MqiXsQQzj2Rpc/RTS8IVlH67gCq+wGq1YOAmakPNcZtOA8Ltr
        lP1H8eVewahZzo7Clj/Tf/u/Ag==
X-Google-Smtp-Source: ABdhPJzCjYfPDXZjtVIoZuZSY3z3AIvZYlCHTyKWoFxc6mHjeHmiZ4aFQCmZCupvM/XdurrKzdjmgg==
X-Received: by 2002:a0c:aa1d:: with SMTP id d29mr8663690qvb.47.1621435776189;
        Wed, 19 May 2021 07:49:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a4dd])
        by smtp.gmail.com with ESMTPSA id j6sm15214930qti.4.2021.05.19.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:49:35 -0700 (PDT)
Date:   Wed, 19 May 2021 10:49:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
Message-ID: <YKUlfeAiq/vv+dHl@cmpxchg.org>
References: <20210519013313.1274454-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519013313.1274454-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index b83f734c4e1d..2b6847f4c03e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  				munlock_vma_page(old_page);
>  			unlock_page(old_page);
>  		}
> +		if (page_copied && PageSwapCache(old_page) &&
> +		    !page_mapped(old_page) && trylock_page(old_page)) {
> +			try_to_free_idle_swapcache(old_page);
> +			unlock_page(old_page);

If there are no more swap or pte references, can we just attempt to
free the page right away, like we do during regular unmap?

		if (page_copied)
			free_swap_cache(old_page);
		put_page(old_page);
