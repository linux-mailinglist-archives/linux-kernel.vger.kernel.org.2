Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BACA40C629
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhIONUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhIONUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:20:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2126121F;
        Wed, 15 Sep 2021 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631711970;
        bh=e/WesGgcVk0aOw16WbSTFrc8uzKCIhuU6oYF3jpAddo=;
        h=From:To:Cc:Subject:Date:From;
        b=tZcqFjEHCm1QFWDhx10RIjZZ4zVVb4dQ3QcDPEGx0PKeRWXldFbFYZj6U1w+aWh/4
         59I4hTuw3/ML03joE8WTnakK0qTLYXn1MLRMSgxfouFXmMdpxClrIgZyDFi5VcBa3R
         fK3ZH198F6EDtkP/6NjlsuhXsFndZ0XsMZNPTWGTHyUhycQwsDuPwusNarv8eRHncA
         ZIUhufVibfCRFXKv7JiXpX83VCIYOORsKZssF1CMTFKFomLxvdZykLxoW/sGeT7QDU
         6tyd4dokSTs8GkOSXDwP5tZMWSy4BjauqRxJ2e4Xyts8+bAxbOfXhk82O3Ov4oz4u6
         kVVY2wVPEs8Vw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 0/3] bootconfig: Fixes to bootconfig memory management
Date:   Wed, 15 Sep 2021 22:19:27 +0900
Message-Id: <163171196689.590070.15063104707696447188.stgit@devnote2>
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
In this version, I removed unneeded patches and add a patch to free xbc_data
in xbc_destroy_all().

But still I'm thinking how I can move lib/bootconfig.c and bootconfig.h
to share with tools, because those functions/data are __init and __initdata.
At least I have to add a dummy macro for those in userspace.
Thus the tools/bootconfig build error is still there. I'll fix that in
another series.

Thank you,

---

Masami Hiramatsu (3):
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()
      bootconfig: init: Fix memblock leak in setup_boot_config()
      bootconfig: Free xbc_data in xbc_destroy_all()


 init/main.c      |    2 ++
 lib/bootconfig.c |    3 +++
 2 files changed, 5 insertions(+)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
