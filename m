Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13AC319683
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhBKXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:23:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhBKXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:22:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BN798w151293;
        Thu, 11 Feb 2021 18:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=u33rdnapRAuoBitF00eBLwUv61eOLP0gDvEDPiwBYqg=;
 b=M5u0W4zJbipvxOsnM0jQBRMi5zhiZv5ARj941C8tD7DkBksPRz7V5yKNEZevggziu5kd
 kmQOkTNkUCAfUnKn+3qBOtTD1A7JpV62gt8Cqgb0gL+0DowLMQqbMN0DbBydcfR7gerG
 6aApZXvmLdJXNSqePH2mOEKacMcbG0nOnhlmPhVJ7VkoUcmCiEruTnCu6PflLoyAiy9m
 kl7Fe5jCrK8rvNip39C4tdZTBeiGWJtJXReLZVpGsSv5j5HvYWlF0CNF053zjxlH2e32
 ZeG5YvEHgUJlkgQo0MIImMFfCqTK7SFXKyq9gSIwso/iaXqnZ7D3LeLz3k/jHv4sJzgC Ww== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ndmerpq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 18:22:09 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BNE8JS000799;
        Thu, 11 Feb 2021 23:22:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 36hjr7u7hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:22:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BNLsGd19005950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 23:21:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6541A4055;
        Thu, 11 Feb 2021 23:22:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E43FA4040;
        Thu, 11 Feb 2021 23:22:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.156.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Feb 2021 23:22:03 +0000 (GMT)
Date:   Fri, 12 Feb 2021 01:22:02 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: drivers/media/common/videobuf2/videobuf2-dma-contig.c:509:5:
 error: implicit declaration of function '__pfn_to_phys'
Message-ID: <20210211232202.GS299309@linux.ibm.com>
References: <202102112238.87CWG6bY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102112238.87CWG6bY-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxlogscore=913
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:03:54PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
> commit: 4bfc848e0981fcd35db00fe1c6581560689f6dc7 m68k/mm: enable use of generic memory_model.h for !DISCONTIGMEM
> date:   8 weeks ago
> config: m68k-randconfig-r021-20210211 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bfc848e0981fcd35db00fe1c6581560689f6dc7
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 4bfc848e0981fcd35db00fe1c6581560689f6dc7
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/media/common/videobuf2/videobuf2-dma-contig.c: In function 'vb2_dc_get_userptr':
> >> drivers/media/common/videobuf2/videobuf2-dma-contig.c:509:5: error: implicit declaration of function '__pfn_to_phys' [-Werror=implicit-function-declaration]
>      509 |     __pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
>          |     ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Here is the fix:

From 9709296dbfb627b99defc2c152e1b2d264cf5b86 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Fri, 12 Feb 2021 01:12:15 +0200
Subject: [PATCH] m68k: make __pfn_to_phys() and __phys_to_pfn() available for !MMU

Recent changes that obsoleted DISCONTIGMEM on m68k switched the MMU variant
to use generic definitions of __pfn_to_phys() and __phys_to_pfn(), but
missed the !MMU variant which caused a build failure:

All errors (new ones prefixed by >>):

   drivers/media/common/videobuf2/videobuf2-dma-contig.c: In function 'vb2_dc_get_userptr':
>> drivers/media/common/videobuf2/videobuf2-dma-contig.c:509:5: error: implicit declaration of function '__pfn_to_phys' [-Werror=implicit-function-declaration]
     509 |     __pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
         |     ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Enable __pfn_to_phys() and __phys_to_pfn() on !MMU builds.

Fixes: 4bfc848e0981 ("m68k/mm: enable use of generic memory_model.h for !DISCONTIGMEM")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/m68k/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 6116d7094292..97087dd3ca6d 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,7 +62,7 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
+#if !defined(CONFIG_MMU) || defined(CONFIG_DISCONTIGMEM)
 #define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
 #define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
 #endif
-- 
2.28.0


