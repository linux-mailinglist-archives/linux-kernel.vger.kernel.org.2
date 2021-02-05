Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD731068F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhBEIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhBEIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612513252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeBF5bycuJCMZzkkGmudP+Cph0B7XaVDWKDDmeU89sk=;
        b=W++mGzvmpWwH3B/Sis6jIzMNNPsQyINo23PrO7VewKwuHXw8YQCeYukMVFT6pCwud9oZXW
        FjUy8kfo81o6nnLB2XLsKHDIuLe6Z2DyN8FaiMh61mkvPBw77Jloq1hIbJX4F/tzB0v9Da
        LUe+A9pilY6cFwkkqsDpQC65Ft2eRLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-bodImPgyO6i9pzDC4fIUgg-1; Fri, 05 Feb 2021 03:20:48 -0500
X-MC-Unique: bodImPgyO6i9pzDC4fIUgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C9A8030D1;
        Fri,  5 Feb 2021 08:20:46 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E754A1971C;
        Fri,  5 Feb 2021 08:20:43 +0000 (UTC)
Subject: Re: [RFC 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
 <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
Date:   Fri, 5 Feb 2021 09:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.21 08:01, Anshuman Khandual wrote:
> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
> greater than MAX_ORDER, making it unusable as pageblock_order.

Just so I understand correctly, this does not imply that we have THP 
that exceed the pageblock size / MAX_ORDER size, correct?


> 
> This enables HUGETLB_PAGE_SIZE_VARIABLE making pageblock_order a variable
> rather than the compile time constant HUGETLB_PAGE_ORDER which could break
> MAX_ORDER rule for certain configurations.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 175914f2f340..c4acf8230f20 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1918,6 +1918,10 @@ config ARCH_ENABLE_THP_MIGRATION
>   	def_bool y
>   	depends on TRANSPARENT_HUGEPAGE
>   
> +config HUGETLB_PAGE_SIZE_VARIABLE
> +	def_bool y
> +	depends on HUGETLB_PAGE
> +
>   menu "Power management options"
>   
>   source "kernel/power/Kconfig"
> 


-- 
Thanks,

David / dhildenb

