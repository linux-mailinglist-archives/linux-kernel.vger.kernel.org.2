Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF5457A9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 03:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhKTC0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 21:26:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:19732 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234792AbhKTC0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 21:26:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="234761472"
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="234761472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 18:23:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="508141382"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 18:23:24 -0800
Date:   Sat, 20 Nov 2021 10:24:19 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] xen/pvh: add missing prototype to header
Message-ID: <YZhcU3e0imdoKV7w@rli9-dbox>
References: <20211119153913.21678-1-jgross@suse.com>
 <0c654659-b010-791f-78e7-769108934ce2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c654659-b010-791f-78e7-769108934ce2@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:47:49AM -0800, Dave Hansen wrote:
> On 11/19/21 7:39 AM, Juergen Gross wrote:
> > The prototype of mem_map_via_hcall() is missing in its header, so add
> > it.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: a43fb7da53007e67ad ("xen/pvh: Move Xen code for getting mem map via hcall out of common file")
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> $ git describe a43fb7da53007e67ad
> v4.20-rc6-5-ga43fb7da5300
> 
> Better late than never, I guess.  I wonder what made 0day find this now.
hi Dave, we recently find some unexpected failures for certain bisections,
with the fix, such failures are rerun to see whether we can successfully detect 
bad commits, which i think this resulted in extra but late finding on old
commit on mainline. We will keep scan our bisection process to further improve
it to reduce this kind late reporting.

> 
> I also guess the one mem_map_via_hcall() call site just used the __weak
> definition so it didn't cause problems if there wasn't a declaration in
> the header.
