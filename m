Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED00733E05B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCPVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:19:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233398AbhCPVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:18:56 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12GLCqaZ008792
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nZb1WEq00AR0CkBaawo1pyTiJlIF4fB1PTOzcmTQdIU=;
 b=CsQvU9DRKRgAghlF7EjMXumUaERMbrSwKxep+wOLyLqG/l5eHPHykQtL/BV90VoCzvTC
 qZE8eGLRsULTFogcLY7SH+AQMKkkSKT5n/By8cAEjB2bi7Hqel13uWS16T6EI20hamKW
 RiMWPT6RT9yYpxSc+CQg6N5QvoVpwma74m4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37armw44a9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:56 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 14:18:55 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5F17E62E181B; Tue, 16 Mar 2021 14:18:52 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 3/3] perf-test: add a test for perf-stat --bpf-counters option
Date:   Tue, 16 Mar 2021 14:18:37 -0700
Message-ID: <20210316211837.910506-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316211837.910506-1-songliubraving@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_08:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test to compare the output of perf-stat with and without option
--bpf-counters. If the difference is more than 10%, the test is considere=
d
as failed.

For stable results between two runs (w/ and w/o --bpf-counters), the test
program should: 1) be long enough for better signal-noise-ratio; 2) not
depend on the behavior of IO subsystem (for less noise from caching). So
far, the best option we found is stressapptest.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
new file mode 100755
index 0000000000000..c0bcb38d6b53c
--- /dev/null
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# perf stat --bpf-counters test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# check whether $2 is within +/- 10% of $1
+compare_number()
+{
+	first_num=3D$1
+	second_num=3D$2
+
+	# upper bound is first_num * 110%
+	upper=3D$(( $first_num + $first_num / 10 ))
+	# lower bound is first_num * 90%
+	lower=3D$(( $first_num - $first_num / 10 ))
+
+	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
+		echo "The difference between $first_num and $second_num are greater th=
an 10%."
+		exit 1
+	fi
+}
+
+# skip if --bpf-counters is not supported
+perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+
+# skip if stressapptest is not available
+stressapptest -s 1 -M 100 -m 1 > /dev/null 2>&1 || exit 2
+
+base_cycles=3D$(perf stat --no-big-num -e cycles -- stressapptest -s 3 -=
M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')
+bpf_cycles=3D$(perf stat --no-big-num --bpf-counters -e cycles -- stress=
apptest -s 3 -M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')
+
+compare_number $base_cycles $bpf_cycles
+exit 0
--=20
2.30.2

