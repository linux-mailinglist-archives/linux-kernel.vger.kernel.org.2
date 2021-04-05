Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998173541BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhDELnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:43:42 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42601 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhDELnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:43:42 -0400
Received: by mail-lf1-f41.google.com with SMTP id o10so16950442lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 04:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAKBZ2d0Rw/nnDK1i7qAmnSGu+HKQvzyffx872CcExQ=;
        b=XTlgFuhlxZ+4dohYWoOXdKEVC8IdUmGXwWjvuzA+WdqmYxpvsr7VjLD8nRsVI6zAry
         xBLK7YWtdbT1/hABTi2barNcHJNuA9xF3yHJrwfWUkN5dKeZjYgIz/fT/moirfK2cK27
         TflToZT0YRsUgyVg+KLYQvjivmTeIftcxjCWGc05RD6jMm6Q54IJDpWToGXkwVKVBEPv
         SYO5vi4Jsmm90kkLICA+7apDGLIc5PtrfOtsODpUYU9bNVbDCKHQMcVx5E+7lZ0Pdou5
         Uq+IM3v0sMMKa9fgrBehBRgc2xUyOwuGH90qeCOZFiYl02dxGSrKUZGuxtWBpimM4SDg
         yLcg==
X-Gm-Message-State: AOAM530ddv2wOCYHFXO8tlmSewEa7pXAFt88nCDJjG35uUIlUnGzLuiI
        wuiHR755sSuZrzhp6TJ2TCg=
X-Google-Smtp-Source: ABdhPJzHtF8rXe0lkAP9dyqJkGQk6ZhHGPyjA3pF/mXFobGSdcsEcZyFU2+khS52oQMZETFljVPSjQ==
X-Received: by 2002:a19:4c08:: with SMTP id z8mr16693864lfa.157.1617623013837;
        Mon, 05 Apr 2021 04:43:33 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id l15sm1777387ljg.66.2021.04.05.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:43:33 -0700 (PDT)
Date:   Mon, 5 Apr 2021 14:43:26 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/16] regulator: rohm-regulator: linear voltage support
Message-ID: <8a9519e2fb81569c7488737901f0ecab926c658e.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper for obtaining HW-state based DVS voltage levels currently only
works for regulators using linear-ranges. Extend support to regulators with
simple linear mappings and add also proper error path if pickable-ranges
regulators call this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
Changes since v3:
  - No changes
 drivers/regulator/rohm-regulator.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 5c558b153d55..63aabb8c7786 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -22,13 +22,26 @@ static int set_dvs_level(const struct regulator_desc *desc,
 			return ret;
 		return 0;
 	}
-
+	/* If voltage is set to 0 => disable */
 	if (uv == 0) {
 		if (omask)
 			return regmap_update_bits(regmap, oreg, omask, 0);
 	}
+	/* Some setups don't allow setting own voltage but do allow enabling */
+	if (!mask) {
+		if (omask)
+			return regmap_update_bits(regmap, oreg, omask, omask);
+
+		return -EINVAL;
+	}
 	for (i = 0; i < desc->n_voltages; i++) {
-		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		/* NOTE to next hacker - Does not support pickable ranges */
+		if (desc->linear_range_selectors)
+			return -EINVAL;
+		if (desc->n_linear_ranges)
+			ret = regulator_desc_list_voltage_linear_range(desc, i);
+		else
+			ret = regulator_desc_list_voltage_linear(desc, i);
 		if (ret < 0)
 			continue;
 		if (ret == uv) {
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
