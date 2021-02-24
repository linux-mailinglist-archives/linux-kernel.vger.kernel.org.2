Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9F32415C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhBXPt0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Feb 2021 10:49:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:33394 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234675AbhBXPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:39:25 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-zC_RvgkBOTKB4w5IQULp9w-1; Wed, 24 Feb 2021 10:38:19 -0500
X-MC-Unique: zC_RvgkBOTKB4w5IQULp9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 879BD14E306;
        Wed, 24 Feb 2021 15:08:39 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7BE1002C11;
        Wed, 24 Feb 2021 15:08:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf tools: Move feature cleanup under tools/build
Date:   Wed, 24 Feb 2021 16:08:31 +0100
Message-Id: <20210224150831.409639-1-jolsa@kernel.org>
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

Arnaldo reported issue for following build command:

  $ rm -rf /tmp/krava; mkdir /tmp/krava; make O=/tmp/krava clean
    CLEAN    config
  /bin/sh: line 0: cd: /tmp/krava/feature/: No such file or directory
  ../../scripts/Makefile.include:17: *** output directory "/tmp/krava/feature/" does not exist.  Stop.
  make[1]: *** [Makefile.perf:1010: config-clean] Error 2
  make: *** [Makefile:90: clean] Error 2

The problem is that now that we include scripts/Makefile.include
in feature's Makefile (which is fine and needed), we need to ensure
the OUTPUT directory exists, before executing (out of tree) clean
command.

Removing the feature's cleanup from perf Makefile and fixing
feature's cleanup under build Makefile, so it now checks that
there's existing OUTPUT directory before calling the clean.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Fixes: 211a741cd3e1 ("tools: Factor Clang, LLC and LLVM utils definitions")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/Makefile     |  8 +++++++-
 tools/perf/Makefile.perf | 10 +---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index bae48e6fa995..5ed41b96fcde 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -30,12 +30,18 @@ build     := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
 all: $(OUTPUT)fixdep
 
+# Make sure there's anything to clean,
+# feature contains check for existing OUTPUT
+TMP_O := $(if $(OUTPUT),$(OUTPUT)/feature,./)
+
 clean:
 	$(call QUIET_CLEAN, fixdep)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f $(OUTPUT)fixdep
 	$(call QUIET_CLEAN, feature-detect)
-	$(Q)$(MAKE) -C feature/ clean >/dev/null
+ifneq ($(wildcard $(TMP_O)),)
+	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
+endif
 
 $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5345ac70cd83..536f6f90af92 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1001,14 +1001,6 @@ $(INSTALL_DOC_TARGETS):
 
 ### Cleaning rules
 
-#
-# This is here, not in Makefile.config, because Makefile.config does
-# not get included for the clean target:
-#
-config-clean:
-	$(call QUIET_CLEAN, config)
-	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ $(if $(OUTPUT),OUTPUT=$(OUTPUT)feature/,) clean >/dev/null
-
 python-clean:
 	$(python-clean)
 
@@ -1048,7 +1040,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean bpf-skel-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-- 
2.29.2

