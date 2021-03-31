Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8301134E601
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhC3LCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:02:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhC3LCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:02:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UAWox4077568;
        Tue, 30 Mar 2021 07:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=om4kXnc6pLolT/LnZcgl5vqCg2/CTpifzvCZklyOw3g=;
 b=GqOKa5c3QazKpLo+wJwVBdzBoLW2q+17G9fgrg/AKrXY2nGatyDmenB3C90GQogSiuQM
 B9z3b1aQ/g02KJhvf1XIhG4Z3HVKUfObjp5OXQzNQzCvoPyLtkrR3nrmMebPdAf4W2QK
 +xaqGFd6bqqJwWDZomD6nGTFCPO8nYXUbIip4ujPPr8meLoFKR5oN+T64osMvpTU/eKf
 npSk0OM1fguPKbDhIAANCgmAWX1rVOtP0XTX5bGHtjcE1dx2gWruhlF9mg2U8rfWwLkk
 K1ad8kRGoYXQCGSnPUcDl5hMQRa2muqPR/BEBxI3iRn9mOiVISagJqxntFIiALaJHuHu +g== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhrv5416-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 07:02:18 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UAv7Cs005488;
        Tue, 30 Mar 2021 11:02:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 37hvb9a5yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 11:02:17 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UB2GSN12321244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 11:02:16 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FCE46A04D;
        Tue, 30 Mar 2021 11:02:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E8286A057;
        Tue, 30 Mar 2021 11:02:13 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.52.226])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 11:02:12 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm/region: Allow setting align attribute on
 regions without mappings
In-Reply-To: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
References: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
Date:   Tue, 30 Mar 2021 16:32:10 +0530
Message-ID: <87h7ks7vm5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OxXYJEFgsgdkfzk5hXQMLRFhUREY3PS6
X-Proofpoint-ORIG-GUID: OxXYJEFgsgdkfzk5hXQMLRFhUREY3PS6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_03:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler Hicks <tyhicks@linux.microsoft.com> writes:

> The alignment constraint for namespace creation in a region was
> increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
> commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
> attribute"). The thought behind the change was that region alignment
> should be uniform across all architectures and, since PowerPC had the
> largest alignment constraint of 16M, all architectures should conform to
> that alignment.
>
> The change regressed namespace creation in pre-defined regions that
> relied on 2M alignment but a workaround was provided in the form of a
> sysfs attribute, named 'align', that could be adjusted to a non-default
> alignment value.
>
> However, the sysfs attribute's store function returned an error (-ENXIO)
> when userspace attempted to change the alignment of a region that had no
> mappings. This affected 2M aligned regions of volatile memory that were
> defined in a device tree using "pmem-region" and created by the
> of_pmem_region_driver, since those regions do not contain mappings
> (ndr_mappings is 0).
>
> Allow userspace to set the align attribute on pre-existing regions that
> do not have mappings so that namespaces can still be within those
> regions, despite not being aligned to 16M.
>
> Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/nvdimm/region_devs.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119db574..09cff8aa6b40 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -545,29 +545,32 @@ static ssize_t align_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev);
> -	unsigned long val, dpa;
> -	u32 remainder;
> +	unsigned long val;
>  	int rc;
>  
>  	rc = kstrtoul(buf, 0, &val);
>  	if (rc)
>  		return rc;
>  
> -	if (!nd_region->ndr_mappings)
> -		return -ENXIO;
> -
> -	/*
> -	 * Ensure space-align is evenly divisible by the region
> -	 * interleave-width because the kernel typically has no facility
> -	 * to determine which DIMM(s), dimm-physical-addresses, would
> -	 * contribute to the tail capacity in system-physical-address
> -	 * space for the namespace.
> -	 */
> -	dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> -	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
> -			|| val > region_size(nd_region) || remainder)
> +	if (val > region_size(nd_region))
>  		return -EINVAL;
>  
> +	if (nd_region->ndr_mappings) {
> +		unsigned long dpa;
> +		u32 remainder;
> +
> +		/*
> +		 * Ensure space-align is evenly divisible by the region
> +		 * interleave-width because the kernel typically has no facility
> +		 * to determine which DIMM(s), dimm-physical-addresses, would
> +		 * contribute to the tail capacity in system-physical-address
> +		 * space for the namespace.
> +		 */
> +		dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> +		if (!is_power_of_2(dpa) || dpa < PAGE_SIZE || remainder)
> +			return -EINVAL;
> +	}

We still want

else {

if (!is_power_of_2(val) || val < PAGE_SIZE)
         return -EINVAL?

}
> +
>  	/*
>  	 * Given that space allocation consults this value multiple
>  	 * times ensure it does not change for the duration of the
> -- 
> 2.25.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
