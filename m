Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADE33FD8D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCRDHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:07:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:37684 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhCRDHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:07:45 -0400
IronPort-SDR: yKaHnaUzQnywe95yNEuQkdb/x5Chl9qpJUdr+k7I/SBFtDGmMl0bIBydA5v3kZvJHv+LrCxaet
 +mQF0f3SNEoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="169509492"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="169509492"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 20:07:45 -0700
IronPort-SDR: To81mTiyNzacaGr5ZeEbxfATpWia2tmPKB2sFuzkB9r9yHyKe+V7SxCkeKvoOXKX4lQ4qQgQOP
 JadvHCF0TF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="433651877"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2021 20:07:43 -0700
Cc:     baolu.lu@linux.intel.com,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, chenjiashang@huawei.com
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To:     Alex Williamson <alex.williamson@redhat.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
 <20210317091820.5f4ab69e@omen.home.shazbot.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <87a5f90a-d1ea-fe7a-2577-fdfdf25f8fd7@linux.intel.com>
Date:   Thu, 18 Mar 2021 10:58:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317091820.5f4ab69e@omen.home.shazbot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 3/17/21 11:18 PM, Alex Williamson wrote:
>>>           {MAP,   0x0, 0xc0000000}, --------------------------------- (b)
>>>                   use GDB to pause at here, and then DMA read IOVA=0,
>> IOVA 0 seems to be a special one. Have you verified with other addresses
>> than IOVA 0?
> It is???  That would be a problem.
> 

No problem from hardware point of view as far as I can see. Just
thought about software might handle it specially.

Best regards,
baolu
