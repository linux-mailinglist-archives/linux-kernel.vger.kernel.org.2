Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71954320326
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 03:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBTC3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 21:29:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:57745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBTC3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:29:21 -0500
IronPort-SDR: nFb4XlhzCMxsqyy3c9T7JtvAC5HOjUSsSqvZ+8x5XoFegW+h9UcNxYo0/juNWiMAqMu/A27ve8
 0u05G+5UfQTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="184134716"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="184134716"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 18:27:35 -0800
IronPort-SDR: GcL94HWIGLluk7WpNMjG61xGyie8AgY/sonXVxtDaxY+1xdJP8g63g0aFMbzpzn5U2hFzn7ppp
 J+hRQJlDM6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="420617217"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2021 18:27:31 -0800
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH 4/4] iommu/vt-d: Calculate and set flags for
 handle_mm_fault
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1613683878-89946-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <96124ae0-8d7e-864c-3de9-f8c0f2d7fffd@linux.intel.com>
Date:   Sat, 20 Feb 2021 10:18:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1613683878-89946-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 5:31 AM, Jacob Pan wrote:
> Page requests are originated from the user page fault. Therefore, we
> shall set FAULT_FLAG_USER.
> 
> FAULT_FLAG_REMOTE indicates that we are walking an mm which is not
> guaranteed to be the same as the current->mm and should not be subject
> to protection key enforcement. Therefore, we should set FAULT_FLAG_REMOTE
> to avoid faults when both SVM and PKEY are used.
> 
> References: commit 1b2ee1266ea6 ("mm/core: Do not enforce PKEY permissions on remote mm access")
> Reviewed-by: Raj Ashok <ashok.raj@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index ff7ae7cc17d5..7bfd20a24a60 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1086,6 +1086,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   	struct intel_iommu *iommu = d;
>   	struct intel_svm *svm = NULL;
>   	int head, tail, handled = 0;
> +	unsigned int flags = 0;
>   
>   	/* Clear PPR bit before reading head/tail registers, to
>   	 * ensure that we get a new interrupt if needed. */
> @@ -1186,9 +1187,11 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		if (access_error(vma, req))
>   			goto invalid;
>   
> -		ret = handle_mm_fault(vma, address,
> -				      req->wr_req ? FAULT_FLAG_WRITE : 0,
> -				      NULL);
> +		flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
> +		if (req->wr_req)
> +			flags |= FAULT_FLAG_WRITE;
> +
> +		ret = handle_mm_fault(vma, address, flags, NULL);
>   		if (ret & VM_FAULT_ERROR)
>   			goto invalid;
>   
> 
