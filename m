Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367B63309AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhCHInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:43:40 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44996 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhCHInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:43:07 -0500
Received: by mail-lj1-f173.google.com with SMTP id r25so14989184ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 00:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dE3BZyNyaZZzuGwy1u0cWYAy4rq3owbLwTAZirSnl1o=;
        b=o5dNFkiHR19uoERyRXa2dPaVb5X0wDVP4X9DTv6Ddc+X/+ZNjEX2YmAHgKHklkR7eN
         st/QcEvCX2R5DM4xEIk3Ge2utoYisIdfcAir7FZ9dJIMDBke9jQAMMBndG5kS/R9Hj0n
         dVytbIGsoM0oJL02I6xzaRh97NuAXWreWOKqzC+xhyG+R81SDlekIAtiJFkFnDKLngls
         JlACClKZDCp+3vL/ZDeWr0cFSj673+8iYoK4T4lvb/+8Gm4b0j7f4qGHd/kswtituOGR
         srpPqDEr1Vj1tw/nSNMREyvVP5Jgbdvtc4EkWVwz1AvIokRe10adV6AEQ/GFxPgBAuv+
         agwQ==
X-Gm-Message-State: AOAM531Sq61QGzcerQo/f7TtdN8qGl0t31VJnIx6yhlKiObLD2ox6s7T
        +rV03nxbirnK0zksp++Ch50=
X-Google-Smtp-Source: ABdhPJweNYoBFV1QwL+7H6cwN1E6/z1tykv1RorGy488Z212TbN6xWWY5SddQnYMpJ1mKOjGwEGrEQ==
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr13430230ljc.175.1615192986287;
        Mon, 08 Mar 2021 00:43:06 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id q14sm1274009lfu.196.2021.03.08.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:43:05 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:43:00 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/8] regulator: qcom_spmi-regulator: Clean-up by using
 managed work init
Message-ID: <6b9bd171e5e48514ba00ddf8cbc4dae72b6f0d47.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

Additionally, this helps avoiding mixing devm and manual resource
management and cleans up a (theoretical?) bug where devm managed
over-current IRQ might schedule a new work item after wq was cleaned
at remove().

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 34 ++++++-------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index e62e1d72d943..c2442d7798ab 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -1842,7 +1843,10 @@ static int spmi_regulator_of_parse(struct device_node *node,
 			return ret;
 		}
 
-		INIT_DELAYED_WORK(&vreg->ocp_work, spmi_regulator_vs_ocp_work);
+		ret = devm_delayed_work_autocancel(dev, &vreg->ocp_work,
+						   spmi_regulator_vs_ocp_work);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2157,10 +2161,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
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
@@ -2203,8 +2205,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		rdev = devm_regulator_register(dev, &vreg->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "failed to register %s\n", name);
-			ret = PTR_ERR(rdev);
-			goto err;
+			return PTR_ERR(rdev);
 		}
 
 		INIT_LIST_HEAD(&vreg->node);
@@ -2212,24 +2213,6 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
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
@@ -2238,7 +2221,6 @@ static struct platform_driver qcom_spmi_regulator_driver = {
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
