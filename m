Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88C38E539
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhEXLRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:17:04 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:13883 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhEXLQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3312; q=dns/txt; s=iport;
  t=1621854916; x=1623064516;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFjfl4xJfPfBHw99z86+v8NqOKExMrnDkDvZI6epnsk=;
  b=ClUcGhRrQVTh35gwh7Q9fC5SsxJCFH5LYwi1RjIR9ZmnzccRZ5YCBq17
   1B31aTk4gIZev9B4pdJLGkS84jSh8jO250Zq9gVZjpAEGQWE7vtds6Og+
   +QtxNwICWtNT0qdXEHFM6UJPkpAz7PqH4JHcZzxc9DV5Id1UtSr9YZayp
   4=;
X-IPAS-Result: =?us-ascii?q?A0BkAQA9iqtgl5BdJa1agmCDIlYBOTGxaIF8CwEBAQ0BA?=
 =?us-ascii?q?S0UBAEBhFACgX4CJTUIDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFaA2GRQYyAVYeMywrBxKCcQGDB6digiyBAYgzgUSBOoh2doN4JxyBS?=
 =?us-ascii?q?USBFYNgihsiBIJHexMBohacVYMhnUgUKYNbixmWWJU9nxcgVYQNAgQGBQIWg?=
 =?us-ascii?q?VUBN4FbMxoIGxWDJAlHGQ6OOIM+ixchAy8CNgIGCgEBAwmJbgEB?=
IronPort-Data: A9a23:TVet4qncS6SOzfiP4XKbylbo5gxTJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbDTvVb/2NNmagLdEiPoiz8k8E6sTRn4BgTFE/+S0yEltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMo/y1Si6FatANl1EkvU2zbue6WLSs1hxZH1c+EX980047wobVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQ/45gFFv0lY3tPsDa3xuta4
 ohitJyZHFJB0q3kwIzxUjFCGC14eKZB4rKCcT60sNeYyAvNdH6EL/dGVR5te9ZHvLcsRzgSq
 ZT0KxhVBvyHr+6kyb28UPRtrs8iN8LseogYvxmMyBmHXKl/HMicE/SiCdlwwTsAi8ZuJuviP
 ttAchR/QT7wWQcVEwJCYH45tL742iagG9FCk3qRpKwq8y3QwRZ33bzFLtXYYJqJSN9Tk0Leo
 XjJl0z8AxcVM/SFxDaF+27qjejK9Qv5X4YJHZWi+/JqiUHVzWsWYDUfUVarqP+1h1T4QNJeM
 EwX+ywGqak06VztT9/hUhn+q3mB1jYaUt9QAvA85ymOx7DS7gLfAXILJhZIY9krnMw7Xzon0
 hmOhdyBLSRirLCPW1qc8LmOpD+/MCRTKnUNDQcBRBEGpcP+vIU6iB7nR8xmVqWyi7XI9SrY2
 TuGqm01gK8eyJ5N3KSg9leBiDWpznTUcuIrzgjmYFyH6TpzWJaeZLLx0nPxsNlBLK/MGzFto
 0M4d9iiAPEmVM/XzXHdHr1SQNlF9N7eamyA3gUH840JsmXzpCb5Lei89RknfB8xWvvobwMFd
 6M6Vel53p5YPHKwYbRwZepd4Ox1kPCwTLwJuh0oB+eij7BrfwOBuSppf0PVjwgBcXTAc4liY
 v93ku71UB727JiLKhLtG4/xNpdwnEgDKZv7H8yT8vhe+eP2iISppVI53L2mMLlRAESs/ly9z
 jqjH5HiJ+h3CbenOXCHreb/03hXfSBT6W/KRzx/L77ffVUO9JAJIP7KyrRpQJ1+g6lQjY/1E
 oKVCxIGkgGm7UAr3T6iNyE4AJuyDMkXkJ7OFXF1Vbpe8yN7MdjHAWZ2X8ZfQITLA8QznKYoE
 KFdI5vo7zYmYm2vxgnxpKLV9ORKHClHTyrVV8Z5SFDTp6JdejE=
IronPort-HdrOrdr: A9a23:CIppnKij7UP2MHy/CnLutxDU53BQXtsji2hC6mlwRA09TyX+rb
 HLoB1173HJYVoqNU3I3OrwW5VoIkmskKKdn7NxAV7KZmCP0wGVxcNZnOnfKlbbdBEWmNQw6U
 4ZSchD4BmaNykdsS48izPIdOod/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="697150789"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 24 May 2021 11:15:15 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 14OBFE27012694
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 May 2021 11:15:14 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 350EBCC1254; Mon, 24 May 2021 04:15:14 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v8 3/3] perf parse-events: add bison --file-prefix-map option
Date:   Mon, 24 May 2021 04:15:14 -0700
Message-Id: <20210524111514.65713-3-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210524111514.65713-1-dzagorui@cisco.com>
References: <20210524111514.65713-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
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

