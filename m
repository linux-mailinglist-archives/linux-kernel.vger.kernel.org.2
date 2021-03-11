Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2C336EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhCKJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:17:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231918AbhCKJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:16:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12B94BJB079599;
        Thu, 11 Mar 2021 04:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NTUxSj/ZvJD7UMviL6RQgq5D7zSxRgUaGUGx61pbYPU=;
 b=QGLxfQTiWPU2O95O6mSoU+nfwP6cdNVk59eONYnrKRZl8jvFYGRij8qzFP3FSgNY/ICd
 fhZXxrYm+TxXQC5Ttok7/AI9OMB/kFl+ZVys/slDmaLzTJ8Swy2ohDN/xhTQ+ewSWE0N
 UUv/AEwE0rG/pJCDNQsnR03BPKKLSKpHXDFNWFnCNYQrsxAuWSOx8MaT/t+rqJpRzNrk
 ed48rCB8pve3E5iH5/rg7ud3gXmbJERx5pWsugdTZv1u2uCmDDq0vhYI1pmqXurZcd5p
 dUYn46aT3cNX7M3k0Q0/5883qX+lC3Lxl7nqerHbLLNcN2Hm57+xtLZZprMO066nQx2u sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m3gskr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 04:16:05 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12B95OHI085293;
        Thu, 11 Mar 2021 04:16:04 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m3gsje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 04:16:04 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12B9EQSq005375;
        Thu, 11 Mar 2021 09:16:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 376agr0vje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 09:16:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12B9Fx1337224818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 09:15:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C0654205C;
        Thu, 11 Mar 2021 09:15:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6431942049;
        Thu, 11 Mar 2021 09:15:56 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.41.237])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 09:15:56 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        paulus@samba.org, jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu
Subject: [PATCH v5] powerpc/uprobes: Validation for prefixed instruction
Date:   Thu, 11 Mar 2021 14:45:38 +0530
Message-Id: <20210311091538.368590-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per ISA 3.1, prefixed instruction should not cross 64-byte
boundary. So don't allow Uprobe on such prefixed instruction.

There are two ways probed instruction is changed in mapped pages.
First, when Uprobe is activated, it searches for all the relevant
pages and replace instruction in them. In this case, if that probe
is on the 64-byte unaligned prefixed instruction, error out
directly. Second, when Uprobe is already active and user maps a
relevant page via mmap(), instruction is replaced via mmap() code
path. But because Uprobe is invalid, entire mmap() operation can
not be stopped. In this case just print an error and continue.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Sandipan Das <sandipan@linux.ibm.com>
---
v4: https://lore.kernel.org/r/20210305115433.140769-1-ravi.bangoria@linux.ibm.com
v4->v5:
  - Replace SZ_ macros with numbers

 arch/powerpc/kernel/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index e8a63713e655..186f69b11e94 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 	if (addr & 0x03)
 		return -EINVAL;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
+	    ppc_inst_prefixed(auprobe->insn) &&
+	    (addr & 0x3f) == 60) {
+		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.27.0

