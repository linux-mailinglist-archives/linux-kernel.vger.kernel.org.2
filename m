Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633183E044B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhHDPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhHDPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C100C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a14so2056728ila.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYPy0EiH44k22cfOkFHbddfBvF8NraMV8hju0p8WV3I=;
        b=nfa3a3gifGAmzcnPuZcW28cXDmG7gslzHVrpFLibwHKn64pSf5F/fFXAkN5hxytTFh
         c0t9+UkVdA1SGhzdUZGHw4bKRUh7vheepR4V2huVhnQGjCoMaUISEC37qvUHyLPLcWjZ
         W64vnSt7ckWVNnG7lG9SI0LODBArDaedcM3lpze2zHX+DVRCAsibwTl9ReYUa28PiqWV
         BTfrDCUlzG49F3K6xUtadCNjZT61slN9YjELEpkE+okX9aFEx99mGnCrieUQvDVgspeD
         BVYUIMEFZ+xezpvVatoESVQsGVCq4nGfQz0wiNrWNVRlmaOgIEEiPoUsaPIlgdntuSWM
         nq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYPy0EiH44k22cfOkFHbddfBvF8NraMV8hju0p8WV3I=;
        b=SRrJ4RtHBYp4n7lD0I0JD+u/lDeb2UAZLzkF4dWWvSXYunPH3o/sSHiytsXV7IXVLN
         foqvhVcM+Z7CrTs9Zv/Aouh0aeYyWJrauIISXv9P7Z5MvGfZCa20dSdY77HhlZmG/mSF
         yUudg25Wl81B7I0/clEw4CNDMHSuXDUPu+ManTXRSU2R06B7qARMVsea+r4hrcnuEHyX
         jtTrUTAki6BtnUD7Kjk2E84aIslVIi9nqYmSEv9+k5HCaYHRFMStdUQKp4k4akGSyFXB
         83vw38U4YmCPzT49Y0x+bu7T8d+Cqne/b/F8ZvOIx0xL0MGFEnoeqHu3kQPQWnAPdYUG
         yMgw==
X-Gm-Message-State: AOAM531XVFmJ0ugP526iLvehRJoEsItjNWcvkOGXM4X1nbrAeCwwVpvj
        cQFhI3X2+oxQKFN/GPhDKesdSw==
X-Google-Smtp-Source: ABdhPJwGqr5/W6FnnktevxSPEjDx/bi8jPDZYzGSMV8sOYwzaTbXIWly9NHRvAY0TkszVEtUUoUytA==
X-Received: by 2002:a92:d088:: with SMTP id h8mr11704ilh.165.1628091391490;
        Wed, 04 Aug 2021 08:36:31 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: reorder netdev pointer assignments
Date:   Wed,  4 Aug 2021 10:36:22 -0500
Message-Id: <20210804153626.1549001-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804153626.1549001-1-elder@linaro.org>
References: <20210804153626.1549001-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the ipa->modem_netdev and endpoint->netdev pointers *before*
registering the network device.  As soon as the device is
registered it can be opened, and by that time we'll want those
pointers valid.

Similarly, don't make those pointers NULL until *after* the modem
network device is unregistered in ipa_modem_stop().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 663a610979e70..ad4019e8016ec 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -231,13 +231,15 @@ int ipa_modem_start(struct ipa *ipa)
 	SET_NETDEV_DEV(netdev, &ipa->pdev->dev);
 	priv = netdev_priv(netdev);
 	priv->ipa = ipa;
+	ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = netdev;
+	ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = netdev;
+	ipa->modem_netdev = netdev;
 
 	ret = register_netdev(netdev);
-	if (!ret) {
-		ipa->modem_netdev = netdev;
-		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = netdev;
-		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = netdev;
-	} else {
+	if (ret) {
+		ipa->modem_netdev = NULL;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = NULL;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = NULL;
 		free_netdev(netdev);
 	}
 
@@ -276,10 +278,10 @@ int ipa_modem_stop(struct ipa *ipa)
 		/* If it was opened, stop it first */
 		if (netdev->flags & IFF_UP)
 			(void)ipa_stop(netdev);
-		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = NULL;
-		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = NULL;
-		ipa->modem_netdev = NULL;
 		unregister_netdev(netdev);
+		ipa->modem_netdev = NULL;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = NULL;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = NULL;
 		free_netdev(netdev);
 	}
 
-- 
2.27.0

