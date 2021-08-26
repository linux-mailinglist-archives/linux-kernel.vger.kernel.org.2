Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27A23F8433
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhHZJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240568AbhHZJMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DBCE610A7;
        Thu, 26 Aug 2021 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629969129;
        bh=meKhmtBmoGyefNNnjjVv3WI9mW4s09+k2cghNqEPaJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzPaqZkmsRvCr4GM8GIyS55/EbB74uaI+c07Sy4nbXsrYn2bd1HZSmZt9+GGPZOJw
         qW5B+5tgmuaQktGLxSLPtfzWp8VP9uGEdSMCRNg+AjCUSAbbhc5AsbW/f/Peyhh6h/
         aUjoHRXE/t/iOqglsrA6qnRNLIncZz0WoUWzFcotAwWKemab1lVMc+/UuOsfWKUpg4
         3mURqpeiZR2wctswidzkUhtXjeyxlvPajppqvkze0yN1HjQ9/TPOuLZJwayDVYx5z7
         SL+HYuKO32gYJDd/7vLlOd1EKjjQnG6YdeSt4Bpae32Gd/hhk5CqTCkxJ7A6xBK4V9
         4Obr0ZZNxpm7Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] init: bootconfig: Remove all bootconfig data when the init memory is removed
Date:   Thu, 26 Aug 2021 18:12:07 +0900
Message-Id: <162996912688.236535.4047855429538984099.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162996911932.236535.7533708592332223449.stgit@devnote2>
References: <162996911932.236535.7533708592332223449.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the bootconfig is used only in the init functions,
it doesn't need to keep the data after boot. Free it when
the init memory is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 8d97aba78c3a..d9b0a99bb2dd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1493,6 +1493,7 @@ static int __ref kernel_init(void *unused)
 	kprobe_free_init_mem();
 	ftrace_free_init_mem();
 	kgdb_free_init_mem();
+	xbc_destroy_all();
 	free_initmem();
 	mark_readonly();
 

