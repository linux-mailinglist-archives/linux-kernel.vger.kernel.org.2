Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50023305CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhCHCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:07:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:11593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233640AbhCHCHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:07:30 -0500
IronPort-SDR: sC6LTNmax546DQWPK7T1AupliIMXHaBGOVY9TyBAX/p5cLuNf6annEJuhLNOWFuj5HZhS/xpOL
 SHFUdY/jGdzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="175566479"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="175566479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 18:07:29 -0800
IronPort-SDR: UdQgNuwx5+ufsJ4dlq+lt4nLz79o1bEti5AcVcisLcTvMff4/Zi7EFkWaOBGKy/4+B2g0cwYdZ
 ou0Nno+JiegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="430183307"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2021 18:07:27 -0800
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
To:     Joerg Roedel <joro@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
Date:   Mon, 8 Mar 2021 09:58:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304122623.GD26414@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 3/4/21 8:26 PM, Joerg Roedel wrote:
> On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
>> When the first level page table is used for IOVA translation, it only
>> supports Read-Only and Read-Write permissions. The Write-Only permission
>> is not supported as the PRESENT bit (implying Read permission) should
>> always set. When using second level, we still give separate permissions
>> that allows WriteOnly which seems inconsistent and awkward. There is no
>> use case we can think off, hence remove that configuration to make it
>> consistent.
> 
> No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?
> 

The statement of no use case is not correct. Sorry about it.

As we have moved to use first level for IOVA translation, the first
level page table entry only provides RO and RW permissions. So if any
device driver specifies DMA_FROM_DEVICE attribution, it will get RW
permission in the page table. This patch aims to make the permissions
of second level and first level consistent. No impact on the use of
DMA_FROM_DEVICE attribution.

Best regards,
baolu
