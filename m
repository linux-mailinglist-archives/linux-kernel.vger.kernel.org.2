Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE33F9608
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbhH0IZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbhH0IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:25:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m4so3509140pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=zktf+/p86fTWqdQ8mVamuslYY1EqZYgEv8DP2sHNp7YY3OUMJ01Mvi5DMFzUzREusI
         kgoWYfZOV5zYZDs8wyU70siIKTHq/PtU7G+Jukqy8QgCU4gSkmEZ37ItWUkcb+3Lr8/y
         8YKD14+joyXg7nggTF3l0v4+7tPy7zhbrVBdti2yjwgo2oICln+Pg58Waf7ISvMK8xtl
         ZNe/ZPilCU9WtOHp+yZ+xvX7WA4CtMUO8mlxlEI6870WVE8ru64GHaddlJj+5i+kBZxW
         xzhhVqW0i2Dsua5u5R0CwVh245aXbARdLgSo5Wd53QM4dQv2YEdfu9r5S+u054tP3It+
         iW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=Gqc/irkyJxJv2f3iTPQUcJhG/R5aZY14recXsNO6WX6MfrYpzMijwEenNJh22/y72/
         Ft36GTD+G/LjsFvWTKisj0UyUBaJIWbm7PlROIIpe7dhLHL3s63od3UNAskp3wEoS5zR
         Yqwmqx49JU1xbIBP50iSSVHZNb3zKBWrZ0f2lWS5UD7ei8mOtvYqnOJZhi29/QspKqIA
         CmM8ucY7CZ6ItE7QRIw5dr9IPyZDfc6NkCkenxb5PSkxjqtE2VEUh+FPMasOc9bcotLT
         z2bZzpNYduya3upOjdSjHphu98okmIhYcuTAR/NLMKaV/XdONzHJeEnV0Xm0eIkwt0Ie
         DXzg==
X-Gm-Message-State: AOAM531I430FvQNPQXAGUFS3CdLyaKNGC9t6+EnKwQr46NNCHjEYA6fu
        oETdPY+8OKEttSlZqww+Ar+quQ==
X-Google-Smtp-Source: ABdhPJwjwFm5HrTFTcrFg2ztSmUwlihs33RfTHwXzh7mjp4UZQEbCqjNfmZSMh/nrYp/7xoYHd51MQ==
X-Received: by 2002:a17:90a:ab8f:: with SMTP id n15mr9463755pjq.154.1630052667348;
        Fri, 27 Aug 2021 01:24:27 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id m18sm5391371pjq.32.2021.08.27.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:24:27 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 2/4] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 27 Aug 2021 16:24:05 +0800
Message-Id: <20210827082407.101053-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
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
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..a7091ae0f791 100644
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
 
-- 
2.25.1

