Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92041079F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhIRQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhIRQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:43:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E29C061574;
        Sat, 18 Sep 2021 09:41:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so20468473wrb.3;
        Sat, 18 Sep 2021 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTKqIcca/utcTTxlHf5hXce4bNe2j9wD2CfxEiVjuFM=;
        b=XdmBouuGb1eJjc0Mdka5weBctR7j9RNQcXzM7BKsoFMapfO+4pFCKgo9+uuLcPRGi+
         7C5BJqLWqZNz3yVoLAREEKRiA4N22Iv7/LZYd7ZNa38fWZPtJx9jO5NGOlcGekdKbcdj
         PUz5h0dzFjxr4mCVBRQ7di0pRxKF9+pPmW8urs86yPbKuxb09/FNhTR2obViREJ1i+Sh
         4NoMnPSGTS90VooIupcVe8E+fMkinXa5Qq5QFumfcqwaQzrJb807DPxzcu/C9HGF80P9
         6RAEs7qcNJ/JhPu/qK8pqmtJYzmY03MhlXdbPrj6Of0pWy5pUkL4PrJHycw97t2jlV9+
         FeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTKqIcca/utcTTxlHf5hXce4bNe2j9wD2CfxEiVjuFM=;
        b=5D5f7nToBF9kA78j6CZcUbAjWKA8pVsKgxj30xpiQ/h+ghTfe166Yc0okHjtHDIheI
         1wTMYhhOajhJHylls9mcQj2Tk44jd5Lzkoa/QQMPKh/gzXRe1H8FXCbtehTgu6LYRZzO
         UqLNEOJNfzZ2i2i0NEZ5KONr0Tw0vXMBoGp8X1BOhJtiQU8/GggWuZ6NE6UXp7xwbCE0
         M4Vh97jDg4a/8q3Sx1ktKFyxwH6+F54LcflFVqvyZI71JMeqrDWM5t78jMS+4Ym53sDH
         VpgawweuCeCZC/Te/mhwjRUFlKjF2GhhcAYQIBC4VCzRK7n7bcwzZjjfM7WsRew8HnTE
         NRpg==
X-Gm-Message-State: AOAM532Zlqa0LBsAkwdJiwZdji6TL8PNtkdxU6DbbMfyeJwZ+IFo0ahM
        2TgoMUn4moS6EvKbGSlRRg8=
X-Google-Smtp-Source: ABdhPJznYWiLeTeU4vmOa96S+2effptTpHYjKKQFxyfrHhPyPcyEb/hRezc2U/W90vQHZth/2MrEPw==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr20037150wra.216.1631983316448;
        Sat, 18 Sep 2021 09:41:56 -0700 (PDT)
Received: from tom-desktop.station (net-5-94-68-9.cust.vodafonedsl.it. [5.94.68.9])
        by smtp.gmail.com with ESMTPSA id j98sm10705219wrj.88.2021.09.18.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 09:41:55 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix: PCI reg address is not configuration space
Date:   Sat, 18 Sep 2021 18:41:51 +0200
Message-Id: <20210918164153.207146-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index c1bcc8ca3769..799580314c1a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -461,7 +461,7 @@ &pcie0 {
 	vpcie0v9-supply = <&pp900_pcie>;
 
 	pci_rootport: pcie@0,0 {
-		reg = <0x83000000 0x0 0x00000000 0x0 0x00000000>;
+		reg = <0x0000 0 0 0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
-- 
2.25.1

