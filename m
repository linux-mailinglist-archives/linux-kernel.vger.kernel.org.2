Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C19B3998CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 06:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCEEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 00:04:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:61449 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhFCEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 00:04:15 -0400
IronPort-SDR: nA1mvO6xdl617qgFT3hojha54zW0hGOpvwnSrBfAl5vMKvoxcGrk+9mh53v9TSAL6c/QmribeT
 wQ8NPwcwhbqw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203988459"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203988459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 21:02:31 -0700
IronPort-SDR: eEPbiSnatcxwFz1MIHAGiqlURWg97YVMLLchQhh6e6iCeiUcbEie29Jt0yKv9fUFRmBH2QL+yg
 Gh0zCTGCIDmA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="417188440"
Received: from sboinap-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 21:02:31 -0700
Subject: Re: [PATCH v1 4/8] x86/tdx: Add arch_has_restricted_memory_access for
 TDX
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-5-ak@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2dd6a4a1-e5f7-23e2-9c5b-abfe8ff20e79@linux.intel.com>
Date:   Wed, 2 Jun 2021 21:02:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-5-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 5:41 PM, Andi Kleen wrote:
> +int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return is_tdx_guest();
> +}
> +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> +

This function definition had to be removed from arch/x86/mm/mem_encrypt.c.

Otherwise, if you enable both CONFIG_AMD_MEM_ENCRYPT,
CONFIG_X86_MEM_ENCRYPT_COMMON it will generate multiple definition error.

--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -493,9 +493,3 @@ void __init amd_mem_encrypt_init(void)

         print_mem_encrypt_feature_info();
  }
-
-int arch_has_restricted_virtio_memory_access(void)
-{
-       return sev_active();
-}
-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);

--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -40,7 +40,7 @@ void __init mem_encrypt_init(void)

  int arch_has_restricted_virtio_memory_access(void)
  {
-       return is_tdx_guest();
+       return (is_tdx_guest() || sev_active());
  }
  EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
