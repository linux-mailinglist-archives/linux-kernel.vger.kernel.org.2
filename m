Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B345C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCWLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:05:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:31610 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCWLF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:05:29 -0400
IronPort-SDR: Iut2h5aE/y4yWu0097pxYK3JTpdav8CHGnopx4JMywUByEfSmOy8mvVMTZ1Oefs9uMuCiL0aa7
 AyCbci10ewmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189854350"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="189854350"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:05:22 -0700
IronPort-SDR: YuARCY5NsHDZ0ybCrSAyF7P8IWMCmEBQjrkxEsSqxGO0f3YbTLERo0LkkDkr+SuNQVhTQ87zeZ
 klqIpUGPflxw==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="604267746"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:05:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOeqW-00EzhN-Vs; Tue, 23 Mar 2021 13:05:12 +0200
Date:   Tue, 23 Mar 2021 13:05:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v1 0/3] kernel/resource: make walk_system_ram_res() and
 walk_mem_res() search the whole tree
Message-ID: <YFnLaLsTRv8T9fPe@smile.fi.intel.com>
References: <20210322160200.19633-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322160200.19633-1-david@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:01:57PM +0100, David Hildenbrand wrote:
> Playing with kdump+virtio-mem I noticed that kexec_file_load() does not
> consider System RAM added via dax/kmem and virtio-mem when preparing the
> elf header for kdump. Looking into the details, the logic used in
> walk_system_ram_res() and walk_mem_res() seems to be outdated.
> 
> walk_system_ram_range() already does the right thing, let's change
> walk_system_ram_res() and walk_mem_res(), and clean up.
> 
> Loading a kdump kernel via "kexec -p -s" ... will result in the kdump
> kernel to also dump dax/kmem and virtio-mem added System RAM now.
> 
> Note: kexec-tools on x86-64 also have to be updated to consider this
> memory in the kexec_load() case when processing /proc/iomem.


> Against next-20210322.

Hint: `git format-patch --base ...`

> 
> David Hildenbrand (3):
>   kernel/resource: make walk_system_ram_res() find all busy
>     IORESOURCE_SYSTEM_RAM resources
>   kernel/resource: make walk_mem_res() find all busy IORESOURCE_MEM
>     resources
>   kernel/resource: remove first_lvl / siblings_only logic
> 
>  kernel/resource.c | 45 ++++++++++++---------------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> -- 
> 2.29.2
> 

-- 
With Best Regards,
Andy Shevchenko


