Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F00438855
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJXKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJXKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:36:13 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494FC061348
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:33:53 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id s136so2312027vks.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=/aYNmBhOsLowuk15bZQ2XtTVmZBS0SEagXWIBEMDC7M=;
        b=x6+ZqtTKK7odxsvzlhnmqf+rwhYwtvry3aGMDJJ1YuoVa+qsplCT+uWOeLa732U8Y+
         mhX5HF61cUUYwxz8BdwZEvLCRq/LSlNYApYeC2c2ZQQ7ShMj2uGD5Kj0NdksS7DnAJCz
         4SwJsuMjP86EtoigMSIxPhFBE/Us67eSYHi71mpLQQz78yZK9y4CTQ3PGa0WmeSI4rsA
         9pyL1svkfjhIUdNLs34TT4YeNs8TARrMuN9EXjgAoqpP4nSogpcQuDIo8zkdI06waU6f
         rhPLEeXqxMT39NP6nzoIDisz5BAqg6TIy3RaFev/y/0U5+K2pktuelgGJR1rQQ55HXod
         fWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=/aYNmBhOsLowuk15bZQ2XtTVmZBS0SEagXWIBEMDC7M=;
        b=T8pMfNWT3JtDpoqGeUgVY10E0B0P978lxLpCSl7fpe2zfo1mUhz0lFIjhwAfBh9FHx
         5rWaCCxIG00JWJQZYcOpGxMhKE37aug40TIfe3VhvdEdFt1EJ+By0R0iAH103C4isIY8
         /NuvUjlF6wEITEf0/Krcu0tKmH3nZF0JVsIbhZih+lBw2GuVzJ7isqYthAG/dDWfBHvy
         mJsLn6f1S10L/f9f1INKeNOhluPXB1bn594kEnGf5XNj8btYTUJKSdfbEBrJGe/3hIvO
         vRtjIa6Rri6d9UTggGJXHOTU7kLvUnWC1HqvXId6u6ltkPE82ecr8Loi5TDp8pyiAIc5
         pNeg==
X-Gm-Message-State: AOAM532dZv0jv38mYUebbbd4WIjz0YQpNlAaJllP4HhzMqFF78oXkokw
        cV6SZ3yvRZ+PWzwhQ0pMWzl+KQ==
X-Google-Smtp-Source: ABdhPJyER3HeBarSA6Waz3h6Yrn+767lHJpaZZISJJLgo+xlDPElIq+/KAN4N2HcOJYIH0aCsL+X8A==
X-Received: by 2002:a05:6122:788:: with SMTP id k8mr10207633vkr.8.1635071632144;
        Sun, 24 Oct 2021 03:33:52 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id p6sm8139712vko.16.2021.10.24.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 03:33:51 -0700 (PDT)
Date:   Sun, 24 Oct 2021 07:33:47 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <YXU2i0FtAGDRCMSu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
replace it for the atomic PWM API.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2: Assign variables directly and simplify conditional statement
V2 -> V3: Fix declaration of undeclared variable
---
 drivers/media/rc/pwm-ir-tx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 4bc28d2c9cc9..e1f348a962e8 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -53,22 +53,21 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 {
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
-	int i, duty, period;
+	struct pwm_state state;
+	int i;
 	ktime_t edge;
 	long delta;
 
-	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
-	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
+	pwm_init_state(pwm, &state);
 
-	pwm_config(pwm, duty, period);
+	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
+	state.duty_cycle = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * state.period, 100);
 
 	edge = ktime_get();
 
 	for (i = 0; i < count; i++) {
-		if (i % 2) // space
-			pwm_disable(pwm);
-		else
-			pwm_enable(pwm);
+		state.enabled = !(i % 2);
+		pwm_apply_state(pwm, &state);
 
 		edge = ktime_add_us(edge, txbuf[i]);
 		delta = ktime_us_delta(edge, ktime_get());
@@ -76,7 +75,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 			usleep_range(delta, delta + 10);
 	}
 
-	pwm_disable(pwm);
+	state.enabled = false;
+	pwm_apply_state(pwm, &state);
 
 	return count;
 }
-- 
2.31.1

