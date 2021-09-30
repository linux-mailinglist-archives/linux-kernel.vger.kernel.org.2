Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8558C41D7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350094AbhI3KqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:46:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60362
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350066AbhI3KqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:46:15 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F90040264
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632998672;
        bh=1+7qOmsUZM+kk+KMExa6VeC0uD5tDlWk3nuJO06+4ds=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RX5a2EOsuvmNsHzokDCfmV7t41kcee9WeTgrYTT9JJJ4hvhRJi3YMe7B6dWmPmcxL
         ZjQDsOPIByCDAN1DWjCMJTwA7DteOOsAu/pT0GOZAMJC22OvPP9Espowzt+neL4lDt
         mzSBuKxBsqk1BD26J3YtDYQPRUJZt4odcEeFZucmYE0c29iaa47GqAL0DsYyuTvQOj
         vly4o+lAIpp6QLzDOJyT6m8ZOmrmyiEvlpKF/sfvY2tKZveFURM8GqCuofc7kitzPF
         kjc2cV1k6PE5u2XbGDHLinLgQ5wMwL0NsK9QdHTcqfDJrSRaVPOihODCShMocIh1mi
         UeQ/Gff1lyk6Q==
Received: by mail-pg1-f197.google.com with SMTP id x123-20020a636381000000b00291a31e736dso3315943pgb.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+7qOmsUZM+kk+KMExa6VeC0uD5tDlWk3nuJO06+4ds=;
        b=eVka0Fj5s9AiG2BWUF31zlU9Km4zoV0Y0A3zA+Kr3Eb/8VQXdxGX8pQc7+qDUy1U3t
         z1jdGB21jZp43d8GTPLGJgypSAgg16Ls4DIhzD5L+UbB5t78Ibgu6S5OTTiiAXbkGlNb
         lMy1ecgvYpFsjZCxtQq/szvnD8ZalP1VPBdTUIrjCDovpLwX2L9L+BK3DRjEW8EkSb+E
         xgMmDc8bCe9+LaN+a81Yq9smlum2tjfgwfvwqZ1cwK/ntz8F17VYrcSfBYnH+BfDgpkv
         76YYm2OX20yMEmr+fQR5Cual0JqO5yEjDTNsMKx5NpfjjnqxIBWa/+HQGavAqFX4/cSb
         cQFg==
X-Gm-Message-State: AOAM530CpkmOp23KQOUYNoN1ikay1BDHT6nMxHC28+GLqr48APVhax3x
        6IjidtlQEC0dL6eHxFYr1ypCWQcH4ZegZWz71FwJMhdm8YVB4B3CHsRxckABQYytdq2lrUuX6TS
        zMLgf+GbLrOW2VoXDRqUIONQeBBhrS8HmqzuZOIAY1w==
X-Received: by 2002:a17:90b:1d0f:: with SMTP id on15mr3834470pjb.77.1632998670711;
        Thu, 30 Sep 2021 03:44:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSQ7Rude9wGaP2b5cEB+yxk+8eHNpSDFIhYv0pHZ3q20W4ZKZy0lUJTrs9eS5unQFcg7kA2A==
X-Received: by 2002:a17:90b:1d0f:: with SMTP id on15mr3834444pjb.77.1632998670456;
        Thu, 30 Sep 2021 03:44:30 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e255-baca-c7f7-191a-11a1-0473.emome-ip6.hinet.net. [2001:b400:e255:baca:c7f7:191a:11a1:473])
        by smtp.gmail.com with ESMTPSA id c7sm2654844pfd.75.2021.09.30.03.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 03:44:30 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] rtl8xxxu: Use lower tx rates for the ack packet
Date:   Thu, 30 Sep 2021 18:44:22 +0800
Message-Id: <20210930104422.968365-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Realtek propritary driver and the rtw88 driver, the
tx rates of the ack (includes block ack) are initialized with lower
tx rates (no HT rates) which is set by the RRSR register value. In
real cases, ack rate higher than current tx rate could lead to
difficulty for the receiving end to receive management/control frames.
The retransmission rate would be higher then expected when the driver
is acting as receiver and the RSSI is not good.

Cross out higer rates for ack packet before implementing dynamic rrsr
configuration

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 7 ++++++-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 774341b0005a..413cccd88f5c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4460,13 +4460,18 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 
 static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 {
+	struct ieee80211_hw *hw = priv->hw;
 	u32 val32;
 	u8 rate_idx = 0;
 
 	rate_cfg &= RESPONSE_RATE_BITMAP_ALL;
 
 	val32 = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
-	val32 &= ~RESPONSE_RATE_BITMAP_ALL;
+	       val32 = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
+	if (hw->conf.chandef.chan->band == NL80211_BAND_5GHZ)
+		val32 &= RESPONSE_RATE_RRSR_INIT_5G;
+	else
+		val32 &= RESPONSE_RATE_RRSR_INIT_2G;
 	val32 |= rate_cfg;
 	rtl8xxxu_write32(priv, REG_RESPONSE_RATE_SET, val32);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index a2a31f374a82..438b65ba9640 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -516,6 +516,8 @@
 #define REG_RESPONSE_RATE_SET		0x0440
 #define  RESPONSE_RATE_BITMAP_ALL	0xfffff
 #define  RESPONSE_RATE_RRSR_CCK_ONLY_1M	0xffff1
+#define  RESPONSE_RATE_RRSR_INIT_2G	0x15f
+#define  RESPONSE_RATE_RRSR_INIT_5G	0x150
 #define  RSR_1M				BIT(0)
 #define  RSR_2M				BIT(1)
 #define  RSR_5_5M			BIT(2)
-- 
2.20.1

