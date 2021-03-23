Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE5345F81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCWNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhCWNSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:18:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 095FE61878;
        Tue, 23 Mar 2021 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616505526;
        bh=TnNY1s6JhV3sTYmjT+7hIDfNwNGsQcx6oyd3Bpkho/4=;
        h=From:To:Cc:Subject:Date:From;
        b=FcnBPRSYmdQLY8yXEHIF9BjIuWjQM5zHg5NOFyxUTE1KmwSHgg3XfYSxZ6Z9z4BRe
         nSHnk2LXqeRKeJxIWMGGtimhmq48xt0kMmUNRsPWZolu8j+OTVfXWS3o5fTXQbxySn
         qCzRTqhyo6dUW+T2Hl1kv6Cjcj7IbYOtbOX3PeMyyG7DFzFLEWJZyH1NzZaZQtj9Qc
         ymrl5oN28qB8rW0KA23FKDYrYfm+bD3LQNTsQKXicHY88OMLfYE9Z7EZuEHTBGk3ow
         8o7jPCDmPl/FBRUnPYlQfnk/Yg7TnvEZWqbtV0VdT1OvTS16igYqaKdm7iOy4MRNhu
         420AvFwudAmbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] irqchip/gic-v3: fix OF_BAD_ADDR error handling
Date:   Tue, 23 Mar 2021 14:18:35 +0100
Message-Id: <20210323131842.2773094-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with extra warnings enabled, clang points out a
mistake in the error handling:

drivers/irqchip/irq-gic-v3-mbi.c:306:21: error: result of comparison of constant 18446744073709551615 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                if (mbi_phys_base == OF_BAD_ADDR) {

Truncate the constant to the same type as the variable it gets compared
to, to shut make the check work and void the warning.

Fixes: 505287525c24 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 563a9b366294..e81e89a81cb5 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -303,7 +303,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 	reg = of_get_property(np, "mbi-alias", NULL);
 	if (reg) {
 		mbi_phys_base = of_translate_address(np, reg);
-		if (mbi_phys_base == OF_BAD_ADDR) {
+		if (mbi_phys_base == (phys_addr_t)OF_BAD_ADDR) {
 			ret = -ENXIO;
 			goto err_free_mbi;
 		}
-- 
2.29.2

