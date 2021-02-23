Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBB32336D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBWVr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhBWVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:47:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992CC061797
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kr16so2741925pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=niEv14NOkKJjaKQaXzaP2FFAvsr9oabzdLHL5oVtiLE=;
        b=X/XMKNruvhykGhsqLzDERdOHohFu5lLgGpyeNxihl5H0fQgjnUGaRUMc19Oz/5l1C5
         eu+qI2gBcmq7wPLOram7J5YiUELdk+UrWdW5rPLpmkcXbO7D0xU39hAOsECfMHrpFGM2
         HShxLBXH3EdWfy5t8OyfqlrI6mSKLKO/jxkbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niEv14NOkKJjaKQaXzaP2FFAvsr9oabzdLHL5oVtiLE=;
        b=mM7/nzBV4tucexFy2m5UPK7O8HBbgl57OTxaBzxEv5a76Axi1X0zLvA6LXGaS2UOnq
         53nMRd59ZJLSUFF6CXYIngrgx+4xxo8haqrWHpDhymtPKNv08g1m3lZlHahEnG3briwz
         rKLw2+KpoxwRpj6lenMbWBPhg3cb39iwWq4ixU0aLAw/W774YjtHHdq0ThPsyc5fx/d0
         +hR2J3qXAXM8XUGu7RnO/yBYApSVbn1rxjKqVtKbVw9sSaJL/B3WEuWXsKSJT8Rr9mxa
         XTNyGp3ykJBk9oYfsIK/cKeaPftyLmqLINS8m8CWNTF8dysgSivgQQnj7KUqWSqDQFuq
         3LAg==
X-Gm-Message-State: AOAM530KtiyskvAgnGCH0sHw1USqt1HwHwqBV1zRBaCCmCLPtLfZ16nf
        CjpTsRkjafmIuL0J+vN6JSgWNA==
X-Google-Smtp-Source: ABdhPJyCy5ckToNt32r6CZZqwU0hn80SFbKdwiAZiGtuoCfNxwxI6Lk6ZWg+Yl33mQKD/Zao9ss+9w==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr831063pjb.35.1614116745955;
        Tue, 23 Feb 2021 13:45:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id r68sm137951pfc.49.2021.02.23.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:45:45 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 4/6] firmware: qcom_scm: Suppress sysfs bind attributes
Date:   Tue, 23 Feb 2021 13:45:37 -0800
Message-Id: <20210223214539.1336155-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223214539.1336155-1-swboyd@chromium.org>
References: <20210223214539.1336155-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want userspace ejecting this driver at runtime. Various other
drivers call into this code because it provides the mechanism to
communicate with the secure world on qcom SoCs. It should probe once and
be present forever after that.

Cc: Elliot Berman <eberman@codeaurora.org>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 9ac84b5d6ce0..ee9cb545e73b 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1301,6 +1301,7 @@ static struct platform_driver qcom_scm_driver = {
 	.driver = {
 		.name	= "qcom_scm",
 		.of_match_table = qcom_scm_dt_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = qcom_scm_probe,
 	.shutdown = qcom_scm_shutdown,
-- 
https://chromeos.dev

