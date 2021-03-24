Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5C348520
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhCXXOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhCXXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:14:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:14:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y5so75463pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyHzegzCKmX71L4a4ycrls9K9563QpXhhpNkT8KIV5U=;
        b=WVb6OULb7d2h1TjLeoxHbmk9OorP+RZH5J0DpUfRz+zDpIHYebKd3NZBud+nKEsw+Q
         MnDqAlA8iLhkwTrElzJJLiBzoqsdoq1Z5VwYhuXZZagGGRGp2ijKYrbGLG2E48h/Augm
         n0EhXKvlvcOR7ErrCKPeMqEF7hYosr8qYp/Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyHzegzCKmX71L4a4ycrls9K9563QpXhhpNkT8KIV5U=;
        b=qgDMXjZ0lYOO2ImYZm1HkiJYvh/hOo+n2oqWaHwMYdJWXSOSsD3C6wcpxHTloxc5Ym
         X3u5TToNU7OZ1qcZAGr1n4QQxB990Map9cTd5MnZP6o+kVnd9xq1ij8h5V9mFNi7XrTN
         xgQ8Eecdre3p8C4snYZwZhIScqUghTZdInYnmQljKyvK2SKFOeJyx5pkQDmqchhhwAUy
         QS6nVtFx4XOrxoeta8XombptC+Ze1p+06SbRHmZFHM5x0iCl6wXxVXwhjunxoKbiPqoO
         bIHQDIVqqzpuuurFvj3C2MahOJT+R2c3rellmFY3KVUB0Yj4a4vwvptRNJFrYkwyWJQa
         Foyw==
X-Gm-Message-State: AOAM5320HiddFhruqWDuLE3VuKQuYvqg12wLVWQ56FWa2RPdVXqk7Yjk
        dvsP9g/U10pQ8v0U0BBquMtaFZXhP2/niA==
X-Google-Smtp-Source: ABdhPJwGJw+JcbwiJP4/piQ4MvZoACLFpP8UfoL2bC6oJj//Hmi4KIb3DoVNtZ4z3lGMAiRho979FQ==
X-Received: by 2002:a63:ee4b:: with SMTP id n11mr4983845pgk.265.1616627666442;
        Wed, 24 Mar 2021 16:14:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id y9sm3396207pja.50.2021.03.24.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:14:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v2] arm64: dts: qcom: c630: Add no-hpd to DSI bridge node
Date:   Wed, 24 Mar 2021 16:14:24 -0700
Message-Id: <20210324231424.2890039-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should indicate that we're not using the HPD pin on this device, per
the binding document. Otherwise if code in the future wants to enable
HPD in the bridge when this property is absent we'll be enabling HPD
when it isn't supposed to be used. Presumably this board isn't using hpd
on the bridge.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Steev Klimaszewski <steev@kali.org>
Fixes: 956e9c85f47b ("arm64: dts: qcom: c630: Define eDP bridge and panel")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 140db2d5ba31..c2a709a384e9 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -376,6 +376,8 @@ sn65dsi86: bridge@2c {
 		clocks = <&sn65dsi86_refclk>;
 		clock-names = "refclk";
 
+		no-hpd;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
https://chromeos.dev

