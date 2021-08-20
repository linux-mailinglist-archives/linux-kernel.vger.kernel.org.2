Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89EE3F273B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhHTHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhHTHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:02:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34276C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:01:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w6so5427783plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=aRMqUWS9nLpM5yOQ2nBhEQWrqnbF6ihk1Ki2ziRxoUM+rPLnRsSaqM/R7hV8G4rdur
         0bjhHww20DxAsIgcXxsBfZg6LeWJVPTeUv8SN/c9Exu1+eeKfmpsHZd6I/07fL1Q9DY3
         KRpVc70rOeFP/CjBzkw/jA9sTIpKG0u8y0Z4EbnxjA9cdodzNHtIhPEROAt21KI1XX4u
         s0gPTnKX0lNwDCzhOTSIm7pC+i/8Xb2vrBiap/quu53iG6r8dWH+cGqwWww8yj9asUIq
         GrZvyl5cIJiYeNMhqzQqt6MB9PyxGn7UGio+ES58f4FqiuYBXTvyHTsOM6ws161DAXgR
         TMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=ilvtb//wHGUD85ZY+fIAx0x91+XmJ1C2egGbZtqox44Xpun9sCy4u4DByB9jjgK3WD
         pl2kcSFLEIGACIPJx5NOWbh2tIEIMav6xKGJ7oqObQDwpNuNT5KI/NZnN7dNu5gHNHBr
         pA+11tulbCKsZIao7Y5tPU+4lzaW8RjSx1yhpu1f7MuhhOh8J61AFvuqcFOI8j/tA4AQ
         cfwsgBGIl9is6coZpv46TXirth/UinxqixrolTJOGb9yDl/3n6yPGsbWTiiXEGRCqZi+
         80jumIqjImNXKXC/fRzPL/3R3Fi7xAeAATsVM5sF8NPLvxp2M7yExJIfRJh+QzZZiSpG
         cUbg==
X-Gm-Message-State: AOAM533ZZA6L3iKPZHnLpNiG9f41xt2m9vpGpBN1ee4gP/SfsNmLl9dH
        MS3pmDzG+H4vyhQTMcvkMtzWAw==
X-Google-Smtp-Source: ABdhPJw2zK3S5b1K/1RwQ6A2/7zXhDLmaX5knLzuXE8Gd+zanyl8DH9ZUOSigjP9IuNEoySH7yknnA==
X-Received: by 2002:a17:902:bd07:b029:12c:f4d5:fc6b with SMTP id p7-20020a170902bd07b029012cf4d5fc6bmr15315683pls.31.1629442888807;
        Fri, 20 Aug 2021 00:01:28 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id hd21sm10539997pjb.7.2021.08.20.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 00:01:28 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 20 Aug 2021 15:01:13 +0800
Message-Id: <20210820070113.45191-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
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

