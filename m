Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15B3345C76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCWLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:08:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:4766 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhCWLIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:08:49 -0400
IronPort-SDR: C0P2P18Yt+0wrq1OmDwdFTTF34bZVIZPQTm//7GnYvYyuW0UjWrC5cRZV7NeMB7bPFBj2aN2QN
 kbfHjjqT7Rag==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251809068"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="251809068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:08:49 -0700
IronPort-SDR: lbaINAHh1CRWNiOOuf/ZQzF5Y+Xkbthj3gVNoPusQ5T0hjDgqNl/TzlYV3XpFqsX+XjGgDSDxS
 EG/6Zt8NDv/w==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="413347877"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:08:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOets-00Ezjz-6J; Tue, 23 Mar 2021 13:08:40 +0200
Date:   Tue, 23 Mar 2021 13:08:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all
 busy IORESOURCE_MEM resources
Message-ID: <YFnMOK6VuIBsoKWr@smile.fi.intel.com>
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322160200.19633-3-david@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:01:59PM +0100, David Hildenbrand wrote:
> It used to be true that we can have system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., dax/kmem and virtio-mem).
> 
> The function walk_mem_res() only consideres the first level and is
> used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
> fail to identify System RAM added by dax/kmem and virtio-mem as
> "IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
> "normal RAM" in __ioremap_caller().

Here I dunno, but consider to add Fixes tag if it fixes known bad behaviour.

> Let's find all busy IORESOURCE_MEM resources, making the function
> behave similar to walk_system_ram_res().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: x86@kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 4efd6e912279..16e0c7e8ed24 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -470,7 +470,7 @@ int walk_mem_res(u64 start, u64 end, void *arg,
>  {
>  	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  
> -	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
>  				     arg, func);
>  }
>  
> -- 
> 2.29.2
> 

-- 
With Best Regards,
Andy Shevchenko


