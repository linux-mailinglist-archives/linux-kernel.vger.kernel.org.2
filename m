Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F542A817
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhJLPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhJLPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A63B60E0B;
        Tue, 12 Oct 2021 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634051929;
        bh=JiebhzwuHVXY80Oic6utfrmJONJx8VfAP7QNQDVcqMs=;
        h=From:To:Cc:Subject:Date:From;
        b=uR/kT2xSoizS9rasOuK34HL8QIyL1MeUKiN6cCH7xbeVXoqQdGga8pdfpOgEEWcKm
         K60YyUfG/XcGQWkQw57Yz7uLcF+5aLJ50tqKanW87C69WAMmp/MwV6/MK9q6bLvlph
         +cU+OmijhxAN+h3oV/4/rOVfq4Tf8iwIdOYjqIhXhHaPVYn0r33J605soOFJHSjhMa
         exXEIB11fwoCOuoYxCWuqbEggd6k8oUzjCnGkGtEWA1RXodyXvVQiaWvaCLN0Y4RBZ
         Hh4V81oUQX0ISzfYmfrzhv5/mELKa+USfhAzPFWHVv4kSVh8s7Nd52y2SgmF/VSESs
         e8u0cLRb13ZAA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Date:   Tue, 12 Oct 2021 17:18:00 +0200
Message-Id: <20211012151841.2639732-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

My previous bugfix ended up making things worse for the QCOM IOMMU
driver when it forgot to add the Kconfig symbol that is getting used to
control the compilation of the SMMU implementation specific code
for Qualcomm.

Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: John Stultz <john.stultz@linaro.org>
Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
In case we want fix it this way after all, here is the patch
I made. Either this one or Dmitry patch from the link above
is required for v5.15
---
 drivers/iommu/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c5c71b7ab7e8..3eb68fa1b8cc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  'arm-smmu.disable_bypass' will continue to override this
 	  config.
 
+config ARM_SMMU_QCOM
+	def_tristate y
+	depends on ARM_SMMU && ARCH_QCOM
+	select QCOM_SCM
+	help
+	  When running on a Qualcomm platform that has the custom variant
+	  of the ARM SMMU, this needs to be built into the SMMU driver.
+
 config ARM_SMMU_V3
 	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
-- 
2.29.2

