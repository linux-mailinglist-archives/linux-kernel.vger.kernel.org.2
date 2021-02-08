Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29883313AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhBHRRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233760AbhBHPZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:25:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B2D164F1C;
        Mon,  8 Feb 2021 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612797323;
        bh=qW8LkbnbrJe4/eL0XdRTduZmErZLTDf4hS5G9CaUnKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19s6UEDcQlhVbovP3pNF8HkAh8Qn31PQaxbFeAveR286i0OwtjFWCUT8X9q8MBHcE
         53R15Swz4pkY+t80IOcUFTNdjfcijooXWpl3pAD4BFVjvCXu0/JlUZMsFUfoZ0S+UH
         U2CeiqiygX1T3MmMpBxTa/CmPpd45Yfd+IlHAqU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 5.10 070/120] RISC-V: Define MAXPHYSMEM_1GB only for RV32
Date:   Mon,  8 Feb 2021 16:00:57 +0100
Message-Id: <20210208145821.203360523@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208145818.395353822@linuxfoundation.org>
References: <20210208145818.395353822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

commit de5f4b8f634beacf667e6eff334522601dd03b59 upstream.

MAXPHYSMEM_1GB option was added for RV32 because RV32 only supports 1GB
of maximum physical memory. This lead to few compilation errors reported
by kernel test robot which created the following configuration combination
which are not useful but can be configured.

1. MAXPHYSMEM_1GB & RV64
2, MAXPHYSMEM_2GB & RV32

Fix this by restricting MAXPHYSMEM_1GB for RV32 and MAXPHYSMEM_2GB only for
RV64.

Fixes: e557793799c5 ("RISC-V: Fix maximum allowed phsyical memory for RV32")
Cc: stable@vger.kernel.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e9e2c1f0a690..e0a34eb5ed3b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -252,8 +252,10 @@ choice
 	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
 
 	config MAXPHYSMEM_1GB
+		depends on 32BIT
 		bool "1GiB"
 	config MAXPHYSMEM_2GB
+		depends on 64BIT && CMODEL_MEDLOW
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
 		depends on 64BIT && CMODEL_MEDANY
-- 
2.30.0



