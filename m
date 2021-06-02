Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C010398639
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhFBKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhFBKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F47C061344
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1016048wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiECzVNIaAqnnDt6pnKwVNNPdqlT5g0qpNhz7Lhftfc=;
        b=CRC2LTSpC8iWLc8pLdkBi6pidI9fIS5qX+Bg0OXcSFn6ICsBqVeXNo/d/IJN+DTJrt
         WeAOuktIBnXDJCv8LGdQWD8DiAIPHLjTaGc0xWFog/WconDc5wK1XD2pH1hRMbSdUNBz
         GpkASXhYXd2bgru4ihU4Qi87o5yoNpr/RbPpvo/kkWn1J2WlH02iaGvHFZkIyTUtuZCK
         OQpN9df8bP4Y9mHAENecoyD8PYMLQfBblTo/S/lHPSn9nL55IteQAzbOpWgcyS7jB7nD
         azKYATo7wOT1jAXysZUcFWTevFpIcV9WO9J+k6XB+dNLQ1Gt7OlvsHcYylm8HwQ8/ER1
         /30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiECzVNIaAqnnDt6pnKwVNNPdqlT5g0qpNhz7Lhftfc=;
        b=ZaRrPVYB4RefT8S8GKosNVtrQRd1XwJyPGn17q49dar2m4cWxVA0dSRlEGmIpbMu/U
         skfjpLHRQBWL6N3VnN656EY1pWcBAJKtybYJpygViXb1tpiRZ3OH5nPCkCK6Kjy9kACK
         cOloUBIDPDEaGBvUoO0N2dRTK+dVfe1eAHwNK5u6cXCq4f+iQMlZBTwfSjGu/oPgfh9o
         rhaCkswlL4o9WPs8CaeJoYPPIoDzWys5k/ggN0oj4VpoiyqGfmR74R1Dom09N+NUHkkV
         0vTd/k1R9AW6gtYiT1roEWaA0JTrt65kpq9ZQDT5Nfq6ymdKeDLHDwh4IEl+sA37OMWq
         lVKA==
X-Gm-Message-State: AOAM533UKWyeC8U/Wc/hSPTs+tMbyM89ceYn0jAHvQ47qCR0p1IRN4C6
        uzuyrINroqMzUJLJBdS8sC8xpQ==
X-Google-Smtp-Source: ABdhPJw0M02WJo35W/Tt4aHnTpwkrficGrlEkPJpG93ilGGrvX/tTZ8xsqA1edgUt+kS33Y9oXo3LA==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr13479869wml.16.1622629062680;
        Wed, 02 Jun 2021 03:17:42 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/21] ide: piix: Remove unused variable 'sitre'
Date:   Wed,  2 Jun 2021 11:17:10 +0100
Message-Id: <20210602101722.2276638-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/piix.c: In function ‘piix_set_dma_mode’:
 drivers/ide/piix.c:146:8: warning: variable ‘sitre’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index 2634768a4e664..ede42d2a5b0b1 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -143,13 +143,11 @@ static void piix_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	int v_flag		= 0x01 << drive->dn;
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
-	int			sitre;
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 	const u8 speed		= drive->dma_mode;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
 	pci_read_config_byte(dev, 0x54, &reg54);
-- 
2.31.1

