Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8813E377414
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEHUvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 May 2021 16:51:35 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:55956 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhEHUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 16:51:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-lEE9aI5YNN-KhvcsOFOykA-1; Sat, 08 May 2021 16:50:25 -0400
X-MC-Unique: lEE9aI5YNN-KhvcsOFOykA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC937107ACC7;
        Sat,  8 May 2021 20:50:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 480BA1037F20;
        Sat,  8 May 2021 20:50:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        "Justin M . Forbes" <jforbes@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Fix dynamic libbpf link
Date:   Sat,  8 May 2021 22:50:20 +0200
Message-Id: <20210508205020.617984-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin reported broken build with LIBBPF_DYNAMIC=1.

When linking libbpf dynamically we need to use perf's
hashmap object, because it's not exported in libbpf.so
(only in libbpf.a).

Following build is now passing:

  $ make LIBBPF_DYNAMIC=1
    BUILD:   Doing 'make -j8' parallel build
    ...
  $ ldd perf | grep libbpf
        libbpf.so.0 => /lib64/libbpf.so.0 (0x00007fa7630db000)

Fixes: eee19501926d ("perf tools: Grab a copy of libbpf's hashmap")
Cc: Ian Rogers <irogers@google.com>
Reported-by: Justin M. Forbes <jforbes@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config | 1 +
 tools/perf/util/Build      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7b195e16040e..dacd16874d3d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -546,6 +546,7 @@ ifndef NO_LIBELF
       ifdef LIBBPF_DYNAMIC
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
+          $(call detected,CONFIG_LIBBPF_DYNAMIC)
         else
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e27a551acd3a..95e15d1035ab 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,7 +145,14 @@ perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
 perf-$(CONFIG_LIBELF) += probe-event.o
 
+ifdef CONFIG_LIBBPF_DYNAMIC
+  hashmap := 1
+endif
 ifndef CONFIG_LIBBPF
+  hashmap := 1
+endif
+
+ifdef hashmap
 perf-y += hashmap.o
 endif
 
-- 
2.31.1

