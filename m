Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9EA380FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhENSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhENSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:35:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E8C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:34:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v191so342807pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lELtbwQEctdIwPQb3wCQp5OuKO4/lkfT92gv1xyToGE=;
        b=gSrEImsqcT8WUGbSMZ53B7UmwxHd+LIibGRNufbT852dWJIzp0i8btI4zX7WXhaYtG
         XvOIwJcw8HHEeQkgQHQ5YeVjBnSpqI8AgJNG4QNiIkHMitswBlzQoq4kHxTrUiXytj0Z
         RsCHapE64niz5srWtsa12N8xR/tqm/VLRfqtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lELtbwQEctdIwPQb3wCQp5OuKO4/lkfT92gv1xyToGE=;
        b=ie4bARibNE2qp/b5Kra2sbMStfQ2nnkA2uzdXNandoxyeHZJWPFcHu9BKEvbXlzkt4
         +f9rxQNvmwVQI0OdovQDCClhAAinbWMMyKUnrnxJeyhPU//XerJhjbKYqip1wVnne7Qt
         37fWtFyJEtowDRXfzUn0Ddpi45cxPZKOU/hdILxOeFNcL7IztNoVvVva/V4+ErDikPVY
         3tmvUJ8V+kGCs/N0Mcy6+lGfqS/604tKgdRiHeGkwdLw//0tV5f7rdJkAtc4H1RN7r3c
         YndN0r+6zJ3XnPMHFf7mHHju2CMM6eEhmshFPX982GrBg1BUUR3QPTqnjuh7TEt/6prG
         RD9Q==
X-Gm-Message-State: AOAM532qcj4VxABOuiNndPrIP6adeugvOPjXzN6LAjHv+32naUBIEM8d
        DsiD8KixZ3b1dftrFDiGXnhZgw==
X-Google-Smtp-Source: ABdhPJwwG0FPWg4ZVysBvGRUFzN69CmNe/Rog4IBIjy9UL84MRc8Br5Uk3bUyMH30eFS+wfxZ/h4fQ==
X-Received: by 2002:a62:585:0:b029:2a2:3976:60a9 with SMTP id 127-20020a6205850000b02902a2397660a9mr42984565pff.47.1621017281302;
        Fri, 14 May 2021 11:34:41 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:6d29:e373:344b:8862])
        by smtp.gmail.com with ESMTPSA id ga1sm5375127pjb.5.2021.05.14.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:34:40 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Move rmtfs memory region
Date:   Fri, 14 May 2021 11:34:34 -0700
Message-Id: <20210514113430.1.Ic2d032cd80424af229bb95e2c67dd4de1a70cb0c@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rmtfs memory region so that it does not overlap with system
RAM (kernel data) when KAsan is enabled. This puts rmtfs right
after mba_mem which is not supposed to increase beyond 0x94600000

Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index e77a7926034a7..afe0f9c258164 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -45,7 +45,7 @@ chosen {
 
 /* Increase the size from 2MB to 8MB */
 &rmtfs_mem {
-	reg = <0x0 0x84400000 0x0 0x800000>;
+	reg = <0x0 0x94600000 0x0 0x800000>;
 };
 
 / {
-- 
2.31.1.751.gd2f1c929bd-goog

