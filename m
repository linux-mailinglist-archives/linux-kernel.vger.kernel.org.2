Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F0444756
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCRkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKCRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:40:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F29C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:38:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w29-20020a056830411d00b0055abaca9349so4474094ott.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=KNIg2kQ3uZauu+dnwK3HwVUo4epk3uh+4Ru2o+wrxl0=;
        b=ILGjE1hgsxqN3af/0WC7REvDKgUS7+6LqX6lOkbSBAzASsdyW8wbRImU0SNUwB48Nc
         UW6KiJ1e0JCzGrLJAm7s6Lcl5AWZoMzgIP6wE38AC4mw+sV/R5PDAcvltRJ6jH/dF3xo
         wRC7HScW0cjAz9xgavhgDhIoNYFnQg4z3q+suYLGj8tfqJdROD1MSSkMM33ig/8XpPjw
         lTlJtkgar8mgjyJdvjTp1i6eRs/WbVekjEg2Qa6VYOpmHyxHvvoeCoGI7JmOKm0N35g7
         CoDS1jynUT7ELatCQK+qEGU0rytOyhZIoxFKbYfvqNlgGEEdiKyr1CCm/mYaXKEHGVXa
         ZZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=KNIg2kQ3uZauu+dnwK3HwVUo4epk3uh+4Ru2o+wrxl0=;
        b=Qa8JPtDTYFL7mnh6UhkoUUaJSHMBmZL7Ubw+pIMJ4ZMS0N5S/okGjqYTowVj8s8T/O
         nZv0aVoCqNfmHJiXb5+9HVoJ+qWHYkByWz0aL9mbNRFxfFEWeFfQcuFpaY7mZevF21YB
         U3d/zg80w5DmV7x3k3p57uCwbkz96C5vC9Nv995DW9/Q7UZqNFbOYTxiqvLhK0rqL7zD
         RmhtJKx5x1G1ZbRqL3ugtoamXHvWIuBAJsA00oLzedKb1rrJolt1Q2rN6bsYoD/Vl57s
         pLx2CpawtIemSXxxC2CDCpTg3rA0cnB9OfwOkkUe3os8AfedvW+n97aSO0KAAUF+x1bz
         CRVA==
X-Gm-Message-State: AOAM530QWP9VtCw1qetz3Qu0k7xRusDpUlwrPBCHfLSIcCZjaQIEi518
        zPG8yxLV+T3UeYWhxMH7ekkFrQ==
X-Google-Smtp-Source: ABdhPJwMefisJ6fYt8/aFM7zFKH09aYePVgs7ob6+8bNCxPG+kXZp8UpPBPULcCTaQBjsUg8VtkQsQ==
X-Received: by 2002:a05:6830:1e42:: with SMTP id e2mr33459329otj.41.1635961092162;
        Wed, 03 Nov 2021 10:38:12 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id d7sm669920otl.19.2021.11.03.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:38:11 -0700 (PDT)
Date:   Wed, 3 Nov 2021 14:38:05 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     daniel.thompson@linaro.org, lee.jones@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v5] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YYLI/b7KcqM8wcEB@fedora>
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
V1 -> V2: Initialize variable and simplify conditional loop
V2 -> V3: Fix assignment of NULL variable
V3 -> V4: Replace division for pwm_set_relative_duty_cycle
V4 -> V5: Fix overwrite of state.period
---
 drivers/video/backlight/lp855x_bl.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..e70a7b72dcf3 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -245,18 +244,16 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 
 		lp->pwm = pwm;
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pwm);
+		pwm_init_state(lp->pwm, &state);
+		state.period = lp->pdata->period_ns;
+	} else {
+		pwm_get_state(lp->pwm, &state);
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	pwm_set_relative_duty_cycle(&state, br, max_br);
+	state.enabled = state.duty_cycle;
+
+	pwm_apply_state(lp->pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

