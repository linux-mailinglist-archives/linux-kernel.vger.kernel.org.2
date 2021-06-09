Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAB3A0E0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhFIHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:50:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:44454 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234011AbhFIHux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:50:53 -0400
IronPort-SDR: Az2widXAzVqt2LMZU7QdAT4h3RWDv1XlFS36QUXQ4lsAeCcsXa7jS38xrCCMCRra9x2vKcXDL/
 lmqQFRivuPMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290653379"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="290653379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 00:48:59 -0700
IronPort-SDR: PFd3i6KK743/tq3npJaexSx+N7YLLYHWZzbadclXJ5v6GicPi5RIYi/rz1d7xzFEttD3PYqYP6
 sJJsVtHQZ2SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552591618"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105]) ([10.239.159.105])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:48:54 -0700
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, yian.chen@intel.com, sohil.mehta@intel.com,
        ravi.v.shankar@intel.com, ashok.raj@intel.com
Subject: Re: [PATCH] iommu/vt-d: Dump DMAR translation structure
To:     Kyung Min Park <kyung.min.park@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210526233549.31569-1-kyung.min.park@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <13351083-2929-046b-0538-4f760ee89571@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:47:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526233549.31569-1-kyung.min.park@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 7:35 AM, Kyung Min Park wrote:
> When the dmar translation fault happens, the kernel prints a single line
> fault reason with corresponding hexadecimal code defined in the Intel VT-d
> specification.
> 
> Currently, when user wants to debug the translation fault in detail,
> debugfs is used for dumping the dmar_translation_struct, which is not
> available when the kernel failed to boot.
> 
> Dump the DMAR translation structure, pagewalk the IO page table and print
> the page table entry when the fault happens.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>

Please fix below compile error:

ld: drivers/iommu/intel/dmar.o: in function `dmar_fault_do_one':
/home/allen/Workspace/iommu/drivers/iommu/intel/dmar.c:1965: undefined 
reference to `dmar_fault_dump_ptes'
make: *** [Makefile:1191: vmlinux] Error 1

Best regards,
baolu

