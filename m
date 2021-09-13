Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE840900B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbhIMNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241355AbhIMNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB6B061414;
        Mon, 13 Sep 2021 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631539832;
        bh=6jWX9ignM5vZQBV3AXjs5PVBKQL7FqEl6BRITeAkCuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbeuH/1UirNGdGMzvBG+FCST+D2MgyOB8OGaTuUp7g6VhJzjaFGfVR9McrpmW8k2W
         xqxoYcSBvLxAJ0y9DVsQUA0Y5ieDaZ5gTBqBFYj9zrgijyHhRH9gYHhOSzBicPfepP
         L66RybuFFd2xImi0nSU7pfPbeVeWmts5j54c6fs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 179/236] i2c: hix5hd2: fix IRQ check
Date:   Mon, 13 Sep 2021 15:14:44 +0200
Message-Id: <20210913131106.455278615@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913131100.316353015@linuxfoundation.org>
References: <20210913131100.316353015@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit f9b459c2ba5edfe247e86b45ad5dea8da542f3ea ]

Iff platform_get_irq() returns 0, the driver's probe() method will return 0
early (as if the method's call was successful).  Let's consider IRQ0 valid
for simplicity -- devm_request_irq() can always override that decision...

Fixes: 15ef27756b23 ("i2c: hix5hd2: add i2c controller driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index c45f226c2b85..8993534bc510 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -413,7 +413,7 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return irq;
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.30.2



