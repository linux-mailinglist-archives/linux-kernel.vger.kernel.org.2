Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C83B3DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFYHsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhFYHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5492061428;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=2vhjiYcekYv+JW0f4M/x8jeeqlFPnpMWrhRu0RrwZzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQ4AoDCHr532Z81eBEUtkZcByWgnaso9uhyiSzFwfnIplnMtBvCaxcIZbXt7KHAG9
         m5Aym91pe79GnW+LylH7gXrq4Nuz1kQg8X2YSb+UEZ+wq61UlAvC2AXc00medjN9Tg
         rsc4HZzRPsIdH/FO+n08RppON/P3g1fo2YA3/m4dQ3GBrdDK3nlQrDNLcAwqwpy/89
         rkDjTPOdzmoCCqUpaIz2nrz9Rc9LdR9e3357BHER/kbi39XpVhKHdcbWU0ZBK9QkJt
         /nFgqlFcJzO8lkwXaLO1KtVmVHlhNQXv5AlmTFa1HDeqV09LDqS9kF+Cu/WZ5SDHJq
         /WUYzIqAdA81w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004aeQ-Fj; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v8 06/12] staging: hi6421-spmi-pmic: better name IRQs
Date:   Fri, 25 Jun 2021 09:45:58 +0200
Message-Id: <327fb075905b889a43a0f9dced29ea9966d611f8.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of naming them as just "hisi", use hi6421v600 to
make it clearer.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 2b55acdaad85..be049a5abbcd 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -145,7 +145,7 @@ static void hi6421_spmi_irq_unmask(struct irq_data *d)
 }
 
 static struct irq_chip hi6421_spmi_pmu_irqchip = {
-	.name		= "hisi-irq",
+	.name		= "hi6421v600-irq",
 	.irq_mask	= hi6421_spmi_irq_mask,
 	.irq_unmask	= hi6421_spmi_irq_unmask,
 	.irq_disable	= hi6421_spmi_irq_mask,
@@ -158,7 +158,7 @@ static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
 	struct hi6421_spmi_pmic *ddata = d->host_data;
 
 	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
-				      handle_simple_irq, "hisi");
+				      handle_simple_irq, "hi6421v600");
 	irq_set_chip_data(virq, ddata);
 	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
-- 
2.31.1

