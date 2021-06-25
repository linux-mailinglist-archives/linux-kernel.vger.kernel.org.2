Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26503B3BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFYExE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 00:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFYExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 00:53:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 21:50:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so6597743pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4VjLVI1+JQezoGsB2rjrmRWITUxJ0Ev6QoBWCF5jew=;
        b=KqYq1jFKhlnOot+3QYTp5WDXOXMbvK/3orgEK61UgNT8430jPZTDc0wbGBxaoMwm9k
         UMoECpqk0Kyjps8GY/vqtiHc3XSEEuG34S/fd+e+uw2M2KLOF3qzwh6uqsiafhr7xlnz
         muSIlQdZ3cpR5lI6j9cTXwm8CvmioF7D+Tl/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t4VjLVI1+JQezoGsB2rjrmRWITUxJ0Ev6QoBWCF5jew=;
        b=LZfMtFJecFWgMt6z4EZ/KqJq9LQPixiq5/vxf+gpGodWGtyGddxoVJAL7c0WtywqeC
         qFFBN7t4+beovymhfMP9P9UR9fF66pMrZfLu5IbYGpEBvfD6xTvCXvJBQbcvVJl1F01q
         +ya3qGQWAhnpVJYFeSmPZYEZUJ+YcLkcrsBO/2j5jpS1YI3auIRQgQrpfvuj8n1yHrk3
         QwRlS0FplhpPzP1NdcSytvoSl/c12mbfZp2nbuu2zdRZnVMDswd09SEIzHE1aJ558yWg
         yNDw2Ndsma4HajzStvxfc7irAmTpHhXiyG6JOS6zHpvAN7RpkXHZBfcIcItr7QDuOk4+
         k98g==
X-Gm-Message-State: AOAM530DFaagAaknmDprCTvotpOCxTNHePb/me/7SGH4Dkt7/zdpMsKI
        q31E06VlEC5ki3Bpqk3ZzJUlpLXtoDnC+w==
X-Google-Smtp-Source: ABdhPJyhWBPiTtWwYwjfbIyjn/rCHweL/ULrqmPPZ+7r0G/oMgGIFubSmyglkFCJ3k0TyDaKrzoAlw==
X-Received: by 2002:a62:d408:0:b029:305:d371:b547 with SMTP id a8-20020a62d4080000b0290305d371b547mr8747502pfh.52.1624596639373;
        Thu, 24 Jun 2021 21:50:39 -0700 (PDT)
Received: from judyhsiao-p920.tpe.corp.google.com ([2401:fa00:1:10:284e:f3ac:295b:a774])
        by smtp.gmail.com with ESMTPSA id j17sm4270070pfc.139.2021.06.24.21.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 21:50:38 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, dgreid@chromium.org, cychiang@google.com,
        judyhsiao@google.com, tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: trogdor: Update audio codec to Max98360A
Date:   Fri, 25 Jun 2021 12:50:10 +0800
Message-Id: <20210625045010.2914289-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use max98360a dts node to correctly describe the hardware.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 77ae7561d436..38f1fababc33 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -247,8 +247,8 @@ pen_insert: pen-insert {
 		};
 	};
 
-	max98357a: audio-codec-0 {
-		compatible = "maxim,max98357a";
+	max98360a: audio-codec-0 {
+		compatible = "maxim,max98360a";
 		pinctrl-names = "default";
 		pinctrl-0 = <&amp_en>;
 		sdmode-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;
@@ -311,7 +311,7 @@ cpu {
 			};
 
 			sound_multimedia1_codec: codec {
-				sound-dai = <&max98357a>;
+				sound-dai = <&max98360a>;
 			};
 		};
 	};
-- 
2.32.0.93.g670b81a890-goog

