Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D683730DBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhBCNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhBCNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:52:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C67564E50;
        Wed,  3 Feb 2021 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612360302;
        bh=Ey+JlWCEQQKKbQ7yXT0IyF/tXkhjplLdJYRFLMeSDDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/KMvmQH3zyIjHcIUY0MfuALCPlqdU6Q97E+fjEojbjwIkKz6zOL7V/G9v10BR+Bv
         LhlqV10rgMYveIOwqXAG3JtStfy7eepbClwEKSl9TyijSEexHvSlTvMIe5fhbz6YmV
         0hvt9IT+zC+Di6/H9LsRssPMc3iGbp6eRQCRo1a98Q2+QzWAwT8MfS+hPxTsrFcagt
         60JNFnynywMcvMKqHrkGfaaJYjoO4DibXgEP39jK4UQcP55c+G/J2JEy8DQHDeO5jy
         b3aJR8oGHZQv5XandpH0hDooAJtNCqw4bsnp3fsii6Her5pXlTtTnVTx8rgtNg8lfm
         bJ2nW0J8jAcOQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] drivers/clocksource: Fixup csky,mpintc compile error with CPU_CK610
Date:   Wed,  3 Feb 2021 21:48:34 +0800
Message-Id: <20210203134834.2367593-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203134834.2367593-1-guoren@kernel.org>
References: <20210203134834.2367593-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The timer-mp-csky.c only could support CPU_CK860 and it will
compile error with CPU_CK610.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..f773ecacb5f9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -663,7 +663,7 @@ config CLINT_TIMER
 
 config CSKY_MP_TIMER
 	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
-	depends on CSKY
+	depends on CSKY && CPU_CK860
 	select TIMER_OF
 	help
 	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
-- 
2.17.1

