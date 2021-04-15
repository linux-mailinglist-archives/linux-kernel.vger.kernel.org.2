Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C363613A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhDOUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:39:20 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:64872 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234536AbhDOUjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:39:19 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FKXcn9014485;
        Thu, 15 Apr 2021 20:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=fXYQm734UsRrabPEPzfs0MZWUHypdpJKEqde7+t8ygE=;
 b=kw30dG6owFXuMqD4SDlKQQGb+58b0pHS5S5oabN1uujEOyRzg9yZ7HSP7V+C47b8CJwI
 HEPdI2n7NbtNmEkhKjVeuomwGUHOyDpAmGBMX/B/ATaaeA96PTKixUKhHHTvQawBh4Qq
 jSQQD8PbLKBMt+VmX9ObwMRaUoJNmgcTa6Xfsptk5g9laVVbPwyLMdaM7SbFxHEscpow
 z4Pida9RaShtgkL+WC5w/K5Ycm9agaZPI6WX8rJpUfdCubD7U2dn/VqTbYD1tGhg9Wu3
 hESb0AWPmImV2+AaZp9UGh2hZSA+A/P3tAPdv1Oz0WA3KvY6GVLOal1i7YHxqL2Z0Qhx VQ== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 37xm4xmvdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 20:37:23 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 8F4F16C;
        Thu, 15 Apr 2021 20:37:22 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 9E45050;
        Thu, 15 Apr 2021 20:37:21 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id F3B87302F481D; Thu, 15 Apr 2021 15:37:20 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Avoid null dereferences (uncore_extra_pci_dev)
Date:   Thu, 15 Apr 2021 15:37:20 -0500
Message-Id: <20210415203720.334007-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vvxCp2kQGs7q2H9_Jc55UIUY6x3O-Ahq
X-Proofpoint-GUID: vvxCp2kQGs7q2H9_Jc55UIUY6x3O-Ahq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_09:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an uncore has no pci_init routine, or that routine fails,
uncore_pci_init is not called, and memory is not allocated for
uncore_extra_pci_dev.

So check to make sure uncore_extra_pci_dev is not NULL before use.

And fix the case that led us to discover the null derefs; don't fail
snbep_pci2phy_map_init if BIOS doesn't supply pcibus_to_node
information.

Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b79951d0707c..14c24356a2fa 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1373,11 +1373,11 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		/*
 		 * The nodeid and idmap registers only contain enough
 		 * information to handle 8 nodes.  On systems with more
-		 * than 8 nodes, we need to rely on NUMA information,
+		 * than 8 nodes, if available we rely on NUMA information,
 		 * filled in from BIOS supplied information, to determine
 		 * the topology.
 		 */
-		if (nr_node_ids <= 8) {
+		if ((nr_node_ids <= 8) || (pcibus_to_node(ubox_dev->bus) == -1)) {
 			/* get the Node ID of the local register */
 			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
 			if (err)
@@ -2865,7 +2865,9 @@ void hswep_uncore_cpu_init(void)
 		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 
 	/* Detect 6-8 core systems with only two SBOXes */
-	if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
+	if (!uncore_extra_pci_dev)
+		hswep_uncore_sbox.num_boxes = 2;
+	else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
 		u32 capid4;
 
 		pci_read_config_dword(uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
@@ -3243,6 +3245,8 @@ void bdx_uncore_cpu_init(void)
 	if (boot_cpu_data.x86_model == 86) {
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 	/* Detect systems with no SBOXes */
+	} else if (!uncore_extra_pci_dev) {
+		bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
 		struct pci_dev *pdev;
 		u32 capid4;
-- 
2.26.2

