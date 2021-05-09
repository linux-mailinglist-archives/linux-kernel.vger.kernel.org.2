Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E83775FA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEIJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhEIJMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:12:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3210D613D9;
        Sun,  9 May 2021 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620551470;
        bh=WzG2lAYSFUb1qOykunoY65bLJ+09ULrrsSxpy9StCGI=;
        h=From:To:Cc:Subject:Date:From;
        b=tKf/JefM9p7PyZRzddthC9m72Khd0qTm2laCNQQFNGeO7h4bdiXSJ+MOJxbCULW3Z
         Gudn1UedLnYAKooaCKePhLVTYU8UXgJ6gUASyVTKonWAynFo9Q74uRFevq9KSXvgbx
         4CknSQg/fp0r7LfK1IrStnfaJv3wAES0SZHywIwPu+rfabC3vMv+GHUgpRoyFQnk8T
         EbMQOBlC+5pkW9DBA5vxRktI9Jk918/bwRJuEfywFC3UcKWaNldRumznDe6C2lInTd
         Bqn+CRMLVEre0MldhH7OPPcrQtvv37kMn0izaFG232OBldcN7JBJFv2vk2BAoOKwC3
         uo4Bkqfh/jROQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] openrisc: mm/init.c: fix compilation warnings
Date:   Sun,  9 May 2021 12:11:01 +0300
Message-Id: <20210509091103.7985-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Kbuld test bot reported an unused in map_ram() and while on it I've found
another compilation warning about unused variable in paging_init().

Here are the fixes for both.
The patches are vs 5.12.

Mike Rapoport (2):
  openrisc: mm/init.c: remove unused memblock_region variable in map_ram()
  openrisc: mm/init.c: remove unused variable 'end' in paging_init()

 arch/openrisc/mm/init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.28.0

