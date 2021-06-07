Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABA39E4E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFGRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:10 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:36700 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhFGRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:08 -0400
Received: by mail-pg1-f177.google.com with SMTP id 27so14319887pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRXNe2oDJn4wT5OJBJOLyBxBuxZlGLcl9ENnPPgLKPk=;
        b=OkmdLJvhXIXLKJoCVrXVxc5RYkvyMAg6zmrUupVVH9E3Nk2c1btyz7zDhEXOdXdRXT
         UWGdAmIejGafSF/IyTVHP4NNEnLRLkS1+Mkba2wv94LbN54WPOfdwsUq2NNaVa0R6NL6
         zt2SCUbiHtjBTafVOoGoA96E1mIxBsLpWZq74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRXNe2oDJn4wT5OJBJOLyBxBuxZlGLcl9ENnPPgLKPk=;
        b=CV7noQJ8djCUjk5PXWkRuONDOrF/7vF7n2GDJJOkrKVCoiUbRrjDOIBprq/AyBQTzA
         PNxJFWsouoOX8OTy/6QC2tWfa7HqiY2wGUdwfGbPOEyCAyE2ca84sFfi6uoH8PE8nftm
         c99cY33TAouLQYGwpK7xi7yiKksRW4qg4GsQJspINgWSFp9rjd11EIIMjAIU2MSFoQ01
         lRAEQDKErUS5UzWhMIMAi00r5aP7KdWtQL4KZ9jpeARlXyC4x8VBZvwRxmTHVT7LHLdK
         usAnH5mHZ1m68FauDWM1+LEHBFjcQ5dZMUnUFB/TMhveOOZbVmbYGMAVcUvHElgFIPQV
         2scA==
X-Gm-Message-State: AOAM533JIVfECXHFx/Xa1K3JzleOIsNamV8m2KO7nId456vC2sqmN6tX
        yrYKivadhoFNdj6hzacm1cTmGQ==
X-Google-Smtp-Source: ABdhPJxpq6X9P7SHMiEyqIpwGb/2S/gW3Uc2YoygXu+i/ugFbz64zcZ/cRusfBngEATD2ksy5s1VKA==
X-Received: by 2002:a65:6a07:: with SMTP id m7mr18475877pgu.294.1623085577248;
        Mon, 07 Jun 2021 10:06:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f656:ffce:6348:a42a])
        by smtp.gmail.com with ESMTPSA id fs24sm12897639pjb.6.2021.06.07.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:06:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/11] dt-bindings: display: simple: List hpd properties in panel-simple
Date:   Mon,  7 Jun 2021 10:05:45 -0700
Message-Id: <20210607100234.v9.1.Ieb731d23680db4700cc41fe51ccc73ba0b785fb7@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210607170555.4006050-1-dianders@chromium.org>
References: <20210607170555.4006050-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPD (Hot Plug Detect) signal is present in many (probably even
"most") eDP panels. For eDP, this signal isn't actually used for
detecting hot-plugs of the panel but is more akin to a "panel ready"
signal. After you provide power to the panel, panel timing diagrams
typically say that you should wait for HPD to be asserted (or wait a
fixed amount of time) before talking to the panel.

The panel-simple bindings describes many eDP panels and many of these
panels provide the HPD signal. We should add the HPD-related
properties to the panel-simple bindings. The HPD properties are
actually defined in panel-common.yaml, so adding them here just
documents that they are OK for panels handled by the panel-simple
bindings.

NOTE: whether or not we'd include HPD properties in the panel node is
more a property of the board design than the panel itself. For most
boards using these eDP panels everything "magically" works without
specifying any HPD properties and that's been why we haven't needed to
allow the HPD properties earlier. On these boards the HPD signal goes
directly to a dedicated "HPD" input to the eDP controller and this
connection doesn't need to be described in the device tree. The only
time the HPD properties are needed in the device tree are if HPD is
hooked up to a GPIO or if HPD is normally on the panel but isn't used
on a given board. That means that if we don't allow the HPD properties
in panel-simple then one could argue that we've got to boot all eDP
panels (or at least all those that someone could conceivably put on a
system where HPD goes to a GPIO or isn't hooked up) from panel-simple.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v8)

Changes in v8:
- Explain better why HPD needs to be in panel-simple in commit msg.

Changes in v7:
- List hpd properties bindings patch new for v7.

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b3797ba2698b..4a0a5e1ee252 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -298,6 +298,8 @@ properties:
   enable-gpios: true
   port: true
   power-supply: true
+  no-hpd: true
+  hpd-gpios: true
 
 additionalProperties: false
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

