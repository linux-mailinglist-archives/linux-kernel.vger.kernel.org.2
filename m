Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC83881F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352430AbhERVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235250AbhERVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621372604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yuOc2aL9R33jaIl7mlMHhqH6hbm5A0t+kn6e6OKsWE=;
        b=VnmNKuXlbyVyxs8/KgMR3FJIb6fYWM2pKd6bjxL/tErwYwsLaTCuDyRMPc3OMZBJj0Gkwh
        EMtoCIfiPeDfNK6YM8GqGkrYlp+8OukqIInPmmDybzvuudVaIf+gtZDqLxRsB4WsU8CQPX
        iFD6UE3q+QTqjn2U02iM8uO+hsxXmoY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-iQBpKZNfOxiUEgP-pYRMgg-1; Tue, 18 May 2021 17:16:42 -0400
X-MC-Unique: iQBpKZNfOxiUEgP-pYRMgg-1
Received: by mail-qt1-f198.google.com with SMTP id b17-20020ac854110000b02901f279c73d75so4460680qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yuOc2aL9R33jaIl7mlMHhqH6hbm5A0t+kn6e6OKsWE=;
        b=uZD7nI/zw+Jz2/z80xbu88iJhd16TyILz1Vt55toe2sdPWWU6o6Yh8iR7DrDrMzUR+
         O3595b8aNRWn3zDcPvsmKIdcKLLNUcmbaax+QyBO0g6N4WHhlLpb40jIuGXcwDQ9uKgr
         fdgN2Zt099KCMqaN/RGgzGoDXUl4JGcsORvX48uBpV6WEp792XWIQN7ckFtQOgbXx3jE
         zoEicmDmyd67vrcst8UH79oc3mtfbf/FadghvgR10hQkK1sxYKYHwIEYeGNsDkhJZqWh
         +WC6sZjZpAapexxoOdgSLTSFYHvV4KTKSKWACYhbdnibBAkPZ6fYDSNuNms3B7iOjM40
         B7TQ==
X-Gm-Message-State: AOAM533Cn3Phh/r06ETtFib67VCPK+ZZ1Rq3JnEd0oX/IE89CdGYxgG3
        mqO44hG8oUF82LNokVBl8A1ONsugiLCYkQ6MYn9MivRcHr/I+XVhSjOTwXWzMlWd/P7G0PqYKC4
        oLGF++hT41qUETFLCyh+SRCX9
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr7111156qta.172.1621372601481;
        Tue, 18 May 2021 14:16:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7CflObEdpN93nC2c9rCnQMv5qBohaNF3R0O5eiJLrnt/E6MHpUTkD6EfDzN6tiXMS/VwRag==
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr7111124qta.172.1621372601142;
        Tue, 18 May 2021 14:16:41 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id v66sm13507150qkd.113.2021.05.18.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:16:40 -0700 (PDT)
Date:   Tue, 18 May 2021 17:16:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKQutvAa3NlgGaMm@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407084238.20443-6-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:42:35PM +1000, Alistair Popple wrote:

[...]

> +static bool try_to_protect(struct page *page, struct mm_struct *mm,
> +			   unsigned long address, void *arg)
> +{
> +	struct ttp_args ttp = {
> +		.mm = mm,
> +		.address = address,
> +		.arg = arg,
> +		.valid = false,
> +	};
> +	struct rmap_walk_control rwc = {
> +		.rmap_one = try_to_protect_one,
> +		.done = page_not_mapped,
> +		.anon_lock = page_lock_anon_vma_read,
> +		.arg = &ttp,
> +	};
> +
> +	/*
> +	 * Restrict to anonymous pages for now to avoid potential writeback
> +	 * issues.
> +	 */
> +	if (!PageAnon(page))
> +		return false;
> +
> +	/*
> +	 * During exec, a temporary VMA is setup and later moved.
> +	 * The VMA is moved under the anon_vma lock but not the
> +	 * page tables leading to a race where migration cannot
> +	 * find the migration ptes. Rather than increasing the
> +	 * locking requirements of exec(), migration skips
> +	 * temporary VMAs until after exec() completes.
> +	 */
> +	if (!PageKsm(page) && PageAnon(page))
> +		rwc.invalid_vma = invalid_migration_vma;
> +
> +	rmap_walk(page, &rwc);
> +
> +	return ttp.valid && !page_mapcount(page);
> +}

I raised a question in the other thread regarding fork():

https://lore.kernel.org/lkml/YKQjmtMo+YQGx%2FwZ@t490s/

While I suddenly noticed that we may have similar issues even if we fork()
before creating the ptes.

In that case, we may see multiple read-only ptes pointing to the same page.  We
will convert all of them into device exclusive read ptes in rmap_walk() above,
however how do we guarantee after all COW done in the parent and all the childs
processes, the device owned page will be returned to the parent?

E.g., if parent accesses the page earlier than the children processes
(actually, as long as not the last one), do_wp_page() will do COW for parent on
this page because refcount(page)>1, then the page seems to get lost to a random
child too..

To resolve all these complexity, not sure whether try_to_protect() could
enforce VM_DONTCOPY (needs madvise MADV_DONTFORK in the user app), meanwhile
make sure mapcount(page)==1 before granting the page to the device, so that
this will guarantee this mm owns this page forever, I think?  It'll simplify
fork() too as a side effect, since VM_DONTCOPY vma go away when fork.

-- 
Peter Xu

