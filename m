Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186563C3D81
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhGKPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhGKPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:01:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F66C0613DD;
        Sun, 11 Jul 2021 07:59:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o5so28149354ejy.7;
        Sun, 11 Jul 2021 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kVKa/qYsm/LpBgzMfgFjq0sOew6IiQd+6gndsgTAoYI=;
        b=Ykk/6xz1usz9fsC1y04TF/bA30koNu2R8BTHIxArpRCZDmuJrslu6KANI2roRVhGBS
         VM+vZkL8+Y+BuIPs8o6l60nvMUc7b8R5ArvXkFIZzV7w8TVdRzg7w3aMp2uP5MCZNGsU
         J6Fob66RzlCNPB0Ta8ZRBbmb//bhNd0oWxTujujnk2GUkmH13ReXUD9l1wrBtx/MDwck
         T8aIuJvLv1/VrCAaTw2RVRN3xIDNPTb2Q2F1uPMFYUlPFNIDaYD2HNTzkC9qC3lFr2v6
         8xDvjKJm1oHANCEKYPcIdBvHNkc1v0BAUsrchPvVh8REUsoqtZGl7z/c4x2+mbjmjJKu
         WOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVKa/qYsm/LpBgzMfgFjq0sOew6IiQd+6gndsgTAoYI=;
        b=DcnrJML7h/mWejlndhBOsL0E6dRsgvUbs2+dAeEAQcGQdHjG6I4fda7GYcO1s8H641
         Ggdcyj6ws6P8KcqB/aE/E7DoMkAuWlZmcwqD8DEQFwxU7q+2ZFOzQLsT3tQI2HOf6XlC
         nSJIeczuGv/W9KynJlVyS18vzURf/lT3qLsvvKQQghLaJyzDRH1VsWrMHct+dMcS225o
         YATvMB+DBp7fklArgDVqONiAIvgG78JV7AUhox6xPWw3epBtRTeITELdQoQzWJ5d8uOG
         wYj198VTkKH1I+/wpJbdz/w3hNHCdxzBFI2rl1rrdsKyuZH9eZeFL6IpDaq1uL+bWj8d
         0IxA==
X-Gm-Message-State: AOAM531VJ3qTYptFGxDZXWnSl1+zpEdK6QFVwt+M8II4n1FSFVg7pkVN
        +vV+GzfLlHn47lgvFdnmT2r8UOJFKq2Z/Q==
X-Google-Smtp-Source: ABdhPJxiqiHLAFDJEPlGH9Q9L7eaaJxjFmJd+1auawdbNyKHUZxhCQNu7/YDdiqHmB1tyW9wPQY6Xw==
X-Received: by 2002:a17:906:660f:: with SMTP id b15mr48961130ejp.443.1626015548161;
        Sun, 11 Jul 2021 07:59:08 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t4sm1318045ejo.125.2021.07.11.07.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 07:59:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rename flash nodenames
Date:   Sun, 11 Jul 2021 16:59:00 +0200
Message-Id: <20210711145900.15443-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes with compatible "jedec,spi-nor" are now checked with
jedec,spi-nor.yaml and mtd.yaml. The pattern is now
"^flash(@.*)?$", so change that for the boards with a
Rockchip SoC.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 1b0f7e455..f69a38f42 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -345,7 +345,7 @@
 &spi0 {
 	status = "okay";
 
-	spiflash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index c1bcc8ca3..e310b51ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -543,7 +543,7 @@ ap_i2c_audio: &i2c8 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-1 = <&spi1_sleep>;
 
-	spiflash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 
-- 
2.11.0

