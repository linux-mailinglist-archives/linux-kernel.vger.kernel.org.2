Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F67361486
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhDOWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:07:24 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:40684 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhDOWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:07:23 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FM4LcL009635;
        Thu, 15 Apr 2021 22:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=f7aIsr0i2GQwqRxmxViS2LhcA/rB1Iud9NdSL0zneIk=;
 b=bPsLHsbCDm/hKBuJgQkO/UthxunCwhQDBk271Hc7AaSY2pMw/uXmiol2GvMeZjlrnkVj
 q8QsyitsqxyT994NG1lJsj/lzKXHwGd9Er/DrDp5wigA1/Tm7UTXzNbJ+VIFPcsho6Vk
 4Ame8ZarqIg7uATLonc7GVhMNyR5h7rZUSWFEEIOBtkhh16SgXu1XY+hlIbelrCFNtQP
 DoZx1NRROkYNDJuaMBTtxKy5IhriapXX7C/iM68tLJ6Efy9IWyWNg8La12QK6vohkEL9
 /PKLt7DSpad2cRunKAd1PjNUUkZ3rnK2oNB+Ie9dAYadWyUZKB5yNUFmeTwEeHP9HVUa HQ== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 37xg7kfg03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 22:06:36 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 11BE465;
        Thu, 15 Apr 2021 22:06:34 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 123E736;
        Thu, 15 Apr 2021 22:06:33 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix set apic mode from x2apic enabled bit patch
Date:   Thu, 15 Apr 2021 17:06:26 -0500
Message-Id: <20210415220626.223955-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CDR6Knr75KaPglY3bk50XebWd8YJkC26
X-Proofpoint-ORIG-GUID: CDR6Knr75KaPglY3bk50XebWd8YJkC26
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_10:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=996 clxscore=1015
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not set uv_system_type for hubless UV systems as it tricks the
is_uv_system function into thinking it's a UV hubbed system and includes
a UV HUB RTC.  This causes UV RTC init to panic on UV hubless systems.

Fixes: 41e2da9b5e67 ("x86/platform/uv: Use x2apic enabled bit as set by BIOS to indicate APIC mode")

[41e2da9b5e67 was accepted into tip x86/platform branch but not yet
pulled into the linus tree.]

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 2e99605f9a05..68ef9abc91f7 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -413,9 +413,8 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 		else
 			uv_hubless_system |= 0x8;
 
-		/* Copy OEM Table ID and set APIC Mode */
+		/* Copy OEM Table ID */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
-		early_set_apic_mode();
 
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
-- 
2.21.0

