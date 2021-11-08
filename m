Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919CE447888
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhKHCZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:25:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:56662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhKHCZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:25:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="212885130"
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="212885130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 18:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; 
   d="scan'208";a="451304727"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2021 18:22:35 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix an unbalanced
 rcu_read_lock/rcu_read_unlock()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
        kevin.tian@intel.com
References: <40cc077ca5f543614eab2a10e84d29dd190273f6.1636217517.git.christophe.jaillet@wanadoo.fr>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c7ac5f27-d7b6-6f19-75cc-c047ad590696@linux.intel.com>
Date:   Mon, 8 Nov 2021 10:18:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <40cc077ca5f543614eab2a10e84d29dd190273f6.1636217517.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/21 12:53 AM, Christophe JAILLET wrote:
> If we return -EOPNOTSUPP, the rcu lock remains lock. This is spurious.
> Go through the end of the function instead. This way, the missing
> 'rcu_read_unlock()' is called.
> 
> Fixes: 7afd7f6aa21a ("iommu/vt-d: Check FL and SL capability sanity in scalable mode")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative, review with care.
> ---
>   drivers/iommu/intel/cap_audit.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
> index b39d223926a4..71596fc62822 100644
> --- a/drivers/iommu/intel/cap_audit.c
> +++ b/drivers/iommu/intel/cap_audit.c
> @@ -144,6 +144,7 @@ static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
>   {
>   	struct dmar_drhd_unit *d;
>   	struct intel_iommu *i;
> +	int rc = 0;
>   
>   	rcu_read_lock();
>   	if (list_empty(&dmar_drhd_units))
> @@ -169,11 +170,11 @@ static int cap_audit_static(struct intel_iommu *iommu, enum cap_audit_type type)
>   	 */
>   	if (intel_cap_smts_sanity() &&
>   	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
> -		return -EOPNOTSUPP;
> +		rc = -EOPNOTSUPP;
>   
>   out:
>   	rcu_read_unlock();
> -	return 0;
> +	return rc;
>   }
>   
>   int intel_cap_audit(enum cap_audit_type type, struct intel_iommu *iommu)
> 

Nice catch! Thank you!

I will queue this for v5.16.

Best regards,
baolu
