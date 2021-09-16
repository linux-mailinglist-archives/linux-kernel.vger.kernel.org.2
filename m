Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245840ED3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhIPWTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:19:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55096 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbhIPWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:19:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 405AD22293;
        Thu, 16 Sep 2021 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631830698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBzVatUHKFu0Cyk7pN9Ddz6kBstECbffWfHI3HWpgnw=;
        b=MzpzwYmHK6IHe/Wggxw00m7dOgq0DG4OMOxiM6R+h5+ObovCqHjt6Zgq77+uD2D632RiO2
        LBrEiD0wg4qdy/VMn0bPMVBbrWSDH7jUgsvDuKnrfM2bzNlxbudufixfGuFZkdnvHX0Ez3
        HraWPUwJ6EBv5cpi52RE3Uir3glCumc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631830698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBzVatUHKFu0Cyk7pN9Ddz6kBstECbffWfHI3HWpgnw=;
        b=XNR4lite8fITY4tYX0a2WIgmLRwMIqxR2LfY68Wg7YGUP83o2apY6s4r1dJ5f/+WMsM3wm
        Uhm1EWl3f7GK8QBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FB4A13D6B;
        Thu, 16 Sep 2021 22:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1wmjBqrCQ2GuVQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Sep 2021 22:18:18 +0000
Subject: Re: [PATCH] mm/smaps: Use vma->vm_pgoff directly when counting
 partial swap
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
References: <20210916215839.95177-1-peterx@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <738511ae-b253-9927-eca1-97d621d9f149@suse.cz>
Date:   Fri, 17 Sep 2021 00:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210916215839.95177-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 11:58 PM, Peter Xu wrote:
> linear_page_index(vma, vma->vm_start) of a shmem vma is exactly vm_pgoff.

Could you use "vma->vm_pgoff + vma_pages(vma)" instead of the other
linear_page_index() then?

But now I wonder, is smaps_pte_hole() broken? it calls
shmem_partial_swap_usage with addresses, not pgoffs?

> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/shmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 96ccf6e941aa..2aef5b8e17c9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -856,8 +856,7 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
>  		return swapped << PAGE_SHIFT;
>  
>  	/* Here comes the more involved part */
> -	return shmem_partial_swap_usage(mapping,
> -			linear_page_index(vma, vma->vm_start),
> +	return shmem_partial_swap_usage(mapping, vma->vm_pgoff,
>  			linear_page_index(vma, vma->vm_end));
>  }
>  
> 

