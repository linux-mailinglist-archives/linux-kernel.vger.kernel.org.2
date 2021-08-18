Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652C3F04FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhHRNk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237168AbhHRNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF087610A7;
        Wed, 18 Aug 2021 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293970;
        bh=JGqTmZgGmKYxeDTnbAFBi/4Wd/xFy5P2Gi6l6kpWNMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQMJk7TWN+cGOEzVSuI4VoS4y23vSkIaxARTKuQ+Bow5BHMx7qzrd4iF2rv1HKcPd
         t1HFYbmy2PkXyUBfMCLcBDpbZcmQw9s57anzDL+0GTBpJeXiJ2u8VTvVYpAhuQnh+I
         B+IZaJWBfik/saIPFRJU5TWoXnNs8sGcmCYGi3N1rGmx6ZwVnsKxn8zb6KUEl4ij0b
         A0v2ZJ/9ofRaoOk1Vd+ufhhwjuUiqQ64ntj33L2rubycUazeekZN13+BP8E+FgD/U3
         Jlhor2kv78eg4f9Sy9whxfctrz+NfR/RT209bpt2izY3lixKMqFokE/krM3IoGRI3R
         bU422SNURaY+A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 04/16] habanalabs: fix mmu node address resolution in debugfs
Date:   Wed, 18 Aug 2021 16:39:10 +0300
Message-Id: <20210818133922.63637-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

The address resolution via debugfs was not taking into consideration the
page offset, resulting in a wrong address.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 264424c96959..6a7df57883d9 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -349,7 +349,7 @@ static int mmu_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	phys_addr = hops_info.hop_info[hops_info.used_hops - 1].hop_pte_val;
+	hl_mmu_va_to_pa(ctx, virt_addr, &phys_addr);
 
 	if (hops_info.scrambled_vaddr &&
 		(dev_entry->mmu_addr != hops_info.scrambled_vaddr))
-- 
2.17.1

