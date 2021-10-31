Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F644112A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhJaWS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJaWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 18:18:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4BC061746
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 15:15:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y128so22325602oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=ahrGibv35CkHD9QWEzZtWa48R45ATn0IgOuUT3/eqfc=;
        b=I97gDV02HD9z6GNpcuq/68Jzcnb6HUZMpT2BHnkvVS2hCs6TQ5wI/3DqovKI5s0F6c
         qaHJ511JfWKPTjlsa86DzzY5cC7l4wVwCMS+YimfISlURspDxFXeITLRpTtNfDsadZmr
         2/HJXF55Pk2j9q3S8FwUyZOvldfHEfLHZtMd9AZ0G+Skh074cy3aj8+aR85BwbqurUXd
         J40XnlJFctPQ7OEGYmwoYIYRj1ari1zBmwGGuH2YgOBYaAW/CuN4wvwzQOyavsc0lhsX
         FrSnmwpJ4zh04Uj6GYxuvyzvSue1FGS08CcTYXiNljc2UxWEI5o1epM6OP8MlcdlY7If
         4sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ahrGibv35CkHD9QWEzZtWa48R45ATn0IgOuUT3/eqfc=;
        b=6cdmrs3UephyjVnfOfhUJCKj2SzajZDALTrvHGpxXFr8Mis7sIx1PpR/EZz1rXav4F
         Cv7Q7Z4Y8SmsrZ2H0bMjjy/nJGlL4j9hlpd3o0RVYofyI4zelN/iGwug7ma/ALq/vKNm
         RqU8jggnVTnSculI9jltNQRm1RhaF/lSHROT/aeO5Mhq2i6GTHD212xC+zOgBMbSQqah
         CtEuyNc3ch7QO3WmQ6v/8a73CFXov1BBcohjpndevkYIZc1neP9oZOLpNJ9/u8knaJx6
         cUn5t9kdCJa5TkRljKRsHXqZCKW5+25BcbY6Si7yKIv67/KBQn3gZxUFODs5uc+nS4aA
         10cw==
X-Gm-Message-State: AOAM532jahs5qEmh10CFbWBCaryGeINDLzJLQV2JaWL4Ao+04gc2arQC
        RM6CQQIQ8ni/gPvr0HtsuOSOGw==
X-Google-Smtp-Source: ABdhPJxVS6VRoBWILO8RW1vB7P3ZlBMpyFzv8jVuUfrkUchFBWjd2yPxep/8okvJ3Hzbsnwz4weiTw==
X-Received: by 2002:a05:6808:1996:: with SMTP id bj22mr2448052oib.69.1635718551756;
        Sun, 31 Oct 2021 15:15:51 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id l27sm1066967oof.18.2021.10.31.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 15:15:51 -0700 (PDT)
Date:   Sun, 31 Oct 2021 19:15:45 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2] media: ir-rx51: Switch to atomic PWM API
Message-ID: <YX8VkdCAe6coHC4w@fedora>
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
V1 -> V2: remove conceptually wrong chunk of code and correct the position
of pwm_init_state function
---
 drivers/media/rc/ir-rx51.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index a0d9c02a7588..41d4a4338072 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -19,6 +19,7 @@
 struct ir_rx51 {
 	struct rc_dev *rcdev;
 	struct pwm_device *pwm;
+	struct pwm_state *state;
 	struct hrtimer timer;
 	struct device	     *dev;
 	wait_queue_head_t     wqueue;
@@ -32,22 +33,22 @@ struct ir_rx51 {
 
 static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
 {
-	pwm_enable(ir_rx51->pwm);
+	ir_rx51->state->enabled = true;
+	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
 }
 
 static inline void ir_rx51_off(struct ir_rx51 *ir_rx51)
 {
-	pwm_disable(ir_rx51->pwm);
+	ir_rx51->state->enabled = false;
+	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
 }
 
 static int init_timing_params(struct ir_rx51 *ir_rx51)
 {
-	struct pwm_device *pwm = ir_rx51->pwm;
-	int duty, period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
+	struct pwm_state *state = ir_rx51->state;
 
-	duty = DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
-
-	pwm_config(pwm, duty, period);
+	state->period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
+	pwm_set_relative_duty_cycle(state, ir_rx51->duty_cycle, 100);
 
 	return 0;
 }
@@ -242,6 +243,7 @@ static int ir_rx51_probe(struct platform_device *dev)
 
 	/* Use default, in case userspace does not set the carrier */
 	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
+	pwm_init_state(pwm, ir_rx51.state);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.31.1

