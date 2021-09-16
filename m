Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5740D322
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhIPGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234469AbhIPGY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5899D60E76;
        Thu, 16 Sep 2021 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773386;
        bh=y6i0mll5ycxRMhkwuLJkyH6J5MoI0QZBK20JbH3dz9g=;
        h=From:To:Cc:Subject:Date:From;
        b=q13cRJ01f0d/JVXT6QJ4J7m4w5Y2QI+Ek3CnCCOsAfVq+GqWh48m5xfkeZRvM0eLk
         WhvUQQjZbpUldT6xQ75gj1S9GCQuCZB5oME9zPc9xocN+WzY7kmFhTajmzbu4qVV8x
         uqlnXGlEJvHZybvWeRimrzdsdEI3y+akzHbY4grhaGkNoPu2mX6IvUM1HWgH/58nGs
         7umgdQopOGRcfaHj4dUGDgyjk2+jzs12smBI07hGfEBD23zRDzdGSQhBzYgUsbJwPQ
         I+AjByUEjuYyDQ/cfJKxyMVMDAf/g8wJc9aN3FmbK9Y2LBV577IYNCZsCRxjMpuAml
         SZAQD+cKsXBPw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 0/4] bootconfig: Fixes to bootconfig memory management etc.
Date:   Thu, 16 Sep 2021 15:23:03 +0900
Message-Id: <163177338366.682366.5998343833719057348.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here are the 4th version of the series to fix bootconfig memory 
management issues and API cleanup.

In this version, I added patches to move the memory allocation 
for the bootconfig in xbc_init() [2/4], add xbc_get_info()[3/4],
and rename xbc_destroy_all()[4/4].

Thank you,

---

Masami Hiramatsu (4):
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()
      bootconfig: Allocate xbc_data inside xbc_init()
      bootconfig: Add xbc_get_info() for the node information
      bootconfig: Rename xbc_destroy_all() to xbc_fini()


 include/linux/bootconfig.h |    6 +++-
 init/main.c                |   17 ++++--------
 lib/bootconfig.c           |   60 +++++++++++++++++++++++++++++++++-----------
 tools/bootconfig/main.c    |    9 ++++---
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
