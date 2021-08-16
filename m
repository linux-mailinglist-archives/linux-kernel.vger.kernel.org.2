Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC33ED928
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhHPOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:48:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33010
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhHPOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:48:13 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C613E3F10B;
        Mon, 16 Aug 2021 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629125261;
        bh=LpKhP3By7l4CvlmRd1gqogt+J8pQf+y6CrU76SUhQKs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dYFeJ3aoPTNv6sbQCK+pQUwJpv5M4pE9gr9fshjkgtEu/75igIuCE/djoDetlBozT
         7S/KeG01kXExxGUbPZ8BAuVmRX1q0/MKjCGDVQtvwNt6Be29TZKgOr5ArTzF5i4wQp
         EQzO9XqkxQYtt5FdtttXM86jV3QIPDVzK4WF3GawFNeYgkdq0AAvD4feecOE92WaOs
         jjFnO+pOyCDXGNnEIVFWw9EOZWY5gx9eY6YgLsQeUv3yFZdVYfm0YSnQ7TkNGGu2j9
         6w7vQrzVQWCReXPv13WZ2c7/+QWc3tDrL+F651vkixLT4Ezbu2v+3NaJpcZmy6OMdE
         nVNciKp+8x4IQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Mon, 16 Aug 2021 16:47:28 +0200
Message-Id: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For analyzing memory blocks we can either use the memblock=debug command
line argument which creates massive output or a debug file system.

Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
/sys/kernel/debug/memblock to analyze memory blocks. The
same is already done for arm, arm64, mips, powerpc.

The actual provisioning of the file system depends on CONFIG_DEBUG_FS.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4f7b70ae7c31..a6e57614c3fd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -31,6 +31,7 @@ config RISCV
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_KEEP_MEMBLOCK
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
-- 
2.30.2

