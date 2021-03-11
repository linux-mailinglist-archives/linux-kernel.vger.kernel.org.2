Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316CC337F76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCKVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhCKVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:13:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1539C061762
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:13:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o10so14474819pgg.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hu6N2c26ob5VSIjkLdDPo/XEQBI5GcbOJ5Q5+a/XrD0=;
        b=VY/tVCOyvjoZ/Z3CoAWkFRM/TecX7OFfGs04TDrnK9CjQuxrVSbdKh4hx07J62ZxwE
         C2JwJbYywAXlTPU0bneB9EkbtScBSL8nr+lnQBlNXusun5VLi4wftKtPHLtA0b7Vhk8K
         FNCnhMpOMuZ3ANj6WTKwv6pjGYNvi6DgnFfBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hu6N2c26ob5VSIjkLdDPo/XEQBI5GcbOJ5Q5+a/XrD0=;
        b=oUWiBmT3fSF9QIWzVTF6AXDRpBDZUvEkf7hZ59D1+26Ye551X/RIKYNVck++EpGUHe
         i1NAa8rkvcjPMFdQCMvDfZ+RRUSWcZc+ZhJhWtmfXg5dZPB4UPNe73tQIgRQrchPORfe
         bs/+LJ6OKN/Hoj8nfw7bftapjcJrblcP4GoUK56ucwDPXQyuLohEB7m5fxsTCfODxyob
         M/5fkrWIwW4NCdHKPYMZgBPDArmLrhChRUp0dE6gv1Zmti8KOCc9SKFew9nnUzKiEatd
         NT64WGtjrKlmBqM4F7hEqUn+nQjE/DXBe3DdJprLN53+b50iK9Ppy8yWROwONanrz4pv
         nppQ==
X-Gm-Message-State: AOAM530hBzBTarLbxu5lq3rDE2MgBrg3e/0wEWeRpC1+BQAZKdZrZ4PT
        5YwtRWMp+ZCp6nzpv+tge5lHDw==
X-Google-Smtp-Source: ABdhPJwF9dj5QdrWGGlb9ywhLjkfy+TrcolBRDSOohdN3oPACrGh8qyfegAb1VPZ6PmONDFrj2NYvw==
X-Received: by 2002:aa7:9989:0:b029:1f5:aa05:94af with SMTP id k9-20020aa799890000b02901f5aa0594afmr9276024pfh.34.1615497184169;
        Thu, 11 Mar 2021 13:13:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:cc68:8f0e:75e5:47ab])
        by smtp.gmail.com with ESMTPSA id l2sm26428pji.45.2021.03.11.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 13:13:03 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, mka@chromium.org,
        Tanmay Shah <tanmay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Drop duplicate dp_hot_plug_det node in trogdor
Date:   Thu, 11 Mar 2021 13:12:41 -0800
Message-Id: <20210311131008.1.I85fc8146c0ee47e261faa0c54dd621467b81952d@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

This moved from being trogdor specific to being part of the general
sc7180.dtsi SoC file in commit 681a607ad21a ("arm64: dts: qcom:
sc7180: Add DisplayPort HPD pin dt node"). Then we dropped the pinconf
from the general sc7180.dtsi file in commit 8d079bf20410 ("arm64: dts:
qcom: sc7180: Drop pinconf on dp_hot_plug_det") and added it back to
the trogdor dts file in commit f772081f4883 ("arm64: dts: qcom:
sc7180: Add "dp_hot_plug_det" pinconf for trogdor").

As part of this we managed to forget to drop the old copy in the
trogdor dts. Let's do it now.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
[dianders: updated desc]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Sorry for missing this in my last batch. I think my eyes glazed over
everything "dp" related as not-done-yet even though this one is easy
to do now.

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 436582279dad..192e2e424fde 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1155,20 +1155,6 @@ pinconf {
 		};
 	};
 
-	dp_hot_plug_det: dp-hot-plug-det {
-		 pinmux {
-			 pins = "gpio117";
-			 function = "dp_hot";
-		 };
-
-		 config {
-			 pins = "gpio117";
-			 bias-disable;
-			 input-enable;
-			 drive-strength = <2>;
-		 };
-	 };
-
 	edp_brij_en: edp-brij-en {
 		pinmux {
 			pins = "gpio104";
-- 
2.31.0.rc2.261.g7f71774620-goog

