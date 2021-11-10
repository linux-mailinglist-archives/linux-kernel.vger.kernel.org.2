Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9322E44BBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKJGeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhKJGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:34:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6BC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:31:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g18so1749209pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLjicxNmNpYNSdlDLoBw1hRqse8yPujz3RAWyTpfEac=;
        b=Gtn4k4zzu3W6ljfQD1cvBo1rwiOcUgXBRBafENUqpx5Wk3/Elt1T+pI3Pmb7uAQnay
         P6Z+NUHvKTtOQN4Ek9pvPReyXFOBSlulbtA6qYgiH/tbNY+puEmzxNzDvYiQ0Fn6vEin
         rZaEP67DtUT74PfPez9hZt2FVTWSGkBj+9X2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLjicxNmNpYNSdlDLoBw1hRqse8yPujz3RAWyTpfEac=;
        b=Y5yfsCyz2BCnLZSzSIpc20VHgNBbLFEtAWxCm8fA4qJ0LzD0hRuiIlZ4Pn/Bcr3fEX
         6KTSiT+TB9n/2Z4aqCz40ccdlsF/jQ8DYLzCmhYE1CyN5gyG5KQR4loyuUhmbaQ9xDE+
         g9sz4TQ5CYSi8EnkR0MlvG5kPbpNBKvLpO5EF2lJEXkS+QwgJioZlqs2efR0rGSrQTMA
         zMPZLAB5+2rC+aD8gH2mwjEmczEymbqupyLy1KbOMP8RKlNQgIsHOpbPrKynn2Lpqauf
         u4QyC0k6k6bVC6ct9M8eukU5y/3dQeIqMu7wYjoZmgdCJDGgynCj9cPTRoBCX2p4Ri02
         OAYQ==
X-Gm-Message-State: AOAM532vMrFNOe3++pgzjqzhuiNld6u7MV3JGvZn5IvM3nOs5uC+pP5h
        H45rayfou5CKwMSMoRkGEvMmrsHHRo2m4w==
X-Google-Smtp-Source: ABdhPJwh/XmhIgwBxJwYcav1VPaKKJl7gxfyiZhW7q0qH/IvtJeKhRTimzl4lnxVJpIpXTwItejE0g==
X-Received: by 2002:a62:1d8e:0:b0:481:598:eb97 with SMTP id d136-20020a621d8e000000b004810598eb97mr14860418pfd.39.1636525882526;
        Tue, 09 Nov 2021 22:31:22 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6886:f712:1a79:e3d9])
        by smtp.gmail.com with ESMTPSA id w1sm15623959pgb.50.2021.11.09.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:31:22 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] arm64: dts: mt8183: jacuzzi: remove unused ddc-i2c-bus
Date:   Wed, 10 Nov 2021 14:31:12 +0800
Message-Id: <20211110063118.3412564-1-hsinyi@chromium.org>
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

