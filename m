Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328AF42D61C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJNJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:35:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:33:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so4988485pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fwWMum+XGi3+U2DaIfb9q6LtryQgWT3ekOpQvR6dCM=;
        b=Ol6rRe7O26a+knJp2yEBarjsvc1AXZULqEyq6SqcwKJucDHNVpL17Mrx+bW69+Ch1e
         WlTXZDDtPg3zodERZTAE7EPuRvQI1fzCk8aaVNaYbuzvb35wBzDLSH0rue3UfG2GPvnU
         B/qX2dIFsazwatobJ1SUHJqZCTC6+aaenNs3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fwWMum+XGi3+U2DaIfb9q6LtryQgWT3ekOpQvR6dCM=;
        b=CDXZBdIb6n6/SPMFwuXpo2wYep//yLRiNZ1jj6eKZnghvTO2xuO3VICbdhJm9l5jGR
         ouyoOpTbWywp7V2qK0pESUFMWnqr9GalJb04HJgPM8JDc0TYTYukUhkjEHLhdmxVWJU0
         Pzi3KvjiOoi+lWiTAEF0+DlhFaOv7y3bCIbeJnmkXgSEeR6BnNjhNjRclnk+/Vkh74Wv
         bHMn8Svj+ybu0ZEYuKDZ2gjpvcGGM2tXaLzXm8jAVfaLkuyG/uiqWKDInxk3oFj69PEV
         Bg9VpX7c0AlhyRz/9+qauxXkSxB+fkL4OWrkw++F3T/MwJ7Qmfdlf1xGGh7NCoYrWnTD
         4ZrQ==
X-Gm-Message-State: AOAM53177qDDu4J8kTOmq/Q++zY72c+4yv3UXRAUmQORFNdPKrlsv2+S
        ASQlosmFwkxOrsw+ixTxkTFTpA==
X-Google-Smtp-Source: ABdhPJwA36WyDNJj0nGpSsGt31gMXDVvFxJphvharItmmO5IICkZJmsfpN/t18YYip6v37GGlIaunw==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr3373441pgv.425.1634203980906;
        Thu, 14 Oct 2021 02:33:00 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:64c0:3f2d:5152:a6f1])
        by smtp.gmail.com with ESMTPSA id k6sm2120116pfg.18.2021.10.14.02.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 02:33:00 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Fei Shao <fshao@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
Date:   Thu, 14 Oct 2021 17:31:11 +0800
Message-Id: <20211014093112.3852491-2-fshao@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211014093112.3852491-1-fshao@chromium.org>
References: <20211014093112.3852491-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the probe function, the clock IDs were pointed to local variables
which should only be used in the same code block, and any access to them
after the probing stage becomes a use-after-free case.

Since there are only limited variants of the gce clock names so far, we
can just declare them as global constants to fix the issue.

Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for
mt8195")
Signed-off-by: Fei Shao <fshao@chromium.org>

---

 drivers/mailbox/mtk-cmdq-mailbox.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f3e52dddd422..27248b31cd51 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -90,6 +90,9 @@ struct gce_plat {
 	u32 gce_num;
 };
 
+const char *clk_name = "gce";
+const char *clk_names[] = { "gce0", "gce1" };
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -532,7 +535,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	struct device_node *phandle = dev->of_node;
 	struct device_node *node;
 	int alias_id = 0;
-	char clk_name[4] = "gce";
 
 	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
 	if (!cmdq)
@@ -570,12 +572,9 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	if (cmdq->gce_num > 1) {
 		for_each_child_of_node(phandle->parent, node) {
-			char clk_id[8];
-
 			alias_id = of_alias_get_id(node, clk_name);
 			if (alias_id >= 0 && alias_id < cmdq->gce_num) {
-				snprintf(clk_id, sizeof(clk_id), "%s%d", clk_name, alias_id);
-				cmdq->clocks[alias_id].id = clk_id;
+				cmdq->clocks[alias_id].id = clk_names[alias_id];
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
 				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
 					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
-- 
2.33.0.882.g93a45727a2-goog

