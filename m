Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE367364B35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbhDSUh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 16:37:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234546AbhDSUh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:37:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JKXZ3d022044
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:36:58 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 381fdfrhq1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:36:58 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 13:36:57 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C34F062E1A1C; Mon, 19 Apr 2021 13:36:55 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v4 0/4] perf util: bpf perf improvements
Date:   Mon, 19 Apr 2021 13:36:45 -0700
Message-ID: <20210419203649.164121-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WOpH4Uv3eYnLaLzS4ML9I8ysjr7hkWKd
X-Proofpoint-ORIG-GUID: WOpH4Uv3eYnLaLzS4ML9I8ysjr7hkWKd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches set improves bpf_perf (perf-stat --bpf-counter) by
 1) exposing key definitions to a libperf header;
 2) adding compatibility check for perf_attr_map;
 3) introducing config stat.bpf-counter-events.
 4) introducing 'b' modify to event parser.

Changes v3 => v4:
1. Improve the logic that decides when to skip read_affinity_counters().
   (Jiri)
2. Clean up a condition in bpf_counters.c:read_counters(). (Jiri)

Changes v2 => v3:
1. Add 'b' modifier. (Jiri)
2. Allow configuring stat.bpf-counter-events with any event name (instead
  of limiting to hardware events). (Jiri)

Changes v1 => v2:
1. Separte 2/3 from 1/3. (Jiri)
2. Rename bperf.h to bpf_perf.h. (Jiri)
3. Other small fixes/optimizations. (Jiri)

Song Liu (4):
  perf util: move bpf_perf definitions to a libperf header
  perf bpf: check perf_attr_map is compatible with the perf binary
  perf-stat: introduce config stat.bpf-counter-events
  perf-stat: introduce ':b' modifier

 tools/lib/perf/include/perf/bpf_perf.h | 31 ++++++++++++++++
 tools/perf/Documentation/perf-stat.txt |  2 ++
 tools/perf/builtin-stat.c              | 40 ++++++++++++---------
 tools/perf/util/bpf_counter.c          | 49 +++++++++++++-------------
 tools/perf/util/config.c               |  4 +++
 tools/perf/util/evsel.c                | 22 ++++++++++++
 tools/perf/util/evsel.h                |  9 +++++
 tools/perf/util/parse-events.c         |  8 ++++-
 tools/perf/util/parse-events.l         |  2 +-
 tools/perf/util/target.h               |  5 ---
 10 files changed, 123 insertions(+), 49 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/bpf_perf.h

--
2.30.2
