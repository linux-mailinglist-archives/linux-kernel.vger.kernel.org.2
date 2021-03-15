Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432933C4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCORjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCORjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:39:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F2C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:39:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w34so19818028pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=actTwiUWVnuBfKNd4eo6gsL+oSGlooW2XvlXpiME//U=;
        b=TjU+3b33taeIPvWCr9LrJRwKbASE5h/1/36mQFFG1Qs8q/KUQTkLEDqcc5umt693c7
         b2E0PUBO/+KGvsfuKr4Zsh+NP8XbpV58I8seCvJ4I62+8bAjVvBg/6uY13HOElmvcAat
         GmRfGLGvnSyHmOY6C49esiHAN+YHHDDla8G7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=actTwiUWVnuBfKNd4eo6gsL+oSGlooW2XvlXpiME//U=;
        b=OgcyQTaOzEKXaQRaqAnYkHCympct8zdi0nduxeJ/XkZhi7xTqkpD25QLRlfEmAfq+d
         Z8NcSQJgOgD9Ycj8g0ekipQaP7/0KR31fSloq6bcNMRIK1FFKkKanhEsP2ryQ5aa72Hd
         GRIakhwsCH+LC/4pDdhL29Vq5IZfxL6rfil/1a6S80OLTXer2LqqLcxpq+5AyImqXXLS
         WfhEP5bnVa2G6/Uov0zTEZ/+3v6sVjFH3knH/dOTWH0/l0bpT7OBtqsa//wEuQBRVKxd
         kSrrI8TMNIa31bGnhl0hay3RsCUU2SH2H1BsHkMqLItSbwZzPyji7FtHgmDH0mHl2Pb6
         00mQ==
X-Gm-Message-State: AOAM531Le6ULtqEDIgGMJgHJhGEtXeUsYEEInTMy/e/5HcGc1nW/guQQ
        TNjlitcWbmYof+/etDmJ/xSTdA==
X-Google-Smtp-Source: ABdhPJxWHs2gi96AZyoEt/UwvdmHSnaKsqZDHZItliL+Gimic0yreRUGnvwYj1XiQCMcGkN+0GATRA==
X-Received: by 2002:a05:6a00:1585:b029:203:6bc9:3ca6 with SMTP id u5-20020a056a001585b02902036bc93ca6mr11233370pfk.79.1615829963877;
        Mon, 15 Mar 2021 10:39:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:14ce:2d12:6a1f:f42])
        by smtp.gmail.com with ESMTPSA id x4sm13638430pfn.134.2021.03.15.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:39:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Fix sc7180-qmp-usb3-dp-phy reg sizes
Date:   Mon, 15 Mar 2021 10:38:54 -0700
Message-Id: <20210315103836.1.I9a97120319d43b42353aeac4d348624d60687df7@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Dmitry Baryshkov [1]:
a) The 2nd "reg" should be 0x3c because "Offset 0x38 is
   USB3_DP_COM_REVISION_ID3 (not used by the current driver though)."
b) The 3rd "reg" "is a serdes region and qmp_v3_dp_serdes_tbl contains
   registers 0x148 and 0x154."

I think because the 3rd "reg" is a serdes region we should just use
the same size as the 1st "reg"?

[1] https://lore.kernel.org/r/ee5695bb-a603-0dd5-7a7f-695e919b1af1@linaro.org

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Rob Clark <robdclark@chromium.org>
Fixes: 58fd7ae621e7 ("arm64: dts: qcom: sc7180: Update dts for DP phy inside QMP phy")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 83fbb481cae5..61732e5efe62 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2754,8 +2754,8 @@ usb_1_hsphy: phy@88e3000 {
 		usb_1_qmpphy: phy-wrapper@88e9000 {
 			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x18c>,
-			      <0 0x088e8000 0 0x38>,
-			      <0 0x088ea000 0 0x40>;
+			      <0 0x088e8000 0 0x3c>,
+			      <0 0x088ea000 0 0x18c>;
 			status = "disabled";
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.31.0.rc2.261.g7f71774620-goog

