Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD1362B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhDPWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhDPWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FEC061349
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w6so4735525pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TvqfTmBKpWQk47pVCIMnPVMBwS/uLueprhgNryYtbA=;
        b=jqBZZDcWG7s4YKPCZfESxsi5IWXAX19ybkyjsCxLgUAWTSv+PSrzGu5XAZmwQDFNzM
         ttf7BoB27sCINbqxpc8wkIXKqZG63TiCRPr41Yoek6F8sRzHt9AKgbTQjAwLd6gA9G2c
         5FSbUlFIuDNE1oe4ihKfaXppRgyi9WF7uE43M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TvqfTmBKpWQk47pVCIMnPVMBwS/uLueprhgNryYtbA=;
        b=hRQM6gRbwgI4uW+JqENTqACkZecbsUc9cycnAupHk+3+qd1JvUwCxotvAZ3k4TiEb/
         T2v8h9q0EVnhncPuUNmttcTa9UsEqaLokdLCXvArBBbK2YUq9uaO4LbmYz43Tyz3toq1
         Eigeu629Mfwz++1uXyEJe3gwvMHiF25UgUPomn62A6hqqeTHPd5C5v4PRkjdIgKwnKiN
         5opRaCw5xtT6TxcTtlYwjseCCfX/gLdTsLCPniGvPKmKuU2gAzydHHuNJMJLYLdIAINk
         VYzJgR6Y9IGdF49SMR9Kv/6DqQ7rzRYBzwGFJS5bHiZQk+w38Fqxuq0tItavvjL0zqkZ
         g5Ig==
X-Gm-Message-State: AOAM531sY49ByEs0X9227WszO/64Q+SZLxP7MWGxpOPfkbGII3bF8v4q
        raboijmtxlQz32SmXYNn/zXUrg==
X-Google-Smtp-Source: ABdhPJxQ9DBJQiYCekZ4xDBquq5Hfj2H7iOAKL64Gkmy7QFs0dyOoqt0xfbyRdv9R6gxEd68unyLPw==
X-Received: by 2002:a63:f95a:: with SMTP id q26mr1108999pgk.25.1618612881550;
        Fri, 16 Apr 2021 15:41:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 26/27] arm64: dts: qcom: Link the panel to the bridge's DDC bus
Date:   Fri, 16 Apr 2021 15:39:49 -0700
Message-Id: <20210416153909.v4.26.Ibdb7735fb1844561b902252215a69526a14f9abd@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding this link allows the panel code to do things like read the
EDID.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 24d293ef56d7..96e530594509 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -265,6 +265,7 @@ panel: panel {
 		power-supply = <&pp3300_dx_edp>;
 		backlight = <&backlight>;
 		hpd-gpios = <&sn65dsi86_bridge 2 GPIO_ACTIVE_HIGH>;
+		ddc-i2c-bus = <&sn65dsi86_bridge>;
 
 		ports {
 			port {
-- 
2.31.1.368.gbe11c130af-goog

