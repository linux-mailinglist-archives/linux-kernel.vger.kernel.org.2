Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120633E05A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhCPVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:19:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233393AbhCPVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:18:52 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12GLCrml008836
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=njSFK3JicRjyo/4KbE9DTbc90wVESEM3DHSU7jx5peA=;
 b=BH7ONY1CVZSK/snBRNq5m0u6wn3dng+h0Nl33byzInRt0P/J6ABitsYDiB4L6rAf3Ykl
 2PgyRfqx8U1lO2oWfLGV6KRuGTdm+Ipk/dI07iyZKquXaWkkiyfGk9Nbk3TMfVx+PgQL
 V2muOJhct8fFrMj9MyV6NnGIykiMB7zOdGg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37armw449y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:52 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 14:18:51 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 93D7062E181B; Tue, 16 Mar 2021 14:18:49 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 2/3] perf-stat: measure t0 and ref_time after enable_counters()
Date:   Tue, 16 Mar 2021 14:18:36 -0700
Message-ID: <20210316211837.910506-3-songliubraving@fb.com>
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

Take measurements of t0 and ref_time after enable_counters(), so that
they only measure the time consumed when the counters are enabled.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-stat.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 92696373da994..d030c3a49a8e4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -931,15 +931,15 @@ static int __run_perf_stat(int argc, const char **a=
rgv, int run_idx)
 	/*
 	 * Enable counters and exec the command:
 	 */
-	t0 =3D rdclock();
-	clock_gettime(CLOCK_MONOTONIC, &ref_time);
-
 	if (forks) {
 		evlist__start_workload(evsel_list);
 		err =3D enable_counters();
 		if (err)
 			return -1;
=20
+		t0 =3D rdclock();
+		clock_gettime(CLOCK_MONOTONIC, &ref_time);
+
 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status =3D dispatch_events(forks, timeout, interval, &times);
 		if (child_pid !=3D -1) {
@@ -960,6 +960,10 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
 		err =3D enable_counters();
 		if (err)
 			return -1;
+
+		t0 =3D rdclock();
+		clock_gettime(CLOCK_MONOTONIC, &ref_time);
+
 		status =3D dispatch_events(forks, timeout, interval, &times);
 	}
=20
--=20
2.30.2

