Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C630F993
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhBDRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:23:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238428AbhBDRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:20:40 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114H7wRf089935;
        Thu, 4 Feb 2021 12:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AoG+PFR1pEEkI7Av2jf3eHjRkQdXym44QowalITkavs=;
 b=OvaDceZV7QTvRGwovHAZSnhusnNoytj6a3PqrzU7vka4YCoAMZb3X6MPI4cbWYpCwOzK
 g/UDg1ZewreMYB+gidNMwSZbsQc2oHMSl7kEq/gTuCgN0MT9X2DnV3S7fvtscpbe6f6i
 YqcR5Ll3h953toSeCBMcyawZwpBFmyGCSdTLabQ4J4/OIPdY78Cl0f2gXU3gtnIiLU/D
 mfXlw6pji67Kj/EaMwJMbFZWVvH5E2YQR3Z91y5cPnHZWgLLzvz94AWc3YUNMQAKn7F8
 vOsVmEHBECHOv1rN19cm2txbIiC+rNtygj+3yDgsHaXOyP5cM14Xm5pQnzvtHR9wjHq7 4g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gmn4gvt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 12:19:45 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114HH1TO011620;
        Thu, 4 Feb 2021 17:19:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36cy38n51g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 17:19:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114HJWwh39846266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 17:19:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0907AE057;
        Thu,  4 Feb 2021 17:19:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49AF3AE045;
        Thu,  4 Feb 2021 17:19:31 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.145.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Feb 2021 17:19:31 +0000 (GMT)
Date:   Thu, 4 Feb 2021 19:19:27 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        software@gaisler.com
Subject: Re: [PATCH] sparc32: Limit memblock allocation to low memory
Message-ID: <20210204171927.GK299309@linux.ibm.com>
References: <20210204162053.3954-1-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204162053.3954-1-andreas@gaisler.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_09:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:20:53PM +0100, Andreas Larsson wrote:
> Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 changed sparc32 to use
> memblocks instead of bootmem, but also made high memory available via
> memblock allocation which does work together with e.g. phys_to_virt and
> leads to crashes.
> 
> This changes back to only low memory being allocatable in the early
> stages, now using memblock allocation.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/sparc/mm/init_32.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index eb2946b1df8a..6139c5700ccc 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -197,6 +197,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
>  	size = memblock_phys_mem_size() - memblock_reserved_size();
>  	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
>  
> +	/* Only allow low memory to be allocated via memblock allocation */
> +	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
> +
>  	return max_pfn;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
