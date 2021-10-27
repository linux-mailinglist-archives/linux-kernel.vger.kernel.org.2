Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21743CE58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhJ0QMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237866AbhJ0QM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF33610A3;
        Wed, 27 Oct 2021 16:10:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV2-000xmh-8D;
        Wed, 27 Oct 2021 12:10:00 -0400
Message-ID: <20211027161000.089664029@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/15] samples/kretprobes: Fix return value if register_kretprobe() failed
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Use the actual return value instead of always -1 if register_kretprobe()
failed.

E.g. without this patch:

 # insmod samples/kprobes/kretprobe_example.ko func=no_such_func
 insmod: ERROR: could not insert module samples/kprobes/kretprobe_example.ko: Operation not permitted

With this patch:

 # insmod samples/kprobes/kretprobe_example.ko func=no_such_func
 insmod: ERROR: could not insert module samples/kprobes/kretprobe_example.ko: Unknown symbol in module

Link: https://lkml.kernel.org/r/1635213091-24387-2-git-send-email-yangtiezhu@loongson.cn

Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/kprobes/kretprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 5dc1bf3baa98..228321ecb161 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -86,7 +86,7 @@ static int __init kretprobe_init(void)
 	ret = register_kretprobe(&my_kretprobe);
 	if (ret < 0) {
 		pr_err("register_kretprobe failed, returned %d\n", ret);
-		return -1;
+		return ret;
 	}
 	pr_info("Planted return probe at %s: %p\n",
 			my_kretprobe.kp.symbol_name, my_kretprobe.kp.addr);
-- 
2.33.0
