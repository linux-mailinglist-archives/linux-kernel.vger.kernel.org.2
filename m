Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF80323AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhBXKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:39:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232634AbhBXKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:39:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OAX4RB050234;
        Wed, 24 Feb 2021 05:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=8xs4x94E8tP06a4TxOYSjwpuKd4KODHK18iSUhK3G5s=;
 b=sYjTbdC6rEiJjly7oiYNTxxIfKyxCs6EBOK11IQ9BnI+Fq8mDQgIG9g7IJju5YD5R9fd
 OLRJBmFnIiVpHDpEYwQFCANyZkDpDiV/AcOHatrDVoJFG/LLc7F4ypRN+qogJ0Nm+E/m
 hhgKtg7WTXzK2n0YlDBQQoxEBbbQIL9R2PYujT9b05FVEaSPO3J5C5Utg0tdKs/ReD1Z
 yXkxf31xukncxC+Ea2HlpTlkBBZAGzfBchG7X8Jpv4R0RPKkd4IpWxgdcyLdtnM82TXR
 VXB/C3c/L+MwW9wMQNkHqjio1rm6DzbjE9VBWkFIdBl/s3olTuDVJvd04cSGhiSb1MrU 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmmf1680-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 05:38:05 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OAY9FQ059077;
        Wed, 24 Feb 2021 05:38:04 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmmf166c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 05:38:04 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OAXMrf032178;
        Wed, 24 Feb 2021 10:38:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 36tt289tcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 10:38:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OAbjHH34537792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 10:37:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07CC52050;
        Wed, 24 Feb 2021 10:37:58 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5936852051;
        Wed, 24 Feb 2021 10:37:56 +0000 (GMT)
Date:   Wed, 24 Feb 2021 12:37:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
Message-ID: <20210224103754.GA1854360@linux.ibm.com>
References: <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_03:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 04:46:28PM -0500, George Kennedy wrote:
> 
> Mike,
> 
> Still no luck.
> 
> [   30.193723] iscsi: registered transport (iser)
> [   30.195970] iBFT detected.
> [   30.196571] BUG: unable to handle page fault for address: ffffffffff240004

Hmm, we cannot set ibft_addr to early pointer to the ACPI table.
Let's try something more disruptive and move the reservation back to
iscsi_ibft_find.c.

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7bdc0239a943..c118dd54a747 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
 	if (acpi_disabled)
 		return;
 
+#if 0
 	/*
 	 * Initialize the ACPI boot-time table parser.
 	 */
@@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
 		disable_acpi();
 		return;
 	}
+#endif
 
 	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..c615ce96c9a2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -570,16 +570,6 @@ void __init reserve_standard_io_resources(void)
 
 }
 
-static __init void reserve_ibft_region(void)
-{
-	unsigned long addr, size = 0;
-
-	addr = find_ibft_region(&size);
-
-	if (size)
-		memblock_reserve(addr, size);
-}
-
 static bool __init snb_gfx_workaround_needed(void)
 {
 #ifdef CONFIG_PCI
@@ -1032,6 +1022,12 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	find_smp_config();
 
+	/*
+	 * Initialize the ACPI boot-time table parser.
+	 */
+	if (acpi_table_init())
+		disable_acpi();
+
 	reserve_ibft_region();
 
 	early_alloc_pgt_buf();
diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index 64bb94523281..01be513843d6 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -47,7 +47,25 @@ static const struct {
 #define VGA_MEM 0xA0000 /* VGA buffer */
 #define VGA_SIZE 0x20000 /* 128kB */
 
-static int __init find_ibft_in_mem(void)
+static void __init *acpi_find_ibft_region(void)
+{
+	int i;
+	struct acpi_table_header *table = NULL;
+	acpi_status status;
+
+	if (acpi_disabled)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
+		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
+		if (ACPI_SUCCESS(status))
+			return table;
+	}
+
+	return NULL;
+}
+
+static void __init *find_ibft_in_mem(void)
 {
 	unsigned long pos;
 	unsigned int len = 0;
@@ -70,35 +88,44 @@ static int __init find_ibft_in_mem(void)
 				/* if the length of the table extends past 1M,
 				 * the table cannot be valid. */
 				if (pos + len <= (IBFT_END-1)) {
-					ibft_addr = (struct acpi_table_ibft *)virt;
 					pr_info("iBFT found at 0x%lx.\n", pos);
-					goto done;
+					return virt;
 				}
 			}
 		}
 	}
-done:
-	return len;
+
+	return NULL;
 }
+
+static void __init *find_ibft(void)
+{
+	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
+	 * only use ACPI for this */
+	if (!efi_enabled(EFI_BOOT))
+		return find_ibft_in_mem();
+	else
+		return acpi_find_ibft_region();
+}
+
 /*
  * Routine used to find the iSCSI Boot Format Table. The logical
  * kernel address is set in the ibft_addr global variable.
  */
-unsigned long __init find_ibft_region(unsigned long *sizep)
+void __init reserve_ibft_region(void)
 {
-	ibft_addr = NULL;
+	struct acpi_table_ibft *table;
+	unsigned long size;
 
-	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
-	 * only use ACPI for this */
+	table = find_ibft();
+	if (!table)
+		return;
 
-	if (!efi_enabled(EFI_BOOT))
-		find_ibft_in_mem();
-
-	if (ibft_addr) {
-		*sizep = PAGE_ALIGN(ibft_addr->header.length);
-		return (u64)virt_to_phys(ibft_addr);
-	}
+	size = PAGE_ALIGN(table->header.length);
+	memblock_reserve(virt_to_phys(table), size);
 
-	*sizep = 0;
-	return 0;
+	if (efi_enabled(EFI_BOOT))
+		acpi_put_table(&table->header);
+	else
+		ibft_addr = table;
 }
diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
index b7b45ca82bea..da813c891990 100644
--- a/include/linux/iscsi_ibft.h
+++ b/include/linux/iscsi_ibft.h
@@ -26,13 +26,9 @@ extern struct acpi_table_ibft *ibft_addr;
  * mapped address is set in the ibft_addr variable.
  */
 #ifdef CONFIG_ISCSI_IBFT_FIND
-unsigned long find_ibft_region(unsigned long *sizep);
+void reserve_ibft_region(void);
 #else
-static inline unsigned long find_ibft_region(unsigned long *sizep)
-{
-	*sizep = 0;
-	return 0;
-}
+static inline void reserve_ibft_region(void) {}
 #endif
 
 #endif /* ISCSI_IBFT_H */

-- 
Sincerely yours,
Mike.
