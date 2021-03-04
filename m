Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6332DD40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhCDWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:40:30 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:26834 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232160AbhCDWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:40:29 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124Md1HE026134;
        Thu, 4 Mar 2021 22:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=rJo9KBcE3VKL3TV4/2Pn8hxYPcduH4AfACYFhzQYJ7k=;
 b=m4GnlzRTvWQBJuDqk6CnxDrnqE+tiMrKMn865+fBA+j41TAvYIb0dtkKBrVTpJxgJ60t
 eEpqcpEzVJ3+2HQDYW/wwnacgSHPQPaRdX/TTiTpOGrFcLRhw/I9cGulmSM3i33xs3AW
 695+LmdMRH5OOjCU3Z0DEZoz7ZlRnL/vtW3xPAUN7xRd6idXBcAswyJr930RyUdp5F4o
 4Udgriujzq4kLgSgr91QKhuexKDhcLLC+B0qDIaf+3w7Fsg5b2MhD6mpZ43/hDkfzax4
 npsaibd3MUXsfeoNgRRprX+AGXrstS/AkAAIOPTzuM6fTXfXxZUEJe7Y8WPU1unqlJPp Gw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 3732ngk2hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 22:40:01 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2CA9E82;
        Thu,  4 Mar 2021 22:40:01 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 17C3539;
        Thu,  4 Mar 2021 22:39:59 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/platform/uv: Add set of kernel block size for hubless arches
Date:   Thu,  4 Mar 2021 16:39:55 -0600
Message-Id: <20210304223955.183463-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_08:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit below added a call to set the block size value that is needed
to set the value used by the kernel.  This was done for UV Hubbed systems.
This commit adds that same set call to hubless systems which supports the
same NVRAMS and Intel BIOS thus the same problem occurs.

Fixes: bbbd2b51a2aa ...
Add a call to the new function to "adjust" the current fixed
UV memory block size of 2GB so it can be changed to a different
physical boundary.  This accommodates changes in the Intel BIOS,
and therefore UV BIOS, which now can align boundaries different
than the previous UV standard of 2GB.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
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

