Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6801344A650
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhKIFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhKIFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:36:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BFC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:33:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p18so18815300plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLjicxNmNpYNSdlDLoBw1hRqse8yPujz3RAWyTpfEac=;
        b=odKCJ6d7H5bH4EsvYJwQsBe08JB8jHarQYqDI5Kfwc2NLU+hySWtFgWDhQox7QAke/
         9UTGnVcsxADRJFMy3iVKlsYAdiG/6ChqgO4Iqd/v2O91diGHSJajZrEL0t6N6N7373wQ
         C59FjlO9LlxmwUN4zx8GIG6KKQPHA2yIrygYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLjicxNmNpYNSdlDLoBw1hRqse8yPujz3RAWyTpfEac=;
        b=KENkhFUSgEh8Ltc6nuEqduLPrvnLyy5cfaFQvgw8s83pALXA/y+k2+sQya2kJUmTEX
         MbNntC5wPUzQFByFeMzCXLVp9fHZLRmCoz4KxnRGfPhsHQFZ8tJ5K+bpp6MvmsZZJgY5
         XiwGb64NHvAOFVYcA4e4N6tUpwsPBEKQc3JNkLrwr4v50nD+l8JRDa6dsu8LerZ5JPQO
         vqe6woR+5/diz6Nq5aJ31snPrM0VEarw806Cgl9czmT/kuHgrCXqMYezJWf0VQB1wkwZ
         DFWD4yshZduRjaXYZT4BYsm3df06gdMuXMQr9/M7oUGDmj5W4YgbDbjxKr3JFmNlNxIo
         OFDA==
X-Gm-Message-State: AOAM531FgJpcTYEwPJUU4zr78v09Q/tRUDyRL9A/dGFABBUirRN8ePXw
        ROii8wGD5yo7h+Fs7y/9xNlb2w==
X-Google-Smtp-Source: ABdhPJz7orF7lfNNUIyXu6Own8rdIu7+OsJ5fOjCVqxqThwEdRZ8ZBjzbGsTPGx6uq8/Cofpfn2h5g==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr4240138pjb.143.1636436018094;
        Mon, 08 Nov 2021 21:33:38 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cc3e:b71b:e327:fb32])
        by smtp.gmail.com with ESMTPSA id w5sm13741479pgp.79.2021.11.08.21.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 21:33:37 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] arm64: dts: mt8183: jacuzzi: remove unused ddc-i2c-bus
Date:   Tue,  9 Nov 2021 13:33:28 +0800
Message-Id: <20211109053334.1840273-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EDID is read from bridge, so the ddc-i2c-bus is unused.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index d8826c82bcda29..8f7bf33f607da2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -9,7 +9,6 @@ / {
 	panel: panel {
 		compatible = "auo,b116xw03";
 		power-supply = <&pp3300_panel>;
-		ddc-i2c-bus = <&i2c4>;
 		backlight = <&backlight_lcd0>;
 
 		port {
-- 
2.34.0.rc0.344.g81b53c2807-goog

