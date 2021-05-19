Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4238991F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhESWNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhESWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:13:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56336C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:12:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 131so17366713ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1Qv2MvucSKULr9M7UG8jApluLlWKnFowTxMZxCpSUA=;
        b=WwuqTrtEgzWUUtXGNku/04BrygQ2rlNC4zWm7Zi3O8ZTR3SwOG6rJf6SBB2AlegZ44
         jJfENYxxC4ovGFPQXv9XtbCJwAysb2VDtjgojE+BRJ5lMprjRnnv6gZZ9lNC32V65yC4
         o7tcaUlkri2DcFL4H8QDjOQYVAoHf47ArtxpMqjMXLoMe8ycl53++IO4YYpA143bxUfX
         Z1fYSHCfOX05uQpMP9jVUTuUHyM0qoWP3bNPAe2ucB1503+qYppJ6+bKpNkLlwTxT8tF
         m4GcOFKKOTWmF+BpJfZgp+laL6vKkevnFibc8bajydb3SIoB2kYHtUGLGZ0VJFH2Rh8M
         BfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1Qv2MvucSKULr9M7UG8jApluLlWKnFowTxMZxCpSUA=;
        b=SbGtMblWjxt6NRcKdNKQXUJQpNO9wAVlnx7SfCuqoJvGLvX4G6H/DKOY6ZOtcAHde1
         ER0VBQkT92FzdWwGY9KAHkB7VGjlBGUc0Y5XO1YFusXTvG9Jebq4ISaZf8ZtL51d0oX9
         IUQsqkUemqjm4LZGGyvvEa2bWfEOQSRuUmd2eygbg7NBCU5PBuk/ajp2NWl+IKafebwT
         GFE7F5y2PM6opUu2i2XFlSYf35Kp7AiEvQGBV3kl/X2ItU5KatKhJwFRoItIgqcqgNRP
         3ftBGSTqq2Qt5ytEBDlL4BITEuzdDgL7ORW6e4JizwHJHPxoIVcDyZMtQlBAHiXtywiV
         IwHg==
X-Gm-Message-State: AOAM531mnbaHujt0p7tp9SbtZYU+T015IHrdJfHR29lxynVwhBBl1TaS
        W4InRZQ+pO50bWdEILn2Taj62w==
X-Google-Smtp-Source: ABdhPJxTi14Q+hHW2JGpBXRMrPylPYezPq/GUWMALGA0Y2O6OBq/D29XnGS6KjvdPFwbqJVYw30wkQ==
X-Received: by 2002:a2e:7f16:: with SMTP id a22mr925429ljd.360.1621462345617;
        Wed, 19 May 2021 15:12:25 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16sm97512lfl.83.2021.05.19.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:12:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: core: resolve supply for boot-on/always-on regulators
Date:   Thu, 20 May 2021 01:12:23 +0300
Message-Id: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the boot-on/always-on regulators the set_machine_constrainst() is
called before resolving rdev->supply. Thus the code would try to enable
rdev before enabling supplying regulator. Enforce resolving supply
regulator before enabling rdev.

Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f192bf19492e..e20e77e4c159 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1425,6 +1425,12 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		/* If we want to enable this regulator, make sure that we know
+		 * the supplying regulator.
+		 */
+		if (rdev->supply_name && !rdev->supply)
+			return -EPROBE_DEFER;
+
 		if (rdev->supply) {
 			ret = regulator_enable(rdev->supply);
 			if (ret < 0) {
-- 
2.30.2

