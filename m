Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5669E32557F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhBYSaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233251AbhBYS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHNWIARkC6eM+jOggwpt1Qmt6zGyG+5uENA/0Jk/MHI=;
        b=LAY5J+QswEM9kI88lWCBrSoyW1fTpBTgQDed5VC1dzy23RVAG/faLcGpZd/JTcCb3vaA7u
        Hd+jc20nYz806+BJFOZRinN5ZFur/2Tp0OYzltoVmYDKLSAH5gZS16Cp82oyOF40VsJedd
        a0TkMKhIJl4V2LoVAQ0VAbc3pPZJz8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-WGxbVyCePlKKVWVaZ-zzew-1; Thu, 25 Feb 2021 13:27:07 -0500
X-MC-Unique: WGxbVyCePlKKVWVaZ-zzew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D5D3809AC7;
        Thu, 25 Feb 2021 18:26:53 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A9907A39C;
        Thu, 25 Feb 2021 18:26:51 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] mm,memory_hotplug: Enforce struct page size to be
 multiple of PMD
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
Date:   Thu, 25 Feb 2021 19:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 14:38, Oscar Salvador wrote:
> When struct page's size is not multiple of PMD, these do not get
> fully populated when adding sections, hence two sections will
> intersect the same the PMD. This goes against the vmemmap-per-device
> premise, so reject it if that is the case.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/memory_hotplug.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 95695483a622..d3fb036d33fd 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -57,10 +57,11 @@ static __meminit int memmap_on_memory_store(const char *val,
>   					    const struct kernel_param *kp)
>   {
>   	/*
> -	 * Fail silently in case we cannot enable it due to platform constraints.
> +	 * Fail silently in case we cannot enable it due to system constraints.
>   	 * User can always check whether it is enabled or not via /sys/module.
>   	 */
> -	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
> +	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
> +	    (PMD_SIZE % sizeof(struct page)))
>   		return 0;
>   
>   	return param_set_bool(val, kp);
> 

Squash that into #1 - it's part of basic operation.

-- 
Thanks,

David / dhildenb

