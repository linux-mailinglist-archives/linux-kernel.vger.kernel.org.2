Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B539E4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFGRIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFGRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:08:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA64C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:06:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g4so781927pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQE2oc4ck1yBx8OjbWi1jB5697iDZ6Jcz+Jq90YnWDE=;
        b=BRHM24dXb9WdBH3AF7IEEdq5qZGZPbGeXoUVu78XEfchuxuyufLLfG7W4v0ZiQA8Dy
         i7nO9xhzjYiBMja5Zr43QEFJeeeqyYZErxY2sVXgFe8yqkhc4x4+r662ossOOHA56BS1
         pRzPqoE6FFJ22C3liFwTJKwnKLckezI1tsHck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQE2oc4ck1yBx8OjbWi1jB5697iDZ6Jcz+Jq90YnWDE=;
        b=h6j8fQzb0R2afBAOEPQvvsvy5RpStW62ripj0EEFfge48jMLgzAdxHQYjxJ0zMHqFM
         oFWhYqfBfG2IhLCLv0XQCEVqDtK687IIef2mImyvNq6E+T/NK0nWjBK3Vu0E5Z7YcC+R
         4mwvAXSpOhG3SKNK6AHDwi1bivzDgwHuw21wHVyALjVSsPbAfXKtdGuCqUTimtVtXG3A
         vfmaRxvzph0k/yC4N1skFOu6viJn0E7FHJS9B1OdUGe+C89ylpWU0+hUEe/EoFgzIayu
         UItNh9T0uACxEJyYJt1wUoHIieE2t1v5TCDtyXX8wXZB/gJ5c0beTT3M/ejkpG1NlicX
         4h7g==
X-Gm-Message-State: AOAM5308RWA3QS6IPcNzbElvN/9R5mN7A5wOekNg8T4130BPRJ/RRBGA
        dLThiivYBlYlvQdMAxsB0V4CpA==
X-Google-Smtp-Source: ABdhPJyWrV1oYCT31s6fWz03UksAA2NhnlHdmI7OV5MP8ziAx7Ta1SgfnVY80ymWu7sQMnlDsAomtQ==
X-Received: by 2002:a17:90a:1641:: with SMTP id x1mr139302pje.114.1623085578464;
        Mon, 07 Jun 2021 10:06:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f656:ffce:6348:a42a])
        by smtp.gmail.com with ESMTPSA id fs24sm12897639pjb.6.2021.06.07.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:06:18 -0700 (PDT)
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
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/11] dt-bindings: drm: Introduce the DP AUX bus
Date:   Mon,  7 Jun 2021 10:05:46 -0700
Message-Id: <20210607100234.v9.2.Id3c048d22e72a9f90084a543b5b4e3f43bc9ab62@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210607170555.4006050-1-dianders@chromium.org>
References: <20210607170555.4006050-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to list an eDP panel as a child of an eDP
controller node to represent the fact that the panel is connected to
the controller's DP AUX bus. Though the panel and the controller are
connected in several ways, the DP AUX bus is the primary control
interface between the two and thus makes the most sense to model in
device tree hierarchy.

Listing a panel in this way makes it possible for the panel driver to
easily get access to the DP AUX bus that it resides on, which can be
useful to help in auto-detecting the panel and for turning on various
bits.

NOTE: historically eDP panels were _not_ listed under their controller
but were listed at the top level of the device tree. This will still
be supported for backward compatibility (and while DP controller
drivers are adapted to support the new DT syntax) but should be
considered deprecated since there is no downside to listing the panel
under the controller.

For now, the DP AUX bus bindings will only support an eDP panel
underneath. It's possible it could be extended to allow having a DP
connector under it in the future.

NOTE: there is no "Example" in this bindings file. Yikes! This avoids
duplicating the same example lots of places. See users of the aux bus
(like ti-sn65dsi86) for examples.

The idea for this bus's design was hashed out over IRC [1].

[1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-05-11

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v9:
- Commit message now notes aux-bus yaml won't have an "Example".

Changes in v8:
- Separate DP AUX bus binding is new for v8.

 .../bindings/display/dp-aux-bus.yaml          | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/dp-aux-bus.yaml

diff --git a/Documentation/devicetree/bindings/display/dp-aux-bus.yaml b/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
new file mode 100644
index 000000000000..5e4afe9f98fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/dp-aux-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DisplayPort AUX bus
+
+maintainers:
+  - Douglas Anderson <dianders@chromium.org>
+
+description:
+  DisplayPort controllers provide a control channel to the sinks that
+  are hooked up to them. This is the DP AUX bus. Over the DP AUX bus
+  we can query properties about a sink and also configure it. In
+  particular, DP sinks support DDC over DP AUX which allows tunneling
+  a standard I2C DDC connection over the AUX channel.
+
+  To model this relationship, DP sinks should be placed as children
+  of the DP controller under the "aux-bus" node.
+
+  At the moment, this binding only handles the eDP case. It is
+  possible it will be extended in the future to handle the DP case.
+  For DP, presumably a connector would be listed under the DP AUX
+  bus instead of a panel.
+
+properties:
+  $nodename:
+    const: "aux-bus"
+
+  panel:
+    $ref: panel/panel-common.yaml#
+
+additionalProperties: false
+
+required:
+  - panel
-- 
2.32.0.rc1.229.g3e70b5a671-goog

