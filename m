Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7992B329FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574812AbhCBDuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhCAVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1493C061A27
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q20so12400823pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/v9Pd43iBs+UXvunT6Xej2iPnF6YuJWrIvn13kPe8ps=;
        b=ER0cDodvgrX0R1orNgdEufheAUD+DGvVilhrK19E8IulYd57qgELzQcP3Y5muluHan
         LBP+p6Y4jL8/Q0Upaclhbl+YvpUOQlXr1YbfrJLED9ymGlvalRPjAI8SigCJn6izIzhD
         VgnBEI35E3zSBP7k7wKNaOq+MVhMkno6a5gUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v9Pd43iBs+UXvunT6Xej2iPnF6YuJWrIvn13kPe8ps=;
        b=Ofb5rKosLpzHsRiReZR98TdAxHbY7I//7rjNArC2sX6k1JoeRV4GQaCrMlj7vNnf8P
         34HiAH3qULy6m58XuAYhHskijySd5ERpA5NqHeN0XDnzjdPwEHc5SPp+s6rlDHKB4ZIU
         /sn38Yw7oPForL9JUyqIzFhDaGVnViWL5KreC6PUvO0dFu1jILeUsqap/k2z8FS2Cq0S
         0t7XsQYrxp6LqYYaXqnnfWXAf6Q5EvYLx3uLovYoAxejOHQ8oVXuPEt3bhdXlXPZGz8S
         M99p5YK0Gcy7UUx5WPUYZv0JNpYtleRwjrYWPHzltXqw5LkhFEkxr1H++d0qDwwl3uwF
         ddFQ==
X-Gm-Message-State: AOAM530oGGpHP2NAqE1K9WmHOFvbpZcb8bF0YpfRuSqSjMXig0WvquS2
        nxKOBafKYbfhSDHBddoS0daSew==
X-Google-Smtp-Source: ABdhPJzwzy+/N6Jkfo5THvMD7z0G+wqXpC7aqjYsGZ2pJZWXcsDeE47DPaZ/S3RIgqr9ZtmEyDKSiA==
X-Received: by 2002:aa7:8f15:0:b029:1ed:9356:a9e with SMTP id x21-20020aa78f150000b02901ed93560a9emr333253pfr.73.1614634499503;
        Mon, 01 Mar 2021 13:34:59 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:58 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Philip Chen <philipchen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] arm64: dts: qcom: sc7180: add GO_LAZOR variant property for lazor
Date:   Mon,  1 Mar 2021 13:34:33 -0800
Message-Id: <20210301133318.v2.9.I4a38fe64dd79c54af80d7e4ef5940f8cf4f86e75@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhishek Kumar <kuabhs@chromium.org>

For trogdor, in the latest board-2.bin file, new BDF with variant
name GO_LAZOR has been introduced, so we need this property set, for
GO_LAZOR BDF to be picked.

Cc: Philip Chen <philipchen@chromium.org>
Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
[dianders: adjusted subject line and sort order]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 5efa04d0d256..6b10b96173e8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -49,6 +49,10 @@ &trackpad {
 	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 };
 
+&wifi {
+	qcom,ath10k-calibration-variant = "GO_LAZOR";
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
-- 
2.30.1.766.gb4fecdf3b7-goog

