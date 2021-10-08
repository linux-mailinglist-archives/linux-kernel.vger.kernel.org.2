Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD7426E7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhJHQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:18:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229673AbhJHQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:18:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198G6LWC004266;
        Fri, 8 Oct 2021 12:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wHGCaMhzns6E4VpxqMZNr4VPru4hJijspVi1FBW2b7k=;
 b=E+bmCS4A/CySBgDtynWh9zQJ3aUltNyAEV24rNsp1gDY32+5G9kNjaurogMYM42Oqldx
 TJTJvFKUj5BRrCF70JdsGLlTf/t6xRM5fKJeWlJHfvfwdRubvf8BnyvuGTQ7kG5KmAqG
 dFScAdqxJaeHxVc26hbiLhB/DMR1S9lZvPtF9uYyrRO4yTNtINXnB+xiTQ/FoHQLcA39
 OzfTwSKm4JXGTZvE8UJiRfnhqjC6ZFsxrZ4/Kty99Wyg0JgQZHs9fjuI5EMR6VeEhGNc
 HrESdHGqCHcPjOl5rcgmktYVu5VthsRKNIi7LH3lXemOeAKJjjv2ujXby8QRiDDx578W gA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjhum3ra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 12:16:03 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 198GCWji018814;
        Fri, 8 Oct 2021 16:16:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3bef2b01vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 16:16:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 198GFueG18678148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 16:15:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F50AA4062;
        Fri,  8 Oct 2021 16:15:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA33A405C;
        Fri,  8 Oct 2021 16:15:54 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.25.237])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 16:15:53 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@ozlabs.org,
        aneesh.kumar@linux.ibm.com
Subject: [PATCH 0/3] Update crashkernel offset to allow kernel to boot on large config LPARs
Date:   Fri,  8 Oct 2021 21:45:49 +0530
Message-Id: <20211008161552.211262-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iotpZJQFMPk9RQJDUmAEw2R28iADHRqK
X-Proofpoint-GUID: iotpZJQFMPk9RQJDUmAEw2R28iADHRqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080092
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

changes in v2:
	0001: Rename the function name to update_cpu_features() as per
	      the review comment.
	0002: Fixed compilation error reported by kernel test robot.
	0003: Added comment and updated commit message

Mahesh Salgaonkar (2):
  fixup mmu_features immediately after getting cpu pa features.
  Remove 256MB limit restriction for boot cpu paca allocation

Sourabh Jain (1):
  powerpc: Set crashkernel offset to mid of RMA region

 arch/powerpc/include/asm/book3s/64/mmu.h |  2 ++
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/kernel/prom.c               |  8 ++++++++
 arch/powerpc/kernel/rtas.c               |  4 ++++
 arch/powerpc/kexec/core.c                | 15 +++++++++++----
 arch/powerpc/mm/book3s64/hash_utils.c    |  5 ++++-
 arch/powerpc/mm/init_64.c                |  5 ++++-
 7 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.31.1

