Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F2444CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKDAj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:39:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:43473 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhKDAjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:39:55 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hl4Tm5pg0z8K;
        Thu,  4 Nov 2021 01:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1635986237; bh=f5cqlw1tZGKFEiZUYL8xXBI9O4s1xQd9SM6Z/48bIuU=;
        h=Date:From:Subject:To:Cc:From;
        b=ZWWGgfoHpKwhWLJP7KsZ9iMZtK7ex8VxloRuus0sA9g/N3VyAztx7dS7ls5+SaazH
         1cTVgmLkq2v7sWmhnu8qTu21vVEgwqK8uYuX1DogJA4MDqhHVMoU4p28iCaKTBPnK1
         zd7fBKGRubcy1VJDgy3nhczM2B0UPwDETPymsoPn3gzlNuzbMxL7GUqBHAT0QAcfuV
         xASrCjdrE5ZFkL9z01ZWRwepXYlWUVQpug5kvUSgMQSeb2lZbvNT7NLwKRCLuKOvCL
         7uP+2lgHTIow0PxlCdIj3RLLmJCEPVRgr68dGDfJTH/7O19cBtqKZsFtTgFdRcEnQ6
         AfUlctQxIgdgg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Thu, 04 Nov 2021 01:37:15 +0100
Message-Id: <990f4427968071d59bcbb7411da73acc379d3ac4.1635986046.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] ARM: fix early early_iounmap()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jon Medhurst <tixy@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __set_fixmap() bails out with a warning when called in early boot
from early_iounmap(). Fix it, and while at it, make the comment a bit easier
to understand.

Cc: <stable@vger.kernel.org>
Fixes: b089c31c519c ("ARM: 8667/3: Fix memory attribute inconsistencies when using fixmap")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a4e006005107..274e4f73fd33 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -390,9 +390,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) < FIXADDR_START);
 	BUG_ON(idx >= __end_of_fixed_addresses);
 
-	/* we only support device mappings until pgprot_kernel has been set */
+	/* We support only device mappings before pgprot_kernel is set. */
 	if (WARN_ON(pgprot_val(prot) != pgprot_val(FIXMAP_PAGE_IO) &&
-		    pgprot_val(pgprot_kernel) == 0))
+		    pgprot_val(prot) && pgprot_val(pgprot_kernel) == 0))
 		return;
 
 	if (pgprot_val(prot))
-- 
2.30.2

