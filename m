Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1339BE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFDRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:10:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99F7C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:08:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jt22so15578881ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OoQ9gA8dbbWK1PtB4dCFVLRMGfxxHdj7P0i/xhgg55I=;
        b=vTUoh8iFX3WkURlZGhaLT4GCmDnGg2CBfohcDURDFZ8JOOKfDNWxGtN+siZlEUUCg8
         eOC+yekb2HorPEMH374VVAe8ep18bRtQUp/CNQxyifMSoI6iWViNQqwdCdGx7Jg8AQK6
         wtPbe3nXeWZBlZ8QJcEaZJZ3gX2A+DmTCODTu441hfpIs+uExsJGdZU82cZAd5W5/Kdl
         oBIP0W9Ww7QN9kvGEArtmMI9iCfEwZ10cC4OrR3NOj5cD0ZakkJvuvOF24nqWrGE5bZZ
         cvkdYzTGfYfACjRNkw5FixPCHtUTg2GeRMUkcmjHOlCXWHDb1Wj3aJG3MCq8s5SUbgep
         Ukfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OoQ9gA8dbbWK1PtB4dCFVLRMGfxxHdj7P0i/xhgg55I=;
        b=mgPOKLokDZDrNcTgRkiOP6yQHy/0Xz6ByofApj+uPMggRjbpaKLNPxgx5SEPttX30O
         gGabQbk431xgnmdNCV1iDKCFynPLtE/sF+kubu53ws58ZdZYzpehBjUs5nGtbnrmIXEg
         7J+21tM63ghp26PefsyvbNO/n6x2mfIvYvEyaad0wYTHlTRRmkQqXTEEL0nSpsjC5SAY
         sSAE7CD23XphOZc40RkW1Loglt/yg7u+yvAIny9U4gPG7D9nAah79nYQphSXGY7T6IwM
         5kVSbHmeB221BXLPolqnoI+hwO/TSaRjKOp4roOp1WugCyfD7hKiUKghLRIwVmuKPsCH
         YVZA==
X-Gm-Message-State: AOAM530JZk7A8BhKGOhp/VoGEqaDvNSbRUQ78y+kE/eg925YLLpiWxWg
        kTW65oEQL9YZwAjP2DYKnMw=
X-Google-Smtp-Source: ABdhPJw7lDvO1MHuloAiRRHK/9CSD4zYB4NRxtgEq0HCbXnurenuq1Ztwl46ypeON4Bk3azBqhh8vQ==
X-Received: by 2002:a17:906:6981:: with SMTP id i1mr5123333ejr.289.1622826537290;
        Fri, 04 Jun 2021 10:08:57 -0700 (PDT)
Received: from localhost.localdomain (p200300f137127c00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:3712:7c00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q26sm3010663ejc.3.2021.06.04.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:08:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ARM: dts: meson: Set the fifo-size of uart_A to 128 bytes
Date:   Fri,  4 Jun 2021 19:08:44 +0200
Message-Id: <20210604170844.2201229-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first UART controller in the "Everything-Else" power domain is
called uart_A. Unlike all other UARTs (which use a 64 byte fifo-size in
hardware) uart_A has a fifo-size of 128 bytes. This UART controller is
typically used for Bluetooth HCI.
The fifo-size of 128 bytes is valid from all SoCs from Meson6 (or
possibly even earlier) all the way up to the latest 64-bit ones.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8bae6ed0abb2..bd0e864964e9 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -50,6 +50,7 @@ uart_A: serial@84c0 {
 				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
 				reg = <0x84c0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				fifo-size = <128>;
 				status = "disabled";
 			};
 
-- 
2.31.1

