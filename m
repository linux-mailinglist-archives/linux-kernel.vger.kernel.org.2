Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E33377A65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEJDJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:09:55 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:19386 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhEJDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:09:54 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 4B16AC2012F;
        Mon, 10 May 2021 11:08:48 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pekka Enberg <penberg@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] m68k: dma: remove unnecessary include of asm/cacheflush.h
Date:   Mon, 10 May 2021 11:08:35 +0800
Message-Id: <20210510030836.11834-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0pKSlZLTUtITkJPTR5ITxlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46Kyo4Fz8USj8QHz0oIxhP
        OBpPCi5VSlVKTUlLTUpNSklDQkpLVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTEJNNwY+
X-HM-Tid: 0a79543fa809d976kuws4b16ac2012f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ca15ca406f660 ("mm: remove unneeded includes of
<asm/pgalloc.h>"), asm/cacheflush.h independent on the MACRO
was included at line 18. The include here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/m68k/kernel/dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 1c1b875fadc1..2e192a5df949 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -34,9 +34,6 @@ pgprot_t pgprot_dmacoherent(pgprot_t prot)
 	return prot;
 }
 #else
-
-#include <asm/cacheflush.h>
-
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
-- 
2.20.1

