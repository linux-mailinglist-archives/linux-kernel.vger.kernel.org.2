Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF033A21B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFJBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhFJBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74A1613FF;
        Thu, 10 Jun 2021 01:01:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr952-002bXA-VL; Wed, 09 Jun 2021 21:01:56 -0400
Message-ID: <20210610010156.806037738@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        zuoqilin <zuoqilin@yulong.com>
Subject: [for-next][PATCH 01/11] tools/bootconfig: Simplify expression
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

It is not necessary to define the variable ret to receive
the return value of the xbc_node_compose_key() method.

Link: https://lkml.kernel.org/r/20210414134647.1870-1-zuoqilin1@163.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: zuoqilin <zuoqilin@yulong.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6cd6080cac04..268b72f4cc92 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -84,11 +84,9 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
-	int ret = 0;
 
 	xbc_for_each_key_value(leaf, val) {
-		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
-		if (ret < 0)
+		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0)
 			break;
 		printf("%s = ", key);
 		if (!val || val[0] == '\0') {
-- 
2.30.2
