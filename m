Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8383D3656EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDTK5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:57:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:45330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhDTK53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:57:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618916217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VOuahTcAZ+eTi+aJO0XhJlpQiupGdAnfYul0ZSkVy94=;
        b=d5rNRkxL7q65Lj2+Q0PEqSn83XZA7eeFvKG4e9/ZNOUzu3ce8lQrqhB7VgKsp24OjTSPOf
        XDdCFZuD+kUB1mwc9vXtROYZKZq/+V2OS8bBm9N9JE9IfFKgbpZrfVh33bEgAGJWcj+hxb
        OLmAmkcF62biRGhbS3WVYm9qO6hlf0A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA666AD77;
        Tue, 20 Apr 2021 10:56:57 +0000 (UTC)
Date:   Tue, 20 Apr 2021 12:56:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/8] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <YH6zeWm5ZSd8JRoA@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-8-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416112411.9826-8-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:24:10, Oscar Salvador wrote:
> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2792879d398e..9f0211df1746 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2433,6 +2433,9 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>  	def_bool y
>  	depends on MEMORY_HOTPLUG
>  
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y
> +
>  config USE_PERCPU_NUMA_NODE_ID
>  	def_bool y
>  	depends on NUMA
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
