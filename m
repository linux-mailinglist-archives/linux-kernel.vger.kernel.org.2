Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C506D30DBEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhBCNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhBCNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:52:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47BDD64E4B;
        Wed,  3 Feb 2021 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612360297;
        bh=YWgD8ncYwKwZy0hA+PhRKY0I9ecfClH6CqH00+ow8xE=;
        h=From:To:Cc:Subject:Date:From;
        b=fkhcLaq2iPGaM7OuZsS1hfZRN4bAU4f+qm3TKDzAZ5zNnZdbRTifR6QXAN0nD28Mf
         bHZbnx6AZ3+HZulQUZazt6qtQi5KeVvZZK5Vq78F+NMhElO1aZbgCO62UfduNwk9Cp
         WXGhnLrZvptw+k4PRGiEemQ0vt9ba4mpbPJQGv6JLRWnXgX8/SuGugmkwZkZ27GiZw
         L86Y9rRW3Pt0Ontf8WZnhRAoSTr9UjRYBcUkx6PkSCnELCz/CUV6831Gi96TuEjCPI
         dpfsgPCH/9EskL9TXCYJ0Bt4N7syiIy9Wt8A+K+9A95nvHlc3QFl3rpTAFVrQpdI7D
         Topu6bxcb5y7w==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/2] drivers/irqchip: Fixup csky,mpintc compile error with CPU_CK610
Date:   Wed,  3 Feb 2021 21:48:33 +0800
Message-Id: <20210203134834.2367593-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The irq-csky-mpintc.c only could support CPU_CK860 and it will
compile error with CPU_CK610.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b147f22a78f4..9be2dd5c6380 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -433,7 +433,7 @@ config QCOM_PDC
 
 config CSKY_MPINTC
 	bool "C-SKY Multi Processor Interrupt Controller"
-	depends on CSKY
+	depends on CSKY && CPU_CK860
 	help
 	  Say yes here to enable C-SKY SMP interrupt controller driver used
 	  for C-SKY SMP system.
-- 
2.17.1

