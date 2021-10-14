Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60042D8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJNMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:06:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBFC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y7so5252922pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS8MhlD7ABmZlkxmQInm9HCla87BICXfSMIw1C1cU54=;
        b=UiaX0lPC+3OXbtfGld9LG1rzAYWJgODKizS41kyTYqH21c+wg6SrSiMTc4xrMfmYc+
         U9U/FMqL5iI5+rILj//TJliaWtB9bJWrem2Avxh2Jvbe1MzHdyiBfJWoYjN2Cxn9dBr7
         5DVSmJjCclkRo1Yrve7gf8CMh6YHZwcIjpEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS8MhlD7ABmZlkxmQInm9HCla87BICXfSMIw1C1cU54=;
        b=u3rY/kkr/vSsnz5WUcqVe+iIiMgaaTSwa0619N7S3oI6Yfei2yPUjOC1sNFotveehf
         bY4Jc4WuJo2yHwdpWpC/oxDAXxIUsuIvRIjsOCk9Z6DZne7cqrQTkOUIMj6uteaoydtz
         CZaz5E+a4zlMMYb1a3RV03aSK561hNTQ+b2vrR3doFglkLv22rUg+FICRBq/OIvu1/+1
         ntp+cesE4I4t1Uvoc2Of8nhcFSUCRI44yv2EKTUfWUdxm/8koA7dXba++7DOiXwVCIE2
         9aNwsRcc3vDGAGo6+vV6XmRVIu/JevfQM2frEEdxPno80OJWDjXHFlIwZ4BE2VoJmSjf
         taeg==
X-Gm-Message-State: AOAM530EzA47VKClPdF+dmlQEL7ssrfE3iR5gVdVVoG9FYnbaUd2GF2t
        g93qcNIO7ez86TZgBxn3AuDxSw==
X-Google-Smtp-Source: ABdhPJzdRj4HVkNLgkG/WEqH2RrZtn2ign69xKx2wyK3OiBy2swev3QG5m5927mSi42rQmeqd8Jhug==
X-Received: by 2002:aa7:824b:0:b0:44c:22ad:2763 with SMTP id e11-20020aa7824b000000b0044c22ad2763mr4913447pfn.63.1634213068837;
        Thu, 14 Oct 2021 05:04:28 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:64c0:3f2d:5152:a6f1])
        by smtp.gmail.com with ESMTPSA id b11sm2300275pge.57.2021.10.14.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 05:04:28 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Fei Shao <fshao@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] mailbox: mtk-cmdq: Validate alias_id on probe
Date:   Thu, 14 Oct 2021 20:03:51 +0800
Message-Id: <20211014120352.1506321-2-fshao@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211014120352.1506321-1-fshao@chromium.org>
References: <20211014120352.1506321-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_alias_get_id() may return -ENODEV which leads to illegal access to
the cmdq->clocks array.
Adding a check over alias_id to prevent the unexpected behavior.

Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for
mt8195")
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
---

Changes in v2:
- Add Reviewed-by tag

 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 64175a893312..f3e52dddd422 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -573,7 +573,7 @@ static int cmdq_probe(struct platform_device *pdev)
 			char clk_id[8];
 
 			alias_id = of_alias_get_id(node, clk_name);
-			if (alias_id < cmdq->gce_num) {
+			if (alias_id >= 0 && alias_id < cmdq->gce_num) {
 				snprintf(clk_id, sizeof(clk_id), "%s%d", clk_name, alias_id);
 				cmdq->clocks[alias_id].id = clk_id;
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
-- 
2.33.0.882.g93a45727a2-goog

