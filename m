Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F23E3D46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 02:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhHIAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 20:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhHIAAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 20:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C2E60F42;
        Mon,  9 Aug 2021 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628467229;
        bh=qEHa2hDDngTAlBTuJT4LlegTNZ05RrFHw4VWLdRzQRU=;
        h=From:To:Cc:Subject:Date:From;
        b=i0SK2sk5DEpxN2Ph+N9gBJuAOdOT244GMQJGFnzKZBtfr9H0n6kBtsngkQiw165tu
         BzpHphiusTY45d6N2RzJlXCb+oZ5x7ah0whip/2Ht2HYqO2tBcjwVxbmWIev+5Ou+I
         CKzkTj5k1mZR67BKqKDIfUNC5GUfLsVXew2HXPdGmZMn7h0lhHnLvaynjD8TG4WZ7l
         fVbVk+8BTU5LmVwWU+DIIL7kgPfDpHFUaw4SgDQfV2EJeTUab48PRGcgXrU/Dwlyap
         9KRv2h2bKN+Fk8B8AYYNJt2tPvrFCFtuT8LyH/xvp6NOcxivEUnNVWArwP+YhbEbkO
         IUrLmeEGf+gWg==
From:   vgupta@kernel.org
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [RFC 1/2] ARC: retire ARC750 support
Date:   Sun,  8 Aug 2021 17:00:24 -0700
Message-Id: <20210809000025.2348004-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

There's no known/active customer using them with latest kernels anyways.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d8f51eb8963b..3015788a7094 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -116,16 +116,9 @@ choice
 	default ARC_CPU_770 if ISA_ARCOMPACT
 	default ARC_CPU_HS if ISA_ARCV2
 
-if ISA_ARCOMPACT
-
-config ARC_CPU_750D
-	bool "ARC750D"
-	select ARC_CANT_LLSC
-	help
-	  Support for ARC750 core
-
 config ARC_CPU_770
 	bool "ARC770"
+	depends on ISA_ARCOMPACT
 	select ARC_HAS_SWAPE
 	help
 	  Support for ARC770 core introduced with Rel 4.10 (Summer 2011)
@@ -135,8 +128,6 @@ config ARC_CPU_770
 	  -Caches: New Prog Model, Region Flush
 	  -Insns: endian swap, load-locked/store-conditional, time-stamp-ctr
 
-endif #ISA_ARCOMPACT
-
 config ARC_CPU_HS
 	bool "ARC-HS"
 	depends on ISA_ARCV2
@@ -275,7 +266,6 @@ config ARC_DCCM_BASE
 choice
 	prompt "MMU Version"
 	default ARC_MMU_V3 if ARC_CPU_770
-	default ARC_MMU_V2 if ARC_CPU_750D
 	default ARC_MMU_V4 if ARC_CPU_HS
 
 if ISA_ARCOMPACT
-- 
2.25.1

