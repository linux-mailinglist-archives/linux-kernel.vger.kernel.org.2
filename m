Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644E3FD8F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbhIALov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbhIALou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:44:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD5C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 04:43:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so5709085lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dv7SSHrzc+JrKmtfmOHwtcJ0mmdkld+UU+xFR+0sd1s=;
        b=SPVgpEGg8weWIgr6ghEmwFMRW755IzX1VvDxe1QzAqsMJcTqN8WGm/DN/EeLe1D9hI
         JCpiJ7DraFf/1cJHWba19usvWWJIqYPfpgbgwSHEfMAzfhghjOyvQn8wdSAbWQLUnAqK
         aPjP7vHuNX1YX1AIphLQP5Nbyn7Pqsp6Z0HHQiT60jRSfL+HvHWLIyj/txLcRVCElCyD
         utbcU2MZMZBgIt5UvxzoaXWXCjJQKN8NqtT60dPQgRSpzExtM0uWbBmHaB6pECdQkHFL
         0Zr0Yb/ZkzfbWIKdI3JUKW7ID0Lqisb3mGnhfZSBfCVigrkMZF2dqD5kxcNQ9FsQa3FA
         YThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dv7SSHrzc+JrKmtfmOHwtcJ0mmdkld+UU+xFR+0sd1s=;
        b=W6GkfLB9Es7YkUw8kGknuZVfsL95/SkYTF7JQJcX4TbQ7hPohD6gaei6Z+eic2DJcj
         4au6YZZrFmjJBAP1+tVatjcNp9nmECctOslPBWZsjJ2D6IBURQ2/bACNinYbb20Xu0h7
         5cow8mMdHZOltxaHYBxWwGUAivL2bpA9jgB+zDSnq1TiLnzhjAqW0AFXpPrnLSmnAJ6m
         RGFkV8PGAl8wZzGDI2MkBiA2c9gaUNYFjh45IPYF9JWWHo9iT2OrHOenDhTNgy0wnimk
         Ni9ToW0XFNHyC4stYE5KI3MqhfioyzAohL1sM6xw/AE9IqZwbsy1VNpUiyxkW6gwXXRk
         NdYA==
X-Gm-Message-State: AOAM531qdDaZeDloZXq+uDULvyJ9nTgJVodP/pxBpZg4V8HMY4QtjSY2
        6fAlQFbXWyO1+A5yjeBTRaJoAw==
X-Google-Smtp-Source: ABdhPJw9BEAZJkcsfe4dO67KihLaBhSi75YCfERe0uWPom1D/IOsHrPIguzc6NavdrcnD6hNXnfVNw==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr21603337lfe.49.1630496631983;
        Wed, 01 Sep 2021 04:43:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k12sm2443762ljm.65.2021.09.01.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:43:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: qcom-rpmh-regulator: fix pm8009-1 ldo7 resource name
Date:   Wed,  1 Sep 2021 14:43:50 +0300
Message-Id: <20210901114350.1106073-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the pm8009 LDO7 declaration, it uses resource name ldo%s6
instead of ldo%s7.

Fixes: 951384cabc5d ("regulator: qcom-rpmh-regulator: add pm8009-1 chip revision")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
 - Dropped extra drm part which somehow got through to the patch.

---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 6cca910a76de..7f458d510483 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -991,7 +991,7 @@ static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
 	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s6",  &pmic5_pldo_lv,   "vdd-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),
 	{}
 };
 
-- 
2.33.0

