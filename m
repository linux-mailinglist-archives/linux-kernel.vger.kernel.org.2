Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10E36FB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhD3Nem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:34:42 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:6871 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhD3Nek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3133; q=dns/txt; s=iport;
  t=1619789632; x=1620999232;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WigcQ1OHmuGN9IHW1rVUKCENXn5dQB3Iyfv7JC2jES8=;
  b=ctJOx/8DgNsXCYGT7Q1clhe+mm6fAOvQbnVIBLW8jQ9r+NIPk0HRLmdk
   QjRI7JyZHAIaXN+HCRNzQrbTtd4EVfXWsMrNiSepnhTLRSwyaYFsdNiDh
   LFSs2SkmHtFyaotIWUX9x1LkpEgysMsyE9rCLHjILuV54cbUYvB1vnPw/
   E=;
X-IPAS-Result: =?us-ascii?q?A0B+AQCABoxgmJpdJa1agmCDIlYBOTGxMoF8CwEBAQ0BA?=
 =?us-ascii?q?SAUBAEBhFACgXsCJTYHDgIEAQEBAwIDAQEBAQEFAQEBAgEGBBQBAQEBAQEBA?=
 =?us-ascii?q?WiFUA2GRQYyAVYeMywrBxKCcQGDB6cogiyBAYg0gUSBOohtdIN2JxyBSUKBF?=
 =?us-ascii?q?YNgiAeCESIEgkd7EwGhcZw+gxqdGhAmg1SLCpZAlSyeYSBUhAcCBAYFAhY1g?=
 =?us-ascii?q?SYBMIFbMxoIGxWDJAlHGQ6OOIM+ixYhAy8CNgIGCgEBAwmNDwEB?=
IronPort-HdrOrdr: A9a23:eF8EHqhZyDelMET+L/bZnJ1LBnBQXmMji2hD6mlwRA09T+Wzkc
 eykPMHkSLugDEKV3063fyGMq+MQXTTnKQFhbU5EL++UGDd1leAA5pl6eLZrgHIOyq7zeJF0L
 clTq4WMqySMXFfreLXpDa1CMwhxt7vytHMuc77w212RQ9nL4Fshj0ZNi+hHkd7RBZLCPMCff
 L2jPZvnDaudW8aac62HBA+Lor+jufWn5HrawNuPXEawTSJ5AnF1JfKVzyR3hITSFp0oYsKwC
 zijxHz4LmlvrWdzBLRvlWjiah+qZ/G1sZJAtCKh4wuDgjUziysZIhnRtS5zVcInN0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,262,1613433600"; 
   d="scan'208";a="729925261"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2021 13:33:50 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 13UDXo40027927
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Apr 2021 13:33:50 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 2D7E3CC1254; Fri, 30 Apr 2021 06:33:50 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v4 3/3] perf parse-events: add bison --file-prefix-map option
Date:   Fri, 30 Apr 2021 06:33:50 -0700
Message-Id: <20210430133350.20504-3-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210430133350.20504-1-dzagorui@cisco.com>
References: <20210430133350.20504-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bison stores full paths in generated files and those paths are stored in
resulting perf binary. Starting from v3.7.1. those paths can be remapped
by using --file-prefix-map option. So use this option if it possible to
make perf binary more reproducible.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/Makefile.config | 9 +++++++++
 tools/perf/util/Build      | 6 +++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d8e59d31399a..2035bae6d5c5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -195,6 +195,12 @@ ifeq ($(call get-executable,$(BISON)),)
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
@@ -1208,3 +1214,6 @@ $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
 $(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
+ifneq ($(BISON_FILE_PREFIX_MAP),)
+$(call detected_var,BISON_FILE_PREFIX_MAP)
+endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e3e12f9d4733..33476b1d28d5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -204,7 +204,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
 
 $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
@@ -214,7 +214,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
 
 $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
@@ -224,7 +224,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
 
 $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
-- 
2.26.2.Cisco

