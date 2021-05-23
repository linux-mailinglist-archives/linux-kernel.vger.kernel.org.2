Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED3538DCFD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhEWUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 16:50:50 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:34661 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhEWUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 16:50:48 -0400
Received: from TimeMachine.localdomain (bband-dyn255.178-41-232.t-com.sk [178.41.232.255])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 68A553E7E6;
        Sun, 23 May 2021 22:49:20 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: arm-smmu-qcom: Add sm6125 compatible
Date:   Sun, 23 May 2021 22:49:11 +0200
Message-Id: <20210523204914.707776-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 98b3a1c2a181..7455bcc92f43 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -333,6 +333,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm8150-smmu-500" },
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
-- 
2.31.1

