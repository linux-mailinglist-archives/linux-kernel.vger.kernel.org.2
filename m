Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C884338B45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhCLLJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhCLLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:09:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF62C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:09:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so1540785wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXQyr4IBlf8BJXFjheDlLrWyrqRa2WbuLrndUKgj2RE=;
        b=c4Js0gyWEoLDKpmd1C7WpG0VFopaDp1dQm2+VZf0oryUz1eScc7ZxDbqb+LyE87I5F
         ePVh3XrvR5lX4IELD37RfRM7gJwEC/tMnPK8m9tRdac5lSxZImh3Le4HEntJ0AQRJYuW
         uJ3Bnp7fjJr+6WYfuUkTAs4LMiiLOLCLKVtXEqGsc88TZgFFa4Vqy8o6jhI6epPJA89d
         7p4FLUSIEm9tQdL2Yf2XMdYQiKEK8b2H/1zq9Po+je7ZIsue6FooKvz+5oheoS1dQiNO
         +82mmwN6XRHI0a4fFBoAjow4p9XtzjUkzKq+p6RfaipS6RgUon1w75j7slPCa5RCoNv+
         y+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXQyr4IBlf8BJXFjheDlLrWyrqRa2WbuLrndUKgj2RE=;
        b=gZfP/gyP4/yS5jgjX8eFQo0SdgS9nnkqSE+TemvaIfdlctVma8plCNDxhOzSCskGtb
         NaDko/OHUw2XsvMkTyvaUd9K8D6VyY+dd3oL5JKQc/ht9cXmiulSm+5fbSwqxmh6JdZA
         guJQClc4NpfpBjoODn+csLRHkOU1XACqWHkuDbEihlcgTtp0Wq9FBrxRxj7hWHlu3fFk
         uMj8nWoo/hKRC8yVkjeOW/x07ikYeYnbQOVc+AWcfFn37kQPnwyRkdNt907aiJBKjAJR
         mA42fov7CtRITiKkZHZXud6HGnA+vWBH8wKDl/PS798j59WaMs+KyIWZm/H1Z3TICDR0
         yiGg==
X-Gm-Message-State: AOAM530WoMiI4s7+BFkF0ybyRaWHC1nbjuyt2qYd6G1q7CkHekqx7grh
        cHsgVGOQA7Ton4Uhw56jMLK7dLbZowpXjQ==
X-Google-Smtp-Source: ABdhPJxk0DwjcM/U/+T+uTxhmPkRR+tX9XIpFD8h/LWICV/2kERf8CJbZMSjxrmB5XjT2NMLQPXlMA==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr13671486wrv.313.1615547354239;
        Fri, 12 Mar 2021 03:09:14 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id b65sm1833255wmh.4.2021.03.12.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:09:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>, netdev@vger.kernel.org
Subject: [PATCH 1/4] ptp_pch: Remove unused function 'pch_ch_control_read()'
Date:   Fri, 12 Mar 2021 11:09:07 +0000
Message-Id: <20210312110910.2221265-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110910.2221265-1-lee.jones@linaro.org>
References: <20210312110910.2221265-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ptp/ptp_pch.c:182:5: warning: no previous prototype for ‘pch_ch_control_read’ [-Wmissing-prototypes]

Cc: Richard Cochran <richardcochran@gmail.com> (maintainer:PTP HARDWARE CLOCK SUPPORT)
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h |  1 -
 drivers/ptp/ptp_pch.c                           | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
index 55cef5b16aa5f..3ce4899a0417a 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h
@@ -612,7 +612,6 @@ void pch_gbe_free_tx_resources(struct pch_gbe_adapter *adapter,
 void pch_gbe_free_rx_resources(struct pch_gbe_adapter *adapter,
 			       struct pch_gbe_rx_ring *rx_ring);
 void pch_gbe_update_stats(struct pch_gbe_adapter *adapter);
-u32 pch_ch_control_read(struct pci_dev *pdev);
 void pch_ch_control_write(struct pci_dev *pdev, u32 val);
 u32 pch_ch_event_read(struct pci_dev *pdev);
 void pch_ch_event_write(struct pci_dev *pdev, u32 val);
diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index ce10ecd41ba0f..f7ff7230623e0 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -179,17 +179,6 @@ static inline void pch_block_reset(struct pch_dev *chip)
 	iowrite32(val, (&chip->regs->control));
 }
 
-u32 pch_ch_control_read(struct pci_dev *pdev)
-{
-	struct pch_dev *chip = pci_get_drvdata(pdev);
-	u32 val;
-
-	val = ioread32(&chip->regs->ch_control);
-
-	return val;
-}
-EXPORT_SYMBOL(pch_ch_control_read);
-
 void pch_ch_control_write(struct pci_dev *pdev, u32 val)
 {
 	struct pch_dev *chip = pci_get_drvdata(pdev);
-- 
2.27.0

