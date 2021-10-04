Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DA42125D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhJDPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:13:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233403AbhJDPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:13:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194EslAb013231;
        Mon, 4 Oct 2021 11:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/pED2LQC9LqzPJIxtOTF67GmisCBvq2p2EFye0bxS+g=;
 b=dOHSy1ErN0zyIJDbW/JODWeaoLyGqrVeXVe/bgBll9a599vaxXAP73RFBxGabeoIbQud
 N+1GC3wAvj5ZXbBzkqsU6o1KMYGm2i6j+FxTCCIHqUF5i63UPCgzPAtIdaICwbEpSx/l
 AQbPJJralGVaxgLq8PmhrjplqpOkihxFyME1QFjODf2CjRWqZ9wyOEwLRZif4Smk0xF6
 9MRQ7HScU1nXpmZ0aS0TGC3ohNCYGnq0mTyuP5d7P8TJjxUUKwWLvmyL2DHSZme7kHz+
 sKkd2Ffj1evPqV2VgYhgd8jSQNgNCsHCu8L/d5+ONtTLrAfUQ4uCydDqD0KruDc9kJIE aw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bg35qhra3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 11:11:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194F962A004392;
        Mon, 4 Oct 2021 15:11:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3bef29rq9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 15:11:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194FBin83539496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 15:11:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC65211C04C;
        Mon,  4 Oct 2021 15:11:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1729B11C07A;
        Mon,  4 Oct 2021 15:11:43 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.74.5])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 15:11:42 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        aneesh.kumar@linux.ibm.com
Subject: [PATCH 0/3] Update crashkernel offset to allow kernel to boot on large config LPARs
Date:   Mon,  4 Oct 2021 20:41:39 +0530
Message-Id: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iNvzv-4BJDcjOxbAUGQX5Q8cRZgEYe-D
X-Proofpoint-ORIG-GUID: iNvzv-4BJDcjOxbAUGQX5Q8cRZgEYe-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the crashkernel reserve memory at 128MB offset in the first memory
block, it leaves less than 128MB memory to accommodate other essential
system resources that need memory reservation in the same block. This
creates kernel boot failure on large config LPARs having core count
greater than 192.

Setting the crashkernel to mid of RMA size which can be 512MB or more
instead of capping it to 128MB by default leaves enough space to allocate
memory to another system resource in the first memory block.

Now keeping the crashkernel at mid of RMA size works fine for the primary
kernel but creates boot failure for the kdump kernel when the crashekernel
reservation start offset crosses 256MB. The reason is, in the early boot
MMU feature of 1T segments support is not detected which restricts the paca
allocation for boot CPU below 256MB. When the crashkernel itself is
starting at 256MB offset, attempt to allocate paca below 256MB leads to the
kdump kernel boot failure.

Moving the detection of segment sizes before identifying the boot CPU
removes the restriction of 256MB limit for boot CPU paca allocation
which allows the kdump kernel to successfully boot and capture vmcore.

While allocating paca for boot CPU we found that there is a small window
during kernel boot where early_radix_enabled returns True even though
the radix is disabled using command-line. This leads to an invalid bolated
size calculation on which paca limit of boot CPU is dependent. Patch 0001
closes that window that by fixing the radix bit in mmu_feature.

Mahesh Salgaonkar (2):
  fixup mmu_features immediately after getting cpu pa features.
  Remove 256MB limit restriction for boot cpu paca allocation

Sourabh Jain (1):
  powerpc: Set crashkernel offset to mid of RMA region

 arch/powerpc/include/asm/book3s/64/mmu.h |  2 ++
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/kernel/prom.c               |  5 +++++
 arch/powerpc/kernel/rtas.c               |  3 +++
 arch/powerpc/kexec/core.c                | 13 +++++++++----
 arch/powerpc/mm/book3s64/hash_utils.c    |  5 ++++-
 arch/powerpc/mm/init_64.c                |  5 ++++-
 7 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.31.1

