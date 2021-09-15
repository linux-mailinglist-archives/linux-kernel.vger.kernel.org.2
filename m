Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD540BCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhIOAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 20:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhIOAyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D726103B;
        Wed, 15 Sep 2021 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667180;
        bh=+za6gOGgZTMu0MVI6wOLAb7tqLNqbH1pbLUF+1xhYYY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZXxQI1qY9O21rUR13+AL/uJn5GG5mGZmg5xcInMK5TcdeHZZumljOixuitQeWqDUy
         GCVkJ7ZrWY4zW20g9X14/2c3D/A3/fMYBgl02VN8Ev6x1ISeSQjTvU+MTDSCNVTVzu
         aF4fK0P0ILpMsGXduS11pROdPdYOnhCcaM7gmV4QWbwZW2xO3DVD0Zp+l59AGUuUGP
         xt6NRqo7EPqiNOvG4+u9mOcAeVoOXzpUcB+qOsmwvFrOOirSUINWVeRSnlRrGov1Cg
         TYXexDRibevnp5XbaXkrheo35145t9vtiJVpBSweahy4NrVoxPi4F+AoD32P0pfcaw
         Mj51CvtWn2iNg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/5] bootconfig: Fixes to bootconfig memory management
Date:   Wed, 15 Sep 2021 09:52:57 +0900
Message-Id: <163166717752.510331.12843735095061762373.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are the series of patches to fix bootconfig memory management issues.
From v1, I added some more fixes and split a memory leak fix from freeing
unused memory patch.

[1/5] fixing kernel BUG issue on boot. Just rebased on the linus tree.
[2/5] Add new memblock leak fix in xbc_make_cmdline().
[3/5] Split from [4/5], fixing a memblock leak in setup_boot_config().
[4/5] Free unused memblock after boot. Use new memblock_free_ptr().
[5/5] Fix a tool build error caused by memblock_free_ptr().

And now I'm considering to move ownership of copied bootconfig data
to lib/bootconfig. That will make code simpler. But I also think fixing
bugs are urgent. So I send this series first.

Thank you,

---

Masami Hiramatsu (5):
      bootconfig: Fix to check the xbc_node is used before free it
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()
      bootconfig: init: Fix memblock leak in setup_boot_config()
      bootconfig: Free copied bootconfig data after boot
      tools/bootconfig: Define memblock_free_ptr() to fix build error


 init/main.c                               |    9 +++++++++
 lib/bootconfig.c                          |    3 ++-
 tools/bootconfig/include/linux/memblock.h |    3 +--
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
