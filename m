Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5817F345C72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhCWLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:07:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:31764 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCWLHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:07:04 -0400
IronPort-SDR: buNFVQCzrq7BlKMhvhjw4ka9jlaG7YNpvnKe+Q0maOPr0o2dGnIzwh5n77akr9TDqd6EbIcG99
 6+kYjLms1RyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189854540"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="189854540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:06:58 -0700
IronPort-SDR: 304IViLktmB5zaz+KAlxvL9xxLnyisMiMXHxnNWIiNXPid/uKsBA+gPKmU0XGStD/ykneHpXXO
 7/DpAWjhEH/A==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="414939300"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:06:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOes4-00EziS-Of; Tue, 23 Mar 2021 13:06:48 +0200
Date:   Tue, 23 Mar 2021 13:06:48 +0200
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
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <YFnLyJF4u5HVXcc2@smile.fi.intel.com>
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322160200.19633-2-david@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:01:58PM +0100, David Hildenbrand wrote:
> It used to be true that we can have busy system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
> lower levels.
> 
> We have two users of walk_system_ram_res(), which currently only
> consideres the first level:
> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>    IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>    locate_mem_hole_callback(), so even after this change, we won't be
>    placing kexec images onto dax/kmem and virtio-mem added memory. No
>    change.
> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>    not adding relevant ranges to the crash elf info, resulting in them
>    not getting dumped via kdump.
> 
> This change fixes loading a crashkernel via kexec_file_load() and including

"...fixes..." effectively means to me that Fixes tag should be provided.

> dax/kmem and virtio-mem added System RAM in the crashdump on x86-64. Note
> that e.g,, arm64 relies on memblock data and, therefore, always considers
> all added System RAM already.
> 
> Let's find all busy IORESOURCE_SYSTEM_RAM resources, making the function
> behave like walk_system_ram_range().
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
> index 627e61b0c124..4efd6e912279 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -457,7 +457,7 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  {
>  	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
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


