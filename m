Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A843697DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbhDWRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbhDWRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:00:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09ABC06135D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:00:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso1597315pjn.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqRgrq5qTHq8+QQOXrqNOrI+XnC8s9rFcrx/PHqU9kA=;
        b=X+2LXkR+x2Y6Yo6aK1kTdJ8Rhytwsl31CFMU6k56xp/RuePZ0vzxwrb2UfkLXWGSBq
         LlAh38K6d3Rlb9ZhLKF9mKVf9rd/crkpvJJ+H9Qkz8Lur52GfMVYXi8zj2XicneHKR7c
         YdlA2lbc+fQi/b3LKgVfUmJaZh6SjEHuSYkCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqRgrq5qTHq8+QQOXrqNOrI+XnC8s9rFcrx/PHqU9kA=;
        b=drGaIEQnLssarA9+LREhJUw8UbzIqXJMZL25wzNMjbrbPhLozCz4MSiD6MMHFgfdFs
         A5mrINknIZfgoBWvqoyTcaDDfBnIySavSgzTuqa5BcDUenjHBVUqnU0M8wnofYBTjwDT
         J+kPl7UJ7l2itunig/q8wackKl10+qsezohE56T48chOuwdm6N/HdYLdB2OjEtGF5b8Q
         6tJ6wEvOFehW1920vJVLzCxe5Oq34m5xVtNWKFFji7qHZY5dZYHzNXoPubLzDyVdgM2Y
         TizIE4/ajshH50iVXE0+CVRRkQ8lmij7qYHT9wt1GHqyAmNgOSTt103yvBQCSzULWTkd
         PmVg==
X-Gm-Message-State: AOAM531px8BDouJIMb8vTWiEI33NjbuoTYjCz3V2pBgMfYfDzpZknXIo
        6flSm8Cn/GHH+XAJXsuw2SSecA==
X-Google-Smtp-Source: ABdhPJwYRj/bkCBR5feDF1qTXpHaqYVIA63dyfs8jdja9V5hgW3GpI+hcKLSiO/ZUNmI8hVVg+H2gQ==
X-Received: by 2002:a17:90a:7d02:: with SMTP id g2mr6649977pjl.153.1619197202494;
        Fri, 23 Apr 2021 10:00:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6d86:663d:71f8:6a11])
        by smtp.gmail.com with ESMTPSA id v8sm5123607pfm.128.2021.04.23.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:00:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/20] arm64: dts: qcom: Link the panel to the bridge's DDC bus
Date:   Fri, 23 Apr 2021 09:59:06 -0700
Message-Id: <20210423095743.v5.20.Ibdb7735fb1844561b902252215a69526a14f9abd@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423165906.2504169-1-dianders@chromium.org>
References: <20210423165906.2504169-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding this link allows the panel code to do things like read the
EDID.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
2.31.1.498.g6c1eba8ee3d-goog

