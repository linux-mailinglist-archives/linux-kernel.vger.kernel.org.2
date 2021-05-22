Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38938D3E0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhEVGVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:21:46 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:56353 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhEVGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2404; q=dns/txt; s=iport;
  t=1621664421; x=1622874021;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jA6VOyUz8HqvmDa574sYJssvKl47NA09np1hsczVkwQ=;
  b=hfgMfnzvk++mK9z3qvXLSn6mEDMnOLkZ1VGQbNcomXrzk1JGSTZpPJUz
   9kMzL8e0aZMFYXGIIfl2NLVhL7QXfs10UIoOvCef+t9e3btY+u5crB6Fc
   uYuQIHsjd7ZYv/Ib6xR4HmVUb9SiPdkpoxMfgx8XndamfaZS6t4oY0Uzu
   o=;
X-IPAS-Result: =?us-ascii?q?A0AiAQAroqhgl4oNJK1agmCDIlYBOTGxYoF8CwEBAQ0BA?=
 =?us-ascii?q?S0UBAEBhE8CgX4CJTQJDgIEAQEBAQMCAwEBAQEFAQEFAQEBAgEGBBQBAQEBA?=
 =?us-ascii?q?QEBAWiFaA2GRQYyAVYeMywrBxKCcQGDB6g+giyBAYhMgUSBOoh2doN4JxyBS?=
 =?us-ascii?q?USBFYNgij0EgkeBDxOTX44gnFWDIYoKkz0TKYUdoC6VOqALhA0CBAYFAhaBV?=
 =?us-ascii?q?DmBWzMaCBsVgyQJRxkOjjiDPocKhAwhAy8CNgIGCgEBAwmJPgEB?=
IronPort-Data: A9a23:XFz8nqqmF2e5GkOz57ClxHGW1vteBmLIZRIvgKrLsJaIsI4StFCzt
 garIBnXOv6KZzb0Ktwkad/g8EsCv8PXyd4wSlM9/ytmRi9Go+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkS5TE3oHJ9RGQ74nQLlbHILOCanoZqTNMEn970Eo+wbdh2+aEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8kFWc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO6VoD66iWuqBDe3Y48avY3eWFoqwm2oNt90
 c1q78GgdQoQa/ikdOQ1C3G0Egl3OalAvbTAO3X67IqYzlbNdD3nxPAG4EMeZNJDvL0pRzgVs
 6VDeFjhbTjb7w6y6L6pQ+ZrnNkiBMLqJ4gY/HpnyFk1CN55G8uaGv2QuoUwMDEY25ANQcTFN
 ssgeAVgfk/jSAYWNlgSB8dr9AuvriCvL2IHwL6PnoIz4m7O3Ely3aLrPd79ZNOHX4NWk1yeq
 2aA+H72ajkfNdqQzhKf/36sj/OJliT+MKoQE7mj/9ZwjVGTz3BVAxoTPXOypfSpg0iyVsgZM
 EwV4SotrK4a8E2tU8m7XhukrXrCtRkZM/JWGug6+RyLxYLX7hyfC2xCSSROAPQvv8o7bT8nz
 FmEm5XuHzMHmKWYVX+H5J+Vqz2oMCQYJGNEYjULJSMA6sPg5psukhbGSNpLGbSwyNbyHFnNL
 yuipSw6gfAYitQGkvj99lHciDXqrZ/MJuIo2unJdmX74ihpQrGFW7OX4lTC9dEacZalQ2DU6
 RDohPOiAPAy4YClzXLXGbhdQun2up5pIxWH2gY+RclJGyCFvi/9I9wNvFmSMW80aq45lSnVj
 Fg/UO+7zLZXOHasBUOcS93sU5xwpUQM+CiMaxw5RtNKZp40fwid8WQzDaJx44wPuBV3+U3cE
 c7GGSpJMZr8Ifg/pNZRb7xAuYLHPghkmQvuqWnTlnxLK4ZygUJ5r59bbjNiichntcu5TPn9q
 L6zyuPTkUwECb2iCsUp2dBNcjjm0kTX9biv+5AIKYZv0yJNGXoqDLfq0Kg9dol+95m5Zc+Zo
 y7nBB4w9bYLvlWaeVTiQi0yM9vHAMcgxU/XyARxZD5ELVB4Ot3xhEreHrNqFYQaGBtLna8sE
 6ZdI53eahmNIxyekwkggVDGhNQKXHyWacimZkJJvBBXk0ZcejH0
IronPort-HdrOrdr: A9a23:odP8LKPi63cZj8BcTsCjsMiBIKoaSvp037BN7TEUdfU7SKKlfq
 yV8cjzkCWE6wr5O0tQ/OxoRpPgfZq0z/cciuMs1PWZLWvbUQCTQ72Kg7GP/9SZIU3DHio379
 YHT0C4Y+eAamRHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,319,1613433600"; 
   d="scan'208";a="723110272"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 May 2021 06:20:17 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 14M6KHFP013759
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 May 2021 06:20:17 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id D6A80CC1253; Fri, 21 May 2021 23:20:16 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: [PATCH v7 2/3] perf tests: avoid storing an absolute path in perf binary
Date:   Fri, 21 May 2021 23:20:15 -0700
Message-Id: <20210522062016.84677-2-dzagorui@cisco.com>
X-Mailer: git-send-email 2.26.2.Cisco
In-Reply-To: <20210522062016.84677-1-dzagorui@cisco.com>
References: <20210522062016.84677-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

python binding test uses PYTHONPATH definition to find python/perf.so
library. This definition is an absolute path that makes perf binary
unreproducible. This path can be found during runtime execution.

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/perf/tests/Build        |  2 +-
 tools/perf/tests/python-use.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d490..a20098dcdbc4 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
-CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
+CFLAGS_python-use.o   += -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 98c6d474aa6f..e196faf1140d 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -8,18 +8,46 @@
 #include <linux/compiler.h>
 #include "tests.h"
 #include "util/debug.h"
+#include "util/util.h"
+#include <sys/stat.h>
+#include <limits.h>
+#include <libgen.h>
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	char *cmd;
 	int ret;
+	char *exec_path;
+	char *buf;
+	char *pythonpath = NULL;
+	struct stat sb;
 
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+	buf = malloc(PATH_MAX);
+	if (buf == NULL)
 		return -1;
 
+	perf_exe(buf, PATH_MAX);
+	exec_path = dirname(buf);
+
+	if (asprintf(&pythonpath, "%s/python", exec_path) < 0) {
+		ret = -1;
+		goto out;
+	}
+
+	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
+		pythonpath[0] = 0;
+
+	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
+		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0) {
+		ret = -1;
+		goto out;
+	}
+
 	pr_debug("python usage test: \"%s\"\n", cmd);
 	ret = system(cmd) ? -1 : 0;
 	free(cmd);
+out:
+	free(buf);
+	free(pythonpath);
 	return ret;
 }
-- 
2.26.2.Cisco

