Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4045A111
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhKWLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:14:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:33565 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234292AbhKWLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:14:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="298411915"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="298411915"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 03:11:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="497249160"
Received: from songallx-mobl.ccr.corp.intel.com (HELO [10.254.215.84]) ([10.254.215.84])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 03:11:18 -0800
Message-ID: <016271ae-956e-23c1-8ff1-67fc108023b3@linux.intel.com>
Date:   Tue, 23 Nov 2021 19:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove unused PASID_DISABLED
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20211123105507.7654-1-joro@8bytes.org>
 <20211123105507.7654-2-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20211123105507.7654-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/23 18:55, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The macro is unused after commit 00ecd5401349a so it can be removed.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 00ecd5401349a ("iommu/vt-d: Clean up unused PASID updating functions")

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   arch/x86/include/asm/fpu/api.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 6053674f9132..c2767a6a387e 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -102,12 +102,6 @@ extern void switch_fpu_return(void);
>    */
>   extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
>   
> -/*
> - * Tasks that are not using SVA have mm->pasid set to zero to note that they
> - * will not have the valid bit set in MSR_IA32_PASID while they are running.
> - */
> -#define PASID_DISABLED	0
> -
>   /* Trap handling */
>   extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
>   extern void fpu_sync_fpstate(struct fpu *fpu);
> 
