Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06172392107
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhEZTmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232975AbhEZTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622058071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IK6Th4ZCx+0amLJEZjMrTW9bDpGzITHnRAL9h8VgscA=;
        b=ZV5MmiOxp6cFaupevgIBPi+3x03Bkd24qjoGhlH389dIjzps2WGegOLjnYuWXyi1xsCDlz
        3WfY7/xAIPZl7HBh5BkmYxdBeK+j+FtTRtwm6y5sJjSNvnaFfuOEpKWm44oaoTfgGlKQaX
        Of/yYe8irIJfXooknise8QwntP3z1aE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-DPTfe7MZNEyFkauIKomKwA-1; Wed, 26 May 2021 15:41:09 -0400
X-MC-Unique: DPTfe7MZNEyFkauIKomKwA-1
Received: by mail-qk1-f199.google.com with SMTP id a24-20020a05620a1038b02902fa6ba180ffso1684125qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IK6Th4ZCx+0amLJEZjMrTW9bDpGzITHnRAL9h8VgscA=;
        b=TeMeWNGJQzaWqnDos6fAmr6cgUWhQykqhyx7Rx6sZ4/J/EHBE/0cJuaj/XWvPLNdQW
         A3M4uMg+T8V1G+X4BPY0GxC4VumDRLfKLrriyxfaMHeaR1ujx2rHj6HznrfDqJJVJ45x
         sd4LAPaNIg0DkILyBHb1mUhwX2h+Qewo/kYz4pu9QapcBFLjI/BHQWV+j+wmlxbHnYfX
         8Mr8bE6uqbDZ+0BNo87pUufRO3lNyQhzr+jL1bZh9huInmzCKjmta5+OzSB2mEohvwas
         kdO6KttVIta0dsGMnMQicIEwMjr+2XMa+vJ3XTtXZhG++DzJ8SlgBC129+Y9+2xRZYr/
         /b1A==
X-Gm-Message-State: AOAM533ltgQ3bzAKTERjdF1g2e1iPIvnj9eBekeqbN7KdrRxhVGjDa8t
        JorhCyj6qs1h8AHrFHNuCGAMFaa8k43Hl/F6H6PFYbxH2pU5675pD84Tv028Lpj+gEcOD/CD9sH
        p4yPw8YifkLgUEmuk10cKajLb
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr38732466qtb.220.1622058069380;
        Wed, 26 May 2021 12:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJnPqtQWXkJ/e/uDJethFbtPOcM3K9BKum6Ztqo6rrKUmjkHKDiiSLmcCX23fB6dWiie8WzA==
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr38732446qtb.220.1622058069146;
        Wed, 26 May 2021 12:41:09 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id j1sm2056219qtn.83.2021.05.26.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 12:41:08 -0700 (PDT)
Date:   Wed, 26 May 2021 15:41:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        jhubbard@nvidia.com, bsingharora@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, jglisse@redhat.com, willy@infradead.org,
        jgg@nvidia.com, hughd@google.com
Subject: Re: [PATCH v9 05/10] mm: Rename migrate_pgmap_owner
Message-ID: <YK6kU25FDhuZC3AV@t490s>
References: <20210524132725.12697-1-apopple@nvidia.com>
 <20210524132725.12697-6-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524132725.12697-6-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:27:20PM +1000, Alistair Popple wrote:
> @@ -521,14 +521,14 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
>  	range->flags = flags;
>  }
>  
> -static inline void mmu_notifier_range_init_migrate(
> -			struct mmu_notifier_range *range, unsigned int flags,
> +static inline void mmu_notifier_range_init_owner(
> +			struct mmu_notifier_range *range,
> +			enum mmu_notifier_event event, unsigned int flags,
>  			struct vm_area_struct *vma, struct mm_struct *mm,
> -			unsigned long start, unsigned long end, void *pgmap)
> +			unsigned long start, unsigned long end, void *owner)
>  {
> -	mmu_notifier_range_init(range, MMU_NOTIFY_MIGRATE, flags, vma, mm,
> -				start, end);
> -	range->migrate_pgmap_owner = pgmap;
> +	mmu_notifier_range_init(range, event, flags, vma, mm, start, end);
> +	range->owner = owner;
>  }

mmu_notifier_range_init_migrate() can even be kept to just call the new helper,
then existing callers are unaffected.  Not a big deal, though:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

