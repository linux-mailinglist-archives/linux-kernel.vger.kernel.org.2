Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC86309C07
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhAaMcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 07:32:33 -0500
Received: from services.gouders.net ([141.101.32.176]:34049 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhAaLfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:35:42 -0500
Received: from localhost (ltea-047-066-000-239.pools.arcor-ip.net [47.66.0.239])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 10VBT2Wt023944
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:29:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1612092543; bh=1UOfvjPVadRcsEZblv5wgGiNEHF3VcM77+wzdncuBgA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=KiUPO1FdL0u3/gLN1egAt6CCGIfPUf0RwjH8Wg8wop+kiHxzA10nVNAmYGdXH9nwI
         XbgT3daRdKWLOtZcUOlyLGg+Fnh8KsqWeckj1CMIs9ZsxyhwJ5ZJkoeGEUOo3Iya5W
         ZAeb3C2il36MlpRKI9TXVeoChHo5fS3NLkt1XDgU=
From:   Dirk Gouders <dirk@gouders.net>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add qi_submit trace event
In-Reply-To: <20210114090400.736104-1-baolu.lu@linux.intel.com> (Lu Baolu's
        message of "Thu, 14 Jan 2021 17:04:00 +0800")
References: <20210114090400.736104-1-baolu.lu@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sun, 31 Jan 2021 12:27:26 +0100
Message-ID: <gh1re1wdlt.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu Baolu <baolu.lu@linux.intel.com> writes:

> This adds a new trace event to track the submissions of requests to the
> invalidation queue. This event will provide the information like:
> - IOMMU name
> - Invalidation type
> - Descriptor raw data
>
> A sample output like:
> | qi_submit: iotlb_inv dmar1: 0x100e2 0x0 0x0 0x0
> | qi_submit: dev_tlb_inv dmar1: 0x1000000003 0x7ffffffffffff001 0x0 0x0
> | qi_submit: iotlb_inv dmar2: 0x800f2 0xf9a00005 0x0 0x0
>
> This will be helpful for queued invalidation related debugging.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

While compiling current linux-next for some other test I noticed a
compiler error because of this patch:

drivers/iommu/intel/dmar.c: In function =E2=80=98qi_submit_sync=E2=80=99:
drivers/iommu/intel/dmar.c:1311:3: error: implicit declaration of function =
=E2=80=98trace_qi_submit=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 1311 |   trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
      |   ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

On my machine CONFIG_INTEL_IOMMU is not set so
#include <trace/events/intel_iommu.h> cannot provide the prototype for
that function.

Dirk

> ---
>  drivers/iommu/intel/dmar.c         |  3 +++
>  include/trace/events/intel_iommu.h | 37 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 004feaed3c72..bd51f33642e0 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -31,6 +31,7 @@
>  #include <linux/limits.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/iommu_table.h>
> +#include <trace/events/intel_iommu.h>
>=20=20
>  #include "../irq_remapping.h"
>=20=20
> @@ -1307,6 +1308,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struc=
t qi_desc *desc,
>  		offset =3D ((index + i) % QI_LENGTH) << shift;
>  		memcpy(qi->desc + offset, &desc[i], 1 << shift);
>  		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_IN_USE;
> +		trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
> +				desc[i].qw2, desc[i].qw3);
>  	}
>  	qi->desc_status[wait_index] =3D QI_IN_USE;
>=20=20
> diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/in=
tel_iommu.h
> index 112bd06487bf..aad2ff0c1e2e 100644
> --- a/include/trace/events/intel_iommu.h
> +++ b/include/trace/events/intel_iommu.h
> @@ -135,6 +135,43 @@ DEFINE_EVENT(dma_map_sg, bounce_map_sg,
>  		 struct scatterlist *sg),
>  	TP_ARGS(dev, index, total, sg)
>  );
> +
> +TRACE_EVENT(qi_submit,
> +	TP_PROTO(struct intel_iommu *iommu, u64 qw0, u64 qw1, u64 qw2, u64 qw3),
> +
> +	TP_ARGS(iommu, qw0, qw1, qw2, qw3),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, qw0)
> +		__field(u64, qw1)
> +		__field(u64, qw2)
> +		__field(u64, qw3)
> +		__string(iommu, iommu->name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(iommu, iommu->name);
> +		__entry->qw0 =3D qw0;
> +		__entry->qw1 =3D qw1;
> +		__entry->qw2 =3D qw2;
> +		__entry->qw3 =3D qw3;
> +	),
> +
> +	TP_printk("%s %s: 0x%llx 0x%llx 0x%llx 0x%llx",
> +		  __print_symbolic(__entry->qw0 & 0xf,
> +				   { QI_CC_TYPE,	"cc_inv" },
> +				   { QI_IOTLB_TYPE,	"iotlb_inv" },
> +				   { QI_DIOTLB_TYPE,	"dev_tlb_inv" },
> +				   { QI_IEC_TYPE,	"iec_inv" },
> +				   { QI_IWD_TYPE,	"inv_wait" },
> +				   { QI_EIOTLB_TYPE,	"p_iotlb_inv" },
> +				   { QI_PC_TYPE,	"pc_inv" },
> +				   { QI_DEIOTLB_TYPE,	"p_dev_tlb_inv" },
> +				   { QI_PGRP_RESP_TYPE,	"page_grp_resp" }),
> +		__get_str(iommu),
> +		__entry->qw0, __entry->qw1, __entry->qw2, __entry->qw3
> +	)
> +);
>  #endif /* _TRACE_INTEL_IOMMU_H */
>=20=20
>  /* This part must be outside protection */
