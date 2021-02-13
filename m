Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBCD31AB40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBMMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:17:15 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40653 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhBMMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:17:11 -0500
Received: by mail-lf1-f52.google.com with SMTP id v24so3309486lfr.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 04:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ts9z6i2Vd+2GEZSPALZGbWQRGVWyFJsdyBZA/pMfoyA=;
        b=NQ1qSU1w8bdwoCCx7JKoyDEicIZrt4+0SGBHpqZhhdsGhooK7FXELN7g2sX6YVh35t
         lFnkOp36hBiPM83DVPoeN761PcH5iXcc4YFNYZrfGo9+QdZajz4kpr1zIi5c24pKL9HM
         eaOMxqm0r2BU2CApPBmqzadz+Q9VijkxkbiTqB6fTcXuJP7ggR/ZdjUhSek7vzvHfDwJ
         XuvgRWikOa0hOm1s9XR+Qa6ZBYD7lit9SjZpCjYXsSsGYbKoGlp11c42vCtr2eax8nfr
         FJryIeMrGl5qR7tKCuWMRTHaW9PivVHOituoGqscty8Vd/uWm3OdqwSYnYyEECrtVrz+
         vDuQ==
X-Gm-Message-State: AOAM531vCvAUgZIDvJ9DOOI40Ziua4XwLdVQrpO5o2kTM+TpRog1uJQK
        jEsTfyjAIyEuwQiJ0mRn4qo=
X-Google-Smtp-Source: ABdhPJweKBwTGCyFjE3vhDeYFSoLEtwohWLK03qNhYcwEmySoDgsIMEdTwsL8Y2CYH714uXN6j4/Fg==
X-Received: by 2002:ac2:58fb:: with SMTP id v27mr3852603lfo.371.1613218588424;
        Sat, 13 Feb 2021 04:16:28 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id y22sm1853210lfl.286.2021.02.13.04.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 04:16:28 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:16:22 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] regulator: qcom_spmi-regulator: Clean-up by using
 managed work init
Message-ID: <19ac678889cac174895b5080321c84ea2c26f530.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 33 ++++++-------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index e62e1d72d943..68aefffc235f 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1842,7 +1842,10 @@ static int spmi_regulator_of_parse(struct device_node *node,
 			return ret;
 		}
 
-		INIT_DELAYED_WORK(&vreg->ocp_work, spmi_regulator_vs_ocp_work);
+		ret = devm_delayed_work_autocancel(dev, &vreg->ocp_work,
+						   spmi_regulator_vs_ocp_work);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2157,10 +2160,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		vreg->regmap = regmap;
 		if (reg->ocp) {
 			vreg->ocp_irq = platform_get_irq_byname(pdev, reg->ocp);
-			if (vreg->ocp_irq < 0) {
-				ret = vreg->ocp_irq;
-				goto err;
-			}
+			if (vreg->ocp_irq < 0)
+				return vreg->ocp_irq;
 		}
 		vreg->desc.id = -1;
 		vreg->desc.owner = THIS_MODULE;
@@ -2203,8 +2204,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		rdev = devm_regulator_register(dev, &vreg->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "failed to register %s\n", name);
-			ret = PTR_ERR(rdev);
-			goto err;
+			return PTR_ERR(rdev);
 		}
 
 		INIT_LIST_HEAD(&vreg->node);
@@ -2212,24 +2212,6 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err:
-	list_for_each_entry(vreg, vreg_list, node)
-		if (vreg->ocp_irq)
-			cancel_delayed_work_sync(&vreg->ocp_work);
-	return ret;
-}
-
-static int qcom_spmi_regulator_remove(struct platform_device *pdev)
-{
-	struct spmi_regulator *vreg;
-	struct list_head *vreg_list = platform_get_drvdata(pdev);
-
-	list_for_each_entry(vreg, vreg_list, node)
-		if (vreg->ocp_irq)
-			cancel_delayed_work_sync(&vreg->ocp_work);
-
-	return 0;
 }
 
 static struct platform_driver qcom_spmi_regulator_driver = {
@@ -2238,7 +2220,6 @@ static struct platform_driver qcom_spmi_regulator_driver = {
 		.of_match_table = qcom_spmi_regulator_match,
 	},
 	.probe		= qcom_spmi_regulator_probe,
-	.remove		= qcom_spmi_regulator_remove,
 };
 module_platform_driver(qcom_spmi_regulator_driver);
 
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
