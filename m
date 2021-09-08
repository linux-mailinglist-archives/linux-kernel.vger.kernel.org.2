Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B4403FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbhIHTVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350490AbhIHTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9777861164;
        Wed,  8 Sep 2021 19:20:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014aa-Ot; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191954.608550008@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julio Faracco <jcfaracco@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vgar.kernel.org
Subject: [for-next][PATCH 08/12] bootconfig: Fix missing return check of xbc_node_compose_key function
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julio Faracco <jcfaracco@gmail.com>

The function `xbc_show_list should` handle the keys during the
composition. Even the errors returned by the compose function. Instead
of removing the `ret` variable, it should save the value and show the
exact error. This missing variable is causing a compilation issue also.

Link: https://lkml.kernel.org/r/163077087861.222577.12884543474750968146.stgit@devnote2

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vgar.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index f45fa992e01d..fd67496a947f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -111,9 +111,11 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
+	int ret;
 
 	xbc_for_each_key_value(leaf, val) {
-		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0) {
 			fprintf(stderr, "Failed to compose key %d\n", ret);
 			break;
 		}
-- 
2.32.0
