Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3B306B17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhA1CZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:25:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11522 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhA1CZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:25:51 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DR46414W7zjFL8;
        Thu, 28 Jan 2021 10:23:56 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 10:25:07 +0800
Subject: Re: [PATCH] mm, slub: remove slub_memcg_sysfs boot param and
 CONFIG_SLUB_MEMCG_SYSFS_ON
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210127124745.7928-1-vbabka@suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <36b8a6fb-9b51-bd1b-d5b8-cb65b2be9c1a@huawei.com>
Date:   Thu, 28 Jan 2021 10:25:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127124745.7928-1-vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/27 20:47, Vlastimil Babka wrote:
> The boot param and config determine the value of memcg_sysfs_enabled, which is
> unused since commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") as there are no per-memcg kmem caches
> anymore.
> 

Good catch. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 --------
>  init/Kconfig                                    | 14 --------------
>  mm/slub.c                                       | 16 ----------------
>  3 files changed, 38 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f4497faef266..7dc351da0005 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4892,14 +4892,6 @@
>  			last alloc / free. For more information see
>  			Documentation/vm/slub.rst.
>  
> -	slub_memcg_sysfs=	[MM, SLUB]
> -			Determines whether to enable sysfs directories for
> -			memory cgroup sub-caches. 1 to enable, 0 to disable.
> -			The default is determined by CONFIG_SLUB_MEMCG_SYSFS_ON.
> -			Enabling this can lead to a very high number of	debug
> -			directories and files being created under
> -			/sys/kernel/slub.
> -
>  	slub_max_order= [MM, SLUB]
>  			Determines the maximum allowed order for slabs.
>  			A high setting may cause OOMs due to memory
> diff --git a/init/Kconfig b/init/Kconfig
> index e4e2932da237..af454a51f3c5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1851,20 +1851,6 @@ config SLUB_DEBUG
>  	  SLUB sysfs support. /sys/slab will not exist and there will be
>  	  no support for cache validation etc.
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
>  config COMPAT_BRK
>  	bool "Disable heap randomization"
>  	default y
> diff --git a/mm/slub.c b/mm/slub.c
> index 1b5148747c64..88782727412c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5040,22 +5040,6 @@ enum slab_stat_type {
>  #define SO_OBJECTS	(1 << SL_OBJECTS)
>  #define SO_TOTAL	(1 << SL_TOTAL)
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
>  static ssize_t show_slab_objects(struct kmem_cache *s,
>  				 char *buf, unsigned long flags)
>  {
> 

