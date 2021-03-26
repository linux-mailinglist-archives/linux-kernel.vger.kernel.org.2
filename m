Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399ED34A2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCZHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:40:07 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39905 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhCZHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:39:38 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lPh48-003gXi-Va; Fri, 26 Mar 2021 08:39:33 +0100
Received: from dynamic-089-012-002-103.89.12.pool.telefonica.de ([89.12.2.103] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lPh48-001Hx7-Op; Fri, 26 Mar 2021 08:39:32 +0100
Subject: Re: [PATCH] ia64: simplify code flow around swiotlb init
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210325233530.1397011-1-slyfox@gentoo.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <d0f37f22-1d2a-50f5-886b-5e4b9892b921@physik.fu-berlin.de>
Date:   Fri, 26 Mar 2021 08:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325233530.1397011-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.2.103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 3/26/21 12:35 AM, Sergei Trofimovich wrote:
> Before the change CONFIG_INTEL_IOMMU && !CONFIG_SWIOTLB && !CONFIG_FLATMEM
> 
> could skip `set_max_mapnr(max_low_pfn);` is iommu is not present on system.
                                           ^^
                                       typo s/is/if/

I will test this patch to make sure it doesn't break on the BL870c i4.

Adrian

> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-ia64@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  arch/ia64/mm/init.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 16d0d7d22657..a63585db94fe 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -644,13 +644,16 @@ mem_init (void)
>  	 * _before_ any drivers that may need the PCI DMA interface are
>  	 * initialized or bootmem has been freed.
>  	 */
> +	do {
>  #ifdef CONFIG_INTEL_IOMMU
> -	detect_intel_iommu();
> -	if (!iommu_detected)
> +		detect_intel_iommu();
> +		if (iommu_detected)
> +			break;
>  #endif
>  #ifdef CONFIG_SWIOTLB
>  		swiotlb_init(1);
>  #endif
> +	} while (0);
>  
>  #ifdef CONFIG_FLATMEM
>  	BUG_ON(!mem_map);
> 
-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

