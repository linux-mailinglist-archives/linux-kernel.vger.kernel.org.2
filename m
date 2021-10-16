Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD5430382
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhJPPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhJPPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:48:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF0C061570;
        Sat, 16 Oct 2021 08:46:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j12so5208105qkk.5;
        Sat, 16 Oct 2021 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJw7aF7DxG9NnVA6g34yZ865pnpXfhLPwQt1JZttLHs=;
        b=nSufe+7arm6icB5EEbIr121817RNffkcgx+AQmFpYuKTO3aikT4ueYPebn3ZFOxxiW
         mG6KUJgSOx3RDjzP+jyLVSUKfuZz8ea7WXfRj8pLCHP6BNYA2X1aG4vjdI+3wt1MpZU3
         XXaOBgViUkIX9QpXx6hmGYrkHzwKcO76ipcp7Fwdr/MuTIcePtkMSpeMgH1SIm+xUn1c
         EJfejFPIDA1tp7R92Z7vW0uHb5h9bBhcHubNe4YrS+VNJb5ANxzjDAS457f51NYKyOBd
         UUjvCL9irESOLxFmI0VRjRSlFXWfULZTMEKfYcy8AKtk8AxaIcUYy/T8ck6NNqGMthk6
         ATjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJw7aF7DxG9NnVA6g34yZ865pnpXfhLPwQt1JZttLHs=;
        b=wE074NXz9/NOntG5Su5iwTBvlUrh0OJaVPELF9p3QEvvXH23ZqFg0QGeAUE2E0MBu/
         xOJwZewdOON2G0/zNDrA+Sql9DcopslTkLQjp9OGdbegiSUNnb4zUcGhYA6bYS/eAxBq
         pvhYK4zZvmHXCiDwKe6V5GhqUDb0nZXsod+1Mwrccplr1CYmfwiEdmeeTqDpkVkAQ+iV
         MCy3EYx4P73kMM8jnNrKPYD/J/fI1UZeeKNyQeU0Wcpa0KCWhkYn6RFJP5csZfR4sqR0
         OpYElkSdjegHJZ9bR6yn7r4lG3bMU8/hkkyKaAnA4zbu1aKPtGTGeBamVzq5HObkkjE/
         JzVg==
X-Gm-Message-State: AOAM530Gtn/h3F9/LJqWSI6Rc2GSnb5k7EJSJ8mR005Ad5A1g0bEwHLY
        uUn9Ix0LiVzW15bRbxvHqAAKJlJNBFk=
X-Google-Smtp-Source: ABdhPJzwHdseQdrE783rhDJjxBOWvnkcfPzKhbI8sgu8Ytmb+boDfLWyTDwEIjUoJ7HydBCy8oAoKA==
X-Received: by 2002:a37:aa07:: with SMTP id t7mr14980731qke.158.1634399166625;
        Sat, 16 Oct 2021 08:46:06 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id i13sm4047978qtp.87.2021.10.16.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:46:06 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Cameron Nemo <cnemo@tutanota.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 2/2] arm64: dts: rock64: add gpu regulator
Date:   Sat, 16 Oct 2021 11:45:45 -0400
Message-Id: <20211016154548.29555-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20211016154548.29555-1-twoerner@gmail.com>
References: <20211016154548.29555-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regulator for the GPU in order to properly make use of the newly added
operations-table.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 1b0f7e4551ea..e76673d5fdc5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -133,6 +133,10 @@ &cpu3 {
 	cpu-supply = <&vdd_arm>;
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
2.30.0.rc0

