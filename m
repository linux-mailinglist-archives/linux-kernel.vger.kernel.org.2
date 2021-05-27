Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF2393966
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhE0Xtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236603AbhE0Xta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622159276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nBjrn2Nu1rup4YX34Bcybft9Ot8nZh9IC/a7KhqVnU=;
        b=RStS3Dw85vYb+wrFqATu8W6RaXDyKVzTP56lpSjvNc3gJwj+UhEN8zVEESu3bqtb5o1JOr
        km/nfzP8NDlNv/ww5On/B4ymOFGQZzdxFCHDN0sDcQtpQc6aOSdRa7hkTLvdPDsxscFgUL
        aadCaoN5rfIoCYftcc/VsoZqV2/tAiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ChZNmBx4NlquyKHweb1k6w-1; Thu, 27 May 2021 19:47:55 -0400
X-MC-Unique: ChZNmBx4NlquyKHweb1k6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3DA1188E3C9;
        Thu, 27 May 2021 23:47:53 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35CF95B686;
        Thu, 27 May 2021 23:47:52 +0000 (UTC)
Date:   Fri, 28 May 2021 07:47:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        yangerkun <yangerkun@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix counting of managed_pages
Message-ID: <20210527234750.GB31898@MiWiFi-R3L-srv>
References: <20210527125707.3760259-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527125707.3760259-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/21 at 08:57pm, Liu Shixin wrote:
> The commit f63661566fad (mm/page_alloc.c: clear out zone->lowmem_reserve[]
> if the zone is empty) clear out zone->lowmem_reserve[] if zone is empty.
> But when zone is not empty and sysctl_lowmem_reserve_ratio[i] is set to zero,
> zone_managed_pages(zone) is not counted in the managed_pages either. This is
> inconsistent with the description of lowmen_reserve, so fix it.

Right, this is a good catch. Thanks for the fixing. 

Is it worth adding words in Documentation/admin-guide/sysctl/vm.rst
to notice this?

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> Fixes: f63661566fad ("mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty")
> Reported-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/page_alloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..49a2efce5a84 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8061,14 +8061,14 @@ static void setup_per_zone_lowmem_reserve(void)
>  			unsigned long managed_pages = 0;
>  
>  			for (j = i + 1; j < MAX_NR_ZONES; j++) {
> -				if (clear) {
> -					zone->lowmem_reserve[j] = 0;
> -				} else {
> -					struct zone *upper_zone = &pgdat->node_zones[j];
> +				struct zone *upper_zone = &pgdat->node_zones[j];
> +
> +				managed_pages += zone_managed_pages(upper_zone);
>  
> -					managed_pages += zone_managed_pages(upper_zone);
> +				if (clear)
> +					zone->lowmem_reserve[j] = 0;
> +				else
>  					zone->lowmem_reserve[j] = managed_pages / ratio;
> -				}
>  			}
>  		}
>  	}
> -- 
> 2.18.0.huawei.25
> 
> 

