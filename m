Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88B13A0DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhFIHpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:45:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:53679 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhFIHpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:45:09 -0400
IronPort-SDR: wtAwLZFPGuK5BJ2T5yMSO3YoRFuuSf5nyMk/0wq4W3wOX24cn+4OogrPPtYYt0IjcDGnLpu5o9
 lOqX0FCqSD5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="266177033"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="266177033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 00:43:15 -0700
IronPort-SDR: HnDCS4+nCKuu3tCwI/PtgKDqTwENFG1lTzv7Vy0x364pm/g80y9lD+IXDCddFK7IqUJcfKs1Xi
 1xqN0pUq6syg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552589925"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:43:13 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: use DEVICE_ATTR_RO macro
To:     YueHaibing <yuehaibing@huawei.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
References: <20210528130229.22108-1-yuehaibing@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4ce91672-a0e4-c1f6-4e8c-e926e03cfddd@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:41:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528130229.22108-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 9:02 PM, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing<yuehaibing@huawei.com>

Queued for v5.14. Thanks!

Best regards,
baolu
