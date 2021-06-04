Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3E39BBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFDPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhFDPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12E5761404;
        Fri,  4 Jun 2021 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622820653;
        bh=R1r4ZguRR84eTqlTIHaQSm5s7ptxjLy5YZxmd+O0MGU=;
        h=From:To:Cc:Subject:Date:From;
        b=jEmShnjDYIryA9zlIrpPRtTFYU2+DUFfJb7yc9HZF/LEffRL/jDcDzjgOzLv8XF6e
         TFiXP9ZfXiP5L2BEpM05h2w0WtWPJ40vSvM3r5oTqzO+6blfGzGJcb30XV0DOnDBpk
         yo2K7s0+ZMuzPXj8zbZoaEzpMlU83cy4Va8wfP+i05Xorn7XPGeWlnKuPrOMXx5QfA
         WiaRcBkCXOovUbKS/1/QgBKFO0QyJc81gLka1b/gWBuwnqKSMBm5UYssUFImK0PITh
         kcJ4yp99jRTaO/56Tgof2kN70BdV/kIugi6PiPd3C8qxQU7B/espbeXeiBbBJy8ds2
         2I5VlZ8xTYJyw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/2] perf probe: Report permission errors
Date:   Sat,  5 Jun 2021 00:30:48 +0900
Message-Id: <162282064848.448336.15589262399731095367.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo and Ravi,

Here is a couple of patches to improve error message for the permission
errors on perf probe, which we talked in the following thread;

 https://lore.kernel.org/lkml/20210525043744.193297-1-ravi.bangoria@linux.ibm.com/

Thank you,

---

Masami Hiramatsu (2):
      perf/probe: Report possible permission error for map__load failure
      perf/probe: Report permission error for tracefs error


 tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
 tools/perf/util/probe-file.c  |    4 ++++
 2 files changed, 26 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
