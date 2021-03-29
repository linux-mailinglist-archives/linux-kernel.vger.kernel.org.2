Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D134D49D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhC2QN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhC2QNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:13:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AEAC061574;
        Mon, 29 Mar 2021 09:13:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j9so11716494wrx.12;
        Mon, 29 Mar 2021 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZhzW4vGlptf3m5Yu0AgcPAv1OEq7UcLKHN0eiSAYY8=;
        b=SVM7M0Wc+ARI0ldCbAG8m88O4CdzrXYjMS0ZXc2LoTt27YeCA7FaEcxPzVd3pGLogr
         l5dMg6SVL978LlqtxAKwxP1sUWizPwL2FkTw5wfeoUj49DGoOnDkIoPSIt3TvxQnS5Pr
         gJQCRpP2HbJS65HVb5eF7NCcHwEws3Rz/mzSU6iDk09QzzU51tvUGrQtYYsqSsftak0h
         OPWNMbC/D/DsqhISu1zRO8zYKLEJkMqf3m9RPugowarXrWrBvdAxqHnvLzR0RWvnkJR9
         xqyP0E0wZW+OCLXDCLfEbbMhvkc5O6kS63olvMVM/hDzsz3WhVGmTup68P+go8y2wGJT
         ZMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZhzW4vGlptf3m5Yu0AgcPAv1OEq7UcLKHN0eiSAYY8=;
        b=GMJKkbaQMcchCGMqYg02IRPe8JkjsD1xYFxTlhhYqa+fEGfT6VuUhfLZEC+IY5pKW7
         Jr1oxtqcjU2JwrdTSdn/BMybKd55Q4eZFSlt+9x71L6aGMSrIdPfr/SXq5Zl/AzXDTbj
         gniZ1cOvCDdYEWsRGrnbgj1Rvza2GlcCvg9PNlIYq5lVJFtTad7Wmh9Hx69NMp5V/Hm7
         bArb5sB4VvrR8xvVMWrAuA/z0IU3rJRjBVVRDKhx5KSr5i3V6YniOiIsL+0Cw4nmEdsf
         5TLt2Hu38LmTH5iJCB1WgL7Ocie4o3k2tDsgj4k4Aebqpl6apJArpP8KDUzLzuuxUiAv
         FRNg==
X-Gm-Message-State: AOAM531nz5RTMai0WE4CC0NsX81DAy2r3k3jHav3zkZd4X4g14EYOj2U
        wJjWT22yFIchBugV9notnMc=
X-Google-Smtp-Source: ABdhPJxUCY6a+zgeNnE4fZUYOqKSMnPB8ZuOGJnXFf8Fa2+bMk8tyCxiNJ73gCeGKLgoM3en55VbOQ==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr12140559wrt.10.1617034386830;
        Mon, 29 Mar 2021 09:13:06 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a6sm28570964wmm.0.2021.03.29.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:13:06 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Hyeonki Hong <hhk7734@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson: add GPIO line names to ODROID N2/N2+
Date:   Mon, 29 Mar 2021 16:12:56 +0000
Message-Id: <20210329161256.31171-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329161256.31171-1-christianshewitt@gmail.com>
References: <20210329161256.31171-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonki Hong <hhk7734@gmail.com>

Add GPIO line-name identifiers to the ODROID N2/N2+ common dtsi.

Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 139c12cf9f66..4489715fc4f3 100644
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

