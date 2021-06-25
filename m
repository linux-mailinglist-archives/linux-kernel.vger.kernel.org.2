Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764133B3DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFYHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFYHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50C17613C0;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=zCr7xakHM20j5t0qB7rt1N3MWJ4ELpuHzWFgieOCIbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=new0Vv6Pz1K5A7hRfSwlIQnMARbTBTypdGwWhgzFO9NZ2e0SMHx+o3gaQw372ONA/
         R+capB3W5F1GbbXJ99s5hjKh72OCHKcsAkQlKnny7OOPeWDYZMOfJH6hM0oPIRY3lE
         ZTyBbOvbzQL10CDaFmzxsue+4pN60BgJdaDpxu5MXdZrhMqNMq8y+4Sf7e/xLEUmoG
         vM4guCUPyyLVQTLj7vLZ4KEO/qZxNPV1I5h6SgKTqQD8DfL1vKbaj74Qdfp1q7wZNO
         SrZFsH0qIujo9QaUElE5w+L0RJR+HvigRQx5tVv9qNfU4DjlvoR9CEI8vemanarVKY
         q9lppC7UAflHQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004aeM-Eo; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v8 05/12] staging: hi6421-spmi-pmic: use devm_request_threaded_irq()
Date:   Fri, 25 Jun 2021 09:45:57 +0200
Message-Id: <b47827c3466eeef3a7de6ac56b1fe93b5ff84e30.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_request_threaded_irq() in order to simplify the
driver.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 29ac53684ad2..2b55acdaad85 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -250,9 +250,11 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 		ddata->irqs[i] = virq;
 	}
 
-	ret = request_threaded_irq(ddata->irq, hi6421_spmi_irq_handler, NULL,
-				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
-				   "pmic", ddata);
+	ret = devm_request_threaded_irq(dev,
+					ddata->irq, hi6421_spmi_irq_handler,
+					NULL,
+				        IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
+				        "pmic", ddata);
 	if (ret < 0) {
 		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
 			ret);
@@ -270,13 +272,6 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	return ret;
 }
 
-static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
-{
-	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
-
-	free_irq(ddata->irq, ddata);
-}
-
 static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "hisilicon,hi6421-spmi" },
 	{ }
@@ -289,7 +284,6 @@ static struct spmi_driver hi6421_spmi_pmic_driver = {
 		.of_match_table = pmic_spmi_id_table,
 	},
 	.probe	= hi6421_spmi_pmic_probe,
-	.remove	= hi6421_spmi_pmic_remove,
 };
 module_spmi_driver(hi6421_spmi_pmic_driver);
 
-- 
2.31.1

