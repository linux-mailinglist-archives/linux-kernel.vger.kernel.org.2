Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA3356066
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbhDGAgU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Apr 2021 20:36:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232985AbhDGAgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:36:17 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1370StsL005205
        for <linux-kernel@vger.kernel.org>; Tue, 6 Apr 2021 17:36:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37rvb725g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 17:36:09 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 17:36:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id EF0E562E22EC; Tue,  6 Apr 2021 17:36:04 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 0/3] perf util: bpf perf improvements
Date:   Tue, 6 Apr 2021 17:35:58 -0700
Message-ID: <20210407003601.619158-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SrJzJksxO5_btDM9kDtbKc3AciKia_5T
X-Proofpoint-ORIG-GUID: SrJzJksxO5_btDM9kDtbKc3AciKia_5T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_09:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=882 adultscore=1 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches set improves bpf_perf (perf-stat --bpf-counter) by
  1) exposing key definitions to a libperf header;
  2) adding compatibility check for perf_attr_map;
  3) introducing config stat.bpf-counter-events.

Changes v1 => v2:
1. Separte 2/3 from 1/3. (Jiri)
2. Rename bperf.h to bpf_perf.h. (Jiri)
3. Other small fixes/optimizations. (Jiri)

Song Liu (3):
  perf util: move bpf_perf definitions to a libperf header
  perf bpf: check perf_attr_map is compatible with the perf binary
  perf-stat: introduce config stat.bpf-counter-events

 tools/lib/perf/include/perf/bpf_perf.h | 31 ++++++++++++++
 tools/perf/Documentation/perf-stat.txt |  2 +
 tools/perf/builtin-stat.c              | 43 ++++++++++++-------
 tools/perf/util/bpf_counter.c          | 57 +++++++++++++++-----------
 tools/perf/util/config.c               | 32 +++++++++++++++
 tools/perf/util/evsel.c                |  2 +
 tools/perf/util/evsel.h                |  6 +++
 tools/perf/util/target.h               |  5 ---
 8 files changed, 134 insertions(+), 44 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/bpf_perf.h

--
2.30.2
