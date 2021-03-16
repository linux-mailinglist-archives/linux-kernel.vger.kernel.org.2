Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352433CE61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCPHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:04:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50154 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229540AbhCPHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:04:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12G72XXM119941;
        Tue, 16 Mar 2021 03:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+v4+oo99lYmkSGGgW/Q+P5qZ1gw/VuyyQrJqKexrzvk=;
 b=SBpZan8ZD70bv+32YpZIO7lFwV8WF1StI1pmF1d1YciIi3sBIysQTRvT/+DNosu+C7qM
 +voJKB/Xo71KEtvVM5cUH+tl6nieq9CD+a8k+/Z+401IcHtuWUriBGszh/caeycmww5B
 rOAST/Po/rUGjJtTONkPaxU7kC41BDsrESIgGcX9fJMcVN+ZTzWvJkTQJ0LxnvSRRwMS
 hyhHQlDg+sLy5TCGu4sCxU3hhjDSCfPgJj4R+vzyMit6pH1uYbXS/QdnmwZ3P5ZPVyVc
 v8koumk8MvyyIjyTPPIagAY4NLyPOAlQNn16AsElbzKnLlnsoJThh537lVAerCE+0B6Y +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ap2t2qjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 03:04:02 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12G73C9l121473;
        Tue, 16 Mar 2021 03:04:02 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ap2t2qgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 03:04:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12G7407N011575;
        Tue, 16 Mar 2021 07:04:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 378n189bqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 07:04:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12G73vp641943384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 07:03:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D93B611C05E;
        Tue, 16 Mar 2021 07:03:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F076511C04C;
        Tue, 16 Mar 2021 07:03:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.58.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Mar 2021 07:03:56 +0000 (GMT)
Date:   Tue, 16 Mar 2021 09:03:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in
 reference from the function memblock_find_in_range_node() to the function
 .init.text:memblock_bottom_up()
Message-ID: <YFBYWjtWJrnGyiVp@linux.ibm.com>
References: <202103160133.UzhgY0wt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103160133.UzhgY0wt-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_15:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103160046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:23:08AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> commit: 34dc2efb39a231280fd6696a59bbe712bf3c5c4a memblock: fix section mismatch warning
> date:   2 days ago
> config: arm64-randconfig-r013-20210315 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a28facba1ccdc957f386b7753f4958307f1bfde8)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34dc2efb39a231280fd6696a59bbe712bf3c5c4a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 34dc2efb39a231280fd6696a59bbe712bf3c5c4a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0x74fea4): Section mismatch in reference from the function memblock_find_in_range_node() to the function .init.text:memblock_bottom_up()
> The function memblock_find_in_range_node() references
> the function __init memblock_bottom_up().
> This is often because memblock_find_in_range_node lacks a __init
> annotation or the annotation of memblock_bottom_up is wrong.

I don't have clang-13 setup handy so I could not check, but I think this
should be the fix:

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d13e3cd938b4..5984fff3f175 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -460,7 +460,7 @@ static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
 /*
  * Set the allocation direction to bottom-up or top-down.
  */
-static inline __init void memblock_set_bottom_up(bool enable)
+static inline __init_memblock void memblock_set_bottom_up(bool enable)
 {
 	memblock.bottom_up = enable;
 }
@@ -470,7 +470,7 @@ static inline __init void memblock_set_bottom_up(bool enable)
  * if this is true, that said, memblock will allocate memory
  * in bottom-up direction.
  */
-static inline __init bool memblock_bottom_up(void)
+static inline __init_memblock bool memblock_bottom_up(void)
 {
 	return memblock.bottom_up;
 }

 
-- 
Sincerely yours,
Mike.
