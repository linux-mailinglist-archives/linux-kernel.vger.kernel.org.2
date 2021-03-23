Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AE345EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhCWM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhCWM4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:56:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE8A619B8;
        Tue, 23 Mar 2021 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616504213;
        bh=JV3WAjemhG4S+sdfwTHE1VntgQXalZBY5SjRSt0aTaM=;
        h=From:To:Cc:Subject:Date:From;
        b=MSmptEuTcdj5GSLvt1vFHdKrWUxuRjHNZpUBB3z6DguJNKeG+AQB0OJ9v30Qfg3wL
         hUvy8eJoIJtelH5OEYVVtc525SlbkFushCHQG5kInMk+D4J1GLG8m0puiyRMrv7QNb
         KQvCRsBiAZUX0pyM7+c94BZdgihEbsqsYa44qP0c718W9dOasGzb8NZJSyULTMq/v6
         f/AOIogOYH9KaTdy85+ogsF5OJlxXJeuKCV2qFkbuyQVK3qEeq3sRK4rNnWeOnm1ff
         QKnzWVApot3bae3ytJAnysCfe3YFILe0Z9i4aPkwOFFgtYWXVeocbOX2+6ps37n0a8
         /20bOmLwpqo9A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vexpress: spc: fix uniprocessor initialization
Date:   Tue, 23 Mar 2021 13:56:38 +0100
Message-Id: <20210323125649.1930186-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_SMP is disabled, topology_physical_package_id()
returns -1 and gcc notices undefined behavior:

arch/arm/mach-versatile/spc.c: In function 've_spc_clk_init':
arch/arm/mach-versatile/spc.c:583:21: error: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Werror=array-bounds]
  583 |   if (init_opp_table[cluster])
      |       ~~~~~~~~~~~~~~^~~~~~~~~
arch/arm/mach-versatile/spc.c:556:7: note: while referencing 'init_opp_table'
  556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
      |       ^~~~~~~~~~~~~~

It's not clear to me what the correct behavior should be, but
it seems safe to just not continue with the initialization.

Fixes: 2a76352ad2cc ("ARM: vexpress: Set-up shared OPP table instead of individual for each CPU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-versatile/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 1da11bdb1dfb..1c6500c4e6a1 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -580,7 +580,7 @@ static int __init ve_spc_clk_init(void)
 		}
 
 		cluster = topology_physical_package_id(cpu_dev->id);
-		if (init_opp_table[cluster])
+		if (cluster < 0 || init_opp_table[cluster])
 			continue;
 
 		if (ve_init_opp_table(cpu_dev))
-- 
2.29.2

