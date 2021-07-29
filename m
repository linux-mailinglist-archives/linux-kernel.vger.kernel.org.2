Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268083DA6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhG2OoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:44:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237204AbhG2OnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:43:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TEYaQg132506;
        Thu, 29 Jul 2021 10:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1WnoUeY2cTdqyR8/5IEUdSrKcbultvZ1pgIti/x/5GE=;
 b=rXEdq7f9mDsfNoeOSI0raRd6x3Z7ibuLxaibo2M1Jl4ytCLisxtWeslVdyjeZCBpuyXM
 viomk6dDgcWAPOeMrT7rNLKyhN7nRDPMzmx56+Z+08LfQVarkC6zXPRjrgAv69PO66Dc
 s1+PCGxkzG5oVqKdOTsQ+Y1k8pNfAw331MNE9lnOjVjIN8f9W/ZQWjJWpjayCAhVQgG4
 FYC/UiyF3nfOTpWO5COilcr0QrBeaTAN4UmN1qBvkQ8Nd9uRiCF2PkazbmSOaCeGHMYN
 Y9hcSzc9hZczqZ67uC0+T1Ii5MDs/M3kh7PqbFGF+KVwsKhbhsmbIGuEb5Fv4XUP6Idb 2g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3wftu115-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 10:43:04 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TEXMWN024299;
        Thu, 29 Jul 2021 14:42:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kh5wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 14:42:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TEeEYD29884830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 14:40:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7830C5215D;
        Thu, 29 Jul 2021 14:42:55 +0000 (GMT)
Received: from osiris (unknown [9.145.0.186])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3A4655211D;
        Thu, 29 Jul 2021 14:42:55 +0000 (GMT)
Date:   Thu, 29 Jul 2021 16:42:53 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] s390/boot: fix zstd build for -march=z900
Message-ID: <YQK+bbDzoqhOngxZ@osiris>
References: <202107280146.D9p1EaKo-lkp@intel.com>
 <cover.thread-f0f589.your-ad-here.call-01627564869-ext-2765@work.hours>
 <patch-1.thread-f0f589.git-f0f58936888f.your-ad-here.call-01627564869-ext-2765@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-1.thread-f0f589.git-f0f58936888f.your-ad-here.call-01627564869-ext-2765@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DHZgxyDvz1uoRlFqkI9oJWo9BDvY3Uwb
X-Proofpoint-GUID: DHZgxyDvz1uoRlFqkI9oJWo9BDvY3Uwb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:29:19PM +0200, Vasily Gorbik wrote:
> zstd decompression uses __builtin_clz() which fails back to __clzdi2()
> when the kernel is built for older hardware like z900. This leads to
> build failures like the following:
> s390x-11.1.0-ld: /devel/src/kernel/arch/s390/boot/compressed/../../../../lib/zstd/bitstream.h:148: undefined reference to `__clzdi2'
> 
> Fix that by optionally including lib/clz_ctz.c into the decompressor.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 7b034d9c1b08 ("s390/boot: add zstd support")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/boot/compressed/Makefile  | 1 +
>  arch/s390/boot/compressed/clz_ctz.c | 2 ++
>  2 files changed, 3 insertions(+)
>  create mode 100644 arch/s390/boot/compressed/clz_ctz.c

Applied, thanks!
