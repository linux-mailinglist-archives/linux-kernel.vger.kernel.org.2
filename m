Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14489410F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 06:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhITEtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 00:49:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:23744 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhITEtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 00:49:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="223100333"
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="223100333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 21:47:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,307,1624345200"; 
   d="scan'208";a="532043668"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 21:47:52 -0700
Date:   Sun, 19 Sep 2021 21:47:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/mce: Get rid of msr_ops
Message-ID: <YUgSd6Sl/bFaGydO@agluck-desk2.amr.corp.intel.com>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917105355.2368-4-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:53:54PM +0200, Borislav Petkov wrote:
> +	switch (reg) {
> +	case MCA_CTL:
> +		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_CTL(bank)
> +				      : MSR_IA32_MCx_CTL(bank);
>  
> -static inline u32 smca_ctl_reg(int bank)
> -{
> -	return MSR_AMD64_SMCA_MCx_CTL(bank);
> -}
> +	case MCA_STATUS:
> +		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_STATUS(bank)
> +				      : MSR_IA32_MCx_STATUS(bank);
>  
> -static inline u32 smca_status_reg(int bank)
> -{
> -	return MSR_AMD64_SMCA_MCx_STATUS(bank);
> -}
> +	case MCA_ADDR:
> +		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_ADDR(bank)
> +				      : MSR_IA32_MCx_ADDR(bank);
>  
> -static inline u32 smca_addr_reg(int bank)
> -{
> -	return MSR_AMD64_SMCA_MCx_ADDR(bank);
> -}
> +	case MCA_MISC:
> +		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_MISC(bank)
> +				      : MSR_IA32_MCx_MISC(bank);
> +	default: break;
> +	}

I think this would be easier on the eyeballs with
a couple of helper functions:

	if (mce_flags.smca)
		return smca_msr_number(bank, reg);
	else
		return msr_number(bank, reg);

with the switch (reg) in each of those helper functions.

-Tony
