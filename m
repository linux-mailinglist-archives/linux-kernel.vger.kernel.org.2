Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBB32F00A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCEQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:29:27 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:37986 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhCEQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:29:16 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125GOAXi001599;
        Fri, 5 Mar 2021 16:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=fJHyDTB2qPx+sZf6HGzCPJL+APYbN9P6V3Y1YSTgLkg=;
 b=ChkZ/+Iys3Az4ekP4HQ+/L3SjbR4IH8047LydBdT7q8DRaf760tIya+bdcF325aTPw8m
 +sl8rmm4GAyrPgyFACYvkKb8r+B9X3W+odos90PAUPgpNpoU8qOS0Ntv7pkJ1nVyorcj
 fR7ejuetWopl0XwVuwfR97mgtMjRAiD1O5UBrNd4Y/Dee9/FIJtoH3Aja2xs1DAV0M5k
 5MIn6wmDlGnnRphJRjnJc3UV3OfXXbjzlij9Ar87yEHdj2uxEPDgBa5TinNDOVcZ26FB
 8yeXnQOf6fDSpHDD5MDLnT6QoeEbYO/GVamDZsUvNC93H/5jpTePjMAi1JitarIb1Gn3 dA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 373feec5ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 16:29:04 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 2A2EB83;
        Fri,  5 Mar 2021 16:29:03 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 5E05237;
        Fri,  5 Mar 2021 16:29:02 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/platform/uv: Add set of kernel block size for hubless arches
Date:   Fri,  5 Mar 2021 10:28:53 -0600
Message-Id: <20210305162853.299892-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_10:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit below added a call to set the block size value that is needed
by the kernel to set the boundaries in the section list.  This was done
for UV Hubbed systems but missed in the UV Hubless setup.  Fix that
mistake by adding that same set call for hubless systems, which support
the same NVRAMS and Intel BIOS, thus the same problem occurs.

Fixes: bbbd2b51a2aa ("x86/platform/UV: Use new set memory block size function")

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
---
v2: Change patch description to match requirements.
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 52bc217ca8c3..c9ddd233e32f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1671,6 +1671,9 @@ static __init int uv_system_init_hubless(void)
 	if (rc < 0)
 		return rc;
 
+	/* Set section block size for current node memory */
+	set_block_size();
+
 	/* Create user access node */
 	if (rc >= 0)
 		uv_setup_proc_files(1);
-- 
2.21.0

