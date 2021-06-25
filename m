Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE803B4AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 00:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFYW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFYW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 18:57:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE1C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:55:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so11018318oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luOPyFo3L01zOr2qtu2eBJWxs2yeN+/Vdrodh5iollo=;
        b=mJh25ztmvFCyH/W7nUNGj+2z4f2AS5pMEcCtLdpkIz3FZUmG28wxqomX9SpHT3Mt87
         fW5Sf/kTK9V2CIKz5rbS1vfkZTnk/NY/g3uuKHSHc2M7VjnU+Ui6LSWuSQTc/5jANbJm
         VHx3dNIxXVrQaHzmJVxdwM2WqhGR7TnDke6YXw/9Og6Uggsd1QPOtTaf+eE4ARfWkwR+
         HTl/F6SLnoAbsOYJTy7PYIvqwIywJD2cAZ1GzU3lJuV3IMwt8GWBWwVeIlHAH+giF/w9
         Oa2ZrLoCcb1BpKXb1/l147l2tkaEUTsHH880jRo33dmA0gEHZBNUb7MlTl1GZGPEjkOU
         kRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=luOPyFo3L01zOr2qtu2eBJWxs2yeN+/Vdrodh5iollo=;
        b=oG4FmadGCMvUrId7FJzAV3MueVnsKKzX0j/Ef/h5IHi3SRyjHIetwrKtLrV+I5DDrL
         HMX+3YoptGw5ZIOqIdMtt0ZEG6jCTFPsj3AW2c+xSCYoeqW9VTZRKaG44VEJ1rFIn3nk
         D+xwYkRV5xFJ0PKoph0amrEJ4GbaibXwPrQ9HmQ3Ez+3tEEVZlhRl8nJt+r1PM8aaXiL
         3vWTIJGTopfWN9nmMWToB/IJk3FAPCowjE8bexqSwV8ahIezFlek83M5LNdQnHu0yFkh
         30k13e8Pz1GpAMWcEK3dMPfF71cOwsQMlrXT7ZITAVSeSkcHjgf8rX8JvFbgE4kmyTKI
         oU5g==
X-Gm-Message-State: AOAM530+0qfRmAkMMIKG2lhEh/OSHGsQED4Pk8HLEacMminirGrIRTdJ
        yLnTmQRy5owUO4AVIW8nEt9lCg==
X-Google-Smtp-Source: ABdhPJwiJynOzvN6yh3Vh7xbiLJtDZrSq3jgQsBh55iOSBxetLaVl9zxb1FS3c7rwCCJBapHH8IC+g==
X-Received: by 2002:a9d:c23:: with SMTP id 32mr11451076otr.182.1624661724139;
        Fri, 25 Jun 2021 15:55:24 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w11sm1516557oov.19.2021.06.25.15.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:55:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] clk: qcom: gdsc: Ensure regulator init state matches GDSC state
Date:   Fri, 25 Jun 2021 15:54:14 -0700
Message-Id: <20210625225414.1318338-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As GDSCs are registered and found to be already enabled
gdsc_toggle_logic() will be invoked for votable GDSCs and ensure that
the vote is matching the hardware state. Part of this the related
regulator will be enabled.

But for non-votable GDSCs the regulator and GDSC status will be out of
sync and as the GDSC is later disabled regulator_disable() will face an
unbalanced enable-count, or something might turn off the supply under
the feet of the GDSC.

So ensure that the regulator is enabled even for non-votable GDSCs.

Cc: stable@vger.kernel.org
Fixes: 37416e554961 ("clk: qcom: gdsc: Handle GDSC regulator supplies")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 51ed640e527b..f7e7759cdb90 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -359,10 +359,17 @@ static int gdsc_init(struct gdsc *sc)
 
 	/*
 	 * Votable GDSCs can be ON due to Vote from other masters.
-	 * If a Votable GDSC is ON, make sure we have a Vote.
+	 * If a Votable GDSC is ON, make sure we have a Vote. If
+	 * non-votable, ensure that the supply is kept enabled (as
+	 * is done by gdsc_enable).
 	 */
-	if ((sc->flags & VOTABLE) && on)
+	if ((sc->flags & VOTABLE) && on) {
 		gdsc_enable(&sc->pd);
+	} else if (on) {
+		ret = regulator_enable(sc->rsupply);
+		if (ret < 0)
+			return ret;
+	}
 
 	/*
 	 * Make sure the retain bit is set if the GDSC is already on, otherwise
-- 
2.29.2

