Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4D3A4C32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFLCOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 22:14:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:55212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 22:14:42 -0400
IronPort-SDR: iz7NMTjWTI2MrBBe1rbZM/nN7sP3Yn2SbT/JYURbU0lqd5zjC+6NxGl8fGN6bamebmh15iYM9n
 mJuDsxMYrMug==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291270863"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="291270863"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:12:43 -0700
IronPort-SDR: bDCVmVTzI/B1lIEtuckex3DVDIS5G+IAmy/E22QftX8SaVx9sdunbRuoF/PlcQHXO9C7FRJqXO
 YAObKPRb9GFg==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="483472429"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.238.4.20]) ([10.238.4.20])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 19:12:40 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
Subject: Re: [PATCH v12 2/5] iommu: Enhance IOMMU default DMA mode build
 options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-3-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9a98ef6f-c804-4778-0503-6b82b828a851@linux.intel.com>
Date:   Sat, 12 Jun 2021 10:12:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/11 20:20, John Garry wrote:
> +choice
> +	prompt "IOMMU default DMA mode"

This is not explicit.

How about

"IOMMU DMA default cache invalidation policy"

?

Best regards,
baolu

> +	depends on IOMMU_DMA
> +
> +	default IOMMU_DEFAULT_STRICT
> +	help
> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
> +	  override the default DMA mode of each ARCH, removing the need to
> +	  pass in kernel parameters through command line. It is still possible
> +	  to provide ARCH-specific or common boot options to override this
> +	  option.
> +
> +	  If unsure, keep the default.
