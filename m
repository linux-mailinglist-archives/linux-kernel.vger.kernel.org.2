Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C767438D3E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhEVGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:21:49 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:47171 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEVGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3312; q=dns/txt; s=iport;
  t=1621664421; x=1622874021;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFjfl4xJfPfBHw99z86+v8NqOKExMrnDkDvZI6epnsk=;
  b=WJ4YRBTgLkM7QtTEpkf8WcXnI1NNBKau7deW5fzFfEBWB2X0QqGLOMN4
   bCy7xaPUZUWN4pmimMqN293n4tUeBx95Lntd4y+HMJ0P6R4hjYq5Bh4gr
   q29ilJg4KO1EIYEeekGQktBSoDZKDWEX/UVXB6WJmLFe86mKUvexxXPpw
   Q=;
X-IPAS-Result: =?us-ascii?q?A0AiAQAroqhgl4kNJK1agmCDIlYBOTGxYoF8CwEBAQ0BA?=
 =?us-ascii?q?S0UBAEBhE8CgX4CJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFaA2GRQYyAVYeMywrBxKCcQGDB6g+giyBAYhMgUSBOoh2doN4JxyBS?=
 =?us-ascii?q?USBFYNgihsiBIJHexMBohKcVYMhnUcTKYNbixmWV5U6nxYgVYQNAgQGBQIWg?=
 =?us-ascii?q?VQ5gVszGggbFYMkCUcZDo44gz6LFiEDLwI2AgYKAQEDCYk+AQE?=
IronPort-Data: A9a23:dvhK2qBY5I5vuxVW//njw5YqxClBgxIJ4kV8jS/XYbTApDt0hjRVm
 jAWUWjXO/aCY2T9e90jb47k/B5TuZfXy9E1OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /3z6bAsFehsJpPmjk/F3oPJ8D8sj8lkepKmULSdYn0rHFc9IMscoUsLd9AR09YAbeeRW2thi
 fuqyyEIEAb4s9LcGjt8B5Or8HuDjtyr0N8rlgBWicRwgbPrvyJ94KTzik2GByCQroF8RoZWT
 gtYpV2z1juxExwFUrtJnltnG6EHaua6AOSAtpZZc5qAkAEYnDMA65gADOtBYl4MgD+T3Pkkn
 b2htbToIesoFqTInOJYWB5CHmQie6ZH47TAZ3O4tKR/zWWfLCCqmKsoVRpwZNZHkgp0KTkmG
 fgwJCIEYReZmuOey7OgQe4qjcMmRCXuFN1O4igxnGiDVp7KR7idH6Dq68NF7g5g3Pp1EaiHW
 do4ZihGOUGojxpnYwdLV81WcP2Trn3+dSBI7VGYv6w650DNwwFrlrvgKtzYfpqNX8o9tkOZo
 G3B1370DhETKJqUzj/t2nCrgvTGtTn2VIIbCPuz8fsCqFSXy3waDhEbTx2gofiiik2/XfpbK
 koJ6mwvq7Q/8AqgSdyVdxuxpX6VoxgTc9ldCes37EeK0KW8yw+SA2UsTTNbbtEi8sgsSlQCz
 lKVksn7LT1pvqecRX+U+vGTtzzaES0cN2xEfzIYSQID7/HquoR1hRXKJuuPC4a8itnzXDr32
 T3P8G41hq4YiogA0KDTEU37byyElLrbV1QP+TfuYFmd/15yfdWubZbrwA2OhRpfF7p1XmVtr
 VBdxZLHsbBQVc7Q/MCeaL5WRODzt55pJBWZ0AAxQ8R9n9i40yP7Fb289g2SM6uA3iwsUDvtb
 Um7Veh5u8ILZCHCgUOan+uM5ykCxKzkE5HuUerZK4YmjnlNmO2voXoGia24hj2FfK0QfUcXZ
 c3znSGEVilyNEif5GDqL9rxKJdyrszE+Y82eXwd50r5uVZ5TCDMIYrpzHPVBgzExPre+V6Mo
 4o32zWilUsAOAEBXsUn2ddDcQ9VRZTKLbv3sMdQPtWSORZrHXpJNhMi6eJ8JNY7zsxoehPz1
 iztCydwlQuk7VWaeFriV5yWQO62NXqJhSlgZnJE0JfB8yVLXLtDG49PJsNrIuF/rLILIDwdZ
 6BtRvhsy89nElzvkwnxp7GkxGC+XHxHXT6zAhc=
IronPort-HdrOrdr: A9a23:r3C6gK+zsgUd14ZichZuk+DZI+orL9Y04lQ7vn2ZLiYlFvBw+P
 rBoB1273LJYXMqKRIdcLO7Scy9qA3nlKKdiLN5VdzJYOClghrLEGgI1+TfKlPbdxEWjtQ86U
 +lGJIObuEZyjNB/KHH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="690199123"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 May 2021 06:20:17 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 14M6KHQB016465
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 May 2021 06:20:17 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id D92A7CC1254; Fri, 21 May 2021 23:20:16 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v7 3/3] perf parse-events: add bison --file-prefix-map option
Date:   Fri, 21 May 2021 23:20:16 -0700
Message-Id: <20210522062016.84677-3-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210522062016.84677-1-dzagorui@cisco.com>
References: <20210522062016.84677-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
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

