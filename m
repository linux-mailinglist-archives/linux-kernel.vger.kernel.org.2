Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5A3472C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhCXHft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:35:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:28207 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233527AbhCXHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:35:23 -0400
IronPort-SDR: eAvSjiNP8PMFqsaiNeZmD5V+zQ2tnDAOb//HxxaPnbxMn0fTGLw6veItx6DkAYhgSC7A7jdJgf
 r48jm+XnhbHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="210750036"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="210750036"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 00:35:18 -0700
IronPort-SDR: OmnYOMTkXgpKl7T1YTJnYZc69aewVIAzXSe2RtYrSkJaaeTqy5+DhGBfhtogD0+V67ZKn8VQr1
 OEeZ/vz8lX9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="435887389"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2021 00:35:14 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
To:     Christoph Hellwig <hch@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-4-baolu.lu@linux.intel.com>
 <20210323173357.GD2463754@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6fa292bd-9307-6e29-7968-005e1b8a087d@linux.intel.com>
Date:   Wed, 24 Mar 2021 15:25:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323173357.GD2463754@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 3/24/21 1:33 AM, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 09:05:58AM +0800, Lu Baolu wrote:
>> The SVM_FLAG_PRIVATE_PASID has never been referenced in the tree, and
>> there's no plan to have anything to use it. So cleanup it.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you!

> 
> But can we take this a little further?  SVM_FLAG_GUEST_PASID is unused
> as well.  SVM_FLAG_GUEST_MODE is only used in drivers/iommu/intel/svm.c,
> and SVM_FLAG_SUPERVISOR_MODE is actually used as an API flag to
> iommu_sva_bind_device.  So IMHO the latter should be elevated to an
> IOMMU API level flag, and then include/linux/intel-svm.h can go away
> entirely or at least be moved to drivers/iommu/intel/.
> 

Sure. I will consider it and make it in separated patches.

Best regards,
baolu
