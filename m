Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B973D741C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhG0LPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhG0LPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:15:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC6C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:15:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so3623332pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHNyu7k4UK63DVq7rOYoExZI6cBgQIh7p/Fi6u7I8PE=;
        b=DGLK8ZaGcLZ9qrMkM7KdMWjTsFlwbZzg7dIvgy3A8POI0ux2QLqiOutfmPLYOEy4S3
         SP9jaEuFOZwpSipJm9CdJ26hVsVcFyDj2KUHgIZUqc0dxdkxJ7F20hWTGNo4LjSloYR6
         76hzq7Dk1EiJMfPvfji7Zk5dTMsT4XQXW9j8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHNyu7k4UK63DVq7rOYoExZI6cBgQIh7p/Fi6u7I8PE=;
        b=VFRy6HjF+ZG2G+nvwksSTkKkUt95iRhQ2SLOx6tA1hCkQ/tmKzMZUEoGP84ly2M1lE
         aLXq3+hhTcq95t+t6ctJ1Hb/7MzscvMpHST2VaNgHYHJmBmcZZmdXZuVZ4+lEvrDRDtm
         bIicz5WtMSjkyRU3OWEm+c6U4KPrBj/VkAzRsy+yWavGc6FHl5YX6sUAw2C7+tj00WU9
         kqpLFn839p4GFiRZ8IBDg+2W/WA6CsyF9Z+wYsuLyH/6Gi5UoXGTVhJIT1W88MwTRCu9
         Ewln4N7/HwFHmON2z11wTrAvRmbPp5bJiEv7ka96p2Kb7BmfNHh9ddXW9eBWvqg4zwHO
         48Bw==
X-Gm-Message-State: AOAM5309uQYo6OXhyOJ3YAcLaPhOutdgeCT6BdBonSzTgxWKMZN/LCyr
        CCtsdstX8EU9R2q3AsBkMkMjhA==
X-Google-Smtp-Source: ABdhPJzIMWQIKWL3D4AB+HqQObX91XCw/5cAdIwjOgJtQrBbMGoOuLOom54j+toKSzvKj0sN+PeEJw==
X-Received: by 2002:a63:5344:: with SMTP id t4mr5589835pgl.372.1627384507409;
        Tue, 27 Jul 2021 04:15:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id t1sm3362305pgp.42.2021.07.27.04.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:15:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
Date:   Tue, 27 Jul 2021 19:15:01 +0800
Message-Id: <20210727111502.2506311-1-hsinyi@chromium.org>
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
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ae549d55a94fc..ed499e17b6570 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -13,6 +13,8 @@
 / {
 	aliases {
 		serial0 = &uart0;
+                mmc0 = &mmc0;
+                mmc1 = &mmc1;
 	};
 
 	chosen {
-- 
2.32.0.432.gabb21c7263-goog

