Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1D41810A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhIYKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhIYKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 06:33:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0DC061570;
        Sat, 25 Sep 2021 03:31:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dm26so12181684edb.12;
        Sat, 25 Sep 2021 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeH5vkzIpa6TeE8Tz3mSyGZU/tR0+zS/g4jLCGFfdvY=;
        b=USmlh/DZPVWtlxSSuUkmPMHHOwRs9Xv9zziDWV2tjKDDSy1mtSHsSwcMeY6RODpGw/
         bEe6jw9DJEKZKnaYrQ4vLeEoJii6k7oStRkTA/BzA+d/5g5uQXxSZTL6/lAKffMTqwEA
         QOdQVyQlrFmot5aAw3JrYFfnf3d7N9S4IG8n4qrybJKnBDJwbMaooHTa9+FdTGmtUgVh
         ENySnXeG7vOlgTOaLlevLTYvomd5ouIWeE4uXwMU22pr2w7kIds6XU7Zcvdeor1fAbJV
         GA0Et9j6BwOdRfWdrW0pVEpnfjWMVuSWka5gvCly19gLgxdWwZU5JL/+wtrKWaoIL8Ic
         uxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeH5vkzIpa6TeE8Tz3mSyGZU/tR0+zS/g4jLCGFfdvY=;
        b=M2q8MHE/K/QVzoWQ0xvLbQG3QnlYYeP1vOV6fggGy7aNODc0Yu8MhlZeUpazb68o7D
         uewVKwhc9BEGeHmUFFgPBxWt62kb+hKaNn+RCYjlpDuGICQ717s579H3/sqSbqOCuLYM
         McxCMS/lpId38fQY7YMLgneHdp1eRRKLB6xF4e5nmZrTYMIPaX2kCCPLEMADpn4RMxxF
         YLKP0Y0iEf2BQ9HrH/NfZ6JPOUscMfrDnOwxvgiNEi3UWOrnazJ23I2oVsVoA4nWBUpa
         nMO9Bti2lwfz29hrK/UENAqy6mwZzPtyDyBmRrZhXQfzuSNcZyoLYgXeoY/LhsxLFOKk
         4dzw==
X-Gm-Message-State: AOAM531/YGIsYsjgxNhfOXD/9y1kJvj0cPzr9yuIh0PyY+2Uwhwj7KVX
        WQPUBwFzAw+ZzxAN9+cm09w=
X-Google-Smtp-Source: ABdhPJzlNASQZT2iU0BZikQkFfvD82LU7XQPQMGqTq6pq/QLz3B4QtN9njOy5nJ9iqrZmXuGfG4w3w==
X-Received: by 2002:aa7:c905:: with SMTP id b5mr10801924edt.380.1632565918123;
        Sat, 25 Sep 2021 03:31:58 -0700 (PDT)
Received: from localhost.localdomain (net-93-144-178-230.cust.vodafonedsl.it. [93.144.178.230])
        by smtp.googlemail.com with ESMTPSA id m15sm6203750ejx.73.2021.09.25.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 03:31:57 -0700 (PDT)
From:   Raffaele Tranquillini <raffaele.tranquillini@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     y.oudjana@protonmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: panel-simple-dsi: add JDI R63452 panel bindings
Date:   Sat, 25 Sep 2021 12:31:33 +0200
Message-Id: <20210925103135.518443-1-raffaele.tranquillini@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings for the JDI FHD_R63452 1080x1920 5.2" LCD DSI
 panel used on the Xiaomi Mi 5 smartphone.

Signed-off-by: Raffaele Tranquillini <raffaele.tranquillini@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index fbd71669248f..2c00813f5d20 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -35,6 +35,8 @@ properties:
       - boe,tv080wum-nl0
         # Innolux P079ZCA 7.85" 768x1024 TFT LCD panel
       - innolux,p079zca
+        # JDI FHD_R63452 1080x1920 5.2" IPS LCD Panel
+      - jdi,fhd-r63452
         # Khadas TS050 5" 1080x1920 LCD panel
       - khadas,ts050
         # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
-- 
2.32.0

