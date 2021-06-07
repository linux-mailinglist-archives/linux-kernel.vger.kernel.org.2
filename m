Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9094039D56E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:56:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2DC061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:54:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q5so16277218wrm.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SycGxNzUtV3DE7CamJrAD1Pvz+est/FKan8cUWbxD2I=;
        b=DpT2PnRxGVQiCgoJzyNAm/O4RoS9b2+QKEGKEaShOT3FSo0jeaMbyn69YZVT9nQtyl
         a6YFUTS8qVlw6ySBE+kkox9dYFvnUS/o1WOyZ1B7umwqHA1O+3+73GhCNRPtvtFs0mL/
         pM1A3TRy9Gi8Djqqn5ZWh5YcIsPTuWmiNoC0orAbuOf8IeCZi7GvrNgBGDnJEW9oTfXh
         yjM2DLkmQv+Q2QIBKkBXZoE4s/pyimnUfvVLbjqeN7XOc+1KLLy4H7KywVHwquvsg7eC
         xEdbUfp5iCu33yZMrqj0U0untSq5SR+m8ggFdQGpcPcFna+yfo9/5aVubHdh+TO1zz/b
         fGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SycGxNzUtV3DE7CamJrAD1Pvz+est/FKan8cUWbxD2I=;
        b=IfmiQtJ7UjcKUurD1Hmj2wmGqypuBIXPvxtX6iheUXuHNGaQp9dXLWqyD9rKP9vFtE
         2ZD5A8ITep1hqoR9Q4M1tlr3ZqbJ3qr7TCyasgEfZzaXo8LWgnQWwDpvH/oPuexfxJk7
         De31d/K5gxRWt2LKqpKrdNTUPtrtAR3UhsSafWxv1rDHIIPyzlctcjJG18QxuvYhOSp1
         /teGNTHdgasd5a6vUVTnKmnBhVcV5DnPiOnhjm75YoliZ7sKAFH+Iij6Y6ODJRwIXtfO
         37Nw92ppnBDfFBALRRklIl9LOW3LJ6jSyP3BV5rrmu5PmjIwhBy5rAg7ioRrwSSxkKVY
         mBcg==
X-Gm-Message-State: AOAM531y4J2V0DZzbMqSM6ByCZGnU3xNoJkERlIDpQd4b+3Kjs7YuE4p
        FYf55jylQBzxEd9ZiSQ8sWPbwA==
X-Google-Smtp-Source: ABdhPJzl8JaHo/BdUqNgiULQZx1Xi+Byjam5NvSMdsRJ/THVQ/xFGkrNM27ZzIUIO3fErWTHrcrpkw==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr15475997wrr.183.1623048887766;
        Sun, 06 Jun 2021 23:54:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/7] arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
Date:   Mon,  7 Jun 2021 08:54:32 +0200
Message-Id: <20210607065435.577334-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; h=from:subject; bh=YH7kXwU8dyNUaEMmy8cCWl++SIsJdk3eEHxEskLlOOg=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJA4vy8KzbqrA8Ny8bFa1T80r9/Vp8WK95/9XrM T2gvNXyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQAAKCRB33NvayMhJ0cnKD/ 0YeznbdfUMuRyrzsZojSnjNrCjwARL6cJxclh8do9fq2Z5qvM+PE+zLigW0PFyOIONtoIARLtJZUiT kxfrDdPM3AJz1EGXIOLr0SWpRPVdIQeqvGka+pMOoKweoC8Yc76x/Wh3fE3KkMHDbqebujk0CSWcGs NsQLmY//wu0Mf0jD8HtRU71FJzxx3qsyBLcRJ+4bDGRpzNXj0s/RQ5I0n63gZC74WhgaQgTmVh1HRd LG4SUblh7UuJZ9Uayk6qo/9hZdEAsRbmrhqR7dvicz/vJyPtCtDmNX3N6PL192C0dLDvlRvoLxOlGU wcmDFeXbSijydebbS21a2I3bmBNGs5V+kj6jVqz8+pJVSeZBRYqxcM6h/WaPHo9z/Wn+jameRVhuf7 pd2ayBrMBsoe+C74TcP1zcTBIT+vWYV/txH8JyGiZJwJo1eaCiBea5hz52BwmXrcA2scf8EF3WXx0n YCXYStKvvXmB0FpgprL8uCD+bfxiu/Ujr/44fVoPqiL2ZnA+k+GoCjzDvg2WqX+GbDNRdpdiYlM1B+ +8Kw0xziuWovWWyaEvJgMCShvj2AkDTyl5kzjIeCIEQ9eMTvSssDFfGT/BzIlokOiikGdeE5RqfbfS aZBj8w9zeqzs65KUd+AhuhTOLbmrAofGV4l4iGCF2uTt8t2ygmm1aksNyd0g==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the HC4 schematics, only the USB port B is used,
port A is left unconnected. Thus disable PHY0 and remove it from PHYs list.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index bf15700c4b15..0a34b658f994 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -91,6 +91,10 @@ &sd_emmc_c {
 };
 
 &usb {
-	phys = <&usb2_phy0>, <&usb2_phy1>;
-	phy-names = "usb2-phy0", "usb2-phy1";
+	phys = <&usb2_phy1>;
+	phy-names = "usb2-phy1";
+};
+
+&usb2_phy0 {
+	status = "disabled";
 };
-- 
2.25.1

