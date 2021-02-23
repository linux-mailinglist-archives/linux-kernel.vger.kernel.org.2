Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383B2323077
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhBWSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233889AbhBWSP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:15:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86EE64E61;
        Tue, 23 Feb 2021 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614104116;
        bh=IxzJw0GUqBQVtl7etqZ3Ql2q06WxtQPDUPWKaQdph1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6UXG3M3ocNsbDxO/6WLeeQUVjaJrYdkicHuPikB1wtAjJevRvZlsxJNCvGmu54y8
         7ujpwBx6CvfAzXyRXcVbjqJcchaY2jUFg/aCVZlpPPL9W6+r81CseWvIb+kIe1IKtM
         20kL1217B7boS9J6t0i78nVBEbZx7lFb/p5gs0d3/wRMSstr65ARIMBcwuJEpDWBvf
         LTxGqPyz+CHHPg7rapkazKMr9RIZJPYHu0Oa/zV4jc+xzhUDtf1f1d1AFwXXI/cs2+
         kzH8SOmq9H9E1Qc+I80z8dKj9iG3JOb9ClhbNxjTIugffxz30oIIhAkxfRJ91zzgaK
         bHMKPvRxevVYQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/3] selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S
Date:   Tue, 23 Feb 2021 10:15:10 -0800
Message-Id: <4a79388a8ec4fc4c07e61d79ad4fca5c106bba80.1614104065.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614104065.git.luto@kernel.org>
References: <cover.1614104065.git.luto@kernel.org>
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

