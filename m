Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559F5405739
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358137AbhIINc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357680AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4DF611C7;
        Thu,  9 Sep 2021 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193125;
        bh=dNJFtrF78qzIQitC46Mph76KRxuj/uQ+e9tYRuJPMS8=;
        h=From:To:Cc:Subject:Date:From;
        b=hWfP3mb4q02clcV5wHcI9kTMAvBuT6xXHX60s4fxlAidqb2ohtZYeM+oZX+ZITT/0
         ujmOkcaRHm4zdYO85iVowNBBAyyK7wd1t/l6XBK1Q2sHIK38OItcbc/TIrluiqMtcL
         KIGL5hsTE2Ag3AbLUBYCyJcur6BXPAm5WaMM+k7ozWqDkeF0j+D2ero/w7BdcTaT6K
         E5yJXDYNv4c0sSrYf6sn8B+r3NBG0WZQ7kpw15kC/FvmpgHOHy1FAMbKhIRHwAssHa
         DeCU6/Zb19ahrPsSL8lGgZLu4gZBVHmYy8EaO64JyEyDVS4GVf+dJ52n5jP2A400nk
         nf+Qh6qw2Z4tg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] tracing/boot: bootconfig: Fixes and API name change
Date:   Thu,  9 Sep 2021 22:12:03 +0900
Message-Id: <163119312321.159092.9694278669123009540.stgit@devnote2>
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
 kernel/trace/trace_boot.c  |   37 ++++++++++++++++++-------------------
 lib/bootconfig.c           |    8 ++++----
 3 files changed, 24 insertions(+), 25 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
