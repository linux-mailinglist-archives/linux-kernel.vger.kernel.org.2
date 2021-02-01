Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75830B20F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhBAVZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBAVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:25:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:24:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so10773351plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Stmza4ZljYVmGoBag2te1ro2TQptmpx4IjyAJp+jAIQ=;
        b=RTukz/I15+gomvoxURNPYBaO+iQPAJQ7j8SPTDDhq9UlRjA6hVVdohEFSjz2NLtxzu
         te4v/zkr2CANQypbMIiFFGvE+IgZAs8yeXiVvxbwVfWfqEyz9Kf5KYxTCiM11sw79LRr
         lERUPtgup7HUjlKpkk9qpnbY1hnUvEx6r1sbv0Qh1zEvsAeHMVdgD5IhyQ5QT5PO4aIG
         Ez1F850YBZsn3AqraRfPHUDSCungyeAeR3/3rRZAXBsP7wjLZipfQm89OmyCF9GAcO1t
         0eL5xJ7Cm8fAKBZWXSTWb3Fwe8M73WqUY17YBU+udWeGB0YtyDZ33tdpC9sbCxtdQH0s
         o+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Stmza4ZljYVmGoBag2te1ro2TQptmpx4IjyAJp+jAIQ=;
        b=GWSJd1OEKQLs24iWlprxYOlN0meG4jJWr10VBNeprce90yntV56jUbjQfTBNBgnwkC
         MoC5WA9kQa9m62dBRmYdO3djGS4Z0FAejCOngtFFO+j61WSog8nAdgKhzMQT9day/Ria
         XwiANHFa1xBQ1e6zKvTJGnUNSi/tW/3BUmdu//h+fPmNOREdzhd1aeOCBvkF4pvjweRC
         lJdYyQ8tCDq99l363gap+8nynqJFBx8CWvvYg1iqrvTbFqWTxnDLeSDxjnZuzXzpY38J
         n5NEDyfZ6qqblywPzu9JmfJ0tpXoW76pjNhNW6rGvaByqxmTmOq7blbr2DBgfxnsYWOX
         ljHA==
X-Gm-Message-State: AOAM530tRmPRSI3GRwn00XJuO386tdd27JfJYVW24OCwo3x/oE7S6jmn
        1Yfe/spao4Py1FoKWdsLwa7Lkg==
X-Google-Smtp-Source: ABdhPJx9CNcx+6r2+pPMJecmnoC4EI/ehFFZAVeJII0hBoOBWc2uuDTyC9S6RRznVKolCYuRY9Gbrg==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr19643118plr.73.1612214690922;
        Mon, 01 Feb 2021 13:24:50 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id y11sm18311381pfn.85.2021.02.01.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:24:49 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:24:49 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: update the COMPACT[STALL|FAIL] events
 properly
In-Reply-To: <1612187338-19100-1-git-send-email-charante@codeaurora.org>
Message-ID: <d9d1dd7b-1fe7-67b6-6ba4-fb1a6faa8fae@google.com>
References: <1612187338-19100-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021, Charan Teja Reddy wrote:

> By defination, COMPACT[STALL|FAIL] events needs to be counted when there

s/defination/definition/

> is 'At least in one zone compaction wasn't deferred or skipped from the
> direct compaction'. And when compaction is skipped or deferred,
> COMPACT_SKIPPED will be returned but it will still go and update these
> compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
> is counted without even trying the compaction.
> 
> Correct this by skipping the counting of these events when
> COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
> the unnecessary try into the get_page_from_freelist() when compaction is
> not even tried.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 519a60d..531f244 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  	psi_memstall_leave(&pflags);
>  
> +	if (*compact_result == COMPACT_SKIPPED)
> +		return NULL;
>  	/*
>  	 * At least in one zone compaction wasn't deferred or skipped, so let's
>  	 * count a compaction stall

This makes sense, I wonder if it would also be useful to check that 
page == NULL, either in try_to_compact_pages() or here for 
COMPACT_SKIPPED?
