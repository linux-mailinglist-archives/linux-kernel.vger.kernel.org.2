Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A93F1531
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhHSI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbhHSI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:29:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:29:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so10857883pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=hkj83Zr+ZblfHzbFg9Ibwfy+X6mXbl5OoEgBrmAyJ08HPtD6/tVWqZrOlZ95P9qCA4
         qLv7JIfGyiESf+tVTKA7E4tsgxwPPz2iAH30GnlHth/pe6QnkbVzgWyZy5+TgTveWdQu
         6T+eAQRsetJcowu8vjULbtiD7BU4D/AD3afT5NADOny1DuzlqoY8j3RdINep0+vSqJ3N
         +QEMn4Bw2CbhCjLMMdHQFMEJ6qCl/R4iJ+wteLK1EgBZX3/oXRO+wq5pde0p7SM0T8Hv
         T3OAs/drOoo38rBeFurJM9Vyb7E9oK0UIsUcSvqnsgFqF2EGS1ZRyRlB3l/odFh+l6T7
         cLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=CnoRisijWfbXMfaKFva1LETo1hY2In86QZXlmOx1FYTLTmjE5E/jeRMiEKLuWv1c2c
         1MlCPIHI+6ZtY8Loi+SB6QmjckFPBtUeXp13UUO8VCedKnGUa2R9ZaI6DMPEX7reiJJ7
         51tZp+coZFrUJTWO3K2gjMR1mBTX1vZDfunXvlLU5FOn5W44Ol8BS/MkYymNxf3slCqf
         PffUCgxUCnD2l/L5CpdrmYMH/I1pGKS1nUS5JsOZcomNnUhsw7XW77T9Us//y8tK0R3k
         WY4Hpj8zjXG01K9mN+M6Np+SX8Ggtf6DOXjYProwgreDjqq57SfDwpPInTRzWfWoD/Kf
         MbzQ==
X-Gm-Message-State: AOAM530InUd3R40vNzs+cyxQneTy3TpNusPFf9Axnb9iuqbXeOfD3cov
        eLHrPz+YRZo0cbwcaD9gl8monw==
X-Google-Smtp-Source: ABdhPJyutR7vlosglYs3jbeVxN1Iy5tUynkr3fLtf98T3GvmpAwc9K8oCvIQtz2kIFukHbzeHjgMPA==
X-Received: by 2002:a17:902:6b8c:b0:12d:b95c:30fb with SMTP id p12-20020a1709026b8c00b0012db95c30fbmr10870574plk.81.1629361746199;
        Thu, 19 Aug 2021 01:29:06 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id i11sm2347220pfo.29.2021.08.19.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:29:06 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@google.com
Cc:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 16:28:43 +0800
Message-Id: <20210819082843.716986-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819082843.716986-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819082843.716986-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..e45de7a4360e 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -36,6 +36,9 @@ properties:
   pp1800-supply:
     description: core voltage supply
 
+  pp3300-supply:
+    description: core voltage supply
+
   avdd-supply:
     description: phandle of the regulator that provides positive voltage
 
@@ -52,6 +55,7 @@ required:
   - reg
   - enable-gpios
   - pp1800-supply
+  - pp3300-supply
   - avdd-supply
   - avee-supply
 
-- 
2.25.1

