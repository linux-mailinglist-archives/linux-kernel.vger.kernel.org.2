Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0D396BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFAEBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFAEBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:01:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 20:59:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so1056208pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UB61Gzn/MRwmod4oJCljeygOUa03KL82epqgxkhg2kk=;
        b=H4cPMG+N+viqUaTM+Qp5Ik0G0yuzXdhgb8vf+8ySTT1fiEy+L0O4tCybFkjAt1C0as
         3p2tGK3Qbmf+oanC78Ooe7YsL3nsu59z1snFEkgVy4iEzLsPbNBNg1pqvk2zZYkWT3Q/
         +bBHkWZDzeKjlgvslHU0KBs7V51Gph8ngIDZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UB61Gzn/MRwmod4oJCljeygOUa03KL82epqgxkhg2kk=;
        b=M/9V1C648UYK5rXEx/ePCE2rZshRGuTvMu19v3k+7aAgJyzqFyUJWcwKfrBCqtb/k7
         pl4N5nLl2w8zkYO0GbfpyK79WGlL6H3FP3xXhC6ae0HOwfE8roYYaEYzaQY5O+nSTHhB
         c1YT7sYOsjCbwtzrvh+dj0DwFaUL2cif9bFE/ZpJKQxljKtnVrZANSnNnjq5UP1KAVDM
         yvNAQQ1k/sSI1vPYGuQxBo4yHy8rdUAw+kqMvnkJC+IRqyhVu37fNz62m1pWtjpP5IFR
         YQpQFcOdTZQcFYNvS5c5OeIdMHsbAm5uG4E5o1MvupOFZCja2Bph5tgxjywzXlriSVS6
         foeQ==
X-Gm-Message-State: AOAM5336KCnYwQTzcN2oaRxdlIcWStxD4HxI/CDjzyzOBbQ/RDJWA1pc
        Fk/8bnUmneptpQSlw+vn0XbqDgJm8xSodQ==
X-Google-Smtp-Source: ABdhPJwOeJ2sbNS0QZkH6Mt8lSTze0NTU7Hsqwrxy08Rr31iBqCYesAg4OhMUcsdKDFei8oXIvVr/A==
X-Received: by 2002:aa7:8119:0:b029:2b5:7e51:274b with SMTP id b25-20020aa781190000b02902b57e51274bmr19960434pfi.32.1622519951510;
        Mon, 31 May 2021 20:59:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f83:3563:b780:4d82])
        by smtp.gmail.com with ESMTPSA id 203sm2779735pfw.124.2021.05.31.20.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 20:59:11 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 2/3] soc: mtk-pm-domains: do not register smi node as syscon
Date:   Tue,  1 Jun 2021 11:59:04 +0800
Message-Id: <20210601035905.2970384-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210601035905.2970384-1-hsinyi@chromium.org>
References: <20210601035905.2970384-1-hsinyi@chromium.org>
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
clock is an mmsys clock, it will results in an unstable suspend resume.

Fixes: f414854c8843 ("soc: mediatek: pm-domains: Add SMI block as bus protection block")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: chun-jie.chen <chun-jie.chen@mediatek.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 536d8c64b2b4..b762bc40f56b 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -297,6 +297,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
 	struct device_node *root_node = scpsys->dev->of_node;
+	struct device_node *smi_node;
 	struct property *prop;
 	const char *clk_name;
 	int i, ret, num_clks;
@@ -352,9 +353,13 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
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

