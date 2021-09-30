Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5841DA68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbhI3NAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351232AbhI3NAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 165C261452;
        Thu, 30 Sep 2021 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006747;
        bh=jCHcYa/7N+9a8XZMbQeQt9e27EaFOuH4mjGUNTSKkGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGxN1Eb4+lTa1gXDJIoHfdnddhJkKkxFM03Myvg0CIqCfLPBKmbhsexHtLNuN7yxi
         CIZu2kOMW7b5/+wU5SAaV/umnIcvfnXfqkXzHQjjyExybKVli8CT6UbB2hHf8KfNKf
         cJkrWmzYLz4bFvzxqeMAYcUnA+/pmz5LAHWlEHh0eFdyAd1BfcPv76HngHsW+HIRuN
         5UWsK310kf9TGpZCN/vvndprruAMi3V+DV4LxQKhdTh9EY9iH8el8OMKokypAGvx5v
         85B4WwhY+hVE5SPk2OMsGLMZxIc2N/ZctgHIqRqyBD1hGjj6sLQswND+yntHKymv4e
         lQoHbUPqkm5sg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/7] powerpc: add CPU field to struct thread_info
Date:   Thu, 30 Sep 2021 14:58:10 +0200
Message-Id: <20210930125813.197418-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
of struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b4ec6c7dd72e..5725029aaa29 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -47,6 +47,9 @@
 struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
+#ifdef CONFIG_SMP
+	unsigned int	cpu;
+#endif
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH
 	unsigned long *livepatch_sp;
-- 
2.30.2

