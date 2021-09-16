Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44EC40D321
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhIPGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234470AbhIPGYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C7F2611CA;
        Thu, 16 Sep 2021 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773375;
        bh=y6i0mll5ycxRMhkwuLJkyH6J5MoI0QZBK20JbH3dz9g=;
        h=From:To:Cc:Subject:Date:From;
        b=KEOf6KPgaWriDu+CU7mne9sCLxWqyW2K49EDc53xYCbpQhIf05jqhtEQJcwg0SRep
         yLEuZEmduewlxrw8mLCzu4wEQoexPClnCWdApAsmqsc/B7DiovxEeCtyYdaMCSQsto
         fdfzDWP2GwpWnd78PBeKPrt5HoVGFgbytTUb1v7EtRxxxNH31nTFXqNS/VPHHkdvR1
         nrO7kNNTeAcq5KzqiE5wTV+N7c7J0gOv33hbD1CejvZpWJ3DCwigeMLlvLRtwuSPc/
         yZurBjq1S6Tc8z3zIvp7vyvc0MLsIU0g4PxMtMsZrsK5RO/yBq/cIOHqF+Y2WFFATc
         85Bgle/hANiLg==
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
Date:   Thu, 16 Sep 2021 15:22:52 +0900
Message-Id: <163177337229.682186.7065313475385716631.stgit@devnote2>
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
