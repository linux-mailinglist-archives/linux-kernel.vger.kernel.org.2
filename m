Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD843B715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhJZQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhJZQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCEE610A6;
        Tue, 26 Oct 2021 16:23:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEr-000qTU-I8;
        Tue, 26 Oct 2021 12:23:49 -0400
Message-ID: <20211026162349.404893448@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH 11/12] lib/bootconfig: Make xbc_alloc_mem() and xbc_free_mem() as __init
 function
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the xbc_alloc_mem() and xbc_free_mem() are used from
the __init functions and memblock_alloc() is __init function,
make them __init functions too.

Link: https://lkml.kernel.org/r/163515075747.547467.5746167540626712819.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 4ee1b4cac236 ("bootconfig: Cleanup dummy headers in tools/bootconfig")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a056ae137750..3276675b25e1 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -43,12 +43,12 @@ static int open_brace[XBC_DEPTH_MAX] __initdata;
 static int brace_index __initdata;
 
 #ifdef __KERNEL__
-static inline void *xbc_alloc_mem(size_t size)
+static inline void * __init xbc_alloc_mem(size_t size)
 {
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-static inline void xbc_free_mem(void *addr, size_t size)
+static inline void __init xbc_free_mem(void *addr, size_t size)
 {
 	memblock_free_ptr(addr, size);
 }
-- 
2.33.0
