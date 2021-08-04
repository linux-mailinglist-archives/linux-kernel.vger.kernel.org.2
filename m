Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDF3E0447
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbhHDPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhHDPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:43 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE2C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j18so2038231ile.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBctOm9jo5QD+uuBod5VZHnVWZyYPdJk8fSVF+UMMgU=;
        b=sQMMTp1ateLavvDkAiOr9DzhT8dD74LZ0m26c/vnXRq3ZFK6Uc716GC5zveEO2uVqm
         ro2Zgfyoq/3CB9x5KM/jcMNgmcqB5lhmqBilF3HqqOdYXoRFe6hGqNaVkQX0ZbSGmLAE
         yPOr8YTphtRhDYE4wsqZ4pKTlbTOKhsX6h5pTiFKJS0TIobB/fu+bClYgcucnxTx2k3c
         edGpUWO/GFwjR2jwF9RE7lxd8sJTNnTDhQ2dG+f9NG9fpmzzIobs3ahL61+gFwxypN00
         qMyNjYj197c6D0QWsGh2uGoAb80AIS6I38ZyBzHqhTJfv+5phRMsNIC0ESSyfYKDjLI2
         3Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBctOm9jo5QD+uuBod5VZHnVWZyYPdJk8fSVF+UMMgU=;
        b=KqP2FRB/O07ABGV6bVPiUz4awuMWWjf3h8hLVPOFIWHnsFnxJn/QBLQm0yYb26GwJb
         GsBCX++kK+db7gA+C0p5WZjj5N7tgt2hyQ9ZiIYTBEaFJKnn7m2c4BISeRk/68Y6ek1p
         7buLhyxNxdQd1y4L2uAXJ3LIoVdhA8XGzUnuPGCJPhSMEbpuoHyrEo0xf+vmiQW929hw
         rvc01FVnfsykuN//2geVgxWOTfMWklIAyuv3KjRk26rcae8/UUWc34kY/11WrwWsKFl6
         V/Q86szS/whbQzHT0nLGve1r1YUM8DCzjXYU7iT52DD22OUHawpYZaHfrOZY5N0bNaOW
         xOQQ==
X-Gm-Message-State: AOAM531tXDKB0NTF35fHp68RFTe0IqJk5hFIqWVeqhgzFaDXf4Y9go4z
        KlRfLFcgvGE8bbRra3anwPaqEw==
X-Google-Smtp-Source: ABdhPJzQMQi2ZAyoyzj82QF+AzQ7MZR3Vqw2qOJ0h9KfHXaWroo01MD84eUqeFO63QeoIb6XfoyuUg==
X-Received: by 2002:a05:6e02:ef4:: with SMTP id j20mr107037ilk.246.1628091390668;
        Wed, 04 Aug 2021 08:36:30 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: ipa: don't suspend/resume modem if not up
Date:   Wed,  4 Aug 2021 10:36:21 -0500
Message-Id: <20210804153626.1549001-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804153626.1549001-1-elder@linaro.org>
References: <20210804153626.1549001-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modem network device is set up by ipa_modem_start().  But its
TX queue is not actually started and endpoints enabled until it is
opened.

So avoid stopping the modem network device TX queue and disabling
endpoints on suspend or stop unless the netdev is marked UP.  And
skip attempting to resume unless it is UP.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 4ea8287e9d237..663a610979e70 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -178,6 +178,9 @@ void ipa_modem_suspend(struct net_device *netdev)
 	struct ipa_priv *priv = netdev_priv(netdev);
 	struct ipa *ipa = priv->ipa;
 
+	if (!(netdev->flags & IFF_UP))
+		return;
+
 	netif_stop_queue(netdev);
 
 	ipa_endpoint_suspend_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]);
@@ -194,6 +197,9 @@ void ipa_modem_resume(struct net_device *netdev)
 	struct ipa_priv *priv = netdev_priv(netdev);
 	struct ipa *ipa = priv->ipa;
 
+	if (!(netdev->flags & IFF_UP))
+		return;
+
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]);
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]);
 
@@ -265,9 +271,11 @@ int ipa_modem_stop(struct ipa *ipa)
 	/* Prevent the modem from triggering a call to ipa_setup() */
 	ipa_smp2p_disable(ipa);
 
-	/* Stop the queue and disable the endpoints if it's open */
+	/* Clean up the netdev and endpoints if it was started */
 	if (netdev) {
-		(void)ipa_stop(netdev);
+		/* If it was opened, stop it first */
+		if (netdev->flags & IFF_UP)
+			(void)ipa_stop(netdev);
 		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = NULL;
 		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = NULL;
 		ipa->modem_netdev = NULL;
-- 
2.27.0

