Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE340573C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbhIINcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357665AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 555746023D;
        Thu,  9 Sep 2021 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631191727;
        bh=fvr7YWvjjLwZAaltIMSEaPVyp9IkvahaMWcXNJTEqxY=;
        h=From:To:Cc:Subject:Date:From;
        b=J/+yZvFzf8E9qxTG0Vr4wDKnjqeME7LqxBK+p4o3HWlQkqaNSqlcWllXWC3PFeddl
         SMZppRDPKswR47bnHXLs3/oUdsvhTWHO6ssXru3UX8PBboKRhy47XeHshf+yHStTQI
         aelaApzmSckjlKXtu9iacy+0xMhP165vvc1h2aYiLyNLD9+lVwQuolz5s9c9qnWLNz
         gBET/WELcAgFU6q/E+Gx3p4t5rWeEJC6BOMAZ8NDmFHiVDBK53JfvUy+vZRFd/N8h7
         xrMyIs/0AwGgDs2zhad/YlLYiAMaZUGH6kaem3g4Yocr4NNNLQj0vIX3hg4015lUH9
         KRSz7TUfMvwFA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] tracing/boot: bootconfig: Fixes and API name change
Date:   Thu,  9 Sep 2021 21:48:43 +0900
Message-Id: <163119172318.151131.7138254940364392100.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches to fix some issues on boot-time tracing
and bootconfig. Yesterday I sent a bugfix(*), and today I found some
other issues.

(*) https://lore.kernel.org/all/163112988361.74896.2267026262061819145.stgit@devnote2/T/#u

This includes following patches.

[1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value

[2/3] tracing/boot: Fix to check the histogram control param is a leaf node

[3/3] bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
 - Rename xbc_node_find_child() to xbc_node_find_subkey() to avoid
   confusing "child" and "subkey" words.



Thank you,

---

Masami Hiramatsu (3):
      tracing/boot: Fix trace_boot_hist_add_array() to check array is value
      tracing/boot: Fix to check the histogram control param is a leaf node
      bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()


 include/linux/bootconfig.h |    4 ++--
 kernel/trace/trace_boot.c  |   35 +++++++++++++++++------------------
 lib/bootconfig.c           |    8 ++++----
 3 files changed, 23 insertions(+), 24 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
