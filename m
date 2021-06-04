Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECA39BD15
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhFDQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0ACB613BF;
        Fri,  4 Jun 2021 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824097;
        bh=MMbz8ZwPoTr4U3mClTp3y2ef9sHAlK4fsQdGRU0DOX0=;
        h=From:To:Cc:Subject:Date:From;
        b=McuP7bMJ5eyPpqQ7wHCQwHsjEqQCEZ655JFBCSJw6hl12AZM+/3lkMuBBZCiMyzC8
         jOo4dhFM7KakXY4csdGPdjsqERZ7osLVGI4o13jNSj0ls9InkorFv/BIplJceO4u9d
         qVnGK9dHdiL0SbiuIzNXTyOBfS/TkUS7b+HvwN93tvDBly1kJaMQYSg9kR0Dd27Qre
         U+RyfrXW/kWrwfw8UDrK7TCEoIi8/26+D/RIhXxaKlO60FdeSuwkKTQjNgaGKhT4kH
         UnKUxpWmEoh7L4ocPetV4X5/cVMgRrBE/TL/6qypVjvPRu2NPv9nWXCft9vJpb8WNh
         e82ZoARH1gN0g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf probe: Boot time tracing support
Date:   Sat,  5 Jun 2021 01:28:12 +0900
Message-Id: <162282409255.452340.4645118932261585719.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches to add boot-time tracing support to perf
probe command.
Recently, I tried to debug kernel boot process with boot-time tracing
and I found perf probe lacks some features for it.

[1/3] fixes perf probe to show probe definitions on __init functions.
Since __init functions are removed after boot (and those are not in
.text but .inittext section), perf's map object can not find them.
[2/3] is a code cleanup preparing for the next patch.
[3/3] adds --bootconfig option for showing the probe definitions in
the bootconfig format. This option can be used with -D (--definition)
option.

One todo is improving -F option. Since the -F option also using the
map object, it can not list up the __init function. Anyway, that may
not be important. Usually, the person who debugs kernel already know
the target function name, and can use "perf probe -L func" for
checking the function source code. (Note that perf probe -L doesn't
depend on map object)

Thank you,

---

Masami Hiramatsu (3):
      perf/probe: Support probes on init functions for offline kernel
      perf/probe: Cleanup synthesize_probe_trace_command
      perf/probe: Add --bootconfig to output definition in bootconfig format


 tools/perf/builtin-probe.c    |   12 +++
 tools/perf/util/probe-event.c |  167 +++++++++++++++++++++++++++++++----------
 tools/perf/util/probe-event.h |    2 
 3 files changed, 141 insertions(+), 40 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
