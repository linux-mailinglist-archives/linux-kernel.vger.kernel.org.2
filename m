Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B742D8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJNMGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhJNMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:06:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F515C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d23so5319118pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjtTKqJNAW9TAfK1opWSOcT+9CXDZRVrcJjqizIFop8=;
        b=VdsdzRAnoo6T3oe5ardLdZQTZfHNI7s0aObN2E47puJxRGKkUA0aqL/OuTMkAqV8v8
         Kbs/GAGctRezd7TcrMxuBUIHbGiVWwTZs2n8LWJLdOGaOjQg69LHDXh5e/WMJkhd4rHc
         /pB+N/2EBvXkvvsiB8ja2gf9a+ZtlCoe+vSS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjtTKqJNAW9TAfK1opWSOcT+9CXDZRVrcJjqizIFop8=;
        b=Z4pg+lG87lkJrsEvRjU+BaatuVc7+cl7awDzN8RSvVweGkjz/kMWTWdxp3bCSdvZCC
         YfmWZNKEv4Q3TWYnFae+sLwnMkdMtqDbGohxMnTlNI5Bz4t2tSbxVrSD/4PX/lbGSf0C
         ZiAfRo9PHgnu+upAuFkpFPQbZ30DPp+8Jt28D7q6wCYo+CgssZf4oOLMNkOXrwiOEIwk
         MU3klJCbIJylJhIFipYes5DW3H9Z6b8zXENPud4vgSMPY65t/UHarSUpLMJ9dhHiGiCO
         zPnbRsObc+aEiXmTaTrYsvI3HtWDawV/95wTOrC5nZmPWqgUFfr2TC2bosK7muaYMB3p
         yALA==
X-Gm-Message-State: AOAM533tBH6gB7MJIHdAd2x7dTmEv8u33ehmaGLyQ/LWvxVzhRkQJg1o
        L+CO4pYDDLr1C3AyO+S+pqxsFA==
X-Google-Smtp-Source: ABdhPJzfAyd5w8l4m9xU+WIpJBe1EuuS5AIYTA+h6Lpw2RNsav3/vZ5qxcdkGjy6ufyy83SyD0FFQA==
X-Received: by 2002:a63:3481:: with SMTP id b123mr3910867pga.230.1634213072117;
        Thu, 14 Oct 2021 05:04:32 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:64c0:3f2d:5152:a6f1])
        by smtp.gmail.com with ESMTPSA id b11sm2300275pge.57.2021.10.14.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 05:04:31 -0700 (PDT)
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
Subject: [PATCH v2 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
Date:   Thu, 14 Oct 2021 20:03:52 +0800
Message-Id: <20211014120352.1506321-3-fshao@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211014120352.1506321-1-fshao@chromium.org>
References: <20211014120352.1506321-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the probe function, the clock IDs were pointed to local variables
which should only be used in the same code block, and any access to them
after the probing stage becomes an use-after-free case.

Since there are only limited variants of the gce clock names so far, we
can just declare them as static constants to fix the issue.

Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for
mt8195")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Make clock names static

 drivers/mailbox/mtk-cmdq-mailbox.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f3e52dddd422..95ce7275641c 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -532,7 +532,8 @@ static int cmdq_probe(struct platform_device *pdev)
 	struct device_node *phandle = dev->of_node;
 	struct device_node *node;
 	int alias_id = 0;
-	char clk_name[4] = "gce";
+	static const char * const clk_name = "gce";
+	static const char * const clk_names[] = { "gce0", "gce1" };

 	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
 	if (!cmdq)
@@ -570,12 +571,9 @@ static int cmdq_probe(struct platform_device *pdev)

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

