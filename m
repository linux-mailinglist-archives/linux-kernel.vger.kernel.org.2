Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B424305DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhA0OBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhA0OAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611755960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84QZLW2MmSKQhGMceaFRzTS4p8xthVnRtABZqSeleds=;
        b=IsX79c/YzmEtBfaMwaEUcBkvHUkSXsfHfu+roUsRQXEMSN3SMuz6UORXQ78FCsTwMj+CcH
        Kannd6j34OD2N6FeCgU/Vf2LxWesv/OXTCTc1hyGSqVnI9m92cWbMzSJLCwjyKW/GGfJIR
        HzG0QIX4k61ie2sQHGviDbw1RaapJnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-5xc57rt9NrCl0H2D8DACtg-1; Wed, 27 Jan 2021 08:59:18 -0500
X-MC-Unique: 5xc57rt9NrCl0H2D8DACtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8B5107ACE4;
        Wed, 27 Jan 2021 13:59:16 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044A06F451;
        Wed, 27 Jan 2021 13:59:12 +0000 (UTC)
Subject: Re: [PATCH] mm, slub: remove slub_memcg_sysfs boot param and
 CONFIG_SLUB_MEMCG_SYSFS_ON
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20210127124745.7928-1-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8f989256-9e43-1747-4de5-fa46db0d7f7e@redhat.com>
Date:   Wed, 27 Jan 2021 14:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210127124745.7928-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 13:47, Vlastimil Babka wrote:
> The boot param and config determine the value of memcg_sysfs_enabled, which is
> unused since commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") as there are no per-memcg kmem caches
> anymore.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  8 --------
>   init/Kconfig                                    | 14 --------------
>   mm/slub.c                                       | 16 ----------------
>   3 files changed, 38 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f4497faef266..7dc351da0005 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4892,14 +4892,6 @@
>   			last alloc / free. For more information see
>   			Documentation/vm/slub.rst.
>   
> -	slub_memcg_sysfs=	[MM, SLUB]
> -			Determines whether to enable sysfs directories for
> -			memory cgroup sub-caches. 1 to enable, 0 to disable.
> -			The default is determined by CONFIG_SLUB_MEMCG_SYSFS_ON.
> -			Enabling this can lead to a very high number of	debug
> -			directories and files being created under
> -			/sys/kernel/slub.
> -
>   	slub_max_order= [MM, SLUB]
>   			Determines the maximum allowed order for slabs.
>   			A high setting may cause OOMs due to memory
> diff --git a/init/Kconfig b/init/Kconfig
> index e4e2932da237..af454a51f3c5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1851,20 +1851,6 @@ config SLUB_DEBUG
>   	  SLUB sysfs support. /sys/slab will not exist and there will be
>   	  no support for cache validation etc.
>   
> -config SLUB_MEMCG_SYSFS_ON
> -	default n
> -	bool "Enable memcg SLUB sysfs support by default" if EXPERT
> -	depends on SLUB && SYSFS && MEMCG
> -	help
> -	  SLUB creates a directory under /sys/kernel/slab for each
> -	  allocation cache to host info and debug files. If memory
> -	  cgroup is enabled, each cache can have per memory cgroup
> -	  caches. SLUB can create the same sysfs directories for these
> -	  caches under /sys/kernel/slab/CACHE/cgroup but it can lead
> -	  to a very high number of debug files being created. This is
> -	  controlled by slub_memcg_sysfs boot parameter and this
> -	  config option determines the parameter's default value.
> -
>   config COMPAT_BRK
>   	bool "Disable heap randomization"
>   	default y
> diff --git a/mm/slub.c b/mm/slub.c
> index 1b5148747c64..88782727412c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5040,22 +5040,6 @@ enum slab_stat_type {
>   #define SO_OBJECTS	(1 << SL_OBJECTS)
>   #define SO_TOTAL	(1 << SL_TOTAL)
>   
> -#ifdef CONFIG_MEMCG
> -static bool memcg_sysfs_enabled = IS_ENABLED(CONFIG_SLUB_MEMCG_SYSFS_ON);
> -
> -static int __init setup_slub_memcg_sysfs(char *str)
> -{
> -	int v;
> -
> -	if (get_option(&str, &v) > 0)
> -		memcg_sysfs_enabled = v;
> -
> -	return 1;
> -}
> -
> -__setup("slub_memcg_sysfs=", setup_slub_memcg_sysfs);
> -#endif
> -
>   static ssize_t show_slab_objects(struct kmem_cache *s,
>   				 char *buf, unsigned long flags)
>   {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

