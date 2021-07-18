Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE13CC89E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhGRKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhGRKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC5C0613E4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b26so24302070lfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dd9ei2GjQiFjh9R1NgRmYWUwg7rsPR4hERBwm4wpjv0=;
        b=m7dK3rl7blk+8UA/hKxKhQOYMPdH3NxlSmNnG/o1aJEhXEUlncPQuZKivbsbSFsd6D
         3i21AAMkCywCkVBzFWjOAv/d6Z+UDg82Z67QAhvpgJtzh0LcxglFAY9ZrBRrQ8Al6d8l
         lMQf+xWLEFiq96qDgAQPKVXhvqYLYe3nkO04nG49x/8iNM8x9LOo0LdZgU7iW9o/PdXg
         3ucl5q2Sryk4BpUbVP99WB8wcvbyb9Bx+L+AF/axWZZXqEQtAavjhflpKRkmLUluLJjB
         oqrA7G4uMYhngaGUONxfgVAVFnMRQ2sZnRSjZ7o3VcXH2T90XIyy28jrmDw769Z+hdgK
         NvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dd9ei2GjQiFjh9R1NgRmYWUwg7rsPR4hERBwm4wpjv0=;
        b=Mr2TQnGFbGxWTYyvS9sdk9fm2h3y35od2K9LkjR/wt/oM7igylZGy+BHPnfKSOKpVD
         NK5i2TrmX6I7sMJEFMn4Dr/MDwYGuyLjIIU/Pq6fo5cjUZpaU926FydRi1HgfRxzU3v5
         0QwbQvB38M+lhIWoJJlff/m4dtUf6l3Bh3EQsX4iLIqrJLPWYVEVe7EFa83UUD6o8Alg
         RebuiDNl/o7AfZjLP0ZSfTdwoDwbaH+3tfN4GhRT+tiZRDeASuCoR+uJa1hSrXH1EIB6
         N/ejIWs/69SZoRcYGCKi7TAjvf/ZnjEpDlhDpxKtwDoihe7y3bUU1tygxLBZ3aYXbZby
         vtEw==
X-Gm-Message-State: AOAM530Rg1tAPYW4ZkuR+qJtzfcj+zBx9NsB+9XDMXmnW9dghOG/l8e4
        cZf8KMhmNzbn4pU9PVlXWcatqA==
X-Google-Smtp-Source: ABdhPJw9tTR2amz089wkuVxYZzBd42218zETpGO9Z5ykKpcbYkr4c1GBjVvi8xaDTDShfKRsEqLNwg==
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr14921339lff.148.1626605354671;
        Sun, 18 Jul 2021 03:49:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 9/9] clk: qcom: videocc-sm8250: stop using mmcx regulator
Date:   Sun, 18 Jul 2021 13:49:01 +0300
Message-Id: <20210718104901.454843-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
References: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as the common qcom clock controller code has been taught about power
domains, stop mentioning mmcx supply as a way to power up the clock
controller's gdscs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/videocc-sm8250.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index d996b76f4e30..ad46c4014a40 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -277,7 +277,6 @@ static struct gdsc mvs0c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1c_gdsc = {
@@ -287,7 +286,6 @@ static struct gdsc mvs1c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs0_gdsc = {
@@ -297,7 +295,6 @@ static struct gdsc mvs0_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1_gdsc = {
@@ -307,7 +304,6 @@ static struct gdsc mvs1_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *video_cc_sm8250_clocks[] = {
-- 
2.30.2

