Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C138CC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhEUR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:29:20 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:12233 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhEUR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3312; q=dns/txt; s=iport;
  t=1621618075; x=1622827675;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFjfl4xJfPfBHw99z86+v8NqOKExMrnDkDvZI6epnsk=;
  b=ME9B4oRQqShBKB07Uj6jqQedmEGz+17JDS7MOP+pifvxCRBHVSrDeXPS
   tk6CZ2dh9ocqs734Zel9bcpZCT8DDo0aHhdtSD7lag9rG5FZZvprhNRjy
   ivJiX52DmDbGpSJb397QLcVvdvzYXMsKYkRNL59WUTq/7OJ8a66GTNWwg
   Q=;
X-IPAS-Result: =?us-ascii?q?A0BkAQCG7Kdgl40NJK1agmCDIlYBOTGxY4F8CwEBAQ0BA?=
 =?us-ascii?q?S0UBAEBhE8CgX4CJTUIDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFaA2GRQYyAVYeMywrBxKCcQGDB6lYgiyBAYg/gUSBOoh2doN4JxyBS?=
 =?us-ascii?q?USBFYNgihsiBIJHexMBohKcVYMhnUcTKYNbixmWV5U6nxYgVYQNAgQGBQIWg?=
 =?us-ascii?q?VUBN4FbMxoIGxWDJAlHGQ6OOIM+ixYhAy8CNgIGCgEBAwmJZAEB?=
IronPort-Data: A9a23:8PlhCKu+WH4XQBMNMLefZe6mIefnVINeMUV32f8akzHdYApBsoF/q
 tZmKT+OPvaKa2ekeNx2a4yw808HvZ/Xzt5qTAM5pHw0FysXgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokcxJX5BC5C5xZVG/fngqoHUVaiUYEideSc+EH140U85wrZg6mJVqYHR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyV94KYkGE2EByCQrr+4sQKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45Zbc/DKv/RMmsA9+r9nGtU9RlYJsS2IsOFx9
 /Jpir+beD58a8UgmMxFO/VZOyh6OasD87jdLD3v98eS1EbBNXDrxp2CDmlvYtZeobgxWDoIr
 KBBQNwORkjra+aezKCyRe52m8ULJ8jwN4RZsXZlpd3cJal8G8GYE/+RtLe02h8e18xvOfvsN
 vEiRmo0air8fTpOZlwuXcdWcOCA3ymjLGIwREiuja425XXDiQ98yr7gNPLLddGQA8ZYhECVo
 iTB5WuRKhQbMtOY4SCI/nKlmqnEmiaTcIAVEKax3uRnjF2a2ioYDxh+fVK/rOmwjEKzQZREK
 00P+ikvq4A29Uq2Xp/8WQG1pDiPuRt0c9xZFu0r9QeC4qnZ+QCUAi4DVDEpQNUtscIeRjEw0
 FKN2dTzClRHqLCJRGiP3raSoym7NSUcISkFfyBsZQ4M+dqlupwvihvJQv5qCqvzhdrwcQwc2
 BiDqCw4wr4Ul8NOh+Ow/EvMhHSnoZ2hohMJChv/Rz6LwSJWddCff42H2FjkytJ/D62odwzU1
 JQboPRy/NziHLnUynbUHbVTRO70jxqWGGaH2Q81T/HN4xzoqiD9Id0MiN1rDBoxWvvobwMFd
 6M6Vel5zZtXMX3CgURfPN/pU55CIUQN6b3Yuh38Z95KZN16cxWKuXEGia+sM4LFzRNEfUIXY
 MrznSOQ4ZAyVfwPIN2eHLp17FPT7npirV4/vLiip/hd7VZ7WJJzYelbWLdpRr5ghJ5oXC2Om
 zqiH5LQkk4GALGWjtf/r9BMRbz1EZTLLcmm95MIHgJyCiFnA2omQ8TA2q8sfpcNokimvraVo
 SvjCydlJK7ErSCWcm2iNyE8AI4DqL4i9BrXywR3ZQb2s5XiCK7yhJoim2wfLeh/qLM7laYqJ
 xTHEu3Zaslypv3802x1RfHAQEZKLXxHWSrm0/KZXQUC
IronPort-HdrOrdr: A9a23:9zUCZqoQtgfEoGx8jp7tfjEaV5oqeYIsimQD101hICG9Ffbo8/
 xG88506faZslsssTQb6LO90cq7MBbhHOBOgLX5VI3KNGKNhILrFvAB0WKI+VLd8kPFmtK1rZ
 0BT0C7Y+eAa2STSq3BkW6FL+o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="722938239"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 May 2021 17:27:54 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 14LHRsrc004198
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 May 2021 17:27:54 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 092AFCC1254; Fri, 21 May 2021 10:27:54 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v6 3/3] perf parse-events: add bison --file-prefix-map option
Date:   Fri, 21 May 2021 10:27:53 -0700
Message-Id: <20210521172753.55399-3-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210521172753.55399-1-dzagorui@cisco.com>
References: <20210521172753.55399-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
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

