Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1877418698
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 07:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIZFbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 01:31:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229737AbhIZFbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 01:31:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18Q3I198022885;
        Sun, 26 Sep 2021 01:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1lsTWsJ6/U1LARLRntHRGjaGx2Qc6puQ6gYspoxIwoc=;
 b=NKtZlwSKHKVTYX6nPhqu9pkrnd8tnHAAe3ZlrvdmvJdLCn1XdUGTSH+rmRBJaLBFkzSS
 iSlBsX2OkUptZieewkifG6WXzR/ZTt3yo3KFUfd8BuoxOSumpdK14kvACboy6jGmwvWJ
 EIw5m4SJtZ4nI7UcCrhuc5ka9hcFN5Kau6Q/hFm3fPJS5ejPyKqtfowCod6drh2m4pbv
 zr+SjSGWNsiBtlIXJ0P67ugoTiul3OtgeqZshBiD3sV7VbEhdG0p7brneEau7F6W/8OY
 VaN+pFPt6PZBNjHUJ14tL+JX5873xbEnLkCC9RVOMoZ6zr3hNVDt4VyQC6LBZo2PY8UZ Zg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagua1f9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Sep 2021 01:29:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18Q5RDbD026939;
        Sun, 26 Sep 2021 05:29:46 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9ud9cfau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Sep 2021 05:29:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18Q5Omc951380634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Sep 2021 05:24:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC895204E;
        Sun, 26 Sep 2021 05:29:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.34.37])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5EE7C52050;
        Sun, 26 Sep 2021 05:29:43 +0000 (GMT)
Date:   Sun, 26 Sep 2021 08:29:41 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Andreas Oetken <andreas.oetken@siemens.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] NIOS2: setup.c: drop unused variable 'dram_start'
Message-ID: <YVAFRdc/DWN0scc7@linux.ibm.com>
References: <20210924210525.7053-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924210525.7053-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l0q3k16s2x3FvdLEN1FHY1JGXc6zIQmv
X-Proofpoint-GUID: l0q3k16s2x3FvdLEN1FHY1JGXc6zIQmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-25_07,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109260038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:05:25PM -0700, Randy Dunlap wrote:
> This is a nuisance when CONFIG_WERROR is set, so drop the variable
> declaration since the code that used it was removed.
> 
> ../arch/nios2/kernel/setup.c: In function 'setup_arch':
> ../arch/nios2/kernel/setup.c:152:13: warning: unused variable 'dram_start' [-Wunused-variable]
>   152 |         int dram_start;
> 
> Fixes: 7f7bc20bc41a ("nios2: Don't use _end for calculating min_low_pfn")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Andreas Oetken <andreas.oetken@siemens.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/nios2/kernel/setup.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-next-20210917.orig/arch/nios2/kernel/setup.c
> +++ linux-next-20210917/arch/nios2/kernel/setup.c
> @@ -149,8 +149,6 @@ static void __init find_limits(unsigned
> 
>  void __init setup_arch(char **cmdline_p)
>  {
> -	int dram_start;
> -
>  	console_verbose();
> 
>  	memory_start = memblock_start_of_DRAM();

-- 
Sincerely yours,
Mike.
