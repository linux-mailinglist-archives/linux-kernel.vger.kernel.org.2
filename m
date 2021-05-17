Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F5382755
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhEQIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:47:29 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:13144 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhEQIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3312; q=dns/txt; s=iport;
  t=1621241171; x=1622450771;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFjfl4xJfPfBHw99z86+v8NqOKExMrnDkDvZI6epnsk=;
  b=iuKj14CJ8z+uZR7/MrUAy2+53O3kZIdqLZhBXx66udR+V2WdNFHNWw1T
   H8B9E1uMIachofe4jNbQ08YBXDUD9LusOgrFr4VZuipa6pljhfKEUOVV+
   FSMKR1vy1Ucft5uLL7SbGgSAexPQTgqbENFZmzPZ9+x1sqodnrP8flFVv
   Q=;
X-IPAS-Result: =?us-ascii?q?A0AiAQBtLKJgmIsNJK1aHgEBCxIMggwLgyJWATkxsVaBf?=
 =?us-ascii?q?AsBAQENAQEtFAQBAYRPAoF0AiU0CQ4CBAEBAQEDAgMBAQEBBQEBBQEBAQIBB?=
 =?us-ascii?q?gQUAQEBAQEBAQFohVANhkUGMgFWHjMsKwcSgnEBgweoLoIsgQGIE4FEgTqId?=
 =?us-ascii?q?naDdyccgUlEgRWDYIobIgSCR3sTAaIKnEuDIJ00ESiDWosTllCVNp8BIFWED?=
 =?us-ascii?q?AIEBgUCFoFUOIFbMxoIGxWDJAlHGQ6OOIM+ixYhAy8CNgIGCgEBAwmNEAEB?=
IronPort-HdrOrdr: A9a23:DPmeV66vHLya+EGXeAPXwMnXdLJyesId70hD6qkXc20wTiX2ra
 6TdZgguCMczQxhO03I+urwXZVoP0m8yXcd2+B4Vt2ftUvdyQmVxepZgrcKrQeNJ8SHzI5gPW
 MKSdkZNDU2ZmIK6vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,306,1613433600"; 
   d="scan'208";a="713233692"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 May 2021 08:46:09 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 14H8k5Qe028515
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 08:46:08 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id F2E96CC1255; Mon, 17 May 2021 01:46:04 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v5 3/3] perf parse-events: add bison --file-prefix-map option
Date:   Mon, 17 May 2021 01:46:04 -0700
Message-Id: <20210517084604.2895-3-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210517084604.2895-1-dzagorui@cisco.com>
References: <20210517084604.2895-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During perf build with O= bison stores full paths in generated files and
those paths are stored in resulting perf binary. Starting from v3.7.1.
those paths can be remapped by using --file-prefix-map option. Use this
option if it possible to make perf binary more reproducible.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/Makefile.config | 9 +++++++++
 tools/perf/util/Build      | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 406a9519145e..dacd16874d3d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -202,6 +202,12 @@ ifeq ($(call get-executable,$(BISON)),)
   dummy := $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
+ifneq ($(OUTPUT),)
+  ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
+    BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
+  endif
+endif
+
 # Treat warnings as errors unless directed not to
 ifneq ($(WERROR),0)
   CORE_CFLAGS += -Werror
@@ -1228,6 +1234,9 @@ $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
 $(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
+ifneq ($(BISON_FILE_PREFIX_MAP),)
+$(call detected_var,BISON_FILE_PREFIX_MAP)
+endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b64bdc1a7026..95e15d1035ab 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -216,7 +216,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
 
 $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
@@ -226,7 +226,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
 
 $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
@@ -236,7 +236,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
 
 $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
-- 
2.26.2.Cisco

