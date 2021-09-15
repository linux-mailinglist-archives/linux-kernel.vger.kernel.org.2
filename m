Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2140C62F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhIONVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhIONVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:21:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0F5A61251;
        Wed, 15 Sep 2021 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631711996;
        bh=UpxfRZK8T2RDPLPb11HxaKpLoTbgunj3UUurBaCsjc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5T0gQuAHHfsocNubOi/llKfWcL+tZueU/clHXUh+2LvVwTuhEMF2F/cFksZWS+lP
         qyvw+/QFvftdKNxZQfXBYndCXrp8UTLLlgtYYmW2CP1wjNm13z0ZGfp6s92bMACx9D
         nC9ryzggH3XN+9ga1eHG41AYJOIA2mcs2Z4HQNf5VoRCUpahbKHSb0J94IaDYj+Fp9
         RUpmg/pLJ/I0lPeObgHV9o0o9Gt1mEtVZi+Q89uqb8WxRZLuPjWv15VGG4LnrrYHqf
         DQFXXa1Fe11KU8r+AKypfGS5NonZezvAkW7c4ZYIjYNbJVZ+6wSHeFPapJWP+xRAfm
         MyKY+G3nsoHXQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 3/3] bootconfig: Free xbc_data in xbc_destroy_all()
Date:   Wed, 15 Sep 2021 22:19:52 +0900
Message-Id: <163171199244.590070.6356174550728998874.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163171196689.590070.15063104707696447188.stgit@devnote2>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free xbc_data memory in xbc_destroy_all() with other data.
Note that this changes the ownership of the passed bootconfig
data.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 5ae248b29373..2ba7d945adc9 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -789,6 +789,7 @@ static int __init xbc_verify_tree(void)
  */
 void __init xbc_destroy_all(void)
 {
+	memblock_free_ptr(xbc_data, xbc_data_size);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
@@ -810,6 +811,8 @@ void __init xbc_destroy_all(void)
  * In error cases, @emsg will be updated with an error message and
  * @epos will be updated with the error position which is the byte offset
  * of @buf. If the error is not a parser error, @epos will be -1.
+ * Note that the @buf ownership is transferred, so it will be freed
+ * in xbc_destroy_all().
  */
 int __init xbc_init(char *buf, const char **emsg, int *epos)
 {

