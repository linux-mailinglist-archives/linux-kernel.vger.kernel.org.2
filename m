Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121C311D7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBFNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 08:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBFNhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 08:37:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 168E664E5A;
        Sat,  6 Feb 2021 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612618587;
        bh=QmVWEQOUXt2bamsSz0cwns6rsPRXjXQ96AsKqzzL0wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urc64lztlr/us+84S4/hx9RT3/9nkkDTVWaIUCNijunHpiWGuqHNfJqWXo1Aa03K2
         4slFJajVMMXuvdCDbMCPwFOBbTgX+Cg2s/nFQyRU2eQwxGEw3vjj4RV6Luv+v4NiaK
         yoG+OZEKiPglWLwFwCgcysP7/0lMSEiHYjV+azuUD9ZPolV3/nKy6Uc9kljzqWLdEw
         aa/6Zv2fCMNb3uH0E5uvnCtwJzTdZPAmB8ozCEEA3M+/gbfnMfpBVxphft2RxWmNwg
         hlhHHQ+LoxG2jxG2H4sQJjWyYNZN39pFaqUn5ePrQmLMXa4BvG4klPjiTH7gCVtRHy
         7icHk5/hn0dAA==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ARM: s3c: irq-s3c24xx: staticize local functions
Date:   Sat,  6 Feb 2021 14:36:15 +0100
Message-Id: <20210206133615.119804-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206133615.119804-1-krzk@kernel.org>
References: <20210206133615.119804-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make functions used only in this module static to fix W=1 build warnings:

  arch/arm/mach-s3c/irq-s3c24xx.c:360:39: warning:
    no previous prototype for ‘s3c24xx_handle_irq’ [-Wmissing-prototypes]
  arch/arm/mach-s3c/irq-s3c24xx.c:1308:12: warning:
    no previous prototype for ‘s3c2410_init_intc_of’ [-Wmissing-prototypes]
  arch/arm/mach-s3c/irq-s3c24xx.c:1330:12: warning:
    no previous prototype for ‘s3c2416_init_intc_of’ [-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c/irq-s3c24xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 3368159d3f3e..0c631c14a817 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -359,7 +359,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	return true;
 }
 
-asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
 {
 	do {
 		if (likely(s3c_intc[0]))
@@ -1307,7 +1307,7 @@ static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
 	}
 };
 
-int __init s3c2410_init_intc_of(struct device_node *np,
+static int __init s3c2410_init_intc_of(struct device_node *np,
 			struct device_node *interrupt_parent)
 {
 	return s3c_init_intc_of(np, interrupt_parent,
@@ -1329,7 +1329,7 @@ static struct s3c24xx_irq_of_ctrl s3c2416_ctrl[] = {
 	}
 };
 
-int __init s3c2416_init_intc_of(struct device_node *np,
+static int __init s3c2416_init_intc_of(struct device_node *np,
 			struct device_node *interrupt_parent)
 {
 	return s3c_init_intc_of(np, interrupt_parent,
-- 
2.25.1

