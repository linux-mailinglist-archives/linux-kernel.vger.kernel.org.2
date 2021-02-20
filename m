Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05C320320
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 03:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBTCXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 21:23:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:38941 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBTCXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:23:14 -0500
IronPort-SDR: NWVWBcrOoJXr0+r9LDi9ANPUkuroSuxXWN/wTCWOzwr35+uQpKPjQj1HBVjugi8Xac2/F2uqqp
 tuk98380ePng==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="171685573"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="171685573"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 18:21:28 -0800
IronPort-SDR: jgSY0f4qrxlE3DaXtKwmJn+gTZ7v2A0K0Dsz0yVXZEqgzjfpCj4FuGBdhJnfB3jnzvAZU82IRc
 2EmChZmwK2iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="420588765"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2021 18:21:24 -0800
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Reject unsupported page request modes
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fb796569-4612-4ba9-0859-310bd13a32fc@linux.intel.com>
Date:   Sat, 20 Feb 2021 10:12:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1613683878-89946-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 5:31 AM, Jacob Pan wrote:
> When supervisor/privilige mode SVM is used, we bind init_mm.pgd with
> a supervisor PASID. There should not be any page fault for init_mm.
> Execution request with DMA read is also not supported.
> 
> This patch checks PRQ descriptor for both unsupported configurations,
> reject them both with invalid responses.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 23a1e4f58c54..ff7ae7cc17d5 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1113,7 +1113,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			       ((unsigned long long *)req)[1]);
>   			goto no_pasid;
>   		}
> -
> +		/* We shall not receive page request for supervisor SVM */
> +		if (req->pm_req && (req->rd_req | req->wr_req)) {
> +			pr_err("Unexpected page request in Privilege Mode");
> +			/* No need to find the matching sdev as for bad_req */
> +			goto no_pasid;
> +		}
> +		/* DMA read with exec requeset is not supported. */
> +		if (req->exe_req && req->rd_req) {
> +			pr_err("Execution request not supported\n");
> +			goto no_pasid;
> +		}
>   		if (!svm || svm->pasid != req->pasid) {
>   			rcu_read_lock();
>   			svm = ioasid_find(NULL, req->pasid, NULL);
> 
