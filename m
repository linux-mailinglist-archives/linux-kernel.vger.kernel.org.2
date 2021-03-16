Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5433E058
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhCPVTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:19:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233380AbhCPVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:18:47 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12GLAUZp023979
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=FQTmUoRAPFlx1B5rTrVAHZjOG8BVNoahuyKaUq9x9/M=;
 b=p1cfQEC+0NSQI5i19f1fGq20h2meqYeamD8Wa+B7vMRMKXN62SNmEy1EiXiWO/B0SAu3
 AiocKvwgQyuT7qwPJhVWueSmANct8Qk0PDNgant71v0w1VZkOZr4nlOtXoh+QDUM1IsD
 +s29zGBxvqyRihS3eJyXX8vFmh3HMwKiEPg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37b3brrcr1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:18:45 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 14:18:44 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 62A0C62E181B; Tue, 16 Mar 2021 14:18:42 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Date:   Tue, 16 Mar 2021 14:18:34 -0700
Message-ID: <20210316211837.910506-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_08:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf uses performance monitoring counters (PMCs) to monitor system
performance. The PMCs are limited hardware resources. For example,
Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.

Modern data center systems use these PMCs in many different ways:
system level monitoring, (maybe nested) container level monitoring, per
process monitoring, profiling (in sample mode), etc. In some cases,
there are more active perf_events than available hardware PMCs. To allow
all perf_events to have a chance to run, it is necessary to do expensive
time multiplexing of events.

On the other hand, many monitoring tools count the common metrics (cycles=
,
instructions). It is a waste to have multiple tools create multiple
perf_events of "cycles" and occupy multiple PMCs.

bperf tries to reduce such wastes by allowing multiple perf_events of
"cycles" or "instructions" (at different scopes) to share PMUs. Instead
of having each perf-stat session to read its own perf_events, bperf uses
BPF programs to read the perf_events and aggregate readings to BPF maps.
Then, the perf-stat session(s) reads the values from these BPF maps.

Changes v1 =3D> v2:
  1. Add documentation.
  2. Add a shell test.
  3. Rename options, default path of the atto-map, and some variables.
  4. Add a separate patch that moves clock_gettime() in __run_perf_stat()
     to after enable_counters().
  5. Make perf_cpu_map for all cpus a global variable.
  6. Use sysfs__mountpoint() for default attr-map path.
  7. Use cpu__max_cpu() instead of libbpf_num_possible_cpus().
  8. Add flag "enabled" to the follower program. Then move follower attac=
h
     to bperf__load() and simplify bperf__enable().

Song Liu (3):
  perf-stat: introduce bperf, share hardware PMCs with BPF
  perf-stat: measure t0 and ref_time after enable_counters()
  perf-test: add a test for perf-stat --bpf-counters option

 tools/perf/Documentation/perf-stat.txt        |  11 +
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/builtin-stat.c                     |  20 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |  34 ++
 tools/perf/util/bpf_counter.c                 | 519 +++++++++++++++++-
 tools/perf/util/bpf_skel/bperf.h              |  14 +
 tools/perf/util/bpf_skel/bperf_follower.bpf.c |  69 +++
 tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
 tools/perf/util/bpf_skel/bperf_u.h            |  14 +
 tools/perf/util/evsel.h                       |  20 +-
 tools/perf/util/target.h                      |   4 +-
 11 files changed, 742 insertions(+), 10 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
 create mode 100644 tools/perf/util/bpf_skel/bperf.h
 create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_u.h

--
2.30.2
