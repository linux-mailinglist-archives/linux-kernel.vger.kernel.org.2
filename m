Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668843954A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaEhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhEaEgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:36:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3575C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so4591489plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TCxgyYQSr5o3I78mldH5Z9lcyNNYCjL0+Xcvw5BpHc=;
        b=c2reybcrNCcfCPjUCkeuvpe3yKi/hqDQxkdLaYqMtpdB1ihkdJ/Ee6lG3gARI5Tsn6
         dmWLsn8v2A2NK1XB/35IHqY6VaBEVdLMmndFSX/EZsvOQhOz+nZhcfeCRTbp2DyFwVD0
         cKJIZOyZZxC22NNizE2huExt08h9WKwASPX4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TCxgyYQSr5o3I78mldH5Z9lcyNNYCjL0+Xcvw5BpHc=;
        b=A2LnZAX1vaNTUfVrWDF8FsDHKW4aidg4lKKgfsbrmNaOa2+JJX2Jlhvzv+UL8Eg3Xw
         ovqUVz58FQ5qA5YFoFtNZqtHB2O5R00ZAWCrdZbU0T/aBjqVUPyjkqOPar2+SB10WwWj
         0lwRNRjy2xWfjBz20e1eP7zAlCYFG93TOqjhwf/iH4RdjVbsCYRRaoeZLOOQID7l711L
         gqC5DMNnnrTAYpqsVcTzwXFzILDmJZfOpAOyev6zyy/Pn2SQDLDs9mEo8Lyni1M6hH5p
         5Y7++OICh7eCJkzjMec+tlpPzopwwAHpEOT6/by1QqqnyY6cxTkaBtcJ/nlj6rDUelny
         3Rzg==
X-Gm-Message-State: AOAM533D2LyPHcAsibyuHGQcM5MdHN4iFtvEy73KnV34nYt/ShMadeAG
        3ycscHqWqObz7YWuUL96pvRoDQ==
X-Google-Smtp-Source: ABdhPJyFU9b17OROMPbkumQ0tReN4Qd93C+lb9YAfo3Zv09ruH6iQtxzuayQHC3u8LL7xGiLs5hG0g==
X-Received: by 2002:a17:90b:f07:: with SMTP id br7mr10601569pjb.141.1622435708158;
        Sun, 30 May 2021 21:35:08 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c929:9e58:1e99:bfb5])
        by smtp.gmail.com with ESMTPSA id a9sm9366811pfo.69.2021.05.30.21.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:35:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH 2/3] soc: mtk-pm-domains: do not register smi node as syscon
Date:   Mon, 31 May 2021 12:35:01 +0800
Message-Id: <20210531043502.2702645-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210531043502.2702645-1-hsinyi@chromium.org>
References: <20210531043502.2702645-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek requires mmsys clocks to be unprepared during suspend,
otherwise system has chances to hang.

syscon_regmap_lookup_by_phandle_optional() will attach and prepare the
first clock in smi node, leading to additional prepare to the clock
which is not balanced with the prepare/unprepare pair in resume/suspend
callbacks.

If a power domain node requests an smi node and the smi node's first
clock is an mmsys clock, it will results in an unstabke suspend resume.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 536d8c64b2b4..a9ba71eee4bb 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -296,7 +296,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	struct device_node *root_node = scpsys->dev->of_node;
+	struct device_node *root_node = scpsys->dev->of_node, *smi_node;
 	struct property *prop;
 	const char *clk_name;
 	int i, ret, num_clks;
@@ -352,9 +352,13 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	if (IS_ERR(pd->infracfg))
 		return ERR_CAST(pd->infracfg);
 
-	pd->smi = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,smi");
-	if (IS_ERR(pd->smi))
-		return ERR_CAST(pd->smi);
+	smi_node = of_parse_phandle(node, "mediatek,smi", 0);
+	if (smi_node) {
+		pd->smi = device_node_to_regmap(smi_node);
+		of_node_put(smi_node);
+		if (IS_ERR(pd->smi))
+			return ERR_CAST(pd->smi);
+	}
 
 	num_clks = of_clk_get_parent_count(node);
 	if (num_clks > 0) {
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

