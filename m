Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8252E32337D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBWVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:51:51 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:41433 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBWVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:51:40 -0500
Received: by mail-oi1-f182.google.com with SMTP id o3so246271oic.8;
        Tue, 23 Feb 2021 13:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AsR9ipt+b1mHYtmLjiSKpblxqFVh4LbdCrUVluojW2Q=;
        b=A8BydkdYx4OBqOBCkhZ0aE96xMlN+ai9tJxLFB73J6UFqv41FM3uWT1j7AGYsY9ZPP
         7LkNdnVQBERTBZ/DhD1ed+ROFCIy83iyPRU2UO2uhJB+z7Hh3zbec5eQiIRKPe9YbPpO
         juDRBeefSSQ+hRrCEyfEh4x63k3SAvuJXQ/oIpHpd1WokYSW+kXdqau99mhaFSQi8iqk
         1f6LVG5JMSWVeR8yslNyKOIp2lA1VMahqRvU/mBraD97xW2UwqCpf3TTimPwR6rj68Gc
         pAR3acvRedL6nChyWdqQX9W4y7Rw7oZbl3HEV2ZeyQiJZ+bJ8mB8yveX4gFLl77sCyGS
         HmfQ==
X-Gm-Message-State: AOAM533Q8709wmCMniN/1vrPv7V/NQ+P5lF8d7ZX75HyQnlrVagpVpZn
        BIt4/RluRdfjJRThqkCzUe5goqA5Wg==
X-Google-Smtp-Source: ABdhPJwy7fsmg2yVC2MxWgcLyRFaNJiQxfoU7ly52FmudKmJznM3YDMN6gBOsgvWng4cpxYEOHkXaQ==
X-Received: by 2002:a05:6808:14d0:: with SMTP id f16mr601770oiw.56.1614117059629;
        Tue, 23 Feb 2021 13:50:59 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p26sm1444867ota.9.2021.02.23.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:50:59 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: display: mediatek,dpi: Convert to use graph schema
Date:   Tue, 23 Feb 2021 15:50:57 -0600
Message-Id: <20210223215057.125708-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the mediatek,dpi binding to use the graph schema. Missed
this one from the mass conversion since it's not part of drm-misc.

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Jitao shi <jitao.shi@mediatek.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 6cdb734c91a9..eb84b53cabb1 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -50,15 +50,10 @@ properties:
       - const: sleep
 
   port:
-    type: object
+    $ref: /schemas/graph.yaml#/properties/port
     description:
-      Output port node with endpoint definitions as described in
-      Documentation/devicetree/bindings/graph.txt. This port should be connected
-      to the input port of an attached HDMI or LVDS encoder chip.
-
-    properties:
-      endpoint:
-        type: object
+      Output port node. This port should be connected to the input port of an
+      attached HDMI or LVDS encoder chip.
 
 required:
   - compatible
-- 
2.27.0

