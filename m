Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D579C42D61B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJNJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhJNJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:34:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936DC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:32:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so3746600plh.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N7LqSgN+UZnAqVmRLbsz9jNSkFsNbdadLpiAPsmvpk=;
        b=TgDBT/R5HvVKa0u4zhVU3L2rR4sTGVKN8VBSQ/gbIfj4Glo7ia+/8PC5icCb4uRw6+
         Z7sUeLMjbqq7MG5x8IldR+YRUKu8Fn37oI4kfPTO3mV6TeLU75zv4YFHGjjQqad8tYW2
         QDFWX0brHo4Ec/h4sHsklnd0l/SYdQBaAs0lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N7LqSgN+UZnAqVmRLbsz9jNSkFsNbdadLpiAPsmvpk=;
        b=lqJh0ekWiDcPrBbBYHSLFR43Wdtxg0U0/S9sN1DRcE8hZkTQRR1Ub1OC6vW3QrSt95
         epU7ng9nTzd39wMFH9zMjf4nSmE7+6mB79WOamRS4rBEWLGBH8L3CUI0vWQgp87J4GO4
         L9EY5H+lz8pF0OrPaLmIGlZzx3AeRDj/Ri/9gRaGuzasljY7SUlVbCAJnWpwjxqr0wEa
         0n3yBR4rwanxFd2F7wltPTY6eHcS7IKU7En6g6z0fVetnWr/WUxlDW4oFBy63MSmS4Pl
         f86fOHRcfWml3l4YyUcmk4S47/Hlc8kar6YvMFvXiA7iohNh9RvG2mkAWk3wzO9yT2S+
         7qXg==
X-Gm-Message-State: AOAM53386jpoPLwY/s1WjU07/nNmtCWCThuJg5uhyxpCr3/gpzkQnCjp
        pBizrMvwYkccd+SuDdSaP7f5/g==
X-Google-Smtp-Source: ABdhPJzo8cSv6WRzPAAlW8Vhmr32cF+Mld9yZj/Q/Fo9HPwQ4SN8yXMworzFOb19WFWs05zoDSIJpA==
X-Received: by 2002:a17:90a:b948:: with SMTP id f8mr680033pjw.129.1634203965729;
        Thu, 14 Oct 2021 02:32:45 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:64c0:3f2d:5152:a6f1])
        by smtp.gmail.com with ESMTPSA id k6sm2120116pfg.18.2021.10.14.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 02:32:45 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Fei Shao <fshao@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mailbox: mtk-cmdq: Validate alias_id on probe
Date:   Thu, 14 Oct 2021 17:31:10 +0800
Message-Id: <20211014093112.3852491-1-fshao@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
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
---

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

