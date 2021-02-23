Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932B3231E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBWUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:11:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233185AbhBWUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:10:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NK4XJi185352;
        Tue, 23 Feb 2021 15:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=5op8Kt67whagINL33DSIe7bo2wuZ0fdfQE/1gEwLU1Y=;
 b=ed9n0peSYtRsa4UB9T8drO09LVi4CwL7wWJDLjrUIXod7HJSn9QBmaq3UuY9CQzpQ3yF
 KwQjOiLY3gNkdu1AwLVHfOFNxi7rKnknP1QMHoiR+jxiMMKUiHvC0cEIikkTqSmTB7Z1
 QvrgiFUTpRw4NXkCkYEJpJEZdUoJpwIvnrCmbaOPDF8A31Uk0NFEGUAcfzsCxnh9o+50
 xUYdQMRSQtdoLdHl7SlaJK9UCFtAzq3Uw/Soytvr/Xzp1aqIBYGFTp9A/jShR98fw/DF
 NjI+lWknOWja9WEbbFgdanemu6VfTah1M1qiRwC00CtPJEPFtSSZyNE3GGGiDiVMDygy tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkne0qgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:09:27 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NK4Zcm185531;
        Tue, 23 Feb 2021 15:09:26 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkne0qg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 15:09:26 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NK8RE2012157;
        Tue, 23 Feb 2021 20:09:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 36tsph9hta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 20:09:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NK99Ll18088310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 20:09:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2076442047;
        Tue, 23 Feb 2021 20:09:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CB394203F;
        Tue, 23 Feb 2021 20:09:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.51.238])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Feb 2021 20:09:17 +0000 (GMT)
Date:   Tue, 23 Feb 2021 22:09:14 +0200
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
Message-ID: <20210223200914.GH1741768@linux.ibm.com>
References: <1ac78f02-d0af-c3ff-cc5e-72d6b074fc43@redhat.com>
 <bd7510b5-d325-b516-81a8-fbdc81a27138@oracle.com>
 <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
 <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 01:05:05PM -0500, George Kennedy wrote:
> On 2/23/2021 10:47 AM, Mike Rapoport wrote:
> 
> It now crashes here:
> 
> [    0.051019] ACPI: Early table checksum verification disabled
> [    0.056721] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.057874] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
> 00000001      01000013)
> [    0.059590] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
> 00000001 BXPC 00000001)
> [    0.061306] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
> 00000001 BXPC 00000001)
> [    0.063006] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.063938] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
> 00000001 BXPC 00000001)
> [    0.065638] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
> 00000001 BXPC 00000001)
> [    0.067335] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2    
> 00000002      01000013)
> [    0.069030] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
> 00000000      00000000)
> [    0.070734] XXX acpi_find_ibft_region:
> [    0.071468] XXX iBFT, status=0
> [    0.072073] XXX about to call acpi_put_table()...
> ibft_addr=ffffffffff240000
> [    0.073449] XXX acpi_find_ibft_region(EXIT):
> PANIC: early exception 0x0e IP 10:ffffffff9259f439 error 0 cr2
> 0xffffffffff240004

Right, I've missed the dereference of the ibft_addr after
acpi_find_ibft_region(). 

With this change to iscsi_ibft_find.c instead of the previous one it should
be better:

diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index 64bb94523281..1be7481d5c69 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -80,6 +80,27 @@ static int __init find_ibft_in_mem(void)
 done:
 	return len;
 }
+
+static void __init acpi_find_ibft_region(unsigned long *sizep)
+{
+	int i;
+	struct acpi_table_header *table = NULL;
+	acpi_status status;
+
+	if (acpi_disabled)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
+		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
+		if (ACPI_SUCCESS(status)) {
+			ibft_addr = (struct acpi_table_ibft *)table;
+			*sizep = PAGE_ALIGN(ibft_addr->header.length);
+			acpi_put_table(table);
+			break;
+		}
+	}
+}
+
 /*
  * Routine used to find the iSCSI Boot Format Table. The logical
  * kernel address is set in the ibft_addr global variable.
@@ -91,14 +112,16 @@ unsigned long __init find_ibft_region(unsigned long *sizep)
 	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
 	 * only use ACPI for this */
 
-	if (!efi_enabled(EFI_BOOT))
+	if (!efi_enabled(EFI_BOOT)) {
 		find_ibft_in_mem();
-
-	if (ibft_addr) {
 		*sizep = PAGE_ALIGN(ibft_addr->header.length);
-		return (u64)virt_to_phys(ibft_addr);
+	} else {
+		acpi_find_ibft_region(sizep);
 	}
 
+	if (ibft_addr)
+		return (u64)virt_to_phys(ibft_addr);
+
 	*sizep = 0;
 	return 0;
 }

> [    0.075711] CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-34a2105 #8
> [    0.076983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 0.0.0 02/06/2015
> [    0.078579] RIP: 0010:find_ibft_region+0x470/0x577

-- 
Sincerely yours,
Mike.
