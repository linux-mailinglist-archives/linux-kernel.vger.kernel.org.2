Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F013D0E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhGUL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:28:44 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:48536
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhGUL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:28:42 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 188623F232;
        Wed, 21 Jul 2021 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626869356;
        bh=s+IgBHSjMVguwTJ1v1phSYhp0UVRG7GTntf1zs/ccdA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=fa3Pqu8VvsOFAcuoegZDShf92wKk1ii8pxeOVEu954d6Tx49IBsQ8rBcfaHreJ8CP
         ZJY6VLaSW0ZYI9lWZwoac1iH4LmSnv/cpHJUGB1j+H7NSNM0BwBhbaa2nWWf5Y/o9F
         8iT9yIaqpS4HvcSBSmEPi4u8RmJoaUV9MAzrypLQiJNI46rTkCvya4cUjX7hJtPbAY
         t1PA0xXB6ZkduBRJgrxj2Hj8Z3MWLSSqP5RorLbZpX7HhvN/3/Fk8TRkx66y0Kp1OV
         wwp4qKgc/YD1t3wyTAoAbhLrMmCZ7aOKUtuVQPLspgtNrj5zK2ZZyNzOsksGybaGjs
         Ygh/s/uHFglUw==
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: remove redundant initialization of variable ret
Date:   Wed, 21 Jul 2021 13:09:15 +0100
Message-Id: <20210721120915.122278-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6fb3e6e1ffc..baa9463bcf76 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7544,7 +7544,7 @@ int ftrace_is_dead(void)
  */
 int register_ftrace_function(struct ftrace_ops *ops)
 {
-	int ret = -1;
+	int ret;
 
 	ftrace_ops_init(ops);
 
-- 
2.31.1

