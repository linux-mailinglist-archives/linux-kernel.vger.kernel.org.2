Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E303D65D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhGZQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhGZQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:54:22 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:34:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so2412600ooc.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOyJ8Rc1+7t0YsnzVklU5b9F37l3+jW4OcgT5rziuFU=;
        b=fAZlxhQdyRp5zRb1mi25f/B4kL5ZXX0mCPnFX4I0238WwihNK21ztCUO6TrexvvPiv
         2Er0F4JfnIP/P/GHgqmWn6aY2p8ImlWACu77OPYMAWk8CieAem+/B/iCMMuo5ITOPjin
         wvRJO1ER91VkDbE7rjs4gbOdz1ZJxqor+khnQ+BjxYBHShEokP840+yIEdRXIdbKtKtl
         70EXAr2LOoomFXw7miMn+qgh4/rJiukxnfFuRkVATGWGGNqXjSAc+mQrZY+DlCAsnPwL
         7V2bpD0b3uLRIn4Z4QyPaMrKQly0Mdd/oGU7fmaYbyMpLHLaEEFPd+Wx2ORAqfL7vnW/
         KKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOyJ8Rc1+7t0YsnzVklU5b9F37l3+jW4OcgT5rziuFU=;
        b=jWBCck0pebwnWcpOxlnAL8YzfflIpwptTmuOWlEw2GuRL87CX/kpG+Rh6ZR0piWDqL
         Em8nxT7hBA6ddVB3Nptqm94nl1FXRvdQkFdw/PUfV0m9i+NfLdN3NBO9MW+9A09NefBf
         Gq8H5MSWzZlDNy280ojtcWmlE1kZAYnudtTmMOQfil4Pqg70/voyl5wYSEUpALg6tWpj
         Pqt6mTGUzHhiyD0M838I4R2MoLH5libgo8mnN6JXJOBiL+kvDHY93tFQlBL6WD3/AZL3
         eS/7hObCOfvmn+LLcF9u+6XPFHprEU654Uymso8psM2KV99IQ+IzltIebqaEO/4YZstS
         PqTQ==
X-Gm-Message-State: AOAM531ZNTq0cN0PuqKJegK1IEYtf/z30kjUNEhD46FGCekDz6AQ478U
        cXZBp/h+ufBVPUpCS+9GrpueVA==
X-Google-Smtp-Source: ABdhPJzj9GSyzOgaXvC/6u+xBmxl/5r2hXaqVyqoa7pDzveUYNhuECB19AieW7EB2CyiizlnCMCAiw==
X-Received: by 2002:a4a:b98c:: with SMTP id e12mr11209038oop.67.1627320889238;
        Mon, 26 Jul 2021 10:34:49 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s24sm69328ooq.37.2021.07.26.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:34:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add AUO B133HAN05 & B140HAN06
Date:   Mon, 26 Jul 2021 10:32:59 -0700
Message-Id: <20210726173300.432039-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the two AUO panels B133HAN05 and B140HAN06, both
1920x1080 panels with 16.7M colors, first being 13.3" and the latter
14.0".

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b3797ba2698b..7f624cb1199a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -46,9 +46,13 @@ properties:
         # AU Optronics Corporation 11.6" HD (1366x768) color TFT-LCD panel
       - auo,b116xw03
         # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
+      - auo,b133han05
+        # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
       - auo,b133htn01
         # AU Optronics Corporation 13.3" WXGA (1366x768) TFT LCD panel
       - auo,b133xtn01
+        # AU Optronics Corporation 14.0" FHD (1920x1080) color TFT-LCD panel
+      - auo,b140han06
         # AU Optronics Corporation 7.0" FHD (800 x 480) TFT LCD panel
       - auo,g070vvn01
         # AU Optronics Corporation 10.1" (1280x800) color TFT LCD panel
-- 
2.29.2

