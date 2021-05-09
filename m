Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658FA3775FC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhEIJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhEIJMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F03D6141D;
        Sun,  9 May 2021 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620551475;
        bh=dTPu7qA+xLGeJ/0FDcGhgI4f0XSe/BLwn8owpVQCXU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrUZPb9PWta8j618Q2nRKtwWz4Kgme+kHuy2vmxb9IjLL/+5XW0FpJPI9J9W1GLY3
         QozJ3kTd0TbKMyNf6d2L/mVk/RQnQTrC7GPssaT+CclpgC7XGVbO80WkUOcYBAvW+v
         aulBp/ENa7iKuuquLKrsugOJu6NR2qjkJUJMQgClXbNzVz+RRc/kAX4rSfWkFuNoCa
         jtXooiGfc0LBV2Q6fCEJ+getejIiBUY9Q+JpLaJSJ3fLmAcKRoK8ZxEQx/JJUvPKav
         B4U25EWsPRTAUgMHmZ5XeVOEKb4aWI9qtZwnDm/rXRnHQ0r8FWmbw11d7PB8GdCBhZ
         mvU9tPNdUCt2Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] openrisc: mm/init.c: remove unused variable 'end' in paging_init()
Date:   Sun,  9 May 2021 12:11:03 +0300
Message-Id: <20210509091103.7985-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210509091103.7985-1-rppt@kernel.org>
References: <20210509091103.7985-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

A build with W=1 enabled produces the following warning:

  CC      arch/openrisc/mm/init.o
arch/openrisc/mm/init.c: In function 'paging_init':
arch/openrisc/mm/init.c:131:16: warning: variable 'end' set but not used [-Wunused-but-set-variable]
  131 |  unsigned long end;
      |                ^~~

Remove the unused variable 'end'.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/mm/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index f3fa02b8838a..6e38ec96cab8 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -128,7 +128,6 @@ void __init paging_init(void)
 {
 	extern void tlb_init(void);
 
-	unsigned long end;
 	int i;
 
 	printk(KERN_INFO "Setting up paging and PTEs.\n");
@@ -144,8 +143,6 @@ void __init paging_init(void)
 	 */
 	current_pgd[smp_processor_id()] = init_mm.pgd;
 
-	end = (unsigned long)__va(max_low_pfn * PAGE_SIZE);
-
 	map_ram();
 
 	zone_sizes_init();
-- 
2.28.0

