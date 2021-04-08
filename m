Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABA35892C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhDHQCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:02:02 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:19590 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhDHQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:02:00 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138FhYnC004494;
        Thu, 8 Apr 2021 16:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=bHPhz6wN0Wm1q30gUnSgDtJmeUIoENOWsGAzjGlE6/o=;
 b=leq131bmuXl3OtOyu44wgBbJDFbpKK0Hi+6JpZzlIUNxPODZEsGN+tkrYQUVVajrD4Uh
 adHFEJ3rH9bKQyP3uSuwCB7WxCCxtGS+Q4WK7SwnR3dIwfWrlVuAEucWcp/GBTQuu6fZ
 IeY3iT+6yWfWKlszfLXkxXkjOvvnDzO04I/7UlNgn87TubweR9nhsneV/u3B+rnjEsKx
 EqA8JpgsOWTYSsGZ2mgXKhXV0MrCCzHWq5UL95MASVAJliPJ/Tqxu5Ye069KBaJ/6mOf
 fevyJJRnxJ2KeXuxwPRqUwdt1qxdmM1KHk1vESA6xj+iUa2JXs6mzLtEjV2HQ/m/Sxhm kg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 37t29g9wvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 16:01:21 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 9FF7672;
        Thu,  8 Apr 2021 16:01:19 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0A16E4F;
        Thu,  8 Apr 2021 16:01:18 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Use x2apic enabled bit as set by BIOS to indicate APIC mode
Date:   Thu,  8 Apr 2021 11:00:47 -0500
Message-Id: <20210408160047.1703-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: d9nA2zaCNxT9E9iqk_qCnAVfW5RSFMvs
X-Proofpoint-GUID: d9nA2zaCNxT9E9iqk_qCnAVfW5RSFMvs
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS now sets the x2apic enabled bit (and the ACPI table) for extended
APIC modes.  Use that bit to indicate if extended mode is set.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 52bc217ca8c3..2e99605f9a05 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -369,6 +369,15 @@ static int __init early_get_arch_type(void)
 	return ret;
 }
 
+/* UV system found, check which APIC MODE BIOS already selected */
+static void __init early_set_apic_mode(void)
+{
+	if (x2apic_enabled())
+		uv_system_type = UV_X2APIC;
+	else
+		uv_system_type = UV_LEGACY_APIC;
+}
+
 static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 {
 	/* Save OEM_ID passed from ACPI MADT */
@@ -404,11 +413,13 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 		else
 			uv_hubless_system |= 0x8;
 
-		/* Copy APIC type */
+		/* Copy OEM Table ID and set APIC Mode */
 		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
+		early_set_apic_mode();
 
 		pr_info("UV: OEM IDs %s/%s, SystemType %d, HUBLESS ID %x\n",
 			oem_id, oem_table_id, uv_system_type, uv_hubless_system);
+
 		return 0;
 	}
 
@@ -453,6 +464,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	early_set_hub_type();
 
 	/* Other UV setup functions */
+	early_set_apic_mode();
 	early_get_pnodeid();
 	early_get_apic_socketid_shift();
 	x86_platform.is_untracked_pat_range = uv_is_untracked_pat_range;
@@ -472,29 +484,14 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	if (uv_set_system_type(_oem_id, _oem_table_id) == 0)
 		return 0;
 
-	/* Save and Decode OEM Table ID */
+	/* Save for display of the OEM Table ID */
 	uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
-	/* This is the most common hardware variant, x2apic mode */
-	if (!strcmp(oem_table_id, "UVX"))
-		uv_system_type = UV_X2APIC;
-
-	/* Only used for very small systems, usually 1 chassis, legacy mode  */
-	else if (!strcmp(oem_table_id, "UVL"))
-		uv_system_type = UV_LEGACY_APIC;
-
-	else
-		goto badbios;
-
 	pr_info("UV: OEM IDs %s/%s, System/UVType %d/0x%x, HUB RevID %d\n",
 		oem_id, oem_table_id, uv_system_type, is_uv(UV_ANY),
 		uv_min_hub_revision_id);
 
 	return 0;
-
-badbios:
-	pr_err("UV: UVarchtype:%s not supported\n", uv_archtype);
-	BUG();
 }
 
 enum uv_system_type get_uv_system_type(void)
-- 
2.21.0

