Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FB439D22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhJYRMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbhJYRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:11:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C442C061348
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id k11-20020a4aa5cb000000b002b73749f3cdso3886368oom.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGYjCOpl0+eswN9o3EVAbp0e5FxZjoodPge+J7gLiw4=;
        b=JVgdIxy6sniCI1Jza4syS2VrjwpO8z/1jGj1B0vfu6zfWYnWCykxcXA4YAYa8i3frR
         dEaBMgZIcUtIkBZ+DkPGphdyxQw8SPEX6huf0qoWjkGeFqoZpRZ7OvBtzKt4emkkM0dH
         +fFjrHH5IL6AkKiD4LErTOj63Znc4TT4Z3MvFQ7oyA8diRwVggEN9PoTimqN/j+Yf4lp
         FB5chTQ5CLfT20uwQE7VQOT0IIiFrQ9cfNuFlwxCHPsukTVLZpkFY1YDFOhYkUW/a7LP
         ZicYWsTJc03eFTSv7pikefiXahPzjan4v51GlBMlBPBwQ6Yz9OyVi5S1dO0/iel7Rrr+
         s6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGYjCOpl0+eswN9o3EVAbp0e5FxZjoodPge+J7gLiw4=;
        b=epT2463M6aVVr3IQ6HhF8xf0C07LCEvlQAfZFfY00m669vyCfQG6NBOdhYMOzItQ9c
         P+P4RLH1+igMRyB9Ei+JRAZbCWwoui8zOl7D1z+oZJnu3FQKgqpDuQEtM40uEihDmqEa
         FCsuVWJzbg/4JqCAdN+/y4YsrONUhiwgayD0mCh5BtKSXvVtx/8owyi8TEAzAX0kuXnf
         +GY6XjpbTusAKvzemIzXu8vny9CyjgT3JXcO1AP2kDXZ2tK9S2Ey3jez92+/Owhec16i
         Wm321UIBF7jmITrGjAhqYdyJdVqdlK4qzUZqeYh+IHG+3Q7dUGl9CxDUEOvdvOpzij+V
         6RYA==
X-Gm-Message-State: AOAM530L7uW7Pi5b+auR+9Gwt0+eOMhe5gAl7rufQUl8Ur8ZIEek9dlj
        /16mos2EKZCxrfnzI9ratWb3TQ==
X-Google-Smtp-Source: ABdhPJwF78iWwFkA9CuEMKBBAnLBRgaRoiwHCv29CmQ7CbnrCkWmzSL4r14o2hFk5gviC0G9tBHIEA==
X-Received: by 2002:a4a:4fcf:: with SMTP id c198mr13330118oob.26.1635181667796;
        Mon, 25 Oct 2021 10:07:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q2sm3076003ooe.12.2021.10.25.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:07:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v7 1/3] pwm: Introduce single-PWM of_xlate function
Date:   Mon, 25 Oct 2021 10:09:23 -0700
Message-Id: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v6:
- None

 drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 include/linux/pwm.h   |  2 ++
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4527f09a5c50..2c6b155002a2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (pc->of_pwm_n_cells < 1)
+		return ERR_PTR(-EINVAL);
+
+	/* validate that one cell is specified, optionally with flags */
+	if (args->args_count != 1 && args->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a9efdcf839ae..238ec88c130b 100644
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
 	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pc->chip.of_xlate = pxa_pwm_of_xlate;
+		pc->chip.of_xlate = of_pwm_single_xlate;
 		pc->chip.of_pwm_n_cells = 1;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 725c9b784e60..dd51d4931fdc 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -414,6 +414,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-- 
2.29.2

