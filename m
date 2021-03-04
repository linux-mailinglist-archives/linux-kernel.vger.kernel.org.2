Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1010132D841
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhCDRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238823AbhCDRCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:02:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCDD964F5E;
        Thu,  4 Mar 2021 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614877316;
        bh=IxzJw0GUqBQVtl7etqZ3Ql2q06WxtQPDUPWKaQdph1g=;
        h=From:To:Cc:Subject:Date:From;
        b=LwU4aDTwYavEjfgM27t/bOdZISkZPCLyFQQO9rXA66mB8V1GRk7FtnETOecIDrZ8S
         TXnuoZVZ1T3W9S3F9uLxGCUJmefYOReBk0ZQbEOlc/BkuTWYeyGq9xu5bkN81Mfd2h
         gtDWe0gZ7hBaO1uBk2YgFn4VyfpCLK/cmHMEs5K8wuB1bqNv4hn8pQNVbdBKdJVLCl
         G25KKdCTmDI8qRWBjY/RQffRpnHr6reQzxUDGFfAJh3S+xk/vQHPucpuB/6IZcoSKl
         v0WN+d7TcD1wU4uF8ezz9rtKKDDm0iGlLunr89zWzebSb0kmTmPgVtvD1ircY4TYUo
         ARMcLhtpbGn/g==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S
Date:   Thu,  4 Mar 2021 09:01:55 -0800
Message-Id: <487ed5348a43c031b816fa7e9efedb75dc324299.1614877299.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_syscall_vdso_32 ended up with an executable stacks because the asm was
missing the annotation that says that it is modern and doesn't need an
executable stack.  Add the annotation.

This was missed in commit aeaaf005da1d ("selftests/x86: Add missing
.note.GNU-stack sections").

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/thunks_32.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/x86/thunks_32.S b/tools/testing/selftests/x86/thunks_32.S
index a71d92da8f46..f3f56e681e9f 100644
--- a/tools/testing/selftests/x86/thunks_32.S
+++ b/tools/testing/selftests/x86/thunks_32.S
@@ -45,3 +45,5 @@ call64_from_32:
 	ret
 
 .size call64_from_32, .-call64_from_32
+
+.section .note.GNU-stack,"",%progbits
-- 
2.29.2

