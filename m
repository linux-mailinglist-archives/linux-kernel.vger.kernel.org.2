Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A79451B10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356342AbhKOXtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344197AbhKOTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:24:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BE806347B;
        Mon, 15 Nov 2021 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637002418;
        bh=bBkGjMWZxNSNRLaYykUkU8bSGKS7TUKAE7HXC0Eo9ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVYkCwdqodsThVWzjkT4mz8Z7tJuUbo+LKLYbAhYu0V35W/BBojDEdlqfaHWNSobT
         3Wx3mzHShGck0bPPyJX4sWfJ8LyEh8Mqm5D2ZbYQ+PCWAgtSEev9oOBRuSUFAeOoxP
         bWwZZefiS9418iqnlm59QVIZINnbl9QCsuw2gCK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 526/917] spi: spi-rpc-if: Check return value of rpcif_sw_init()
Date:   Mon, 15 Nov 2021 18:00:21 +0100
Message-Id: <20211115165446.597366441@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 0b0a281ed7001d4c4f4c47bdc84680c4997761ca ]

rpcif_sw_init() can fail so make sure we check the return value
of it and on error exit rpcif_spi_probe() callback with error code.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211025205631.21151-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rpc-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index c53138ce00309..83796a4ead34a 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -139,7 +139,9 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rpc = spi_controller_get_devdata(ctlr);
-	rpcif_sw_init(rpc, parent);
+	error = rpcif_sw_init(rpc, parent);
+	if (error)
+		return error;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.33.0



