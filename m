Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516F378B59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbhEJMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236345AbhEJLHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DD856197F;
        Mon, 10 May 2021 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620644420;
        bh=LWT9aXhvCqmJxlUsQyk4qpfL2JJt2Ob3IWUQnXC0seI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqlP6W6X5QADWZp+SEolpEk9B1qC5gAnhZ4ntJFPmVexYeaqzzVfbQ1r7XZRMY4qo
         eFW0AImSOAACDP74hIE1asZ72naDXGRDrFQ7xGYideSoDMMNU7WEHekPga6FKD9UWj
         aTe/3fpwSXu0TBBXEL+lxyy2A9A1Syp3V5bSA9p0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.12 040/384] mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
Date:   Mon, 10 May 2021 12:17:09 +0200
Message-Id: <20210510102016.191364968@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510102014.849075526@linuxfoundation.org>
References: <20210510102014.849075526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit b03aec1c1f337dfdae44cdb0645ecac34208ae0a upstream.

A 'uniphier_sd_clk_enable()' call should be balanced by a corresponding
'uniphier_sd_clk_disable()' call.
This is done in the remove function, but not in the error handling path of
the probe.

Add the missing call.

Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20210220142935.918554-1-christophe.jaillet@wanadoo.fr
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/uniphier-sd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -635,7 +635,7 @@ static int uniphier_sd_probe(struct plat
 
 	ret = tmio_mmc_host_probe(host);
 	if (ret)
-		goto free_host;
+		goto disable_clk;
 
 	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
 			       dev_name(dev), host);
@@ -646,6 +646,8 @@ static int uniphier_sd_probe(struct plat
 
 remove_host:
 	tmio_mmc_host_remove(host);
+disable_clk:
+	uniphier_sd_clk_disable(host);
 free_host:
 	tmio_mmc_host_free(host);
 


