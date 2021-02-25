Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0C325583
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBYSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232984AbhBYS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614277669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eenes0YGF8AnBiRK/oKSjQfRpwUb3Nfu5hqa+ZEPmQA=;
        b=H/vVMVLSdWitADoIJM4zwttHwzVtVVEdeDRvNDi2gAd7W/XchsSTh0sLDsk04+1y9tb6bW
        GIXGLeiqmJ9mbixXoY/yb5LeXdeZQoZYFrOXKzZ+585hwfRcQ79Vo8DcmUitnzsQDGhJlE
        OLRA4iUEkH9JLbuKirLnBDJbjpbyiLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-JtSbnEl9M0y9OBayU7Z1_Q-1; Thu, 25 Feb 2021 13:27:44 -0500
X-MC-Unique: JtSbnEl9M0y9OBayU7Z1_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96FDE91274;
        Thu, 25 Feb 2021 18:27:35 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0475A1346D;
        Thu, 25 Feb 2021 18:27:33 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] mm,memory_hotplug: Enforce pageblock alignment
 when memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-6-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9fcd9246-8e27-2991-a32f-539d9a430514@redhat.com>
Date:   Thu, 25 Feb 2021 19:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209133854.17399-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 14:38, Oscar Salvador wrote:
> Many places expects us to pass a pageblock aligned range.
> E.g: memmap_init_zone() needs a pageblock aligned range in order
> to set the proper migrate type for it.
> online_pages() needs to operate on a pageblock aligned range for
> isolation purposes.
> 
> Make sure we disable the feature in case we cannot guarantee the
> right alignment.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/memory_hotplug.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d3fb036d33fd..1a4d5dd1a2c8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -56,12 +56,16 @@ static int memmap_on_memory_show(char *buffer, const struct kernel_param *kp)
>   static __meminit int memmap_on_memory_store(const char *val,
>   					    const struct kernel_param *kp)
>   {
> +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
> +
>   	/*
>   	 * Fail silently in case we cannot enable it due to system constraints.
>   	 * User can always check whether it is enabled or not via /sys/module.
>   	 */
>   	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) ||
> -	    (PMD_SIZE % sizeof(struct page)))
> +	    (PMD_SIZE % sizeof(struct page)) ||
> +	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) ||
> +	    !(MIN_MEMORY_BLOCK_SIZE - PMD_SIZE) % pageblock_size)
>   		return 0;
>   
>   	return param_set_bool(val, kp);
> 

Dito, rather squash in #1 and add a comment explaining what's happening 
there.

-- 
Thanks,

David / dhildenb

