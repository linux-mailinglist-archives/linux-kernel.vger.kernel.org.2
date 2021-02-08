Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A2314085
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhBHUbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:31:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:18686 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236061AbhBHTLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:11:09 -0500
IronPort-SDR: PA1J/V2TjN9umTntqm0Xxcp9fk6mnnDlw+4XmRyUotg/3T33tgq91aWcavdZxwgpWKCXmzKCou
 AonBsatv0q6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180987078"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="180987078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:10:20 -0800
IronPort-SDR: QFiE6hhQ7xqTdMWFzftnB/WnnPXpSOfw5ZYyI/Z7AKEUaPm8ftugDgT834NB23DeXZQZR8wN4v
 oYVe7pKiTvBQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="358881823"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:10:19 -0800
Date:   Mon, 8 Feb 2021 11:10:18 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, peterz@infradead.org,
        acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 02/49] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20210208191018.GA86425@agluck-desk2.amr.corp.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
 <20210208175640.GD18227@zn.tnic>
 <cddc013c-5b48-f792-058c-009e43cfe547@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cddc013c-5b48-f792-058c-009e43cfe547@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:04:24PM -0500, Liang, Kan wrote:
> On 2/8/2021 12:56 PM, Borislav Petkov wrote:
> 
> I think it's good enough for perf, but I'm not sure whether other codes need
> the CPU type information.
> 
> Ricardo, do you know?
> 
> Maybe we should implement a generic function as below for this?
> (Not test. Just use as an example.)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index a66c1fd..679f5fe 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2056,3 +2056,11 @@ void arch_smt_update(void)
>  	/* Check whether IPI broadcasting can be enabled */
>  	apic_smt_update();
>  }
> +
> +u32 x86_read_hybrid_type(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +		return cpuid_eax(0x0000001a);
> +
> +	return 0;
> +}

Machine check logging will want to include this in "struct mce".

But ok to pick it up with a function like you describe above.

-Tony
