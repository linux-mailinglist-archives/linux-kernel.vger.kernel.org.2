Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03141FF51
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 05:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhJCDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 23:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJCDFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:05:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC4C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4YvURUzfuR+b0ciJbjJBoAaKlNBhJh9slT7j92oq2ws=; b=wyjSaBqMLdq3AWlScqXPahhc8+
        DJR3rBpOwDkvd5yGt614xQcqLNgeAtcYsuVU4dCWz1X38P/8USRS1P3OK/2lx8uvTUa3ONEjnNhFq
        J/7SefOAPKbf/hJDnz6hDVhCtQc6whfuyNiytwfFVgNym5NuXcsPmIz+7kLdM6FaKgMFhod2Trrnp
        zKSOfIFKf8/tz/pmeihDv1kYMfDzDtRWlK3375hzqkZeZPTLsGdBhs9TF4j180fR8w5iLafccdU6Y
        YkS4obrnIPlxlwD+/9O5yjbYqfc/dGdQUGKCmUHr/IrXlmlzsM8oLSF3XxMYfdu/4rj5RdKbd00ZM
        FML0DFbw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWrnC-0037SG-2t; Sun, 03 Oct 2021 03:03:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: atmel: add COMPILE_TEST for SND_ATMEL_SOC_PDC
Date:   Sat,  2 Oct 2021 20:03:57 -0700
Message-Id: <20211003030357.32456-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert pointed out that since sound/soc has the soc_dummy_driver for
NO_DMA platforms, it is possible (desirable) to have drivers that
depend on HAS_DMA to alternately depend on COMPILE_TEST.

This means that SND_ATMEL_SOC_PDC can depend on HAS_DMA || COMPIE_TEST.

Fixes: 6c5c659dfe3f ("ASoC: atmel: ATMEL drivers don't need HAS_DMA")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211001.orig/sound/soc/atmel/Kconfig
+++ linux-next-20211001/sound/soc/atmel/Kconfig
@@ -11,6 +11,7 @@ if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
 	bool
+	depends on HAS_DMA || COMPILE_TEST
 
 config SND_ATMEL_SOC_DMA
 	bool
