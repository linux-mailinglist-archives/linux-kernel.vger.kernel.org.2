Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF67040AD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhINMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhINMMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAEC26113E;
        Tue, 14 Sep 2021 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621464;
        bh=wUEIWjCdyHLOP9Ajpbl5z4Hb5g6osFdwVI9Ed8pwrF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uo9xo1sSKmZ71oRJaftwe86egJ4+rak5RockonFicTeMsL5SQcQBsjVQllEHp2n5s
         RWXu8t9o7m1AjT+zzG7+6LReVKVoDgIF866xt2IBv6qol78pFbWfHldtcAHTWEcGtT
         jks41McZT5NQLTzzDcAYCaRoQPz/jcOnHoOGFyzdlXairXRB69QL/mknHg9B1AKuGB
         vDD92q62XEEhcISCgUKOX70HAbhZ8lSmTxis1mqbAqQMs5rX9FTXzVwiLn/w8KetaK
         2iA5VF9D8CKBjtqK+BcvQxuo3J6ZIxUMevMcCwXb205SGOD7DKMoATRoeFBc0gvwIY
         kZqoSak7m4Zhw==
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
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH 3/8] s390: add CPU field to struct thread_info
Date:   Tue, 14 Sep 2021 14:10:31 +0200
Message-Id: <20210914121036.3975026-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914121036.3975026-1-ardb@kernel.org>
References: <20210914121036.3975026-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to s390's definition of
struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/s390/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index e6674796aa6f..b2ffcb4fe000 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -37,6 +37,7 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned int		cpu;		/* current CPU */
 };
 
 /*
-- 
2.30.2

