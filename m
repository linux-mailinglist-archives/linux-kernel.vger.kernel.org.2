Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D2381346
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhENVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhENVn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:43:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1CAC613BE;
        Fri, 14 May 2021 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621028535;
        bh=Z5dn3pOu6T1cmlr10wNlgyZvDJevaQXpmYAiXwJx5Hs=;
        h=From:To:Cc:Subject:Date:From;
        b=S+yr3SjyENsD54xfDqQgDjt5+BBpyqc+9rXHDybR19TOoOvgTJlADXJiV14rpFbKF
         NuGs+ClfoMlu/5k09URL+54SkLUzSa6F2TXHCwRK2ALrX3BTvVZkxfAKssaokSia0E
         xRAyghKmBMWB+1iVeEdp/hknZyLAMbsXlHBzwrjg73lB8bCfJ7gLI/zoxmcFZQFu1M
         FVScQEtdfmOY+ulKJ6WlAOqV9wjCOFpnHVGTC7LRHAbs0diHeZLFIMvsTRHuAHubVb
         x/1qxnZvJw1DPlvpnYV7AXiGGPqF17vMzu2ld/yMi7g5dSkE9sQ2dEyurVOCdrt/LA
         OyCFQUq50/tyA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-ia64@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: mca_drv: fix incorrect array size calculation
Date:   Fri, 14 May 2021 23:41:15 +0200
Message-Id: <20210514214123.875971-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc points out a mistake in the mca driver that goes back
to before the git history:

arch/ia64/kernel/mca_drv.c: In function 'init_record_index_pools':
arch/ia64/kernel/mca_drv.c:346:54: error: expression does not compute the number of elements in this array; element typ
e is 'int', not 'size_t' {aka 'long unsigned int'} [-Werror=sizeof-array-div]
  346 |         for (i = 1; i < sizeof sal_log_sect_min_sizes/sizeof(size_t); i++)
      |                                                      ^

This is the same as sizeof(size_t), which is two shorter than the
actual array. Use the ARRAY_SIZE() macro to get the correct
calculation instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/mca_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/mca_drv.c b/arch/ia64/kernel/mca_drv.c
index 36a69b4e6169..5bfc79be4cef 100644
--- a/arch/ia64/kernel/mca_drv.c
+++ b/arch/ia64/kernel/mca_drv.c
@@ -343,7 +343,7 @@ init_record_index_pools(void)
 
 	/* - 2 - */
 	sect_min_size = sal_log_sect_min_sizes[0];
-	for (i = 1; i < sizeof sal_log_sect_min_sizes/sizeof(size_t); i++)
+	for (i = 1; i < ARRAY_SIZE(sal_log_sect_min_sizes); i++)
 		if (sect_min_size > sal_log_sect_min_sizes[i])
 			sect_min_size = sal_log_sect_min_sizes[i];
 
-- 
2.29.2

