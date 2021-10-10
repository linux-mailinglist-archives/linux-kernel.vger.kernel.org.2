Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77D428189
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhJJNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:34:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59600
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhJJNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:34:18 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE21B3F338
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633872738;
        bh=VSngw+BuS10HO2dYkx/MXwvMPY51PJ3deWKl4r4S3qQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ccG44VLTMq8SHBMal3otjLWgjTFtQbaHA3W+bM7qLALLAAUwugkNnF78e1+XIRAsP
         bGEFBg4eO8MefGzsT+GKieazKm1OPSA5m2AiKMQNwBMXXrhQ6ofHICYCM09v9Copeb
         ZuGGM44meRKQGnG33jrf0xa+LgIo1PipZLO7gRRDy6Z3/fDT9RZIgKeEvyES6cNGUl
         1dp/Mz2J+rSEA/yspdhGq3if0i9PtzLOdPN8C+4WAIC6Z3WsGS5k3Z1VrX5Xq1fZth
         fZQCKFNrMpIUsby3kp9ORQ5fcewjhQpF4VW9lBT4OJOrTADpnTQg9NX4ZS46qBBkQj
         9g9r6x/4azR6g==
Received: by mail-ed1-f69.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso8016748edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 06:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VSngw+BuS10HO2dYkx/MXwvMPY51PJ3deWKl4r4S3qQ=;
        b=58O06/JpdGxx/EoPcm6MYN8mldxxXzwkS/mXzx3HK1GugbpQhcRvME+vjviOBr/Jxv
         GJHFgFr+xEFEeJB6IwWO74xL4ASDweHJb9DHIra1MiI7g4ZDacLCXOqenlDn3DRMa2xC
         0p2b0YoxGm2PxrVMxnyVUghsdZI1vmzFo6aRdiY3CGTy+tlAKX+vkltcz9Jk9uIhlBPZ
         YhDOGnCs737tdKrAlRPXE1Gn2tD/ErbB+fWgEoAFtw2j2hdMm8Yws138kb9WgM17Rag+
         ZpCVpESYoKSdN54AlJTDzPxwMiz6E5GHExzx9XWtIN3JtmfTeszF7swsd91Rxwbu22qo
         3tqg==
X-Gm-Message-State: AOAM531XzuVmfrmA0Cl7QuQZqFSsQAlJfODHgOGsIGWgROUl95xj84bH
        hnprba2sc4flid8jnOrSgERIDOQ93wz3MF4dhvKXomN5GbZS66E44VRg576NfZ+uu5j60wVa0Aa
        lsDUNWdqMn1DCQqkSjnAUiFLFxy95QOrbpcO3smxvog==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr22194679edd.15.1633872738373;
        Sun, 10 Oct 2021 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxX28avd/zYMEEZvi0uTLj2965i0Y+AZSacZrycO3LtcE4wcV3oD4ApsvkCpz0voOrsfU48g==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr22194652edd.15.1633872738168;
        Sun, 10 Oct 2021 06:32:18 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d25sm2547476edt.51.2021.10.10.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 06:32:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] ARM: dts: imx6dl-prtrvt: drop undocumented TRF7970A NFC properties
Date:   Sun, 10 Oct 2021 15:32:15 +0200
Message-Id: <20211010133215.145722-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the bindings nor the device driver use/document
"vin-voltage-override" and "t5t-rmb-extra-byte-quirk" properties.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/imx6dl-prtrvt.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
index 5ac84445e9cc..56bb1ca56a2d 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -67,11 +67,9 @@ nfc@0 {
 		ti,enable-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>,
 				  <&gpio5 11 GPIO_ACTIVE_LOW>;
 		vin-supply = <&reg_3v3>;
-		vin-voltage-override = <3100000>;
 		autosuspend-delay = <30000>;
 		irq-status-read-quirk;
 		en2-rf-quirk;
-		t5t-rmb-extra-byte-quirk;
 		status = "okay";
 	};
 };
-- 
2.30.2

