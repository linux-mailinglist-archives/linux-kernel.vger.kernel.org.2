Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D96369C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhDWVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhDWVb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:31:29 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCA4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:30:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so46498325otn.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biSWV55F2dE+el+PFILbFyyqzGxlorix6gdc/rvSk1A=;
        b=QKLnSy7HaoTthiq8JJVeJC4MwVDhmw1673MXJ1M7z8smE+Iof3gtd4juqf2WjIA7uG
         jGX3XV1mABlp3VHATKm9zPVoz97OwO/r51APBemFXaAE6cXY9ySi12n1vnbdDKo8skQN
         DmkX3wRalGuYcZ7HfwjPGp/L922MerrwbSRgIxfzHE/x4EblC8BIjBy6zmCl8sCqHDXh
         bKy6lWn2qt/eZxfyAseuRaLgh8aOcalQ13QIyq2y+IOmTCKiR6ra3gb9ON0AfyZlYWoG
         S+xQSDTkLCld+o3WaferAq7PYeWxw1xdmQyin7EzpOKfgGmpkOqUS5MyRJgIWjMsRqCl
         g6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biSWV55F2dE+el+PFILbFyyqzGxlorix6gdc/rvSk1A=;
        b=l4VGIDvUu67aBNbG3w0dp+P1M6hX0NTvov1LnVMvPsnVEgoCJzOrNDApOKgwwEwG02
         ltBSujhFmGko/TJbh8qM+i4Z23eN3nKG86eLreX3jHBx23y9l+ynS5IFEgNKS0bcQ+p9
         hDDDNZ/bvviwKbTrVYZc2qF6oDi/HMC1c01ZfoAIC07IFBWbvoU+PLAnPpwa0q3ZHu8t
         BBbVoevA2DwzwaVSupwPE/wUgfOxU+BqAQn1cweEznRvIMBb6BQd0HxOkGzB55hKb3kL
         BZCYP8mAoY5Qt+Z1CcxxBXrC2nmHb8Rhxvn26VIHTTI3JS6V63tEimeqdEyqKM1hq9y6
         /TQw==
X-Gm-Message-State: AOAM531oB2v1We1lEwxCWKuKFIBb2s52dY0RYQv4hQezfM5Bo/Jzw1Is
        Eb6X9fp972kJ9LgTviCSrX9rNQ==
X-Google-Smtp-Source: ABdhPJySh+dpatWG7Z09QnFYMgdTR7IGynzmALJgchtxrZmyIRPJz2Wxrx7EAtf6GBplbWUmIlVrYA==
X-Received: by 2002:a9d:2f04:: with SMTP id h4mr5030788otb.364.1619213450099;
        Fri, 23 Apr 2021 14:30:50 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a19sm1617075oto.50.2021.04.23.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:30:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: Introduce single-PWM of_xlate function
Date:   Fri, 23 Apr 2021 16:30:48 -0500
Message-Id: <20210423213048.1370821-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing pxa driver and the upcoming addition of PWM support in the
TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
thereby a need for a of_xlate function with the period as its single
argument.

Introduce a common helper function in the core that can be used as
of_xlate by such drivers and migrate the pxa driver to use this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pwm/core.c    | 24 ++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..25ed23cdf0d3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -176,6 +176,30 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	return pwm;
 }
 
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	/* sanity check driver is single PWM */
+	if (pc->of_pwm_n_cells != 1)
+		return ERR_PTR(-EINVAL);
+
+	/* validate that one cell is specified */
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cfb683827d32..8cd82fb54483 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -148,20 +148,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 	return id ? id->data : NULL;
 }
 
-static struct pwm_device *
-pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(pc, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[0];
-
-	return pwm;
-}
-
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -187,7 +173,7 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pwm->chip.of_xlate = pxa_pwm_of_xlate;
+		pwm->chip.of_xlate = of_pwm_single_xlate;
 		pwm->chip.of_pwm_n_cells = 1;
 	}
 
-- 
2.31.0

