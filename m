Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204324057FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355278AbhIINpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357945AbhIINh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BDA060F6C;
        Thu,  9 Sep 2021 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631194577;
        bh=AbOjWGSAY84am/1dCNaeSAOX+oedeLbPka+dFtEQgWw=;
        h=From:To:Cc:Subject:Date:From;
        b=OTY9WQdg+y3Cfp/rNLF6XRUMnoDh6n86sWE0ZvofZUpqi73soqiioiCqIzyU8lw05
         DaEdR88FJ4UA09W9VMqeFPZP9Z60JIcDROnGCXaFGuE3zZL5t2Su1gnFVOQtmLPXB/
         tTiGmShb+pYlku3Uu0ppW4Eflh0khwNXBZZBK81ahi0KQ9snTKwBFVkWe41yRaOxpF
         x9GAdC0KFwvjkNk0yJ+sP4EOq6Ls8NREmXI9t7V+Ck9ufNoni4Jva2QGD+HPFWoZ6J
         vGfjgzJu65S3pADDuq4aGFjPhco3MdEBQ+745hpwpFHMPSuVcJA59m+2kS+fZ8oUAD
         DBkQEv3LrF9hg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RESEND PATCH 0/3] tracing/boot: bootconfig: Fixes and API name change
Date:   Thu,  9 Sep 2021 22:36:16 +0900
Message-Id: <163119457578.161018.1615249460598506238.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Sorry, previous my post was lost from LKML archive, not sure what happen.
I resend this series again.)

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
 kernel/trace/trace_boot.c  |   37 ++++++++++++++++++-------------------
 lib/bootconfig.c           |    8 ++++----
 3 files changed, 24 insertions(+), 25 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
