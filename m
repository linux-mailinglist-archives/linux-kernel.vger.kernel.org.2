Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE793258AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBYVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhBYVcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:32:10 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:31:29 -0800 (PST)
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B00701F9FF;
        Thu, 25 Feb 2021 22:31:25 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: qcom: tsens_v1: Enable sensor 3 on MSM8976
Date:   Thu, 25 Feb 2021 22:31:19 +0100
Message-Id: <20210225213119.116550-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sensor *is* in fact used and does report temperature.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/thermal/qcom/tsens-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 3c19a3800c6d..573e261ccca7 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -380,11 +380,11 @@ static const struct tsens_ops ops_8976 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-/* Valid for both MSM8956 and MSM8976. Sensor ID 3 is unused. */
+/* Valid for both MSM8956 and MSM8976. */
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
-	.hw_ids		= (unsigned int[]){0, 1, 2, 4, 5, 6, 7, 8, 9, 10},
+	.hw_ids		= (unsigned int[]){0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
-- 
2.30.1

