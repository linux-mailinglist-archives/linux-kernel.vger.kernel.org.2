Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DA38F9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEYEj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:39:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229476AbhEYEjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:39:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P4XJdQ183681;
        Tue, 25 May 2021 00:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5ZKnJJvMM/s76BCr9yEVccnrdIJeoK13qMVRszV01iY=;
 b=s/0TV32vg0uBg3wpRccEjCoA/ulWwn6i0JTL6z/AmEcqTY9UTdKIsyQ0AAoYVEJNCahe
 N/fiNPUUdmJ3M2tkiQxEdfk7uRDElDznP309LTlolOHHOGDEju8iCZAmuooINl7oCSfd
 mkr1NVZuKRzv/H2OcOE8xD2AloygaCO1fwQMw4kT2n70JunTDzITTpDMLrMOwBgqc4kD
 qJNOAAS7WyJOf5x01srmqT6vuyi0CUtcR6AU9P+Vj7X0GSY8ChstyNj2i2RolQZ/LZDi
 deB6/sGDW0F43GyuJ4dA3mOWLk7WZ1IbWQxzMPfBtTSXb+GWk23B9BWWt/ZNtbUQ3A77 Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38rrjna85c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 00:37:53 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14P4ZWBl191538;
        Tue, 25 May 2021 00:37:52 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38rrjna84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 00:37:52 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14P4X7nI010180;
        Tue, 25 May 2021 04:37:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 38ps7h8kqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 04:37:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14P4blsJ21430548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 04:37:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDDC3AE051;
        Tue, 25 May 2021 04:37:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 415E3AE045;
        Tue, 25 May 2021 04:37:46 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.36.63])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 04:37:46 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     ravi.bangoria@linux.ibm.com, jolsa@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: [PATCH] perf probe: Provide more detail with relocation warning
Date:   Tue, 25 May 2021 10:07:44 +0530
Message-Id: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YFzV-DSvEX9H-d7HAXFQlWz1PNf3TBHx
X-Proofpoint-GUID: uo1rjiPnU0q86i4oPPuJYtutMS4cw_qc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When run as normal user with default sysctl kernel.kptr_restrict=0
and kernel.perf_event_paranoid=2, perf probe fails with:

  $ ./perf probe move_page_tables
  Relocated base symbol is not found!

The warning message is not much informative. The reason perf fails
is because /proc/kallsyms is restricted by perf_event_paranoid=2
for normal user and thus perf fails to read relocated address of
the base symbol.

Tweaking kptr_restrict and perf_event_paranoid can change the
behavior of perf probe. Also, running as root or privileged user
works too. Add these details in the warning message.

Plus, kmap->ref_reloc_sym might not be always set even if
host_machine is initialized. Above is the example of the same.
Remove that comment.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/probe-event.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a78c8d59a555..3a7649835ec9 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -108,7 +108,6 @@ void exit_probe_symbol_maps(void)
 
 static struct ref_reloc_sym *kernel_get_ref_reloc_sym(struct map **pmap)
 {
-	/* kmap->ref_reloc_sym should be set if host_machine is initialized */
 	struct kmap *kmap;
 	struct map *map = machine__kernel_map(host_machine);
 
@@ -819,7 +818,10 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 
 	reloc_sym = kernel_get_ref_reloc_sym(&map);
 	if (!reloc_sym) {
-		pr_warning("Relocated base symbol is not found!\n");
+		pr_warning("Relocated base symbol is not found! "
+			   "Check /proc/sys/kernel/kptr_restrict\n"
+			   "and /proc/sys/kernel/perf_event_paranoid. "
+			   "Or run as privileged perf user.\n\n");
 		return -EINVAL;
 	}
 
@@ -3025,7 +3027,10 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 			(!pp->retprobe || kretprobe_offset_is_supported())) {
 		reloc_sym = kernel_get_ref_reloc_sym(NULL);
 		if (!reloc_sym) {
-			pr_warning("Relocated base symbol is not found!\n");
+			pr_warning("Relocated base symbol is not found! "
+				   "Check /proc/sys/kernel/kptr_restrict\n"
+				   "and /proc/sys/kernel/perf_event_paranoid. "
+				   "Or run as privileged perf user.\n\n");
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.31.1

