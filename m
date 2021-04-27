Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC236CBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhD0Tkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:40:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238892AbhD0Tiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:38:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJXHmJ177005;
        Tue, 27 Apr 2021 15:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4SIH/+UGufAepLuHzfpxXUXRTKXWIo956SsozOH2pgU=;
 b=TqFhozY3U40JI5uWQv46HKTwD/I2y5AHckemVLxfTEicgxBDRZTk24dLncMifL+KugSU
 sTkxXTq8BPInKQXl8GTH30mSu/Yy/8PRaFarflT8RLF0IV/+n2LSJOeSJYsXHSjAUEWJ
 mUg5Thnz8zURd37EB8obZ4HhNcI5syxRgho8N2qaNutWZFgFwGkVHCrI7k9Eg4us4cm1
 AHZ++6MNGjJ1y6Mu0qv/qYW11rrIbDBOuneR+Zavct5wJSI2XdRRGXQe6hzPxPhLUttF
 ibs8duyNibpQl1MDl9USWZvfI3OWg/Elxz/NfaS4OTsLisIdZErHtdvsbMCYkY320X8h AQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386rtsg5e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:37:45 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RJaU9I025674;
        Tue, 27 Apr 2021 19:37:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 384ay95j9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:37:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RJbh4N30605696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 19:37:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D4EF6A047;
        Tue, 27 Apr 2021 19:37:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 446A16A04D;
        Tue, 27 Apr 2021 19:37:42 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.213.116])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 19:37:41 +0000 (GMT)
Subject: Re: [PATCH] pseries/drmem: update LMBs after LPM
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     nathanl@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210427181308.17640-1-ldufour@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <25fc405a-6de1-5b21-6692-831ddede7c83@linux.ibm.com>
Date:   Tue, 27 Apr 2021 12:37:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427181308.17640-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HQdKSyTQB1io-OQ0STWV_TZc24Fnfx1F
X-Proofpoint-GUID: HQdKSyTQB1io-OQ0STWV_TZc24Fnfx1F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_11:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 11:13 AM, Laurent Dufour wrote:
> After a LPM, the device tree node ibm,dynamic-reconfiguration-memory may be
> updated by the hypervisor in the case the NUMA topology of the LPAR's
> memory is updated.
> 
> This is caught by the kernel, but the memory's node is updated because
> there is no way to move a memory block between nodes.
> 
> If later a memory block is added or removed, drmem_update_dt() is called
> and it is overwriting the DT node to match the added or removed LMB. But
> the LMB's associativity node has not been updated after the DT node update
> and thus the node is overwritten by the Linux's topology instead of the
> hypervisor one.
> 
> Introduce a hook called when the ibm,dynamic-reconfiguration-memory node is
> updated to force an update of the LMB's associativity.
> 
> Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Change since V1:
>  - Take Tyrel's idea to rely on OF_RECONFIG_UPDATE_PROPERTY instead of
>  introducing a new hook mechanism.
> ---
>  arch/powerpc/include/asm/drmem.h              |  1 +
>  arch/powerpc/mm/drmem.c                       | 35 +++++++++++++++++++
>  .../platforms/pseries/hotplug-memory.c        |  4 +++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
> index bf2402fed3e0..4265d5e95c2c 100644
> --- a/arch/powerpc/include/asm/drmem.h
> +++ b/arch/powerpc/include/asm/drmem.h
> @@ -111,6 +111,7 @@ int drmem_update_dt(void);
>  int __init
>  walk_drmem_lmbs_early(unsigned long node, void *data,
>  		      int (*func)(struct drmem_lmb *, const __be32 **, void *));
> +void drmem_update_lmbs(struct property *prop);
>  #endif
>  
>  static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
> index 9af3832c9d8d..f0a6633132af 100644
> --- a/arch/powerpc/mm/drmem.c
> +++ b/arch/powerpc/mm/drmem.c
> @@ -307,6 +307,41 @@ int __init walk_drmem_lmbs_early(unsigned long node, void *data,
>  	return ret;
>  }
>  
> +/*
> + * Update the LMB associativity index.
> + */
> +static int update_lmb(struct drmem_lmb *updated_lmb,
> +		      __maybe_unused const __be32 **usm,
> +		      __maybe_unused void *data)
> +{
> +	struct drmem_lmb *lmb;
> +
> +	/*
> +	 * Brut force there may be better way to fetch the LMB
> +	 */
> +	for_each_drmem_lmb(lmb) {
> +		if (lmb->drc_index != updated_lmb->drc_index)
> +			continue;
> +
> +		lmb->aa_index = updated_lmb->aa_index;
> +		break;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Update the LMB associativity index.
> + *
> + * This needs to be called when the hypervisor is updating the
> + * dynamic-reconfiguration-memory node property.
> + */
> +void drmem_update_lmbs(struct property *prop)
> +{
> +	if (!strcmp(prop->name, "ibm,dynamic-memory"))
> +		__walk_drmem_v1_lmbs(prop->value, NULL, NULL, update_lmb);
> +	else if (!strcmp(prop->name, "ibm,dynamic-memory-v2"))
> +		__walk_drmem_v2_lmbs(prop->value, NULL, NULL, update_lmb);
> +}
>  #endif
>  
>  static int init_drmem_lmb_size(struct device_node *dn)
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..8aabaafc484b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -949,6 +949,10 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>  	case OF_RECONFIG_DETACH_NODE:
>  		err = pseries_remove_mem_node(rd->dn);
>  		break;
> +	case OF_RECONFIG_UPDATE_PROPERTY:
> +		if (!strcmp(rd->dn->full_name,

Pretty much a self nit on myself since I just copied the device node name field
from your initial patch into my suggested code block.

It used to be that dn->full_name was intended to store the full device-tree path
name of the device node ane dn->name simply the base name. These days the values
of both name fields are simply the basename for pseries. Regardless,
rd->dn->name is technically correct and shorter.

-Tyrel

> +			    "ibm,dynamic-reconfiguration-memory"))
> +			drmem_update_lmbs(rd->prop);
>  	}
>  	return notifier_from_errno(err);
>  }
> 

