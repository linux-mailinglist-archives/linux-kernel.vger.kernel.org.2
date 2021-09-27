Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC241981C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhI0Pn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhI0Pnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:43:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D7C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l8so23440335edw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBjJ13FCpP/hd5pZS3FX6dverz31Y4VFTcEH/pao96g=;
        b=SY3wZKR6nOSIasw400g6YgMHSTKCcwuM1yJYuIOu3iQgOwy3IVNZkpZY9rrMHeiGMj
         Sv132G4Gf92KTR68tzfhJhImoWPQ0KqVJrl9+emmmrQuP1p8J7Oathc4m3N336ZE5DRf
         5gdGS34cFE1yZ2dNu2XSZyKtLJ8ANQsJSsAXZgC7R3YdRiZUA0CjJyyXOqeUXWfOK0TA
         9wh1g8ptrCwhbq7RFqM77bCS3kPZIMNx7uhBMQXO+eTHCHF5BT7jeP5UuCrKCghEqecp
         CZFgDsToDyNHVUjWRQ7/jgVRkzDeGRmvB1hYB4jV1UU54oKsgIBHv4NyeFzoV5ausFug
         1LWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBjJ13FCpP/hd5pZS3FX6dverz31Y4VFTcEH/pao96g=;
        b=P12IOx3YUKjnywp/LMPAIeOJV+QSH6BGJ/2mXOQ2564PX8Et2Cr66TzCDatPIZvtm9
         IpjeyM8KQmLfbu/KOqdGpvX94RkMnuUEz3EZV6PQSBntHTIZoWKkN+VhpujDSkkfS3Nk
         C5QQ9GKfy8m45Ga17bDE/lScpD3W/WH7xvKFjP/yzosRYhSj3P8H/N5Q1HuiT6DzutuE
         1zDhDeTDL2iMJGIinMMvATvHfwl/6gPSxeSvl4Zgv/WagSugYkakDHE7ImxuoFhx92/G
         G5DZ0sQAPrRuhftRWDnWzrvFA+d/r4XxPZoJDzcOGlBwzC48S/B6FTNb7Sk8H3ZsruoE
         Mf9g==
X-Gm-Message-State: AOAM5318wm9EtMlYtMAo/noyTQ+Kmzfqv2ZA7OXkPSk9rZnu/TkSeiMp
        LpDqnltkWU5/J9FPomrTYsyLTkLJWZcMhw==
X-Google-Smtp-Source: ABdhPJwvHjPrL+qmjed/Prp0vaMpNeTWufcaTSjUjOBOwnBt2Oqz37Fp7yXMd6pTd1pmdKHGr6PngQ==
X-Received: by 2002:a17:906:a24d:: with SMTP id bi13mr707693ejb.481.1632757330882;
        Mon, 27 Sep 2021 08:42:10 -0700 (PDT)
Received: from fedora.. (dh207-96-123.xnet.hr. [88.207.96.123])
        by smtp.googlemail.com with ESMTPSA id n16sm10768025edd.10.2021.09.27.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:42:10 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/4] arm64: dts: marvell: espressobin-ultra: enable front USB3 port
Date:   Mon, 27 Sep 2021 17:41:59 +0200
Message-Id: <20210927154159.2168500-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927154159.2168500-1-robert.marko@sartura.hr>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Espressobin Ultra has a front panel USB3.0 Type-A port which works
just fine so enable it.
I dont see a reason why it was disabled in the first place anyway.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 96855a10b4a0..aada43fa236c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -112,7 +112,6 @@ rtc@51 {
 
 &usb3 {
 	usb-phy = <&usb3_phy>;
-	status = "disabled";
 };
 
 &mdio {
-- 
2.31.1

