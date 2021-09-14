Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05C40A2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhINBm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbhINBmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:42:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71508C061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:41:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t20so7714416pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z0/SSImFg2hF6zZaUL93PgMKJHZYbA/zVqM/2xdqHn8=;
        b=m+ZZiJzYAZIU+vxr2YG3fqTJmG5Tb98sIMCjHGYVmIiXm7hUBrXIOyVvONa0dW+OGW
         qQptzjhxancQJPTD3kJ3ZYHWPdLH/i7lr0BeifdcerevLzIP7G8lk4EzZUIvaj+orLW1
         WHaOrLfVt8LKud3X8B7q9hf/ntnCh423tTqvc5adu3Aaew6n9suTMmgAK19I45au2DJT
         NtzCLpWi1hO9Q5qr62Y9igyKXTA4oI89oAFBKM+BW8f2I+VaN3AUzs9+JJ+Nt2zBiChx
         vpBzTiAOUQBkJm0TJKlkNu4gH49tjSmCImYUckrCgRB1UWiTCldaKPTscyMyqFVB0cxG
         sP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z0/SSImFg2hF6zZaUL93PgMKJHZYbA/zVqM/2xdqHn8=;
        b=ST0l13XVowh/fx6zTD8QkTzw63ooQVcC68nh2jttDY+p3cgFzlXl6TZRieA9BdEPKH
         +xVBQ87wImtegXIvrd3FdJBm49oL3Q6yezsj7i6eUlsPLPwtLqplKcg/nJsLafkP5xCJ
         KiolxtrKLOSbA9nS3FrB+C1wRfXdpyALWxB2uwtMrRYjEQLJoBW/2JleCSSFUcVaE0v0
         wInn6AYeEYh7HDGLzYKSxcNrFR8G7/VFQKdJ8joysB52HrH36Pp0DYE2CueKIgtWmWoq
         ivIW6R3w1LsOqvdra/yb7p1eNwRwK0klbeu1js4qwpJWl7m+iltsGqClqI7bgPSzxzeN
         DylQ==
X-Gm-Message-State: AOAM530TnAvJXfs2548oX740P97LRMXE5bhU4hwu79V75ccXijgtaAz9
        Rp2h1e5/hMVdN84P9X5bQt4dgQ==
X-Google-Smtp-Source: ABdhPJw9ewtd0lQo3LylLq2v1ej0bV3HMxEADmABBGw5BlH/SE2MkxSP63C2/gDJYQ2iN/I6eWmpdQ==
X-Received: by 2002:a17:90a:1d09:: with SMTP id c9mr2618779pjd.204.1631583666987;
        Mon, 13 Sep 2021 18:41:06 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 4sm8037615pjb.21.2021.09.13.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:41:06 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] mailbox: qcom-apcs-ipc: Add QCM2290 APCS IPC support
Date:   Tue, 14 Sep 2021 09:40:50 +0800
Message-Id: <20210914014050.28788-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914014050.28788-1-shawn.guo@linaro.org>
References: <20210914014050.28788-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QCM2290 APCS IPC support by adding the compatible.  It reuses
msm8994_apcs_data.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index ac42cdae638d..2092dfb5de00 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -151,6 +151,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8994-apcs-kpss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = &msm8996_apcs_data },
 	{ .compatible = "qcom,msm8998-apcs-hmss-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,qcm2290-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,qcs404-apcs-apps-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,sc7180-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
-- 
2.17.1

