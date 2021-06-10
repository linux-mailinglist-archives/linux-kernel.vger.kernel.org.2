Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B843A217E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJAje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:39:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233FA61375;
        Thu, 10 Jun 2021 00:37:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr8hU-002b5e-6B; Wed, 09 Jun 2021 20:37:36 -0400
Message-ID: <20210610003736.014523726@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 20:33:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [for-linus][PATCH 1/5] tools/bootconfig: Fix error return code in apply_xbc()
References: <20210610003344.783752614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Link: https://lkml.kernel.org/r/20210508034216.2277-1-thunder.leizhen@huawei.com

Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure correctly")
Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7362bef1a368..6cd6080cac04 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -399,6 +399,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	if (fstat(fd, &stat) < 0) {
+		ret = -errno;
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
-- 
2.30.2
