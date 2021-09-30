Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F141DA66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbhI3NAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351223AbhI3NAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D056124B;
        Thu, 30 Sep 2021 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006739;
        bh=/kR3+wilfL5yKlLOpGClhsB9X4dt2V1ZGldO2lpLG1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4uwmn9tNHzdrqkVwc6rtnS8fNSYoLvR8k2p+HjvHbxegEB2G64pMGvvKi5qXYdxX
         jdwYU/JorHKKX67+pCpo+vUrpbQh0mGjea0QAqRTer2HGK9nk10KnjWyhME0WqcqXb
         4tS9JphvxwrbXWDY2Ys4f8OF0nL1EWSjoTyv5lyyRCJGrgX9DZKlak8Thfb/4l4zi7
         jG392zrASwDCtUN9mAEaItZ5ASejIFSWJXoMzPv1nMFBCw4q1/+b95HgefGot21Ham
         WxPNfJGtjEjv0iT3wPmjAe127I4WBAaZdvjl/8OCUHqF4D9a/36okGKxhImx9Dr/h9
         0W3Mh+/xMsd9A==
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
        Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/7] x86: add CPU field to struct thread_info
Date:   Thu, 30 Sep 2021 14:58:08 +0200
Message-Id: <20210930125813.197418-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to x86's definition of
struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Borislav Petkov <bp@suse.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/x86/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf132663c219..ebec69c35e95 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -57,6 +57,9 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	u32			status;		/* thread synchronous flags */
+#ifdef CONFIG_SMP
+	u32			cpu;		/* current CPU */
+#endif
 };
 
 #define INIT_THREAD_INFO(tsk)			\
-- 
2.30.2

