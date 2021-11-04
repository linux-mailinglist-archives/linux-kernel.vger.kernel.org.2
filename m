Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366144453C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhKDN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:26:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229505AbhKDN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:26:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4DD63R019476
        for <linux-kernel@vger.kernel.org>; Thu, 4 Nov 2021 13:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7zckvU3CyMlvWvkue7jiilEluIs/oPoVXjT5m4WMrzs=;
 b=GrMT6u1TZ85zXYv7awY7WsguB6naSphafOnji4+YDI0UvorGbnJhydsZhOhqDgBMgIe4
 faeLoZJwmSlk9cFzP51VmcaHKLGA4ryZK2bE2Uu8M62hwE61irb1fYYxFroznCi6R+Po
 AO7zmuC3A8YPsYZVHAqDgkruzDGuHf7a2cb+g3emRcJ3t99uO7jtvU6/MsNIRilaBmcc
 4dE3tSnF7iyvJy/v+EPDtgQKmsIGFG3jZ84RKofd3mhcNHT83b8tvKj99KT5+IWYBf/Z
 JMXM7L+2bu4RmHIn+Z+x2qZupKnlaeu9V4nxbL+s+XsoZNuPVcls6cwkpnCVrRJGWZpe uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c4ffes8rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:23:31 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A4DNVib000530
        for <linux-kernel@vger.kernel.org>; Thu, 4 Nov 2021 13:23:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c4ffes8r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 13:23:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A4D6wpU027769;
        Thu, 4 Nov 2021 13:23:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3c0wpadwjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 13:23:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A4DNPju525008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Nov 2021 13:23:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF68EAE162;
        Thu,  4 Nov 2021 13:23:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 631EBAE097;
        Thu,  4 Nov 2021 13:23:25 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Nov 2021 13:23:25 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] perf: Use __BYTE_ORDER__
Date:   Thu,  4 Nov 2021 14:23:11 +0100
Message-Id: <20211104132311.984703-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3ObdEKI_Nx1qqzP6BxRs_fc8e5UvQC2T
X-Proofpoint-ORIG-GUID: bqtpPfxHAbv-6mO5NAt66MFK1Mvvdwm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_04,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from the libc-defined __BYTE_ORDER to the compiler-defined
__BYTE_ORDER__ in order to make endianness detection more robust, like
it was done for libbpf.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c    | 2 +-
 tools/perf/util/data-convert-bt.c                        | 2 +-
 tools/perf/util/genelf.h                                 | 2 +-
 tools/perf/util/intel-bts.c                              | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c  | 2 +-
 tools/perf/util/s390-cpumsf.c                            | 8 ++++----
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 2e5eff4f8f03..2f311189c6e8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -13,7 +13,7 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
 #define le64_to_cpu bswap_64
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index aa862a26d95c..8f7705bbc2da 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1437,7 +1437,7 @@ static struct bt_ctf_field_type *create_int_type(int size, bool sign, bool hex)
 	    bt_ctf_field_type_integer_set_base(type, BT_CTF_INTEGER_BASE_HEXADECIMAL))
 		goto err;
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	bt_ctf_field_type_set_byte_order(type, BT_CTF_BYTE_ORDER_BIG_ENDIAN);
 #else
 	bt_ctf_field_type_set_byte_order(type, BT_CTF_BYTE_ORDER_LITTLE_ENDIAN);
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index d4137559be05..3db3293213a9 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -42,7 +42,7 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #error "unsupported architecture"
 #endif
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define GEN_ELF_ENDIAN	ELFDATA2MSB
 #else
 #define GEN_ELF_ENDIAN	ELFDATA2LSB
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index af1e78d76228..2c8147a62203 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -35,7 +35,7 @@
 #define INTEL_BTS_ERR_NOINSN  5
 #define INTEL_BTS_ERR_LOST    9
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define le64_to_cpu bswap_64
 #else
 #define le64_to_cpu
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 593f20e9774c..9d5e65cec89b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -143,7 +143,7 @@ static void intel_pt_insn_decoder(struct insn *insn,
 
 	if (branch == INTEL_PT_BR_CONDITIONAL ||
 	    branch == INTEL_PT_BR_UNCONDITIONAL) {
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		switch (insn->immediate.nbytes) {
 		case 1:
 			intel_pt_insn->rel = insn->immediate.value;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 02a3395d6ce3..4bd154848cad 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -16,7 +16,7 @@
 
 #define BIT63		((uint64_t)1 << 63)
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
 #define le64_to_cpu bswap_64
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 8130b56aa04b..f3fdad28a852 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -244,7 +244,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 				   struct hws_basic_entry *basicp)
 {
 	struct hws_basic_entry *basic = basicp;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	struct hws_basic_entry local;
 	unsigned long long word = be64toh(*(unsigned long long *)basicp);
 
@@ -288,7 +288,7 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
 				  struct hws_diag_entry *diagp)
 {
 	struct hws_diag_entry *diag = diagp;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	struct hws_diag_entry local;
 	unsigned long long word = be64toh(*(unsigned long long *)diagp);
 
@@ -322,7 +322,7 @@ static unsigned long long trailer_timestamp(struct hws_trailer_entry *te,
 static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 				     struct hws_trailer_entry *te)
 {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	struct hws_trailer_entry local;
 	const unsigned long long flags = be64toh(te->flags);
 
@@ -552,7 +552,7 @@ static unsigned long long get_trailer_time(const unsigned char *buf)
 	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
 					      - sizeof(*te));
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	clock_base = be64toh(te->progusage[0]) >> 63 & 0x1;
 	progusage2 = be64toh(te->progusage[1]);
 #else
-- 
2.31.1

