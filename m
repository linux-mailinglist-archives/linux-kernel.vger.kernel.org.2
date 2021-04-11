Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C2835B24E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhDKH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 03:56:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:57739 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233612AbhDKH4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 03:56:41 -0400
IronPort-SDR: YBE28eCZWThXTMsqKrKcLIHYQwiCy8DlOxwuoOYLLUvQZ1Og6+0DYm/xMaXS+HYSwct83lRKlw
 YAsFcqPkwh8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="173490538"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="173490538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 00:56:23 -0700
IronPort-SDR: LpBm9mbWSifoYze1iueqgKVnmshJ3hp+KegkzKkyfcvtirNgCZfidWTUKBwstADd1EfIW861tI
 erjvBtIBTopQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="442696473"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2021 00:56:18 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix an error handling path in
 'intel_prepare_irq_remapping()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
        kyung.min.park@intel.com
References: <98d531caabe66012b4fffc7813fd4b9470afd517.1618124777.git.christophe.jaillet@wanadoo.fr>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f43ba8b7-8977-c1e7-ffa2-7f7b5306c7f2@linux.intel.com>
Date:   Sun, 11 Apr 2021 15:46:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <98d531caabe66012b4fffc7813fd4b9470afd517.1618124777.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/21 3:08 PM, Christophe JAILLET wrote:
> If 'intel_cap_audit()' fails, we should return directly, as already done in
> the surrounding error handling path.
> 
> Fixes: ad3d19029979 ("iommu/vt-d: Audit IOMMU Capabilities and add helper functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely speculative.
> It is based on a spurious mix-up of direct return and goto.
> ---
>   drivers/iommu/intel/irq_remapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 75429a5373ec..f912fe45bea2 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -736,7 +736,7 @@ static int __init intel_prepare_irq_remapping(void)
>   		return -ENODEV;
>   
>   	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
> -		goto error;
> +		return -ENODEV;
>   
>   	if (!dmar_ir_support())
>   		return -ENODEV;
> 

Thanks!

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
