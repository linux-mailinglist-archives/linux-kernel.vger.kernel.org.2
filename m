Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5042841C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhJJWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJJWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:51:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76907C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:49:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y7so3663296pfg.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8EcW2ShAuYWF0QWBJ5C9v70rQEiQ/Ji8vWsPGRffTa4=;
        b=tIpCjTWtXKNGQJUpE6NPQfM2QPMkw6oTY7R71q3/D/7RUZDQ+x6ZY9899Lp7OOGdru
         2uuCSCilLNWMitn+XVpEqCq5xFUErtDMqivNCsdQi5proI88u6r373VQpDPSz11lQfFy
         Gt/BO7j12Pi5XQb1pRVqi3CPufpn1mZ9h+XvBTGa33EzpLmkd6tv4wvAGF2uU7OO8D13
         dCS2UAmFLRhCPsqkmRwYffez9C+GBxjZkhuylxs+O4v2YG7NtiM8kN/6EojBYtuCV7MD
         eku6uoMEDF1jJGVYYS15NaM0vCNZVpn3GuAqfv9yqWh90EUYq3zYZpxQRoAJEwHFOTMT
         Ehig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8EcW2ShAuYWF0QWBJ5C9v70rQEiQ/Ji8vWsPGRffTa4=;
        b=iDyOSt4BKe1xwgKlvQLOSGCefJj0m53c+vpp3Nfrl6p5spnioWcv+Bdo6FqkmyhcMe
         5B/0UtLeTBVLNxiVIU+saBTImPfmMDsjISn25GoZC4T92feHwUiRfv0LmR/TF/Yp3lAB
         FvAqLezQlNhQPA45CtX4nDMtZJWJY+kbuL1MPaXJS8VURpWD6SqQDX6gKGai9f+pVIbR
         Ra9XnipEszj8aj20rE5EnrLJsm0pdbhO7lm5E38f4ogFhDC0ysDttmr6gdrXGlq0ahg4
         JkAg5ToAaPcSe5zX00zcDxRRN2H+ldW89aoCtD0FMqs9T5eQnPRrO7tb2Og/L7ws9rHe
         76qQ==
X-Gm-Message-State: AOAM531Gi9hKEx2QRAVXoCRvdNovhE2AJxx70r3r0btmAlnHWAOJmtfG
        uU1ZIS7wPE6/Ir4WOT6q5XcszQ==
X-Google-Smtp-Source: ABdhPJwlNO90Xh8cmYucSShJXLf+PIqFNTI8K4kHV+potciLWvaDJvnKsgMzBGTjNB2bPrBOAzjYsg==
X-Received: by 2002:a05:6a00:230e:b0:44c:4f2d:9b00 with SMTP id h14-20020a056a00230e00b0044c4f2d9b00mr22150072pfh.24.1633906148786;
        Sun, 10 Oct 2021 15:49:08 -0700 (PDT)
Received: from [2620:15c:17:3:3280:1d46:7d55:1fbb] ([2620:15c:17:3:3280:1d46:7d55:1fbb])
        by smtp.gmail.com with ESMTPSA id u24sm5403060pfm.85.2021.10.10.15.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 15:49:08 -0700 (PDT)
Date:   Sun, 10 Oct 2021 15:49:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, slub: Use prefetchw instead of prefetch
In-Reply-To: <20211008133602.4963-1-42.hyeyoo@gmail.com>
Message-ID: <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:

> It's certain that an object will be not only read, but also
> written after allocation.
> 

Why is it certain?  I think perhaps what you meant to say is that if we 
are doing any prefetching here, then access will benefit from prefetchw 
instead of prefetch.  But it's not "certain" that allocated memory will be 
accessed at all.

> Use prefetchw instead of prefetchw. On supported architecture

If we're using prefetchw instead of prefetchw, I think the diff would be 
0 lines changed :)

> like x86, it helps to invalidate cache line when the object exists
> in other processors' cache.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3d2025f7163b..2aca7523165e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -352,9 +352,9 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  	return freelist_dereference(s, object + s->offset);
>  }
>  
> -static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> +static void prefetchw_freepointer(const struct kmem_cache *s, void *object)
>  {
> -	prefetch(object + s->offset);
> +	prefetchw(object + s->offset);
>  }
>  
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> @@ -3195,10 +3195,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  			note_cmpxchg_failure("slab_alloc", s, tid);
>  			goto redo;
>  		}
> -		prefetch_freepointer(s, next_object);
> +		prefetchw_freepointer(s, next_object);
>  		stat(s, ALLOC_FASTPATH);
>  	}
> -
>  	maybe_wipe_obj_freeptr(s, object);
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
> -- 
> 2.27.0
> 
> 
