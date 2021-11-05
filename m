Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C12445EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKEDzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhKEDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:55:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24701C061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 20:52:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso11294304otv.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2+6X9TQmRFBAqTvYPY5wqGGHltv9YNlYSimPRXZ2Y=;
        b=CGLK+9hp1NCCqzbxqqXYsO74IoXZ0KZRbyxU5HVn8hae82mL9KyH4mszZg0rSkS56P
         CwHAwGf3SYIof1+7bn0IgUofU46qXYszVEkzuLX8tky4j6f3Sw1t7+V3YWyY1a/q6jSu
         kHHfp0HDBm4wlBSWbVba2nYZwdQpWQnU7GbqrPuD5p6smkaKOjAqXShOn/tEO3H6ZkmU
         0GZugWDAMOWvb+7v4onW5RvQ7arZZlp6c2N+8/oeounnJ4EcdXYQ+1o/dddkSw4TcxBu
         CbFOZtjNbEaoNq+719aGjc+LVNdIUV1DxTGrzTCxjmbXmrfeP66JQ6hmDcQXyp01cQpo
         NEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2+6X9TQmRFBAqTvYPY5wqGGHltv9YNlYSimPRXZ2Y=;
        b=Jh624v/72LCDpLeBXsR6YErDB7p50SZmMY9FI/HchClRZXfQNrp6M03Q4gKhB2rQ7k
         LwQnWPelHO6Eb84zRYuWZioGxJo/OUc/PBM57kB/4z4sAuxEAojux971V+PoHN/bIZR/
         OjnBIFzNpnAAmYfVnEsFc0AOKX6vPya2hLOxhlTRumBKyDedyFQ13CwkaZD7Ws8P/jgx
         ZT9jAZqxl2Fk9b/awYavpuaGDeo+QtQ9HW46cgFzBxk8Pvu//cnT2I0ZZm+zCMUHdGHC
         YEaqb9RA/chgadHzlOn3ye7oBduoy9/JhKZiVvyWOm1vTLNOfw0QJSS7a4R1bJ5nX4hO
         VOlw==
X-Gm-Message-State: AOAM532nkCJ6qHHkhgtfRM2oLaxWKk65r1lIlvdcPJjPHgqQImtIWxT9
        8j12J4IEz3I8ASRsOYg2pZ9JTA==
X-Google-Smtp-Source: ABdhPJzGwvBoFgn45iP5txtjoxs21//4/l1DkwhT5t8nPl002PE+VKHAfF9OO4JH5M+AYA/UWxKUMw==
X-Received: by 2002:a05:6830:1ad5:: with SMTP id r21mr42931988otc.192.1636084349438;
        Thu, 04 Nov 2021 20:52:29 -0700 (PDT)
Received: from DESKTOP-UL9N8HT.localdomain (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id d10sm1918517ooj.24.2021.11.04.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 20:52:29 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: disable crypto due to serror
Date:   Thu,  4 Nov 2021 22:52:32 -0500
Message-Id: <20211105035235.2392-1-steev@kali.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the crypto due to it causing an serror when cryptomanager tests
are enabled.  Add a fixme comment so that someone way smarter than I can
come along and fix it.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index b2e09d3387ed..955f73acd26b 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -813,3 +813,8 @@ &wifi {
 
 	qcom,snoc-host-cap-8bit-quirk;
 };
+
+&crypto {
+	/* FIXME: qce_start triggers an SError */
+	status= "disable";
+};
-- 
2.33.0

