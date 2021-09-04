Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25C400BFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhIDPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237039AbhIDPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F20860F56;
        Sat,  4 Sep 2021 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630770880;
        bh=dFP4F2MCVFcTXj1Gv7k1QTi8zTvPmHvCY0jx3Djs5f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFYwcM3wzkPdefVLlM13/YW5AKb8psf5CprGxwrOgXJHXhvgeZifcmd/gKiObahmL
         BmZ03C7Mw+7Aj952M0gRBzADKUKaZ0nBn6UVmaLVnsOzi965FvbX2cjUnaRzqkTvtS
         M5hXKXLX8nw+0umWJ8KeukyRk1xAfbEHS8M5wh/9BdFxsFYK6xQSc+La4qVJsZdcvD
         xIrM6EBWKS1JSan7c1nOKOMeF8zk9KcOTXOp05WmSEez7Zyl+bqJgJdMBznmnj4XB/
         Mcz9cgEjBbN4aqrHcfITld3lFup7BCKxYvzmykBBUIAc1ob8cdSMAhS3SfmqBA006L
         J4rWCBtffryHQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Julio Faracco <jcfaracco@gmail.com>, stable@vgar.kernel.org
Subject: [PATCH v3 5/6] bootconfig: Fix missing return check of xbc_node_compose_key function
Date:   Sun,  5 Sep 2021 00:54:38 +0900
Message-Id: <163077087861.222577.12884543474750968146.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163077084169.222577.4459698040375322439.stgit@devnote2>
References: <163077084169.222577.4459698040375322439.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julio Faracco <jcfaracco@gmail.com>

The function `xbc_show_list should` handle the keys during the
composition. Even the errors returned by the compose function. Instead
of removing the `ret` variable, it should save the value and show the
exact error. This missing variable is causing a compilation issue also.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vgar.kernel.org
---
 tools/bootconfig/main.c |    4 +++-
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

