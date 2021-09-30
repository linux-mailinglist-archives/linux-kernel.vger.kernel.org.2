Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6B41DA67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351231AbhI3NAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349111AbhI3NAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22BC961528;
        Thu, 30 Sep 2021 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006743;
        bh=TOF8STtRDv74ETax3OGEGRc7TQEeChSrYXq2Jocmvb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+htrJUyjNY4OYi7Ui2lk+U/fKUYJGdkR1BsiuPUyF85SSnjdsrE3NOjn6InnwGMQ
         3qHVAyX8Qqz/TMvdNnO5XhhQJEAkyRSi4Zkz3L8CVNZPDdyJWiRIZaTSCGvj/PVwIX
         X9XELU0ZAqrTYQPDSp+wO2zsN9xyKky6IIgbxPIGM6fDvp1a3SARGI6FJ2k8+a6Ojd
         dSd/2UUmdyJiLpOwd0wZN40/r5aOXTMeVHOxgbg4ALbx7IdXuaToufsZy6ryNvKJ35
         s45YrniEHPdCV9A50Nstq47iW2mI8ukkEnaVL8nAgb3MW4AiDdAueIzKffZFrAtA4a
         8P01+nAgs7iyw==
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/7] s390: add CPU field to struct thread_info
Date:   Thu, 30 Sep 2021 14:58:09 +0200
Message-Id: <20210930125813.197418-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to s390's definition of
struct thread_info.

Note that s390 always has CONFIG_SMP=y so there is no point in guarding
the CPU field with an #ifdef.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
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

