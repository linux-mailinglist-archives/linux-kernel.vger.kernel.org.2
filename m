Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B85308DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhA2Twr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhA2Twp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:52:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43F7764E10;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=JjIVgD2n/2qhJvQ6jOkaqibRKf9I32u+HalSwJuZenc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNXwJIk4FDUpXTlnDx1mSiIIkUJnN9IMP1VQKOOrL7Zptpj336C8rL4scnpAZqv2a
         AZ01lGha268vHcql12bUZEN528kKR6urA+zNRxT90ed0MokN/SV8Z1L+u6UtkEiPP1
         JFIda/ixBDAtKzyeD31YWPvmmFZ9mFFZjDj4yWWYGYc34N1zrTVY5pPHxgFnzkEkFZ
         bBengVMlnJsGSTEcwOHADRNsUHMKoik3gtdzkCzuhycrCG049iQIdPv36WtOpEn7MB
         7OsaG8VBggQSxxDL95u+9SHSPLXHwCSlkvD3GjAShqWT0bDU6nCkJ9CjebVW7EzvXR
         CNQ1JOOa4z3pw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wjm-3f; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/14] staging: hikey9xx: hi6421-spmi-pmic: fix IRQ handler code
Date:   Fri, 29 Jan 2021 20:51:52 +0100
Message-Id: <2eae710c333a8ee6f9e0a086c84115bc90a782ca.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to regmap introduced a regression at the code
which reads from the IRQ register. Address that.

Fixes: 8148fe6afb24 ("staging: hikey9xx: spmi driver: convert to regmap")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 909f7b106af4..48e4f92f7d1e 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -66,7 +66,7 @@ static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
 	int i, offset;
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
-		regmap_read(ddata->regmap, offset, &data);
+		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &data);
 		data &= HISI_MASK_FIELD;
 		if (data != 0)
 			pr_debug("data[%d]=0x%d\n\r", i, data);
-- 
2.29.2

