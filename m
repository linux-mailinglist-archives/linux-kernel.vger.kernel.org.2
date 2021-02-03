Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC930D78C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhBCKac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:30:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhBCKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:30:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF1D1AD26;
        Wed,  3 Feb 2021 10:29:49 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: Kconfig: Correct typo in NVMEM_RMEM
Date:   Wed,  3 Feb 2021 11:29:32 +0100
Message-Id: <20210203102932.7277-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/drivers/driver/ as the configuration selects a single driver.

Fixes: 2bf4fd065384 ("nvmem: Add driver to expose reserved memory as nvmem")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index fecc19b884bf..75d2594c16e1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -273,7 +273,7 @@ config SPRD_EFUSE
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
 	help
-	  This drivers maps reserved memory into an nvmem device. It might be
+	  This driver maps reserved memory into an nvmem device. It might be
 	  useful to expose information left by firmware in memory.
 
 	  This driver can also be built as a module. If so, the module
-- 
2.30.0

