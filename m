Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3A40F57D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhIQKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343618AbhIQKDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB936103C;
        Fri, 17 Sep 2021 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872946;
        bh=IfM6QSR18LBrVo/U/3coicaKulTtxq8zxeT3oPYS1zs=;
        h=From:To:Cc:Subject:Date:From;
        b=J6HC1nqByL6XU/RAu0wNOYe+mrDFkDmWWifBtZQckcMU02VoBsHJAbS+ApG4c7l6Q
         qRmC8vFjb6amS4AkThgIWQ2M/QTeHwsoC1+/nv4v0VzKoTw1LXnCyPSPXRwsKmBG16
         QqlhgNAIBE1i3mWuvEL8GLSIulAVgUGNb7PcjdgHHJSUTq8pNSxnHBDSQ0fOkmISAs
         AFZWQmpT3gKArkhGHcVJKBA2kDoygh4Y4P03hEwHnKTvO0yxdAr/hc+jB4H59Dnpey
         TNf5Va9Zqa6+oXnDXTDo77JcjeKMae/o1m8Ik8SQFBjYvCPI1pQtzCQjfBxCdFqVZ2
         Eh+Ik6Mrav+jg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/7] bootconfig: Clean up bootconfig
Date:   Fri, 17 Sep 2021 19:02:24 +0900
Message-Id: <163187294400.2366983.7393164788107844569.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a bootconfig cleanup series which includes a previous
xbc_destroy_all() renaming patch. Basically this tries to remove
all dummy patched in tools/bootconfig, except include/linux/bootconfig.

This series can be applied on top of 1-3rd patch of this series.

 https://lore.kernel.org/all/163177338366.682366.5998343833719057348.stgit@devnote2/T/#u


As I added a NOTE in the bootconfig files, those are not intended to
be used from user application, except for tools/bootconfig. Because
tools/bootconfig runs parser tests, it must use the same code of
lib/bootconfig.

However, I don't want to keep the dummy headers for that. This series
minimize the differences and consolidate it to the one wrapper header.

I hope this eases the current situation so that the future change will
not (or hard to) break tools/bootconfig build.

Thank you,

---

Masami Hiramatsu (7):
      tools/bootconfig: Run test script when build all
      bootconfig: Rename xbc_destroy_all() to xbc_exit()
      bootconfig: Split parse-tree part from xbc_init
      bootconfig: Remove unused debug function
      tools/bootconfig: Print all error message in stderr
      bootconfig: Replace u16 and u32 with uint16_t and uint32_t
      bootconfig: Cleanup dummy headers in tools/bootconfig


 include/linux/bootconfig.h                  |   27 ++--
 init/main.c                                 |    2 
 lib/bootconfig.c                            |  187 +++++++++++++++------------
 tools/bootconfig/Makefile                   |    4 -
 tools/bootconfig/include/linux/bootconfig.h |   45 ++++++
 tools/bootconfig/include/linux/bug.h        |   12 --
 tools/bootconfig/include/linux/ctype.h      |    7 -
 tools/bootconfig/include/linux/errno.h      |    7 -
 tools/bootconfig/include/linux/kernel.h     |   18 ---
 tools/bootconfig/include/linux/memblock.h   |   11 --
 tools/bootconfig/include/linux/printk.h     |   14 --
 tools/bootconfig/include/linux/string.h     |   32 -----
 tools/bootconfig/main.c                     |   25 ++--
 13 files changed, 181 insertions(+), 210 deletions(-)
 delete mode 100644 tools/bootconfig/include/linux/bug.h
 delete mode 100644 tools/bootconfig/include/linux/ctype.h
 delete mode 100644 tools/bootconfig/include/linux/errno.h
 delete mode 100644 tools/bootconfig/include/linux/kernel.h
 delete mode 100644 tools/bootconfig/include/linux/memblock.h
 delete mode 100644 tools/bootconfig/include/linux/printk.h
 delete mode 100644 tools/bootconfig/include/linux/string.h

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
