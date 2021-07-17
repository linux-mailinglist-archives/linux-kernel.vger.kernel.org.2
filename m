Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE923CC252
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhGQKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232791AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF440613ED;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=ASkrNuiKvREnI2srww2NLe/CKuKLQYS6oZ5vLC6EqZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeLOuLGvA+F1FgsshH7MX1cQbZwxaMCbKBAkA8P7/Y8gF4WeRexifXQ5cL9sPg0av
         usoKcOvfNoAQ/9Tr5HJ/3Suf5ObEk5XcND9OaAH3S2SAOoa/wBcMeUxl1/4eXnr2WS
         CXaF4p0ZkCuBHAbsxWhGnWlNJu+YbdJ2GKVYWYy0WQ5u17/5djUbjOC6BkHFQu3fuS
         CbgkEqN8OKzQpoEtFqy8N2ABltDXkOcGbhXeZGNH/fEqcPLXMKX2spftcHkXhmUP/m
         DYNm92B1HGVWYuDfg/LtFB+nxZCcY3BWUupFtETyZ/lHF05eyMIUl4hL9zBIjvnYjP
         DavG2L+c4lzug==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007K0-PG; Sat, 17 Jul 2021 11:58:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v14 1/9] staging: hi6421-spmi-pmic: rename spmi_device struct
Date:   Sat, 17 Jul 2021 11:58:12 +0200
Message-Id: <758e98d7f59d739b68b33723a02aca8b9464f8da.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's not call a pointer to spmi_device as pdev, as it is
something else.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 35ef3d4c760b..dd7ff63214d3 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -213,9 +213,9 @@ static const struct regmap_config regmap_config = {
 	.fast_io	= true
 };
 
-static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
+static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct hi6421_spmi_pmic *ddata;
 	unsigned int virq;
@@ -225,7 +225,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	if (!ddata)
 		return -ENOMEM;
 
-	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
+	ddata->regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
 	if (IS_ERR(ddata->regmap))
 		return PTR_ERR(ddata->regmap);
 
@@ -281,9 +281,9 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 		return ret;
 	}
 
-	dev_set_drvdata(&pdev->dev, ddata);
+	dev_set_drvdata(&sdev->dev, ddata);
 
-	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
 				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
 				   NULL, 0, NULL);
 	if (ret < 0)
-- 
2.31.1

