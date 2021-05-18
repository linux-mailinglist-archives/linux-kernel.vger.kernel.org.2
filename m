Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349B4386FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbhERCSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245107AbhERCSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621304257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHUED2xywhieoA8Ohgqwa/BFwS5IrraVCcyW37p8oEc=;
        b=HAxnpIeBAIgJ2cFctu//SWzGseRHbxULUCXTn6S3D1aEZCJnKItOGl0sX/uCMDVNTF8XgH
        iW+tWZzT46YNUKe49wkGl5iWQwna8b11bN2BINLH39Zd7f3i5a3LKa00hOMCK+WKx3qtGO
        vTVyNS5T7oglx0nJM7vxEkEhneqonPs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-0md_fnNGMn6neYGews8OqA-1; Mon, 17 May 2021 22:17:35 -0400
X-MC-Unique: 0md_fnNGMn6neYGews8OqA-1
Received: by mail-qv1-f70.google.com with SMTP id fi6-20020a0562141a46b02901f064172b74so1371888qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SHUED2xywhieoA8Ohgqwa/BFwS5IrraVCcyW37p8oEc=;
        b=LbeZzru8NnJkbjtfPvTa0UAYHxyNUs9dhkweujzz+esiHzfLkkvbR5rzHbYR8Zx+tu
         ILxho4mylvPSF+7bh2gmItu3y+It0fYJRG6IF9Ubo1x16ImqlZ4h9T65GU1NJ/dyq2WG
         L8UaY12tlB9zQAQeuM1y+oaIh0dfhnmUma0cqurVvGRD6/RLSjHjYXWimNLIw8PnX44g
         /7wyOJMApvS3m0YjF0KTeFDviI7CacRomdwOBt5pOBOoCDFQ+aq7MBE0orVe/KbONb3x
         AYci01gISRoL+uFIcitcn5u0rXfpWkldvtkmNeURauJ+ET4gDNAaORx5Z+FUqH0OvCcg
         /FYQ==
X-Gm-Message-State: AOAM531XqOVII4C1NtmuA6wZwI776kpm0yYgzozbHaviH81snalvTXi/
        jmCyLh6mtvI3LF7PjB+wpCluBNc+l3pXSnlWNb3x44uhUi+K1Tr901d03zgoajFkuKL8tE8i/rm
        RC1JLwb/5eQmPU6snA1lec+iU
X-Received: by 2002:a37:acc:: with SMTP id 195mr3056560qkk.237.1621304254983;
        Mon, 17 May 2021 19:17:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvfhDruyVRENBywFHKAF09zhJc/VYjDjiU6UtKjssWV4m2MY09oz2Ie4CFZZ05uo8IZIWTfA==
X-Received: by 2002:a37:acc:: with SMTP id 195mr3056543qkk.237.1621304254755;
        Mon, 17 May 2021 19:17:34 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q185sm11488655qkd.69.2021.05.17.19.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 19:17:34 -0700 (PDT)
Date:   Mon, 17 May 2021 22:17:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 1/8] mm: Remove special swap entry functions
Message-ID: <YKMjvKGIHdwQN2Ml@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-2-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407084238.20443-2-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:42:31PM +1000, Alistair Popple wrote:
> +static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
> +{
> +	struct page *p = pfn_to_page(swp_offset(entry));
> +
> +	/*
> +	 * Any use of migration entries may only occur while the
> +	 * corresponding page is locked
> +	 */
> +	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
> +
> +	return p;
> +}

Would swap_pfn_entry_to_page() be slightly better?

The thing is it's very easy to read pfn_*() as a function to take a pfn as
parameter...

Since I'm also recently working on some swap-related new ptes [1], I'm thinking
whether we could name these swap entries as "swap XXX entries".  Say, "swap
hwpoison entry", "swap pfn entry" (which is a superset of "swap migration
entry", "swap device exclusive entry", ...).  That's where I came with the
above swap_pfn_entry_to_page(), then below will be naturally is_swap_pfn_entry().

No strong opinion as this is already a v8 series (and sorry to chim in this
late), just to raise this up.

[1] https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com/

Thanks,

> +
> +/*
> + * A pfn swap entry is a special type of swap entry that always has a pfn stored
> + * in the swap offset. They are used to represent unaddressable device memory
> + * and to restrict access to a page undergoing migration.
> + */
> +static inline bool is_pfn_swap_entry(swp_entry_t entry)
> +{
> +	return is_migration_entry(entry) || is_device_private_entry(entry);
> +}

-- 
Peter Xu

