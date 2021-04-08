Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7251B357BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhDHFiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:38:16 -0400
Received: from ozlabs.org ([203.11.71.1]:60701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhDHFiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:38:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FG95h3Bvjz9sWC;
        Thu,  8 Apr 2021 15:38:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617860283;
        bh=JiVj825bhXGerOdP3QAAJMvSLpKA8dLeyo8ezDkiuDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F3GBQPT4mEx/8UkzNuegEdJ28NhDHhgsr9HJvlDE7uXSSaAw6IdFqMAYZXDWV7+Eo
         lxJ4CDT0qLPAjiMnAya9GMevNEnEFfqaAczcOBH3IRRegrMn8om4wumf8ie9Bw2ZJl
         BUw3Mql7pGCEcwwoWufvaQ6QoSIKUUw1U60PLqSmXrBn8HCgwfSlxgCFv/9tcn62po
         V3KvMBMHUe3Uio50BV5m5dJ1uos+qyNSt7kwUZruM3aRb0r+jUu+neItbrh7s2cRpX
         sBhrC2+id98VPf+zzKZXQ8kI3T0TprP5wN59SOMfZ+lEQdMWrpmsUuzMfhFpjltdow
         O+nx4sd3B6QBA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
In-Reply-To: <20210407195613.131140-1-leobras.c@gmail.com>
References: <20210407195613.131140-1-leobras.c@gmail.com>
Date:   Thu, 08 Apr 2021 15:37:59 +1000
Message-ID: <87im4xe3pk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Bras <leobras.c@gmail.com> writes:
> According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
> will let the OS know all possible pagesizes that can be used for creating a
> new DDW.
>
> Currently Linux will only try using 3 of the 8 available options:
> 4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
> 128M, 256M and 16G.

Do we know of any hardware & hypervisor combination that will actually
give us bigger pages?

> Enabling bigger pages would be interesting for direct mapping systems
> with a lot of RAM, while using less TCE entries.
>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 49 ++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9fc5217f0c8e..6cda1c92597d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -53,6 +53,20 @@ enum {
>  	DDW_EXT_QUERY_OUT_SIZE = 2
>  };

A comment saying where the values come from would be good.

> +#define QUERY_DDW_PGSIZE_4K	0x01
> +#define QUERY_DDW_PGSIZE_64K	0x02
> +#define QUERY_DDW_PGSIZE_16M	0x04
> +#define QUERY_DDW_PGSIZE_32M	0x08
> +#define QUERY_DDW_PGSIZE_64M	0x10
> +#define QUERY_DDW_PGSIZE_128M	0x20
> +#define QUERY_DDW_PGSIZE_256M	0x40
> +#define QUERY_DDW_PGSIZE_16G	0x80

I'm not sure the #defines really gain us much vs just putting the
literal values in the array below?

> +struct iommu_ddw_pagesize {
> +	u32 mask;
> +	int shift;
> +};
> +
>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>  {
>  	struct iommu_table_group *table_group;
> @@ -1099,6 +1113,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>  			 ret);
>  }
>  
> +/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. See LoPAR */
> +static int iommu_get_page_shift(u32 query_page_size)
> +{
> +	const struct iommu_ddw_pagesize ddw_pagesize[] = {
> +		{ QUERY_DDW_PGSIZE_16G,  __builtin_ctz(SZ_16G)  },
> +		{ QUERY_DDW_PGSIZE_256M, __builtin_ctz(SZ_256M) },
> +		{ QUERY_DDW_PGSIZE_128M, __builtin_ctz(SZ_128M) },
> +		{ QUERY_DDW_PGSIZE_64M,  __builtin_ctz(SZ_64M)  },
> +		{ QUERY_DDW_PGSIZE_32M,  __builtin_ctz(SZ_32M)  },
> +		{ QUERY_DDW_PGSIZE_16M,  __builtin_ctz(SZ_16M)  },
> +		{ QUERY_DDW_PGSIZE_64K,  __builtin_ctz(SZ_64K)  },
> +		{ QUERY_DDW_PGSIZE_4K,   __builtin_ctz(SZ_4K)   }
> +	};


cheers
