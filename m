Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53D2402ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbhIGTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbhIGTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:13:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4A9C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:12:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2170182pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnPT7TZlHwBRf81I6W6ByhmDCzRA+iXQVz1iuWwpEPk=;
        b=jwLx1B6GmssJFxY3kASF5YTUFXXdfgDw0YuywVVzjcQeIDRG8PNSI1lzw8qb6Vm3py
         c8mGaovEAYhU35c1Eumh6GP370deyfBoP5KbhOBucdX9gTv4ERB+vv8N2WPAG7c+gQ+I
         4YENQVcnjfqxeG/NXMreXD5a+SKXWilpY1jsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnPT7TZlHwBRf81I6W6ByhmDCzRA+iXQVz1iuWwpEPk=;
        b=o06UkW3S776IGRcIHTl94LwUj3u0KFqNPwTtlcvnbHcdp0BwoaY9dYRA0bER4gmE24
         DYHu7wYP0ycMOGSY6uPbxHxDuB9VXPJiG4A6H75oE2C99AAC1xaZU3qcFSFlIW09f7a9
         1eDeu0Wy/1F2EiTbO584oIxMId/aSODpJtlC2ZTIVm9tfSrAT/gSd75p6J1vJHUOrRGZ
         xr6sVwbWAWcmDPL9nvrawyHgJMUptfhK2Eitqk8YdysoyZ0rcmoexXR31yvOZSKM76zY
         XkVaa60eEsFd3MadBT5CFoqXor7rneFt0OU0rgjBAhQ1Yu+APLgHksycsmEl7bUtjzzD
         uORA==
X-Gm-Message-State: AOAM531DXI4NaYVLC6OEkuCNaINZjOjd3mKfx8yLTZ1iU4XK8snfRBYo
        9VNXWmb28o739612vfKMtj/P0g==
X-Google-Smtp-Source: ABdhPJzd7mDwV3VCuENrJaBXzRLB4DGhgEbjTDOpjjxyR1IUZZCSnwLfixwDx4pbPzqXCr5uOaXsyw==
X-Received: by 2002:a17:902:dac7:b0:138:cee7:6bbc with SMTP id q7-20020a170902dac700b00138cee76bbcmr16049540plx.0.1631041966143;
        Tue, 07 Sep 2021 12:12:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:188b:a5e5:6bb9:6ce7])
        by smtp.gmail.com with ESMTPSA id c15sm11102224pfl.181.2021.09.07.12.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:12:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "arm64: dts: qcom: sc7280: Fixup the cpufreq node"
Date:   Tue,  7 Sep 2021 12:12:25 -0700
Message-Id: <20210907121220.1.I08460f490473b70de0d768db45f030a4d5c17828@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 11e03d692101e484df9322f892a8b6e111a82bfd.

As per discussion [1] the patch shouldn't have landed. Let's revert.

[1] https://lore.kernel.org/r/fde7bac239f796b039b9be58b391fb77@codeaurora.org/

Fixes: 11e03d692101 ("arm64: dts: qcom: sc7280: Fixup the cpufreq node")
Reported-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 53a21d086178..fd78f16181dd 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1850,9 +1850,9 @@ rpmhcc: clock-controller {
 
 		cpufreq_hw: cpufreq@18591000 {
 			compatible = "qcom,cpufreq-epss";
-			reg = <0 0x18591100 0 0x900>,
-			      <0 0x18592100 0 0x900>,
-			      <0 0x18593100 0 0x900>;
+			reg = <0 0x18591000 0 0x1000>,
+			      <0 0x18592000 0 0x1000>,
+			      <0 0x18593000 0 0x1000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
-- 
2.33.0.153.gba50c8fa24-goog

