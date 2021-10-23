Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24754438472
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJWRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 13:25:12 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A3C061766
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 10:22:52 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id o42so3047429vkf.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=rMMU716GHaoZLnC/TrOOrmJ3Av0qZgKqAsVGe14mcag=;
        b=bAv3xltdUqbZyU8Kzryk8qKpkotV9oeeMBx+cnvkvN7Cw01yCzYij9vS3OvxGlnd1v
         fpsfmSjzAUrHs8nxOTCt00PteFGvpUP3gAAR8uf1RA1wgEfT9V8KQUNAQPq3in3iB6b6
         S334UaGjRmGOZc1jQgnGTXDWYP9RtkdbV7jfs4p/berbo516+3MRPw8CFUp57JJ3OL4Y
         T6dHhmHXNHlhsKZoWhHvzjZW2vOs8RaVW54+qSSjnoxj8tFPec/8e2BBlGzcsMj8u8Jx
         oGmPdVGCX8xmr0tTptOWCEc6ZOjViAxOCscvU7Br8SDjbbwCTBGGwhZMxL9wAT2VvQ0n
         kVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=rMMU716GHaoZLnC/TrOOrmJ3Av0qZgKqAsVGe14mcag=;
        b=g+sBHekMP/vPtmSM4aOS73C+jV4ZsZh2uCF80OcrntI9l+7c873AvgYrwsfNbc+NLX
         iZ++Tt5zPGlKZMEAYMBe1lIt622OdDwmWH9mu6aKdtHiXYnpKJbmnZQ7SNUVcShEk3vl
         TZ64MjHwZ9mH7kZpuY2+R0G1gCheIzEvfdBE16cIlwtJE4MttCfPGdZNaX7ieigVZGR6
         HtHpm3OigiUCvKMP2lic79vSQyBWWFWRkgjhwhxhWPrHIG0nPAmdCTlgP8oHAK0tuGaE
         zrFZ2lxyY4H4xwUEW4HRX1w7bOk9sKM69UtN72wqhPpO6oUVG9NSXluNJi3Yj0G/yRBs
         11iA==
X-Gm-Message-State: AOAM530l1vOytAKB+vbZpfA0W7UrJC77jvskO0qNV6NBx1gQwR4s5UeG
        zrJ71t6Z2ebawbXEv+0eEWM3Eg==
X-Google-Smtp-Source: ABdhPJw/C1xhXJrEAJ5OWeTNzehQlHscq3WksOAKtmNhk+98p5bbKN7O/PdxChrEdify7qToG4Gsow==
X-Received: by 2002:a1f:2345:: with SMTP id j66mr7213989vkj.20.1635009771812;
        Sat, 23 Oct 2021 10:22:51 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id s188sm7130900vkg.9.2021.10.23.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 10:22:51 -0700 (PDT)
Date:   Sat, 23 Oct 2021 14:22:46 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <YXRE5i9xXpwSjicO@fedora>
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
 drivers/media/rc/pwm-ir-tx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 4bc28d2c9cc9..dfaa6125991e 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -53,6 +53,7 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 {
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
+	struct pwm_state state;
 	int i, duty, period;
 	ktime_t edge;
 	long delta;
@@ -60,15 +61,19 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
 	duty = DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
 
-	pwm_config(pwm, duty, period);
+	pwm_init_state(pwm, &state);
+
+	state.duty_cycle = duty;
+	state.period = period;
 
 	edge = ktime_get();
 
 	for (i = 0; i < count; i++) {
 		if (i % 2) // space
-			pwm_disable(pwm);
+			state.enabled = false;
 		else
-			pwm_enable(pwm);
+			state.enabled = true;
+		pwm_apply_state(pwm, &state);
 
 		edge = ktime_add_us(edge, txbuf[i]);
 		delta = ktime_us_delta(edge, ktime_get());
@@ -76,7 +81,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 			usleep_range(delta, delta + 10);
 	}
 
-	pwm_disable(pwm);
+	state.enabled = false;
+	pwm_apply_state(pwm, &state);
 
 	return count;
 }
-- 
2.31.1

