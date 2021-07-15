Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE643CAC41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhGOTbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243672AbhGOTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:09:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB2461404;
        Thu, 15 Jul 2021 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626375972;
        bh=BbBjFFzx3hsiDDbjqsIrvBKyNqlKdtuOHcXFoZnj/iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtLMCNdrKgIbDpRH61NHlMj2g/1gCjkTkTCzzUGwDWYW9dJz1iDKHPfK1MyhBkDxy
         +m4J3IHsXo+APFcuUHq2vHU89AtIJJYyq6GE9l2jcgKPAjBk3qbHa3im8KTBzLXzmN
         ipY15ATPjmYBqxxcaFfWs1KFSfQ/SBFB+JjDm15k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 031/266] pinctrl: equilibrium: Add missing MODULE_DEVICE_TABLE
Date:   Thu, 15 Jul 2021 20:36:26 +0200
Message-Id: <20210715182619.602039389@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715182613.933608881@linuxfoundation.org>
References: <20210715182613.933608881@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bixuan Cui <cuibixuan@huawei.com>

[ Upstream commit d7f444499d6faf9a6ae3b27ec094109528d2b9a7 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Link: https://lore.kernel.org/r/20210508031502.53637-1-cuibixuan@huawei.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index a194d8089b6f..38cc20fa9d5a 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -939,6 +939,7 @@ static const struct of_device_id eqbr_pinctrl_dt_match[] = {
 	{ .compatible = "intel,lgm-io" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, eqbr_pinctrl_dt_match);
 
 static struct platform_driver eqbr_pinctrl_driver = {
 	.probe	= eqbr_pinctrl_probe,
-- 
2.30.2



