Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B915321206
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBVIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:30:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:33568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVIaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:30:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05140AD57;
        Mon, 22 Feb 2021 08:29:23 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf annotate: add --demangle and --demangle-kernel
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
Date:   Mon, 22 Feb 2021 09:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf annotate supports --symbol but it's impossible to filter
a C++ symbol. With --no-demangle one can filter easily by
mangled function name.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
  tools/perf/Documentation/perf-annotate.txt | 7 +++++++
  tools/perf/builtin-annotate.c              | 4 ++++
  2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1b5042f134a8..80c1be5d566c 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -124,6 +124,13 @@ OPTIONS
  --group::
  	Show event group information together
  
+--demangle::
+	Demangle symbol names to human readable form. It's enabled by default,
+	disable with --no-demangle.
+
+--demangle-kernel::
+	Demangle kernel symbol names to human readable form (for C++ kernels).
+
  --percent-type::
  	Set annotation percent type from following choices:
  	  global-period, local-period, global-hits, local-hits
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a23ba6bb99b6..ef70a17b9b5b 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
  		    "Strip first N entries of source file path name in programs (with --prefix)"),
  	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
  		   "objdump binary to use for disassembly and annotations"),
+	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
+		    "Disable symbol demangling"),
+	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
+		    "Enable kernel symbol demangling"),
  	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
  		    "Show event group information together"),
  	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
-- 
2.30.1

