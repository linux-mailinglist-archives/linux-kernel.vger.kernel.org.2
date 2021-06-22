Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8833AFFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFVI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:59:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4D8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:57:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1857747pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=21zli5to4bbxRV7+kJw7X/mPMQyWrvlyQpneffahFWA=;
        b=sGTaSxekFxwVB371yT334il4P8+Ob1toaq2oUzG31a6GaDMTA+F46WmZgq2rbGiw1V
         oWrqn1+UkmJATtKgRjmHPpV339N+3L1TSPVKdCYpDhHgFQABde8lxBLaz5/n+4J1+fZ9
         6KqLDeKIb+adVLw6ZfQTQ7E/UzyuD/ys4pkAC84Rkdf/Ub/1c9eRcdcNRj3ZkxVQHrmM
         vd7Y9Kmwq5kSRQXkV0yfhF7ZagGizYIT69aZzvEiAO4lBV05xjZN2ckiaXRQWJPpJoIh
         cEUL0vABeS/v2GtUIdVF/y8MeV1tZA9VAAe0jYwtZsxcyWS/XZrb+ggYz3L0p/R3cyXv
         ys2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=21zli5to4bbxRV7+kJw7X/mPMQyWrvlyQpneffahFWA=;
        b=F55KYieshEzsmjrt/JrhzCxnsatmeSDL9VQFaoJkm8ctoHZ0Ql5VKK3o1oaffBtoTe
         Fu4cdleVLqvOHc5RN/XGwIUkAfTtd/CraIfY2+juQrHzVQ6aROg8W8O8Nl0aRkDERLhQ
         yRhd0kEhtBV0tCes7mS6iUn5dEaO3gFZKXlTyfYDmcQcJ/8/EiOXX0F6i5fT+7OE4EV2
         Nkrk9uFR0UYcDIETfaxKPi5FxKS62HplCdXvilFbH5onFRfPzjwNV2IwzF9zUBs7reYg
         Fw32Ny9gRZ2giLRbQ1ObN7rVWkug4W+teKDcIeTG6+hIgjTRgmBfMGUJ28gi69BtbTzm
         GPyw==
X-Gm-Message-State: AOAM532oVt5I2YpephS7HqvI74wow7ke6Zu7CAl8lpntRZJ2kY9/yxAw
        fswY3+u/pQL9o4sqrkKFXQ==
X-Google-Smtp-Source: ABdhPJzQitka07vlQqaVI7uo9THiWai320VCBlpCFzpgu+wgRd6BX1oRH9+/jXJJw4mUz8DG+qWnFw==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr2952781pjo.177.1624352262155;
        Tue, 22 Jun 2021 01:57:42 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id l12sm16941506pff.105.2021.06.22.01.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:57:41 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] rapidio: tsi721: handle errors properly inside tsi721_probe()
Date:   Tue, 22 Jun 2021 08:57:19 +0000
Message-Id: <1624352239-6179-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_on() is a too drastic measure, remove them. Instead, just output
error message and exit.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/rapidio/devices/tsi721.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 4dd31dd9feea..92ec5081e5fb 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2851,7 +2851,10 @@ static int tsi721_probe(struct pci_dev *pdev,
 			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
 	}
 
-	BUG_ON(!pci_is_pcie(pdev));
+	if (!pci_is_pcie(pdev)) {
+		tsi_err(&pdev->dev, "Can't find PCI Express capability");
+		goto err_unmap_bars;
+	}
 
 	/* Clear "no snoop" and "relaxed ordering" bits. */
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL,
-- 
2.17.6

