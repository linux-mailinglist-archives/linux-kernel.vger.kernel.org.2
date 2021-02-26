Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4010A325E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:00:47 -0500
Received: from aegir.uberspace.de ([185.26.156.141]:44910 "EHLO
        aegir.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBZIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:00:32 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 03:00:31 EST
Received: (qmail 10560 invoked from network); 26 Feb 2021 07:52:27 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by aegir.uberspace.de with SMTP; 26 Feb 2021 07:52:27 -0000
Date:   Fri, 26 Feb 2021 02:52:23 -0500
From:   Fabian Hemmer <copy@copy.sh>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf tools: Preserve identifier id in OCaml demangler
Message-ID: <20210226075223.p3s5oz4jbxwnqjtv@nyu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some OCaml developers reported that this bit of information is sometimes
useful for disambiguating functions for which the OCaml compiler assigns
the same name, e.g. nested or inlined functions.

Signed-off-by: Fabian Hemmer <copy@copy.sh>
---
 tools/perf/tests/demangle-ocaml-test.c |  6 +++---
 tools/perf/util/demangle-ocaml.c       | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index a273ed5163d7..1d232c2e2190 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -19,11 +19,11 @@ int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_u
 		{ "main",
 		  NULL },
 		{ "camlStdlib__array__map_154",
-		  "Stdlib.array.map" },
+		  "Stdlib.array.map_154" },
 		{ "camlStdlib__anon_fn$5bstdlib$2eml$3a334$2c0$2d$2d54$5d_1453",
-		  "Stdlib.anon_fn[stdlib.ml:334,0--54]" },
+		  "Stdlib.anon_fn[stdlib.ml:334,0--54]_1453" },
 		{ "camlStdlib__bytes__$2b$2b_2205",
-		  "Stdlib.bytes.++" },
+		  "Stdlib.bytes.++_2205" },
 	};
 
 	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
diff --git a/tools/perf/util/demangle-ocaml.c b/tools/perf/util/demangle-ocaml.c
index 3df14e67c622..9d707bb60b4b 100644
--- a/tools/perf/util/demangle-ocaml.c
+++ b/tools/perf/util/demangle-ocaml.c
@@ -64,17 +64,5 @@ ocaml_demangle_sym(const char *sym)
 	}
 	result[j] = '\0';
 
-	/* scan backwards to remove an "_" followed by decimal digits */
-	if (j != 0 && isdigit(result[j - 1])) {
-		while (--j) {
-			if (!isdigit(result[j])) {
-				break;
-			}
-		}
-		if (result[j] == '_') {
-			result[j] = '\0';
-		}
-	}
-
 	return result;
 }
-- 
2.30.1

