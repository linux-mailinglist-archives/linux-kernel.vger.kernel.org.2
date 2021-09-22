Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF44146C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhIVKn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:43:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhIVKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:43:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50FDE222B3;
        Wed, 22 Sep 2021 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632307317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/KdFtGnFgvFLnPvexSZ3NZW6o2MIKdALXdUUIg4l9Y=;
        b=Y+pbaFIcyd9c4gAYy2TlVkve2o9L+fIrdc8RRbGHN4tuqGwKnGJSLLTh/ggaHtWKcMNJ5a
        1Ww00q97r9Sj2FcsPlerpnOyE+7gNCDE13djg/atYYGxJHfhVm49pJ+12a0+gzAQkpOKj0
        Ysjmd9Sp6ixkpvLwLxbWRM0uzD5U8D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632307317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/KdFtGnFgvFLnPvexSZ3NZW6o2MIKdALXdUUIg4l9Y=;
        b=qJgOTu3ovGbLFtkxtTu+uw7UwZPCIPexw7dmS5HERUN0RsH4gGmN2VgQnn2sjP4zrrkHS8
        PsXUV8HAy2Dfn1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32B6C13D69;
        Wed, 22 Sep 2021 10:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 08K8C3UIS2FhXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Sep 2021 10:41:57 +0000
Message-ID: <80d9ecc9-77db-e355-0e95-50ee8698694b@suse.cz>
Date:   Wed, 22 Sep 2021 12:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] mm/smaps: Use vma->vm_pgoff directly when counting
 partial swap
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210917164756.8586-1-peterx@redhat.com>
 <20210917164756.8586-3-peterx@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210917164756.8586-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 18:47, Peter Xu wrote:
> As it's trying to cover the whole vma anyways, use direct vm_pgoff value and
> vma_pages() rather than linear_page_index.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/shmem.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 96ccf6e941aa..d2620db8c938 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -856,9 +856,8 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
>  		return swapped << PAGE_SHIFT;
>  
>  	/* Here comes the more involved part */
> -	return shmem_partial_swap_usage(mapping,
> -			linear_page_index(vma, vma->vm_start),
> -			linear_page_index(vma, vma->vm_end));
> +	return shmem_partial_swap_usage(mapping, vma->vm_pgoff,
> +					vma->vm_pgoff + vma_pages(vma));
>  }
>  
>  /*
> 

