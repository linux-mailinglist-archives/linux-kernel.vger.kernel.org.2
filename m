Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC01345C74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhCWLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:07:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:40572 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCWLHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:07:40 -0400
IronPort-SDR: +r2w4QbmonGTnzjbicX8rR2P8CB6GI1+3gATyoiS4Pz7XYmjJaSt/N8jGRjzRDOEBmjAb0M7BM
 fu+Ue9Xe441w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170419679"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="170419679"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:07:40 -0700
IronPort-SDR: 414qVntEfxbN+cn7Mq/J1eIWwY4ihjJKpuPpfO7rHNtVCipnB/6DDCMp9T5eomjtuPBEtY4MTs
 CGgN+0IWwUxA==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="607685015"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 04:07:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOesk-00EzjH-AE; Tue, 23 Mar 2021 13:07:30 +0200
Date:   Tue, 23 Mar 2021 13:07:30 +0200
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
Message-ID: <YFnL8q6X97T3xAp6@smile.fi.intel.com>
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com>
 <e4a088e3-fc26-cb59-8af8-a746932b108c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a088e3-fc26-cb59-8af8-a746932b108c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:40:33AM +0100, David Hildenbrand wrote:
> On 22.03.21 17:01, David Hildenbrand wrote:
> > It used to be true that we can have busy system RAM only on the first level
> > in the resourc tree. However, this is no longer holds for driver-managed
> > system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
> > lower levels.
> > 
> > We have two users of walk_system_ram_res(), which currently only
> > consideres the first level:
> > a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
> >     IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
> >     locate_mem_hole_callback(), so even after this change, we won't be
> >     placing kexec images onto dax/kmem and virtio-mem added memory. No
> >     change.
> > b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
> >     not adding relevant ranges to the crash elf info, resulting in them
> >     not getting dumped via kdump.
> > 
> > This change fixes loading a crashkernel via kexec_file_load() and including
> > dax/kmem and virtio-mem added System RAM in the crashdump on x86-64. Note
> > that e.g,, arm64 relies on memblock data and, therefore, always considers
> > all added System RAM already.
> > 
> > Let's find all busy IORESOURCE_SYSTEM_RAM resources, making the function
> > behave like walk_system_ram_range().
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> ^ My copy-paste action when creating the cc list slipped in a duplicate  SO
> in all 3 patches. I can resend if desired.

I think to address my comments you will need to resend anyway (as v2).

-- 
With Best Regards,
Andy Shevchenko


