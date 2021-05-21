Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791F38CE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhEUUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhEUUHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:07:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB8C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:06:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b7so7402737plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+EzPeqojY+93vhWBpwnSXdlNpKsgPbELWuAjK3Y1rE=;
        b=ZKsR/+AaHphumaUwqUjftBqQdZqI0fzRobWZ89qGnV4MsIOLuKgdPwcj4rFcxggq4g
         jXLviS+mwisd5u8tm5ff1KmYPgd7yeqwP5quL6XcMjPQGuoBiIU2QAnOD70t1FBmAiTz
         1k1BTysLubdKWE54yPxyxqIru7BueK4OI/B7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+EzPeqojY+93vhWBpwnSXdlNpKsgPbELWuAjK3Y1rE=;
        b=HaJJxj/Cvm/R7OzK3BBmxnrwtuXacNxR8jhUrxut5BEkH5uHzmGOT+b7PoSeLP27Ao
         J9wf1SjZpGlnRsCIwP4sRnR5IhSJiufj3VTzoSdqG3/jwknEsrnVC+Y7VE/7cyOvjwz8
         lAMU2lSfP/Ux2ApNdFzXzgJJwrvOWZZwDf/ihwb4zCSy5O7C8LZx4WFh5y482q4FBCYD
         r0M9QT8mUNUvpia16OSTv+Y+2c9BVHHPsZlA/If0YyiJOHQfFGLbnCn0CSqEwrzU6als
         L7cA6/YsDbaCx9sFk/o5D5kebOEWa3tW21FbADVgYN0rNhhfrvjDYqFIHOrRLrlvsaKM
         j20A==
X-Gm-Message-State: AOAM532p5JY1CnClcRzz5YGThKIlgwKBKdvKO7cCsd0BbqOJid7vdWcG
        +LDNskXk2SwMTsU4zLnLC1c4cA==
X-Google-Smtp-Source: ABdhPJysX2rMH4lavP2VsfLuOs5VOzf6pzH8FUyZzMjCMiAkn90xzeiXrvFoo1P5k6r8OnEA7EDUVg==
X-Received: by 2002:a17:902:f704:b029:f4:228d:4dca with SMTP id h4-20020a170902f704b02900f4228d4dcamr14024654plo.26.1621627570751;
        Fri, 21 May 2021 13:06:10 -0700 (PDT)
Received: from sujitka-glaptop.hsd1.ca.comcast.net ([2601:646:8e00:b2f0:22bd:8c3f:584d:d265])
        by smtp.gmail.com with ESMTPSA id z19sm4550614pjn.0.2021.05.21.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:06:10 -0700 (PDT)
From:   Sujit Kautkar <sujitka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: qcom: sc7180: trogdor: SD-card GPIO pin set bias-pull up
Date:   Fri, 21 May 2021 13:05:29 -0700
Message-Id: <20210521130511.v1.2.I52f30ddfe62041b7e6c3c362f0ad8f695ac28224@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210521200529.1991729-1-sujitka@chromium.org>
References: <20210521200529.1991729-1-sujitka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor board does not have external pull-up for cd-gpio. Set this pin
to internal pull-up for sleep config to avoid frequent regulator toggle
events.

This change is aligned with Qualcomm's DT change posted at:
https://patchwork.kernel.org/patch/11675347/

Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d128a0ed6ad3a..330deb4967ca2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1638,7 +1638,7 @@ pinconf-data {
 
 		pinconf-sd-cd {
 			pins = "gpio69";
-			bias-disable;
+			bias-pull-up;
 			drive-strength = <2>;
 		};
 	};
-- 
2.31.1.818.g46aad6cb9e-goog

