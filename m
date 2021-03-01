Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCB3275AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCAAzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:55:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:29258 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231573AbhCAAzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:55:24 -0500
IronPort-SDR: x5TfNB1bOVVVX9vXbSfb025WdHinVA55V7gs8C+gudn3dUmtLWYRkeJ5GKmWrNxtYVmnVC+eJV
 y6ZERtjHeTIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="182920328"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="182920328"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 16:53:34 -0800
IronPort-SDR: aLtvsQrI8QH9YaUUUS8Mqo5aWURR0Uy3wyoquBZY82C2dk5qiZwjjBI8llH7I1nfYXpcIl/0pT
 xNtPnoa4SDcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="426753275"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2021 16:53:32 -0800
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, jacob.jun.pan@linux.intel.com,
        eric.auger@redhat.com, yi.l.liu@intel.com, kevin.tian@intel.com,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] iommu/vt-d: Fix status code for Allocate/Free PASID
 command
To:     Zenghui Yu <yuzenghui@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210227073909.432-1-yuzenghui@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <30c18a6d-fd0f-6e63-c231-d6f068410342@linux.intel.com>
Date:   Mon, 1 Mar 2021 08:44:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210227073909.432-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 3:39 PM, Zenghui Yu wrote:
> As per Intel vt-d spec, Rev 3.0 (section 10.4.45 "Virtual Command Response
> Register"), the status code of "No PASID available" error in response to
> the Allocate PASID command is 2, not 1. The same for "Invalid PASID" error
> in response to the Free PASID command.
> 
> We will otherwise see confusing kernel log under the command failure from
> guest side. Fix it.
> 
> Fixes: 24f27d32ab6b ("iommu/vt-d: Enlightened PASID allocation")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/iommu/intel/pasid.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 97dfcffbf495..444c0bec221a 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -30,8 +30,8 @@
>   #define VCMD_VRSP_IP			0x1
>   #define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
>   #define VCMD_VRSP_SC_SUCCESS		0
> -#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> -#define VCMD_VRSP_SC_INVALID_PASID	1
> +#define VCMD_VRSP_SC_NO_PASID_AVAIL	2
> +#define VCMD_VRSP_SC_INVALID_PASID	2
>   #define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
>   #define VCMD_CMD_OPERAND(e)		((e) << 8)
>   /*
> 

Thanks a lot for catching this.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
