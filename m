Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C75397A27
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhFASqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFASqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:46:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:44:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i5so132608pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2TX2Vdw/o0zaTAKknUFEUNmG6BDmXhWCNuSw8+ULck=;
        b=L1fnkDVpJ/NPH+VgFT9ATs+Iu0eyrT8uz6GPjPikqry3DCOwqwQAPAZn3xVm1R+j0A
         MJvVBxIUOv0EUZSF1rtfD5FwUeDp4UYUICoIZ93z1HODM7rdqgSCCaJMRjgRomuVCa9D
         G7exwru7qL82YjXqlJ0jOIbPxXSW1TW/WOK7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2TX2Vdw/o0zaTAKknUFEUNmG6BDmXhWCNuSw8+ULck=;
        b=HTYtVERd6nCss4bx++k9sJLXM/tXUAp9D93TrEYeJJssvUgSu2rpFja6ub0qnBDwXY
         yMCrkQgCymvNaTU755qefyGAgYkeJxUXkyg/hzUxCD70lYUOs//zV+svV0xrSoqrJxzB
         1oJ7U8oAEQeiy5eZwXdWeQx4IvYLvM0n8aWh3NGqo5XWZLsyc9oVR6JUpceflS2GuQE8
         6wb4gDdIWBnoFst3kb1rrGTvMgDQCZZ+a63USRCCFgDMBA2r9DY2qMZW0/1+VOBwQsIm
         rC4vxjnC2dDyN/abumWUFg+OY71Pt31BUR4FV4EetkoGJdWSeA5eB4KlZAWU0lIZpncc
         L8qQ==
X-Gm-Message-State: AOAM530gF5AuDcQOvR43/VbPKJK752B4srfnzIb/SdsdNn9l0+zb5t9H
        RIOt4z/IvbKqMYOdQKyW9my0Yw==
X-Google-Smtp-Source: ABdhPJw9MH696XihyRpyC1GpZ6E1M8Ahri6D6zpRirylleIKHL4+GHBH7lfMIWvd4DSv+8WWxyD8Ew==
X-Received: by 2002:a63:5060:: with SMTP id q32mr29791486pgl.32.1622573059486;
        Tue, 01 Jun 2021 11:44:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id m13sm2846319pjj.18.2021.06.01.11.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:44:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: Disable PON on Trogdor
Date:   Tue,  1 Jun 2021 11:44:17 -0700
Message-Id: <20210601184417.3020834-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use the PON module on Trogdor devices. Instead the reboot
reason is sort of stored in the 'eventlog' and the bootloader figures
out if the boot is abnormal and records that there. Disable the PON node
and then drop the power key disabling because that's a child node that
will no longer be enabled if the PON node is disabled.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 24d293ef56d7..cbde625cbea2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -805,7 +805,7 @@ charger-thermistor@0 {
 	};
 };
 
-&pm6150_pwrkey {
+&pm6150_pon {
 	status = "disabled";
 };
 

base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

