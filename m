Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3D39BBA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFDPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhFDPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622820053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AbIlLedm5Mu+ovdpvNjPfOsXH7m99kQNtIejaRsUUU=;
        b=eBAIu4T1v2QMvm5Oc0+dXshQ8vnZHsUuw4qfpirqoXOCAVcHRay+mAON9Tyh2/tQGk2AmK
        vZD4Iu75ZF6sNhXHpjdcDtglxmoMkdfdBnpbldxw8vtW+W0Yks+oPrXU9MaAww+3bcxjK0
        dZ/xXzz7P1EQxXY80VUkbq53xX8kq9E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-rI4OJIZNMMWZySINOyA0UQ-1; Fri, 04 Jun 2021 11:20:51 -0400
X-MC-Unique: rI4OJIZNMMWZySINOyA0UQ-1
Received: by mail-qk1-f198.google.com with SMTP id e8-20020a05620a2088b02903a5edeec4d6so6801971qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AbIlLedm5Mu+ovdpvNjPfOsXH7m99kQNtIejaRsUUU=;
        b=qDKeyaz0BygRmMdjLNbW6B3m8kqo34huSxo0iRVOE7SfHTB3NjPSveHOiAyQiwRPjk
         IsSUMAccKt+wiY+bezUOZKChK8euntbKcMw+eazBqpc/onwUiegWY7kQkn0UNb/5bQ4G
         O1dOux7gPjcXkCRGfVKO9CP/7b3l+G6SwhzG+nZCPFdXINGedXkhPrOgZOUIfuqoaLTv
         i7xNQsHZ3I6dKs2DcyLzQjwWK8CjENa2gXMf4fMGr5D81/VidjCl9ixpAxdhpdHui7ID
         JZVq77dcHJRm1s2bv8q76HLLrDWLI/ZSFrIAni2THeBRHb3+QgJDodKGja2gW1HUCdGm
         dYIQ==
X-Gm-Message-State: AOAM533AnQS2dgFf8P9MZw3/r8ugwOT5mmoEhPvDsXkEyBtffswuSVQb
        s6e508wE/NvnQhtW5lTSQxtzrEnxSI0gXwrLQOYAPsqXX5BapOes4dq38klSKkbqhL0oou/sr8g
        Bj5Ui0CDbEZbftXFYzgTP16mo
X-Received: by 2002:a37:911:: with SMTP id 17mr2506621qkj.436.1622820051403;
        Fri, 04 Jun 2021 08:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSkb15icJCjCC2a0yzUkFB8Tk/1b3Gxyat2dgZri3GuoK2EOI4ZaPq1ePBkTLwQGSCPYLtvg==
X-Received: by 2002:a37:911:: with SMTP id 17mr2506604qkj.436.1622820051225;
        Fri, 04 Jun 2021 08:20:51 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id x9sm3701082qtf.76.2021.06.04.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:20:50 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:20:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, jglisse@redhat.com, willy@infradead.org,
        jgg@nvidia.com, hughd@google.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 07/10] mm: Device exclusive memory access
Message-ID: <YLpE0U789jvD2zxN@t490s>
References: <20210524132725.12697-1-apopple@nvidia.com>
 <3853054.AI2YdRgKcH@nvdebian>
 <YLjrjJXMP9Y3bvej@t490s>
 <10231977.pWpf7cJbZl@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10231977.pWpf7cJbZl@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:07:42AM +1000, Alistair Popple wrote:
> On Friday, 4 June 2021 12:47:40 AM AEST Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > On Thu, Jun 03, 2021 at 09:39:32PM +1000, Alistair Popple wrote:
> > > Reclaim won't run on the page due to the extra references from the special
> > > swap entries.
> > 
> > That sounds reasonable, but I didn't find the point that stops it, probably
> > due to my limited knowledge on the reclaim code.  Could you elaborate?
> 
> Sure, it isn't immediately obvious but it ends up being detected at the start 
> of is_page_cache_freeable() in the pageout code:
> 
> 
> static pageout_t pageout(struct page *page, struct address_space *mapping)
> {
> 
> [...]
> 
> 	if (!is_page_cache_freeable(page))
> 		return PAGE_KEEP;

I did look at pageout() but still missed this small helper indeed (while it's
so important to know..), thanks!

-- 
Peter Xu

