Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F364739154C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhEZKsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:48:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhEZKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:48:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id C08E91FD29;
        Wed, 26 May 2021 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622025645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkCGM14oSutPXR2oQe/Ky///EW/gzPaRnDOrBGh+z4k=;
        b=l0dGOAizp1uH2nbWe1n/07Jv6BlZPm3AjVt/hoYCn2eu6hcQmaKVc7cX9QsCCcbWBxRiZs
        Qo0pg6obADZXGSBVQk8vACeTEn8nxu3uYChZxx/RXEE3iziXWn/ya5Q3tRXvBlGiO5BeSa
        gt6TfiQnRm1oj83rZHheHRaOkF3gkik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622025645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkCGM14oSutPXR2oQe/Ky///EW/gzPaRnDOrBGh+z4k=;
        b=05EZKRMu172ocC8cN5HU987P8mLty1KhACWfX2Ex2tHmynPqV277FfAxCHoi1VcP8dbdHY
        6VUKaVREZbUmR3Bg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id A790D11A98;
        Wed, 26 May 2021 10:40:45 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] slub: Indicate slab_fix() uses printf formats
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
References: <20210526025625.601023-1-swboyd@chromium.org>
 <20210526025625.601023-4-swboyd@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <904b3ea3-c308-5807-4288-d6cd9109be5b@suse.cz>
Date:   Wed, 26 May 2021 12:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526025625.601023-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:56 AM, Stephen Boyd wrote:
> From: Joe Perches <joe@perches.com>
> 
> Ideally, slab_fix() would be marked with __printf and the format here
> would not use \n as that's emitted by the slab_fix(). Make these
> changes.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6168b3ce1b3e..bf4949115412 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -672,6 +672,7 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>  	va_end(args);
>  }
>  
> +__printf(2, 3)
>  static void slab_fix(struct kmem_cache *s, char *fmt, ...)
>  {
>  	struct va_format vaf;
> @@ -777,7 +778,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  						void *from, void *to)
>  {
> -	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x\n", message, from, to - 1, data);
> +	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
>  	memset(from, data, to - from);
>  }
>  
> @@ -1026,13 +1027,13 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
>  		slab_err(s, page, "Wrong number of objects. Found %d but should be %d",
>  			 page->objects, max_objects);
>  		page->objects = max_objects;
> -		slab_fix(s, "Number of objects adjusted.");
> +		slab_fix(s, "Number of objects adjusted");
>  	}
>  	if (page->inuse != page->objects - nr) {
>  		slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
>  			 page->inuse, page->objects - nr);
>  		page->inuse = page->objects - nr;
> -		slab_fix(s, "Object count adjusted.");
> +		slab_fix(s, "Object count adjusted");
>  	}
>  	return search == NULL;
>  }
> 

