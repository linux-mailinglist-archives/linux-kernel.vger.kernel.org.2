Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167BE329FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574784AbhCBDuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbhCAVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FB3C061223
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:53 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b21so12459699pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/ES7EoSoJaRFBTGOtbPv13oD9ftUP+s4gLfSf/Rgw0=;
        b=Of5Qr/1nQ4QTWCJUkTgVjJX/4i11srD3k6K3Y3f9FkGpfmUkd/Wl0ybeV5COOC4rwO
         bMexSfglrY+AaDkOXQb0hPe7t/KY/hJghH3r10hg6mxI+69xeznPFexB72VksXlb/cTK
         0nBeTgW7oDT6yCRspH1RHmZLzG2J7o0GcnD58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/ES7EoSoJaRFBTGOtbPv13oD9ftUP+s4gLfSf/Rgw0=;
        b=euZsY0m2f1P9WjPndc2qDwx2AuQ/xEay9+VITFZVsB5fvtSQD2qjeD2c+327FIixmi
         Y82AVfcHTQ4iRao6lm5OSq6ZyrRQAT0OnOKQyUeZ3GDs8xPS6JCG2R4LsKk2+nFE34dK
         BmLnuFnXEKZgHWTU1d8cocuhA8/9c3ePJIJDp9FQ2p2WxlMxBhXRGOebvkPttd1oiwEl
         tj2nJCGb699RTEenYMTRGt3vsy2PYFHl1bQs/MXahr4TxHs6ihTGxD4BubAkAZdOI0/Q
         rMSO0DFJfra0vp+lY3gL3R/muWJylhm08cREVjTBmSpTBXSQa00aWb+423ZcxaWxsSOg
         okfw==
X-Gm-Message-State: AOAM531yioVzryNPF/BDHMgwotDjLSOGUpTZb8GP8QuNppA2TurdHbvW
        cv0QoWsYCm0qm6bGPq6eEzUXCA==
X-Google-Smtp-Source: ABdhPJzSOFdUhCOZpqR5k47xIE73ykGkKQsXXZIpqcez2jAozspNahIq996f/SXCmfgJw4/uKrjv5Q==
X-Received: by 2002:a63:cd41:: with SMTP id a1mr15448738pgj.177.1614634493162;
        Mon, 01 Mar 2021 13:34:53 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:52 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] arm64: dts: qcom: trogdor: Only wakeup from pen eject
Date:   Mon,  1 Mar 2021 13:34:29 -0800
Message-Id: <20210301133318.v2.5.Ib9672bfbe639c96c85408d6f0217a2609eb0b70f@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Configure the pen to be a wakeup source only when the pen is ejected
instead of both when the pen is ejected and inserted. This corresponds
to wake source requirements.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 7341fe6e2c0b..2e5e3a8f210a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -245,6 +246,7 @@ pen_insert: pen-insert {
 			gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_PEN_INSERTED>;
 			linux,input-type = <EV_SW>;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
 			wakeup-source;
 		};
 	};
-- 
2.30.1.766.gb4fecdf3b7-goog

