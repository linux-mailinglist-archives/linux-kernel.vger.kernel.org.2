Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7C42B185
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhJMA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236694AbhJMA6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A81760F11;
        Wed, 13 Oct 2021 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634086571;
        bh=2i/SmkelTVJDN4ukHIRESkLDHoefkzHPPIw9v0mXuDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWEnwIu7f2bWevI56bnd2OBdPkKpxbDMCYE6bgAA3R/SKBTrrcHTmrlb4JBGAu1a1
         knUjnl/QXzHcGrn3Xt9yo/kZocBHsLA++jyUGhSwfCkK4EMpvMfYajAHL3HTgJoRRp
         L6P/I/T/jyHZd41Jd81+jzdmQjtOFq5iaaQlIssNMYlnFVOA0x+rixBPTDDHDFWLp2
         7S+VFrGcj71ATLBo72nXTgWn13Soi8XtbWdmhL1u9wY9iAoPzitTbGPC1kZ/fHQOUX
         jBGbWNskRr/Y5XTrhbJpn09I8fdE+W6Pz/W8UQkG03CRCDqYd+DLL5kraMqEw2v20+
         4iR0vAYvslyfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        chris@zankel.net, linux@roeck-us.net, linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 5.4 3/6] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
Date:   Tue, 12 Oct 2021 20:55:59 -0400
Message-Id: <20211013005603.700363-3-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013005603.700363-1-sashal@kernel.org>
References: <20211013005603.700363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit f3d7c2cdf6dc0d5402ec29c3673893b3542c5ad1 ]

Use platform data to initialize xtfpga device drivers when CONFIG_USE_OF
is not selected. This fixes xtfpga networking when CONFIG_USE_OF is not
selected but CONFIG_OF is.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/platforms/xtfpga/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 829115bb381f..61c5e2c45439 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -81,7 +81,7 @@ void __init platform_calibrate_ccount(void)
 
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 static void __init xtfpga_clk_setup(struct device_node *np)
 {
@@ -299,4 +299,4 @@ static int __init xtavnet_init(void)
  */
 arch_initcall(xtavnet_init);
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
-- 
2.33.0

