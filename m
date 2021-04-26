Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0033036B86B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhDZR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbhDZR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:56:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CCBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:56:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so1396284wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXJyUHWR9e3fNX0FUmU6U772zBN6/EZYEgPq5y0F7sU=;
        b=HmA0y/KfXqh0WR8B+dGX1F1VSvMeL7nN0dlZk81QnwmqqY4JuLYxHmW3x6cpIs/Ykl
         eHnhmBz5M2iVY4eYjA0FlPYL2+0btrgJ3C6d6QI1ZvfwbuFDd1LZ5MHgG9AEv2EQAZnK
         gc7HkrvFAtsj5dyp2xvUIZR9dQDoplELrLIqHbsIy6/cc9d6ibhAV4TaumRCN9Jg+lIi
         RTdcdtIVsBOfeXYYpEXyAe8YMNgrkEmAPbT7LpIbU/sFloriEqIOaDaawA7pgFWahzH4
         rzJqwWLE5pl8vE312f19VAbPCaLHTB94Gd9p58TFMil5kae1aojdRKNtI/5iax6XkIpt
         trnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXJyUHWR9e3fNX0FUmU6U772zBN6/EZYEgPq5y0F7sU=;
        b=NE8DySpMRASTTu2BHO4WnVlpj09dYo2TDGn9QPJO9/gow3abk+FUZtdVdEnglC+fU+
         eIF6DWkSJYK5FZR2sNlb8rJspopYkcMhjkbMRkycyzAVuNv0j//xxPoRPmaaFHdiW8Ns
         uJSxPqbtZJTFPLRN2vpfZKRFsDI+67nOCGjHY6SkQaSTNm3+aqVVa9Oo+icp8zRcvrP3
         /3lWD7i/TmwT9BmzD2Uir12TtT3wl8mjEuxX4M0wW74wADX4rRCJYRdt02zpy50z3qqw
         LpJPmH2GYMDix1Q5KZr6UxooRNuQu2cSHdbhayQ0F2vyx/rst+eMUmlVDthxaG+Lqlkq
         RThg==
X-Gm-Message-State: AOAM533TbezoKNfpCKEDODaTKRNwcwilaV4pfgCPn1tEPn4laNMl2Hli
        iMDLfCeNTaBx/5qJ6qswar+h3w==
X-Google-Smtp-Source: ABdhPJweRkUEYw1DTQ233pzJ6WEIYcpHgNl0NI0BPe1YM+sLl68gqJqGh/27N0p0TvQ9iP5Eb/6ceQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr222855wmk.83.1619459764533;
        Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id l5sm18001806wmh.0.2021.04.26.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:56:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] mmc: meson-gx: also check SD_IO_RW_EXTENDED for scatterlist size alignment
Date:   Mon, 26 Apr 2021 19:55:59 +0200
Message-Id: <20210426175559.3110575-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426175559.3110575-1-narmstrong@baylibre.com>
References: <20210426175559.3110575-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=0iE1gydo5IoVoHEdTGhZZiatpUhZ9Z5MLK2Vn7+Gc1o=; m=v0oQgZ0JKMrLqEjNdBsLtL6pDaOlXk58P1dmCAEdj/4=; p=apUW8R+B7rDuTY8jQzJbY1kUstg02pFzve7cG1Srg0k=; g=120693627996a6c50f2c7d63785a51f2a4a796fe
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCG/pMACgkQd9zb2sjISdHFYQ/9Hil hhEr9y8pHCmwmEbctpy3poQJ04OI8iFGOlMLw6SKvRXTyjh6C0+YuqQFyCSBO797cuHXqDZ6GgasD qzDUgEerAnznpLY/OSJCwLyTDCTxdAFjR9ueDLCFKrIYN+UQC6ZcQlB0yO/opcAPNlhq5r+QZ1XbB MpQUSH6XAzsOnFd+r6Ww4oSAsT1dheDS1BIM1Q1ZbTev36uBuVbFRxrpip6RzGtB/Yrm/t0qRCX2K MUTa5ylDPWthAb4Qw01P84Tkoi3lwXfCPUCSSckQMiYC2G+HSzbijZESXz5FIITebXEep6l2Qu27c m3b2yf2EKIdvdyN9LgrOIAeHjzUcGdAs4zSCABEj9RQMDmbxf0NlX1dG1eWLKdw67kot33GTUmHhG xjBSshBGPCRxVcH05TX8jvNfBWyca1Tj5IxZohUccSpM8dQs7673a20sEBAdw+hxAMMmuTKphZbRS FZ7X4hb4D2nDxEfVUBl7Un92QM+fcsjsbrNnNvTGIp+Ns2pKv1/jxHpwqywkR+ovEz4E5OBgDVzMY RWo1qCx/ICDLJRWnud0I5bAgPk12t/MAHawWZ1IKO5dyq17FyErMVvJ9bkCd7LoA16I3d9gwqsjSm 8DrrqlcrLswi71Pl6eKju1EMwVMMzuCz9srin2aeFp2DI+1jpHe2UTF8KaQKreME=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brcmfmac driver can generate a scatterlist from a skb with each packets
not aligned to the block size. This is not supported by the Amlogic Descriptor
dma engine where each descriptor must match a multiple of the block size.

The sg list is valid, since the sum of the sg buffers is a multiple of the
block size, but we must discard those when in SD_IO_RW_EXTENDED mode since
SDIO block mode can be used under the hood even with data->blocks == 1.

Those transfers are very rare, thus can be replaced by a bounce buffer
without real performance loss.

Fixes: 7412dee9f1fd ("mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 1c61f0f24c09..016a6106151a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -236,7 +236,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	if (host->dram_access_quirk)
 		return;
 
-	if (data->blocks > 1) {
+	/* SD_IO_RW_EXTENDED (CMD53) can also use block mode under the hood */
+	if (data->blocks > 1 || mrq->cmd->opcode == SD_IO_RW_EXTENDED) {
 		/*
 		 * In block mode DMA descriptor format, "length" field indicates
 		 * number of blocks and there is no way to pass DMA size that
-- 
2.25.1

