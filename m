Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1ED39AD2D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFCVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhFCVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622756930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UyrGmdBsIRNJXWAqlX5+7cTy9HYr4MDviQbOZ7GPJ4c=;
        b=ElUYo3/h2KCc3gKIB2wzAnVwmHGmyQ9UI5G43llw9Q+XDM+AGQacUXaLwMcliVUHyGMXSZ
        UoRHUPULdp1FF/vGifw7PzYQVWZMCellaRPSzZDA4CYQowlTHTEhWBZnwEPCvc8g1NsUCj
        REJteAR7+KjG1EGzHmNmBmLPJ8RSlmQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581--rKPlF7_PnSxD1mL2aW-Gg-1; Thu, 03 Jun 2021 17:48:49 -0400
X-MC-Unique: -rKPlF7_PnSxD1mL2aW-Gg-1
Received: by mail-qv1-f71.google.com with SMTP id if5-20020a0562141c45b029021fee105740so1390033qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UyrGmdBsIRNJXWAqlX5+7cTy9HYr4MDviQbOZ7GPJ4c=;
        b=bArz5PieW4DfF8AhU6JquBNKEue4PlQvKfKisJz6PVLW+QKZtfljiMfy7l4hrSn65Y
         Zvp55pwoNsyptpvEXpPeTAsqpfx+xTPALjk5Txy/ENEYX/t5MabIp/anUflGwAPi4Eua
         lbZB0VRqXxG1vt9JpFRnwNG/4oJAWuUXbAMuXZwa9cXUnpFmPnM1jadTWbLvBcAkzpBT
         vCaVr8uiYUsapu4Hv9PVFmceUrM5pjqkGvPTgDIHqvUBYMQLiUMscjG3d+4GhUB5w8ZV
         M1AD69fAiqEo/D3C93MIMpZOsOvnTF3cUKwfHEY/eRkwq28WeZVZP74pb5THS9z2wzpw
         xbHA==
X-Gm-Message-State: AOAM531+lx7bcF5wt87YdZky/a41eZ2qnw+tRhuM+Js9gtexXN8nzYIV
        IGxkSzn8TNpq0gTRFk1VxBl3FCkDEXuWfsiEsp9JvQVnpAnhNzHwME9gK+YrS8LLVVdL9g+HL/F
        zJnRR8XfCxv77rnRssGxYOYfE
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr1734619qvv.38.1622756928994;
        Thu, 03 Jun 2021 14:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2nEeRfVLrFlr58ZNXyzqKeM3FvzaMg2aryvMBLblQ/w4pTvaJSBbnRscU4sftEzFfHjgyPg==
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr1734600qvv.38.1622756928721;
        Thu, 03 Jun 2021 14:48:48 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id s5sm2378221qtn.33.2021.06.03.14.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:48:48 -0700 (PDT)
Date:   Thu, 3 Jun 2021 17:48:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe
 DEBUG_VM splitting
Message-ID: <YLlOPoP/rIRMm2U5@t490s>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:07:53PM -0700, Hugh Dickins wrote:
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2cf01d933f13..b45d22738b45 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			pvmw->ptl = NULL;
>  		}
>  	} else if (!pmd_present(pmde)) {
> +		/*
> +		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> +		 * cannot return prematurely, while zap_huge_pmd() has
> +		 * cleared *pmd but not decremented compound_mapcount().
> +		 */
> +		if ((pvmw->flags & PVMW_SYNC) &&
> +		    PageTransCompound(pvmw->page))
> +			spin_unlock(pmd_lock(mm, pvmw->pmd));
>  		return false;
>  	}
>  	if (!map_pte(pvmw))

Sorry if I missed something important, but I'm totally confused on how this
unlock is pairing with another lock()..

And.. isn't PVMW_SYNC only meaningful for pte-level only (as I didn't see a
reference of it outside map_pte)?

-- 
Peter Xu

