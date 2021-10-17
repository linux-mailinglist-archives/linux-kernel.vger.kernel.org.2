Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4947C430B24
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbhJQRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbhJQRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 13:19:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C8CC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:17:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so36806535wrc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4viN/Os8N6l4stBrqPBr6YTWSITrWn2XRCojerv1iUg=;
        b=Q9zKX0QnFqfYHtrWDbZpywzKtbR0m++3i/YWT1yPWQGaYeXD+GUiatYEXHbKZ5//7P
         eezHIn4g1vaIKdyIjk2xw0kQboawVO5ZLqfskF48S2fjaVb0L5qZ+zjM+zECzuAamEUs
         i4O3BfFxZKJfYmqxQp2eArqBpZPbEuaqSKxM1uPGNpffkYiJLck0n8kerX8L+ZnZyzoO
         bZi68ZPsMPrB++e6+9QtRQQzt1EXpGYB9yHFyhdOrPsvO9VWxhIphIfxDmawBfSi3WLF
         E4Y2BW9NDgPwwFZqND/SlrsZKCT8aiJJ9OBnTL0rZyY4rA8F03LcbyyUxF/AeGmWQ8Wp
         6QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4viN/Os8N6l4stBrqPBr6YTWSITrWn2XRCojerv1iUg=;
        b=Kxw52RemBGV/z7Lk68H0XG+CQU9aSq4zdodQl30loPt+DfQkdrKvsOjHAdJ5YmRuMg
         1w6FCAIernFZtv2ceWq9ptYjaYHcV0L6pr6aFqWY/pFptnLnfQrr2Tj3vHxpg3wHM8pt
         BmpTBHP6PnLesGiqOxaT8pTzyyOn1XGh7j4SgixqEZNqYBJySKLBtONNawbeFtlvhB54
         2lLTeA2okTEnMbXTU3g9BeqgAVTZ8qvYYxvMswkmbpJEE5qJ9b/hR3CFWWyzgT78/5aS
         yKIFkYEvjrVrlgOpoe0pk/OHQ8ynnhhwXbrgm6NmXm8MC3Fm0gy90b+XyJTfpJA+35Jq
         YIXQ==
X-Gm-Message-State: AOAM531uR3R8RlyMxaKzub5h20EmaDZB9jYfWzzg2lkNMTIJBlGaSiPO
        Ou5Abm3af94QTX1IxlWTICzC3g==
X-Google-Smtp-Source: ABdhPJxE1sAAXF7HZRudLOuJ+b9trDLLoM0RmxxjU1XhjuBo/dgox+Y/S+TDdUZB7k1mamh0iMZskA==
X-Received: by 2002:a5d:4a08:: with SMTP id m8mr12226944wrq.18.1634491047630;
        Sun, 17 Oct 2021 10:17:27 -0700 (PDT)
Received: from kerfuffle.. ([2a02:168:9619:0:5497:3715:36d:f557])
        by smtp.gmail.com with ESMTPSA id k17sm10139820wrc.93.2021.10.17.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 10:17:27 -0700 (PDT)
From:   Erik Ekman <erik@kryo.se>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Erik Ekman <erik@kryo.se>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sfc: Fix reading non-legacy supported link modes
Date:   Sun, 17 Oct 2021 19:16:57 +0200
Message-Id: <20211017171657.85724-1-erik@kryo.se>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything except the first 32 bits was lost when the pause flags were
added. This makes the 50000baseCR2 mode flag (bit 34) not appear.

I have tested this with a 10G card (SFN5122F-R7) by modifying it to
return a non-legacy link mode (10000baseCR).

Signed-off-by: Erik Ekman <erik@kryo.se>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index bf1443539a1a..bd552c7dffcb 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -563,20 +563,14 @@ int efx_ethtool_get_link_ksettings(struct net_device *net_dev,
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 	struct efx_link_state *link_state = &efx->link_state;
-	u32 supported;
 
 	mutex_lock(&efx->mac_lock);
 	efx_mcdi_phy_get_link_ksettings(efx, cmd);
 	mutex_unlock(&efx->mac_lock);
 
 	/* Both MACs support pause frames (bidirectional and respond-only) */
-	ethtool_convert_link_mode_to_legacy_u32(&supported,
-						cmd->link_modes.supported);
-
-	supported |= SUPPORTED_Pause | SUPPORTED_Asym_Pause;
-
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Asym_Pause);
 
 	if (LOOPBACK_INTERNAL(efx)) {
 		cmd->base.speed = link_state->speed;
-- 
2.31.1

