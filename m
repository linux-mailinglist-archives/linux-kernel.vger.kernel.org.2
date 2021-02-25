Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7532598A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhBYWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhBYWQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:16:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBFC0611C2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so4744244pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRM09e0XG9iDpWuWB8nMTgOWrXG/nxGrXiBhekdNcJg=;
        b=G0S7x75/R7r1fGd1saUoVxPFnqw4/sWhW8lHA755YPlAIbFsWyItvuVyfJxHXpasYz
         MdE9DFSfjidLtDYjMjbZKBP5F3n6gyFnXe+Ud+TQqJTzl9+GlI3DQJDxcJATXvQxVctB
         KZLThqNpqhP4hZFetX8vPgMsJNQRaWjjkTQJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRM09e0XG9iDpWuWB8nMTgOWrXG/nxGrXiBhekdNcJg=;
        b=tUD5avnGRw3Mq+qdmUyAmAAQ3AXhhVFx6Mjzd0pdoXiVtVvCmgxRiRjHM/B1qqCPfh
         PlzRY7shxW87pYZJ0WBfpf4DmM4BRgoGTin/AFtH+ecouS0LoPMQk1J8D/D8QU0mfQiy
         HTZwkEtQ46z0kzn8aeLd3ScAkKSXvNy8Bd13QFYOfds0D5aVSbWiYD0JfmzYfOvP2mlD
         l/rQYadOwUYvH5atCfji7BjulmR1WaSSJIanCfIIWyaBKi6K08hgOhpheS1HucHgkmz/
         zWtfUNb7v8looVDIyAMS9RY/gVJRuRzMcOizChqwdivhWF1sBiPdtOlcD2Fzr3VrP2Vy
         AZ8w==
X-Gm-Message-State: AOAM530TPSzxBEV8tKSzQnudeRGzqMB2uEDb6GcFTCnIf0hJcJk+dyH3
        z0bi2/Z51l7g51GZL66w9ppnhw==
X-Google-Smtp-Source: ABdhPJzOJy70QJbhalFGwUvn2ysJjEn64L2lFRIGfvfjaBwOSoSgCdTggX5g0xWNGsYMrfaLKVMkLw==
X-Received: by 2002:a63:e42:: with SMTP id 2mr60944pgo.100.1614291230149;
        Thu, 25 Feb 2021 14:13:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Philip Chen <philipchen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] arm64: dts: qcom: sc7180: add GO_LAZOR variant property for lazor
Date:   Thu, 25 Feb 2021 14:13:06 -0800
Message-Id: <20210225141022.9.I4a38fe64dd79c54af80d7e4ef5940f8cf4f86e75@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
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
---

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

