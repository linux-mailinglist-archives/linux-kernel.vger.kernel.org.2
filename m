Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9858D32258B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBWFvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhBWFvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:51:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA0B64E61;
        Tue, 23 Feb 2021 05:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614059434;
        bh=IxzJw0GUqBQVtl7etqZ3Ql2q06WxtQPDUPWKaQdph1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fn98GEJTL3sl0A4K9Lds/PKQZk62q7DYsV/rWbcO5ctMBMgfmuTo71kJx8BIqcT2O
         f/NmUjcJKY0hrey4kYjnaAwW2W88OFzDE+JOjF+Nr3SFbeOmobH/j6wW4k6xY5r+Tl
         Sqt+bHy4cGWPBBJxwM+f76594/99wfQ6mr30IM2PlgrElC0jcjYPGRZ7QR2OIjruhg
         1i2RBH7bPrTgqo8deOOQo2nCaEfaPlFPNThB23xupkYVPkIpu5Lngxh5wsbdShtsL+
         ExhhYQCeIJ6new0JrMvDCSQEw8TT1AbeDWnxJ4rV7eobLbgzjGcarzROY0n7Oeq2bn
         EfFMolV4byplA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S
Date:   Mon, 22 Feb 2021 21:50:29 -0800
Message-Id: <850bb26d395a4091418f8fc2763359eb7b99ee30.1614059335.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614059335.git.luto@kernel.org>
References: <cover.1614059335.git.luto@kernel.org>
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

