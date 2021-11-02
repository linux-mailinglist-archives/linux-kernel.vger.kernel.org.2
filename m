Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54B4436D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhKBT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:58:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:21882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhKBT6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:58:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="231207667"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="231207667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 12:55:40 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="489251107"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 12:55:40 -0700
Date:   Tue, 2 Nov 2021 12:55:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>
Subject: Re: mce: Add errata workaround for Skylake SKX37
Message-ID: <YYGXu9KxCq2+wlQL@agluck-desk2.amr.corp.intel.com>
References: <20211029205759.GA7385@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029205759.GA7385@codemonkey.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 04:57:59PM -0400, Dave Jones wrote:
> Errata SKX37 is word-for-word identical to the other errata listed in
> this workaround.   I happened to notice this after investigating a CMCI
> storm on a Skylake host.  While I can't confirm this was the root cause,
> spurious corrected errors does sound like a likely suspect.
> 
> Signed-off-by: Dave Jones <davej@codemonkey.org.uk>

Needs:

Fixes: 2976908e4198 ("x86/mce: Do not log spurious corrected mce errors")
Cc: <stable@vger.kernel.org>

otherwise:

Reviewed-by: Tony Luck <tony.luck@intel.com>

> 
> diff --git arch/x86/kernel/cpu/mce/intel.c arch/x86/kernel/cpu/mce/intel.c
> index acfd5d9f93c6..bb9a46a804bf 100644
> --- arch/x86/kernel/cpu/mce/intel.c
> +++ arch/x86/kernel/cpu/mce/intel.c
> @@ -547,12 +547,13 @@ bool intel_filter_mce(struct mce *m)
>  {
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
> -	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
> +	/* MCE errata HSD131, HSM142, HSW131, BDM48, HSM142 and SKX37 */
>  	if ((c->x86 == 6) &&
>  	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
>  	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
>  	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
> -	     (c->x86_model == INTEL_FAM6_HASWELL_G)) &&
> +	     (c->x86_model == INTEL_FAM6_HASWELL_G) ||
> +	     (c->x86_model == INTEL_FAM6_SKYLAKE_X)) &&
>  	    (m->bank == 0) &&
>  	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
>  		return true;
