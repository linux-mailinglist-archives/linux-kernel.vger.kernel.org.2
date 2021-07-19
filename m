Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE23CD614
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhGSNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:08:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43758 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237216AbhGSNI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:08:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JDiL76022315;
        Mon, 19 Jul 2021 09:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hOh8r/dMzBjaNHOhgBJ7i/BDnLV2Wh67OjQ72cPjlDU=;
 b=XT+7WBV7cVbbBGYZ2s6ycaJCP+eP3IVZY5AmcoMtoVO3vl7/5ce1KDVQLI1bllS/rr6L
 /6epSpALiTfuT6qdkVxRjDLMg0qGYs2ND28jFGOuyFY/QOdV4mpsTCEaOSv9ziAa6tja
 fFmWX96nU+aYtN5tu55of/A1lGGmH8DRC80I+0ab1qqS+ti9kRJPpmcbXC+FSU8pcBv1
 WjzSfuADvHxx3866c8524MAa8LKThFJ/XercoJNPwyh96PBt67/3V8a834Ybahnd9jdr
 4yZFCKlie7G/rLhyZDFPD0Kj3P3dC8Vrx3YLufq/nRXVclo40ub/n+piffZNJB5Kute0 yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w8mdcbp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 09:48:44 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JDiZYj023962;
        Mon, 19 Jul 2021 09:48:44 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w8mdcbn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 09:48:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JDE0L1019237;
        Mon, 19 Jul 2021 13:48:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu88qwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 13:48:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JDmdKv22086096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 13:48:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D00BAE05D;
        Mon, 19 Jul 2021 13:48:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 419D5AE053;
        Mon, 19 Jul 2021 13:48:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.62.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 13:48:39 +0000 (GMT)
Subject: Re: [PATCH v5 01/11] powerpc/pseries/iommu: Replace hard-coded page
 shift
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-2-leobras.c@gmail.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <d96c25e1-41da-881b-da35-87ffb28ce335@linux.ibm.com>
Date:   Mon, 19 Jul 2021 15:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716082755.428187-2-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aoYFFamlToAmFJ5NdVz3ojPJHGLHIQ9u
X-Proofpoint-ORIG-GUID: 3BhhQd9Odk_NQ7t_B8pkeOLtNhQ9g0qS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2021 10:27, Leonardo Bras wrote:
> Some functions assume IOMMU page size can only be 4K (pageshift == 12).
> Update them to accept any page size passed, so we can use 64K pages.
> 
> In the process, some defines like TCE_SHIFT were made obsolete, and then
> removed.
> 
> IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figures 3.4 and 3.5 show
> a RPN of 52-bit, and considers a 12-bit pageshift, so there should be
> no need of using TCE_RPN_MASK, which masks out any bit after 40 in rpn.
> It's usage removed from tce_build_pSeries(), tce_build_pSeriesLP(), and
> tce_buildmulti_pSeriesLP().
> 
> Most places had a tbl struct, so using tbl->it_page_shift was simple.
> tce_free_pSeriesLP() was a special case, since callers not always have a
> tbl struct, so adding a tceshift parameter seems the right thing to do.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

FWIW,
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>



>   arch/powerpc/include/asm/tce.h         |  8 ------
>   arch/powerpc/platforms/pseries/iommu.c | 39 +++++++++++++++-----------
>   2 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
> index db5fc2f2262d..0c34d2756d92 100644
> --- a/arch/powerpc/include/asm/tce.h
> +++ b/arch/powerpc/include/asm/tce.h
> @@ -19,15 +19,7 @@
>   #define TCE_VB			0
>   #define TCE_PCI			1
>   
> -/* TCE page size is 4096 bytes (1 << 12) */
> -
> -#define TCE_SHIFT	12
> -#define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> -
>   #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
> -
> -#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
> -#define TCE_RPN_SHIFT		12
>   #define TCE_VALID		0x800		/* TCE valid */
>   #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
>   #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 0c55b991f665..b1b8d12bab39 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -107,6 +107,8 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   	u64 proto_tce;
>   	__be64 *tcep;
>   	u64 rpn;
> +	const unsigned long tceshift = tbl->it_page_shift;
> +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
>   
>   	proto_tce = TCE_PCI_READ; // Read allowed
>   
> @@ -117,10 +119,10 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   
>   	while (npages--) {
>   		/* can't move this out since we might cross MEMBLOCK boundary */
> -		rpn = __pa(uaddr) >> TCE_SHIFT;
> -		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +		rpn = __pa(uaddr) >> tceshift;
> +		*tcep = cpu_to_be64(proto_tce | rpn << tceshift);
>   
> -		uaddr += TCE_PAGE_SIZE;
> +		uaddr += pagesize;
>   		tcep++;
>   	}
>   	return 0;
> @@ -146,7 +148,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
>   	return be64_to_cpu(*tcep);
>   }
>   
> -static void tce_free_pSeriesLP(unsigned long liobn, long, long);
> +static void tce_free_pSeriesLP(unsigned long liobn, long, long, long);
>   static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
>   
>   static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> @@ -166,12 +168,12 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
>   		proto_tce |= TCE_PCI_WRITE;
>   
>   	while (npages--) {
> -		tce = proto_tce | (rpn & TCE_RPN_MASK) << tceshift;
> +		tce = proto_tce | rpn << tceshift;
>   		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, tce);
>   
>   		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
>   			ret = (int)rc;
> -			tce_free_pSeriesLP(liobn, tcenum_start,
> +			tce_free_pSeriesLP(liobn, tcenum_start, tceshift,
>   			                   (npages_start - (npages + 1)));
>   			break;
>   		}
> @@ -205,10 +207,11 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   	long tcenum_start = tcenum, npages_start = npages;
>   	int ret = 0;
>   	unsigned long flags;
> +	const unsigned long tceshift = tbl->it_page_shift;
>   
>   	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_PUT_TCE_IND)) {
>   		return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					   tbl->it_page_shift, npages, uaddr,
> +					   tceshift, npages, uaddr,
>   		                           direction, attrs);
>   	}
>   
> @@ -225,13 +228,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   		if (!tcep) {
>   			local_irq_restore(flags);
>   			return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					tbl->it_page_shift,
> +					tceshift,
>   					npages, uaddr, direction, attrs);
>   		}
>   		__this_cpu_write(tce_page, tcep);
>   	}
>   
> -	rpn = __pa(uaddr) >> TCE_SHIFT;
> +	rpn = __pa(uaddr) >> tceshift;
>   	proto_tce = TCE_PCI_READ;
>   	if (direction != DMA_TO_DEVICE)
>   		proto_tce |= TCE_PCI_WRITE;
> @@ -245,12 +248,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
>   
>   		for (l = 0; l < limit; l++) {
> -			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +			tcep[l] = cpu_to_be64(proto_tce | rpn << tceshift);
>   			rpn++;
>   		}
>   
>   		rc = plpar_tce_put_indirect((u64)tbl->it_index,
> -					    (u64)tcenum << 12,
> +					    (u64)tcenum << tceshift,
>   					    (u64)__pa(tcep),
>   					    limit);
>   
> @@ -277,12 +280,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   	return ret;
>   }
>   
> -static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long npages)
> +static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> +			       long npages)
>   {
>   	u64 rc;
>   
>   	while (npages--) {
> -		rc = plpar_tce_put((u64)liobn, (u64)tcenum << 12, 0);
> +		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, 0);
>   
>   		if (rc && printk_ratelimit()) {
>   			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
> @@ -301,9 +305,11 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
>   	u64 rc;
>   
>   	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
> -		return tce_free_pSeriesLP(tbl->it_index, tcenum, npages);
> +		return tce_free_pSeriesLP(tbl->it_index, tcenum,
> +					  tbl->it_page_shift, npages);
>   
> -	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
> +	rc = plpar_tce_stuff((u64)tbl->it_index,
> +			     (u64)tcenum << tbl->it_page_shift, 0, npages);
>   
>   	if (rc && printk_ratelimit()) {
>   		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
> @@ -319,7 +325,8 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
>   	u64 rc;
>   	unsigned long tce_ret;
>   
> -	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
> +	rc = plpar_tce_get((u64)tbl->it_index,
> +			   (u64)tcenum << tbl->it_page_shift, &tce_ret);
>   
>   	if (rc && printk_ratelimit()) {
>   		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
> 
