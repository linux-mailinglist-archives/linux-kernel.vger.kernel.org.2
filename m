Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7255A421261
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhJDPNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:13:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235652AbhJDPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:13:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194F75eu002231;
        Mon, 4 Oct 2021 11:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=103pzxgjTN/en4mFuBF8OOnn+0rrO/D8X/N82+cJsvo=;
 b=P21lfaDWya01WStsdc0YxOXQeI81Lo+N4hKsHpLxrobqAcVa/rfwTlj3rorxIO0Eb1xf
 0aWRoLHo74YZdZOPFAHlQueXcwDx12ZNofDxO+qUuQejPbbnRopfH70s/uH7XBY6k0Zt
 /kbjzTKdX6NiQ80NpBRyFAH/URf0MvWiLBSACMCVRVdnCsVTbJjdFneCwjJPbu86rqEg
 exJq62ftOvxVol3MtPqcBmQulVMiiy9ixssuk7vTbyTDMZoWVG6UHMmut99GCBg0feGg
 kCIy3gpnZNhyXryWLwy84NmsawS8YBvicYxmxAeQGgJKuuTgDRqaNBfhOoXK+y+hkzcQ KA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg2c82vja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 11:11:59 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194F8qWw005310;
        Mon, 4 Oct 2021 15:11:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3beepj79yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 15:11:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194F6avc56164710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 15:06:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656FF11C06C;
        Mon,  4 Oct 2021 15:11:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FC4F11C058;
        Mon,  4 Oct 2021 15:11:51 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.74.5])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 15:11:51 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        aneesh.kumar@linux.ibm.com,
        Abdul haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc: Set crashkernel offset to mid of RMA region
Date:   Mon,  4 Oct 2021 20:41:42 +0530
Message-Id: <20211004151142.256251-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
References: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0RbC9UD_uyENV6xUjV41H2xetvyc8b_K
X-Proofpoint-GUID: 0RbC9UD_uyENV6xUjV41H2xetvyc8b_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On large config LPARs (having 192 and more cores), Linux fails to boot
due to insufficient memory in the first memory block. It is due to the
reserve crashkernel area starts at 128MB offset by default and which
doesn't leave enough space in the first memory block to accommodate
memory for other essential system resources.

Given that the RMA region size can be 512MB or more, setting the
crashkernel offset to mid of RMA size will leave enough space to
kernel to allocate memory for other system resources in the first
memory block.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reported-and-tested-by: Abdul haleem <abdhalee@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c |  3 +++
 arch/powerpc/kexec/core.c  | 13 +++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index ff80bbad22a5..ce5e62bb4d8e 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1235,6 +1235,9 @@ int __init early_init_dt_scan_rtas(unsigned long node,
 	entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
 	sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
 
+	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL))
+		powerpc_firmware_features |= FW_FEATURE_LPAR;
+
 	if (basep && entryp && sizep) {
 		rtas.base = *basep;
 		rtas.entry = *entryp;
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 48525e8b5730..f69cf3e370ec 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -147,11 +147,16 @@ void __init reserve_crashkernel(void)
 	if (!crashk_res.start) {
 #ifdef CONFIG_PPC64
 		/*
-		 * On 64bit we split the RMO in half but cap it at half of
-		 * a small SLB (128MB) since the crash kernel needs to place
-		 * itself and some stacks to be in the first segment.
+		 * crash kernel needs to placed in the first segment. On LPAR
+		 * setting crash kernel start to mid of RMA size (512MB or more)
+		 * would help primary kernel to boot properly on large config
+		 * LPAR (with core count 192 or more) and for the reset keep
+		 * cap the crash kernel start at 128MB offse.
 		 */
-		crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
+		if (firmware_has_feature(FW_FEATURE_LPAR))
+			crashk_res.start = ppc64_rma_size / 2;
+		else
+			crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
 #else
 		crashk_res.start = KDUMP_KERNELBASE;
 #endif
-- 
2.31.1

