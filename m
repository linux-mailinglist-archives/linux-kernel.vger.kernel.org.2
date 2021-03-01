Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659F1329C21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380155AbhCBBss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241515AbhCAT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:26:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48CEC64E22;
        Mon,  1 Mar 2021 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614618601;
        bh=HuvaGODZbp3hurLAhBmhqPUiJR9JIRrXi8xF1vFELTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdRPeAbVU66OgrSDf+zx2NQq39OpZhXyRuu2MHVmhtXDzE/WUs9E+cju2MyQjmvO1
         qjjpCnY69wq+DBl5eHYfdjAcRH+6QL5HGXrcW5kADLOak036FNfTxQELJnQ1+187xe
         3E5ebDl4S5PF1GXJ+fpchRu5iDAsbabWe/JR8Zyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20 ?= 
        <zhouyanjie@wanyeetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 147/663] hwrng: ingenic - Fix a resource leak in an error handling path
Date:   Mon,  1 Mar 2021 17:06:35 +0100
Message-Id: <20210301161149.044384121@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c4ff41b93d1f10d1b8be258c31a0436c5769fc00 ]

In case of error, we should call 'clk_disable_unprepare()' to undo a
previous 'clk_prepare_enable()' call, as already done in the remove
function.

Fixes: 406346d22278 ("hwrng: ingenic - Add hardware TRNG for Ingenic X1830")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/ingenic-trng.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 954a8411d67d2..0eb80f786f4dd 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -113,13 +113,17 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 	ret = hwrng_register(&trng->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register hwrng\n");
-		return ret;
+		goto err_unprepare_clk;
 	}
 
 	platform_set_drvdata(pdev, trng);
 
 	dev_info(&pdev->dev, "Ingenic DTRNG driver registered\n");
 	return 0;
+
+err_unprepare_clk:
+	clk_disable_unprepare(trng->clk);
+	return ret;
 }
 
 static int ingenic_trng_remove(struct platform_device *pdev)
-- 
2.27.0



