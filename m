Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344854161D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbhIWPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbhIWPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:16:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:15:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so6662837pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Mari3rXpEVIL/MKBwf7Gl4BPU8uaHHJQrmX15CzPOg=;
        b=f9a6wPA2/Ed139nmoq+9njwD0XVqlnEzQYvyODTZpMjfsazNea0OMf6K0Q+Jft1DeD
         O3FhuKxely5MvxnjeP+Hw71KjtWnQUgQEKTgW858KuxrO17LKhJt/1jpZbnDDE/l6Tup
         efMI/YAFqUm1STPTUJTNjMUuXTnoBMmzTf5CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Mari3rXpEVIL/MKBwf7Gl4BPU8uaHHJQrmX15CzPOg=;
        b=V9yFdOXdbNcgfn345SkmrS+OjjcjpsCqdb6Ocy8TA6333LyfTc30RffMdbvLlQoF2j
         Wf506RIImDmhegYTxHoGCTwpbIb/zARIWC8wEtBnN4x3bPhA8mOGKozDMc5PCvnxCTrM
         9ewDBqOeeDDWBLz1zPgdq2vGm85wsTJUX5jm7hBGGV3JR9XvZXW/PyJ4lwJx6XW+MgXD
         9kYWJt5ltdW/tuFyBlY23YhZQRVrFxkkHvoB9mJxs5fqHKWitui/10zykpAcycEMjc8p
         SeaQduqQYDE8Eswu6iWVjpguAlU51A/Ml/vVssep9UqQrRrhAijEMYPmRFIVEuQJ0L5v
         P3Uw==
X-Gm-Message-State: AOAM531dpB2JI370wc6fjzMSw/gxdXIdeAoaCIHYiOXBS4pToj2x8goq
        nns/TByj2KNPfG0Jgw6JCqzN+Q==
X-Google-Smtp-Source: ABdhPJzwhEuRwdUoHrmNTU5q/yYWuNBJursV7vpG2LiRw6Ys4fKbud5vR0OVEyxYD9sVkTgMk3WULg==
X-Received: by 2002:a63:e413:: with SMTP id a19mr4695277pgi.408.1632410107206;
        Thu, 23 Sep 2021 08:15:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:4b4:fd97:7a10:9739])
        by smtp.gmail.com with ESMTPSA id x9sm9591749pjp.50.2021.09.23.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:15:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Base homestar's power coefficients in reality
Date:   Thu, 23 Sep 2021 08:14:04 -0700
Message-Id: <20210923081352.1.I2a2ee0ac428a63927324d65022929565aa7d8361@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base dynamic CPU
power coefficients in reality") and the commit be0416a3f917 ("arm64:
dts: qcom: Add sc7180-trogdor-homestar") passed each other in the
tubes that make up the Internet. Despite the fact the patches didn't
cause a merge conflict, they need to account for each other. Do that.

Fixes: 82ea7d411d43 ("arm64: dts: qcom: sc7180: Base dynamic CPU power coefficients in reality")
Fixes: be0416a3f917 ("arm64: dts: qcom: Add sc7180-trogdor-homestar")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index cd3054226865..382f8c6f1576 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -51,7 +51,7 @@ skin_temp_thermal: skin-temp-thermal {
 			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
-			sustainable-power = <814>;
+			sustainable-power = <965>;
 
 			trips {
 				skin_temp_alert0: trip-point0 {
-- 
2.33.0.464.g1972c5931b-goog

