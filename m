Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8ED343AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCVHin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:38:43 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44681 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:38:29 -0400
Received: by mail-lf1-f51.google.com with SMTP id b83so19664091lfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dE3BZyNyaZZzuGwy1u0cWYAy4rq3owbLwTAZirSnl1o=;
        b=Xc4jnbcKJjyXB7DdCPzeyOCPBp5DYCWKCLbe5W2z8hUBCxFFtPjb6uo+ZrsqhV7XdJ
         jp8AIGrKWAErnKKDwHVq2mCVmZp0keWt6+vmzboF+pJyAAL0qpc+3OgvJEwmUGU7h/sQ
         RRGlBhssbtXO4gHv10XBIadYAzSLenWu7E5Y9sW0nJ9QfMsLprH7fRxhkxllDyP6weDz
         EsmLbp7BdcVi6KxG0adqDwyddPHr0vGqsA10O70SpPkDHa4Ht4tJc/kztXw3dETaoGM8
         GWU/E5raPAs4Mb5lrol1vPv1dXnRFovk1t/BPD29pbIDtpTJAyii7oQ+PxWTPp3//pd3
         uDjg==
X-Gm-Message-State: AOAM530geLeM55hd1Jk8x4E5P5alUkR7V+jZa3Asa8zo+3CYRS68CNwD
        rumQs2uSSd1hUsxCJTPDImw=
X-Google-Smtp-Source: ABdhPJw3Dwd+W855YgILWTJ0REr6P/+Zedu1rp2DOuWUlpo6lVVivlkt9nNh9vlGCv0SI05lkjelCA==
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr8161099lfe.637.1616398707645;
        Mon, 22 Mar 2021 00:38:27 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id 10sm737832lfg.157.2021.03.22.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:38:27 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:38:21 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [RFC RESEND PATCH v2 7/8] regulator: qcom_spmi-regulator: Clean-up
 by using managed work init
Message-ID: <16909efd87d148ec8eab64b7ccd719d0f2d4d9d3.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
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
