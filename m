Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35129356283
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbhDGE0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbhDGE0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:26:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D8C06174A;
        Tue,  6 Apr 2021 21:26:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so16372421wrw.10;
        Tue, 06 Apr 2021 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0o51oKuyha39MJhgnZxMd0OeTompQ+WxXOsAhpP5pys=;
        b=IbPPd48qDCfZS45non9+lat2dwNvXl6fJp5nD0kkUlGT6m8wXcTCbu3qwYB07PzGYt
         twyQp9P46r8yhS+BiJy9za7WYL9oTeolDOSv5LKdBeajdPfawHPDDbKbGrW4bwI0lmne
         LcvS+SApTGwSVkA+Ovq5JeNyLwW/9VWSx76YiDIStlWe3d2/FgLZCm3rr+2z/AZ87FCf
         a1AnufSeTDh1KRgttFCNGbqekvtJcmTNh9q19JEf8bQ4N/Aoz8YGtKND+zJgeHh1DNLt
         fZNRQa6K8SAFGzewWCBvZwrnOvspZHQr4ybYox0rHTqRDZJmibzK0ewsmq7d+LhBnHrv
         KUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0o51oKuyha39MJhgnZxMd0OeTompQ+WxXOsAhpP5pys=;
        b=VCAMsuscor6zJ6hjmKnX2jUoTLfffi0jVVNFrM2HKUgxoARC2jOeK9tMpWqDGENzu5
         7zwk50NwBsVmw+x4HE099kHrD6w5LS/TAEQbQyjumlyS1wukaFzHKnnqBrsYyOfeDaGh
         Ivom2jLt4rOwRJhmJSXd4Sett352zeOVXj8NALvcs5ILyjk0MA8dyYem9AnfFU7WS6jD
         VsRAxSypQ/8LEJBpGO/SmvljouVtKAcI8oz22pJAeJPGDDRiC0Tbfn1e/HXkKU1hxeP0
         /lpUvfF72WnndcAVu4AOz52K22jikU+wHKWFO45fLQTQtULvVsqYKBqoMz32HGOeUTHS
         DHSA==
X-Gm-Message-State: AOAM530O+xMljE9EGivZrXNqGufLXUng45dSHYFMFta8SspTzpEtT5Fy
        qlI6o2aWCL4o7EZrTWG56O/nm/r6u4M=
X-Google-Smtp-Source: ABdhPJzXS9p7nYZ1ia1ZqV4CKAJVhecTAVzEWbh4qtHNl1dKWiE9XW4ULLJge5LZa4M2w/BXPfTkqQ==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr1807871wrz.77.1617769579958;
        Tue, 06 Apr 2021 21:26:19 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k3sm16487112wrc.67.2021.04.06.21.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 21:26:19 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Hyeonki Hong <hhk7734@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add GPIO line names to ODROID N2/N2+
Date:   Wed,  7 Apr 2021 04:26:09 +0000
Message-Id: <20210407042609.9736-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407042609.9736-1-christianshewitt@gmail.com>
References: <20210407042609.9736-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonki Hong <hhk7734@gmail.com>

Add GPIO line-name identifiers to the ODROID N2/N2+ common dtsi.

Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 0a994668e707..473b81c652cf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -446,6 +446,51 @@
 };
 
 &gpio {
+	gpio-line-names =
+		/* GPIOZ */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOH */
+		"", "", "", "", "", "", "", "",
+		"",
+		/* BOOT */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		/* GPIOC */
+		"", "", "", "", "", "", "", "",
+		/* GPIOA */
+		"PIN_44", /* GPIOA_0 */
+		"PIN_46", /* GPIOA_1 */
+		"PIN_45", /* GPIOA_2 */
+		"PIN_47", /* GPIOA_3 */
+		"PIN_26", /* GPIOA_4 */
+		"", "", "", "", "", "",
+		"PIN_42", /* GPIOA_11 */
+		"PIN_32", /* GPIOA_12 */
+		"PIN_7",  /* GPIOA_13 */
+		"PIN_27", /* GPIOA_14 */
+		"PIN_28", /* GPIOA_15 */
+		/* GPIOX */
+		"PIN_16", /* GPIOX_0 */
+		"PIN_18", /* GPIOX_1 */
+		"PIN_22", /* GPIOX_2 */
+		"PIN_11", /* GPIOX_3 */
+		"PIN_13", /* GPIOX_4 */
+		"PIN_33", /* GPIOX_5 */
+		"PIN_35", /* GPIOX_6 */
+		"PIN_15", /* GPIOX_7 */
+		"PIN_19", /* GPIOX_8 */
+		"PIN_21", /* GPIOX_9 */
+		"PIN_24", /* GPIOX_10 */
+		"PIN_23", /* GPIOX_11 */
+		"PIN_8",  /* GPIOX_12 */
+		"PIN_10", /* GPIOX_13 */
+		"PIN_29", /* GPIOX_14 */
+		"PIN_31", /* GPIOX_15 */
+		"PIN_12", /* GPIOX_16 */
+		"PIN_3",  /* GPIOX_17 */
+		"PIN_5",  /* GPIOX_18 */
+		"PIN_36"; /* GPIOX_19 */
 	/*
 	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
 	 * to be turned high in order to be detected by the USB Controller
-- 
2.17.1

