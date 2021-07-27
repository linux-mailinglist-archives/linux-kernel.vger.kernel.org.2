Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618CC3D7435
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhG0LWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhG0LWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:22:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C25C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:22:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n10so15513419plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9OpObOhNKRT1oPCp9Nu/AHOlXXiMYSXBYlg8dkzJ3E=;
        b=DiqnuquaXJwP3eaObksalDscAsH+YhayozsjW33Um66W84C9i6JolTO8sPjpHayoGX
         Ust6aHXUxkBKmmpQzgoYt0z4noDFlUKo7Aid+kRozpswPZwPI+u+dMdkK0nlTuOhLjBF
         ZdQ2JagFO3TqOd+66LDEiQ1243a2V6zstmblM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9OpObOhNKRT1oPCp9Nu/AHOlXXiMYSXBYlg8dkzJ3E=;
        b=VLvyoKZAwtzpGbV891IlySDUxfIWntVtUW8fU9bgTrBhvfZMRmzuyNoe7n1XwNozEo
         cUV3OcT3W14l6i6kuqUhjV0KtwjBr4tG9GfY3xhljpisSDcknJ9tx5nkjAGBVDPtrQbY
         LPD49bwOYdpSV0MJ3Ny9bsQPg7RNDFMN3R8C8cST8dAn2zLL1kJ7WERoouaG16tGa75a
         xTTNoFmpkhoh5D4GnvmAtnxrAsx5KdLvhaZm6yQ236DIcx8S+l2S5qjhGdGDk85ouRCm
         xDNWrKVM+Vb8ilxWxSB/Sb14i14n6QUjuK9w4P2JPBYBkX8zquIZxGGBdRxKcnKy6c7D
         iRwQ==
X-Gm-Message-State: AOAM5312PR6eImcTRAjZevHF7tGjRFlW0L2E+bAuvHLLMVrUi9U/LIEq
        Tz4OVLdBW7k8D3lEQuVYI02tIw==
X-Google-Smtp-Source: ABdhPJxj1u4Gxg84zfPYkvKEg+0aPmJrlpRhck/HakTm5IhumkZ5XEl0Y2WzjGh2P9uFjnQZaZYWQw==
X-Received: by 2002:a17:90a:f86:: with SMTP id 6mr3889825pjz.68.1627384933489;
        Tue, 27 Jul 2021 04:22:13 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id 20sm3506467pfh.15.2021.07.27.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:22:13 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
Date:   Tue, 27 Jul 2021 19:22:07 +0800
Message-Id: <20210727112208.2508675-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
allows the use of aliases to number SD/MMC slots. This patch use aliases
to mmc nodes so the partition name for eMMC and SD card will be consistent
across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v2->v3: fix indentation error and add more commit message.
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94fc..8e9cf36a9a41a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -13,6 +13,8 @@
 / {
 	aliases {
 		serial0 = &uart0;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
 	};
 
 	chosen {
-- 
2.32.0.432.gabb21c7263-goog

