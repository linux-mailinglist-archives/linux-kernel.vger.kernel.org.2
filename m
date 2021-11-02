Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B4443A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhKCAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhKCAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:00:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADFCC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:57:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g18-20020a631112000000b00299f5f53824so614498pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6xRUAwGEAvL2FLNG6Ew0dIktYeQXABiRZImi7UO46gg=;
        b=CsFcRkCifq3Fsq6P3dEKCPtHEuEoIzbRM2MLLoxVkiKbXe3tvWN5WP7lkN/N2YBT9j
         5oaDxmcYbH6b54zSmOpMLiW3UrD19aib4pbRYedyTYrednVpwdd41HohZsAfckvE+MJ0
         E+BwWkp/+ti/DpZgBtNRemaaZ+EMAcHAF8/C95MajuFr9eu7AWw+g1M6JcfZ/sxfZ6en
         dNZOP61uNtlGd0L3S+j/9InZUWEQ5DYsmw72ClpH2i2X+16j6NsQxf2GaszFrwBrTZdL
         V7Y4DfxukazdbSTxmhQk41RnPF63TlrFUaVjvwvWPJ4kezk/uShmNQdgWFQKezmR5ZRT
         qzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6xRUAwGEAvL2FLNG6Ew0dIktYeQXABiRZImi7UO46gg=;
        b=nACDAm/Nv1mIf/E9c05z6yVbnOV2KL1qKw2YqUifFcCz6LYo8kKwQBx/MWzYT/L4Yx
         iJG8lOtFIAEwLWILWXtJcYwEfuz6KzsBE9aUDtss2zx4LhS0udGP9lB0Y+qcybdQgquy
         HSCzE6pFZyQPLQrfuYpe3olt5MwlfCh57ZMFKSQNXilgGcelmvSf3t+y+ec06BIxAgCy
         l2OzfsKBwr87F7fdg2mSgsQxGWmXnWwfhpFJORJs5KComy49fY4YHxK/lDA8NXkG7//j
         2QzSX7aqZiwFCSE3VmxNnozMaTq/lTosVPoS2yGsC4wfVi4HN86B86AWtQV4vjyYv02V
         lC1A==
X-Gm-Message-State: AOAM533A0JGVb4cLqefx8Ai2KmMFiF8xiBm202hKz7A5khB1v77UkdQK
        Gm8MAOdj48xkGO7sKm8VYgejunWMp9X7ZQ==
X-Google-Smtp-Source: ABdhPJxWodAcytdPjc6Pqhtm4ixpFTyLDSQebOYq8Atv0Un99RQTw9uZ6nJvnq5y4XIvN6zorQ8TW2B2JW9xUw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:c525:894b:a510:93ff])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:380d:: with SMTP id
 mq13mr10305132pjb.110.1635897476992; Tue, 02 Nov 2021 16:57:56 -0700 (PDT)
Date:   Tue,  2 Nov 2021 16:57:34 -0700
Message-Id: <20211102235734.497713-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] kunit: add run_checks.py script to validate kunit changes
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This formalizes the checks KUnit maintainers have been running (or in
other cases: forgetting to run).

This script also runs them all in parallel to minimize friction (pytype
can be fairly slow, but not slower than running kunit.py).

Example output:
$ ./tools/testing/kunit/run_checks.py
Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
kunit_tool_test.py: PASSED
mypy: PASSED
pytype: PASSED
kunit smoke test: PASSED

On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
E.g. adding in a type-checking error:
  mypy: FAILED
  > kunit.py:54: error: Name 'nonexistent_function' is not defined
  > Found 1 error in 1 file (checked 8 source files)

mypy and pytype are two Python type-checkers and must be installed.
This file treats them as optional and will mark them as SKIPPED if not
installed.

This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
play nicely together.

It uses --build_dir=kunit_run_checks so as not to clobber the default
build_dir, which helps make it faster by reducing the need to rebuild,
esp. if you're been passing in --arch instead of using UML.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/run_checks.py | 76 +++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 tools/testing/kunit/run_checks.py

diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
new file mode 100755
index 000000000000..d03ca3f84b91
--- /dev/null
+++ b/tools/testing/kunit/run_checks.py
@@ -0,0 +1,76 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# This file runs some basic checks to verify kunit works.
+# It is only of interest if you're making changes to KUnit itself.
+#
+# Copyright (C) 2021, Google LLC.
+# Author: Daniel Latypov <dlatypov@google.com.com>
+
+from concurrent import futures
+import datetime
+import os
+import shutil
+import subprocess
+import sys
+import textwrap
+from typing import Dict, List, Sequence, Tuple
+
+ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
+_TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
+
+commands: Dict[str, Sequence[str]] = {
+	'kunit_tool_test.py': ['./kunit_tool_test.py'],
+	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
+	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
+	'mypy': ['/bin/sh', '-c', 'mypy *.py'],
+}
+
+# The user might not have mypy or pytype installed, skip them if so.
+# Note: you can install both via `$ pip install mypy pytype`
+necessary_deps : Dict[str, str] = {
+	'pytype': 'pytype',
+	'mypy': 'mypy',
+}
+
+def main(argv: Sequence[str]) -> None:
+	if len(argv) > 1:
+		raise RuntimeError('Too many command-line arguments.')
+
+	future_to_name: Dict[futures.Future, str] = {}
+	executor = futures.ThreadPoolExecutor(max_workers=len(commands))
+	for name, argv in commands.items():
+		if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
+			print(f'{name}: SKIPPED, {necessary_deps[name]} not in $PATH')
+			continue
+		f = executor.submit(run_cmd, argv)
+		future_to_name[f] = name
+
+	print(f'Waiting on {len(future_to_name)} checks ({", ".join(future_to_name.values())})...')
+	for f in  futures.as_completed(future_to_name.keys()):
+		name = future_to_name[f]
+		ex = f.exception()
+		if not ex:
+			print(f'{name}: PASSED')
+			continue
+
+		if isinstance(ex, subprocess.TimeoutExpired):
+			print(f'{name}: TIMED OUT')
+		elif isinstance(ex, subprocess.CalledProcessError):
+			print(f'{name}: FAILED')
+		else:
+			print('{name}: unexpected exception: {ex}')
+			continue
+
+		output = ex.output
+		if output:
+			print(textwrap.indent(output.decode(), '> '))
+	executor.shutdown()
+
+
+def run_cmd(argv: Sequence[str]):
+	subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=_TIMEOUT)
+
+
+if __name__ == '__main__':
+	main(sys.argv[1:])

base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
-- 
2.33.1.1089.g2158813163f-goog

