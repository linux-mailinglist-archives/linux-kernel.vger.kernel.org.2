Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4807F34D0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhC2M6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:58:38 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38873 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhC2M6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:58:11 -0400
Received: by mail-lj1-f172.google.com with SMTP id s17so15810634ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 05:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8n7+of59fd+4os1tsFEU9y5dzWtBkQ3BQECWSWuwZU=;
        b=Pk0dV345TQJBLhKp2MiVU3srQOc7KjaxPS6lGZfw0rUY/xU6f50bakq+iDf8/7pxwa
         7S1W0Ls0R/DvrknybMcAAdymKBZkx8XcvEOEA58nYmXrHFhKDvhmGGOwjZPQ6AVZJr/x
         KXZFvDm5631nhvcvrIVPl3/zf6dTb0GRGnkxap2eYgYo8fR2wcXh/2eAfv16/x82oQxQ
         0SeGfLtbtPmmhDAG4dJFgrn1gmo3Hx+Qekh3JGOs9fBwLujQly8RVRr3N3OemzdEtKN6
         ++RcKQDwho5roW6WvPlA9QVKK0bLmH5+sKioqfP965NUVyoL0oJ1wpJXgGcxTu9Eoe3C
         I3Eg==
X-Gm-Message-State: AOAM532kh53Qn3lotR7oo9LwdBikO4OM6SC6ZCCx1/iOz0Vns6GG6KMv
        N8iGFDmzXdpvUD3pBrn5U+I=
X-Google-Smtp-Source: ABdhPJyU2HpdgBOxZFc4xJWrdvqL/+Yuvm+12XXZiYALdiqk/vsmsS6GQf3okGgTeXOWpO08ZgxDfA==
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr17554260ljk.384.1617022690200;
        Mon, 29 Mar 2021 05:58:10 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id a30sm1831103lfi.202.2021.03.29.05.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:58:09 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:58:03 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/19] regulator: rohm-regulator: linear voltage support
Message-ID: <de0516571f78ceded6ca18873a96b7d95008ede1.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper for obtaining HW-state based DVS voltage levels currently only
works for regulators using linear-ranges. Extend support to regulators with
simple linear mappings and add also proper error path if pickable-ranges
regulators call this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
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
