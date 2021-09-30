Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25441D559
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbhI3IX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:23:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37732 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349083AbhI3IX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:23:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F0DDF1FE3A;
        Thu, 30 Sep 2021 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632990134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2lV+mK2M7/NdUSiHiSSKoGAAQWF1PWc4g6uu1e2Vpk=;
        b=NmHM2p/H9RmlpIS4pPmVitWptYM1NJYJWjHCPiSwLS4Yz1/xD6urgKJZxoeEAj2cCpCC7q
        z0Ion9ov98vnSS0L2D3jl3NkgfBtCsude8gecww9rIKbnzE4TVFVIc4qAT3n3f6AEDZvA3
        oA+nDgCJAgLg4jDXJFAy8jTChajF2Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632990134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2lV+mK2M7/NdUSiHiSSKoGAAQWF1PWc4g6uu1e2Vpk=;
        b=lyV0YFiFjWMtwdsfSTlf+dynVDBJWSLoYopHvFyN6PNbxYVQ22fEYyRUc9GHQrKRJ1GLjL
        e8gkjrK3Q0Xqx3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1063140D0;
        Thu, 30 Sep 2021 08:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AolJMrZzVWEtLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 30 Sep 2021 08:22:14 +0000
Message-ID: <a6919b32-e789-7ed9-bab7-8235638e9c12@suse.cz>
Date:   Thu, 30 Sep 2021 10:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] mm: remove useless lines in enable_cpucache()
Content-Language: en-US
To:     Shi Lei <shi_lei@massclouds.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210930034845.2539-1-shi_lei@massclouds.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210930034845.2539-1-shi_lei@massclouds.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 05:48, Shi Lei wrote:
> These lines are useless, so remove them.

I would clarify that they are useless after commit 10befea91b61 ("mm:
memcg/slab: use a single set of kmem_caches for all allocations")



> Signed-off-by: Shi Lei <shi_lei@massclouds.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 4d826394ffcb..01775fe0e002 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3900,8 +3900,6 @@ static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
>  	if (err)
>  		goto end;
>  
> -	if (limit && shared && batchcount)
> -		goto skip_setup;
>  	/*
>  	 * The head array serves three purposes:
>  	 * - create a LIFO ordering, i.e. return objects that are cache-warm
> @@ -3944,7 +3942,6 @@ static int enable_cpucache(struct kmem_cache *cachep, gfp_t gfp)
>  		limit = 32;
>  #endif
>  	batchcount = (limit + 1) / 2;
> -skip_setup:
>  	err = do_tune_cpucache(cachep, limit, batchcount, shared, gfp);
>  end:
>  	if (err)
> 

