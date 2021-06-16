Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA43A8F52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFPDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFPDXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2742F613C2;
        Wed, 16 Jun 2021 03:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813680;
        bh=uwtQcyv5VK7EnNeu4zAuSiFMzgWca2SQ0MXYCFdFfoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUx2c2QdVsJ/e6o1nIEcvcwpfMTTwRZITr/IRvy6cFj1GF8ZkgGPcr9dJhZ0Aahcj
         Db0jmOS2dBE11jCaQ94u8RnJ6pJzeI5ilMOqW96akpc7Cvs2/ytVSzbGwsBKmp3Rav
         x9sATIjBcy21giShX/AUB2ujLJV5m/EcwvZ9k6ouu4vHJvfF+Kt4yDD+0EUlgw92UQ
         Rha8tWvK2dwWtfEwCxxcGLfFBqPBd6JyRHbdy33OZPUUUtbHT9r6q8UGcDUU8UZaD8
         rkDV+j+cu6M5kPmGGXrB1FyGOdj2y3fmZIqPlEim+yeXdHGWVovFbYqHPhBF5kbX0j
         I8AWloY7Mh75A==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Date:   Tue, 15 Jun 2021 20:21:12 -0700
Message-Id: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm32, the only way to safely flush icache from usermode is to call
cacheflush(2).  This also handles any required pipeline flushes, so
membarrier's SYNC_CORE feature is useless on arm.  Remove it.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..89a885fba724 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,7 +10,6 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
-	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
-- 
2.31.1

