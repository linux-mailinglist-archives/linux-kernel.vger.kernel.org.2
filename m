Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18A3D8DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhG1M0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhG1M0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B2C061764;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z24so1941478qkz.7;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saUJiNRMbvLZyMVotP5YuX5FwxQa4tigZr/kaBCa+Io=;
        b=K4v9CqjZNh8twTu5xrnxNT8X9vHL3NFu9kkZsyURLaTJnoNl2/ZwSIiaqs+cqWxZad
         bY/UrFOwxbuO/M3eiSRRA2ymTPp6vYxqfRXnRIq0Q0DGMvpq3qhL2+tIyagxaglPw7mO
         fc2+HnSt+RF7pC/FyHfKjOYOL3IQ1ixEbYK6Gw2i0+PIxY7oK4kmXIoTfj1HxpZJ85j5
         w3/aVtYuvtcc1aiO76NoI7vsstxIhpe3BFfRViapKpgSZ4WJdtOEYF71Qn9SOrrGVTWn
         55Od0ny66He0kH7hV/CAgTWp2YOyiZ69s2/1l1JPUMwT9P1/aLEaKOBiq4qp6iBgcfs6
         9IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saUJiNRMbvLZyMVotP5YuX5FwxQa4tigZr/kaBCa+Io=;
        b=DOAW0+GmqzlU06VoRk/PZBpyDq+X4xiJkNx6PnGcmM//ny/J3EspOXu2mzUT3EQDsG
         vw4dOo35VsXuVeo8MrFjfMaGU6u8ZMMpJ9Edul7W/obWG5cFHV/7RNBr3VhCnHweL0xC
         hQucKql//I5MDuUwctqNPBsG6Zbm+H8bMRXnNLJ23lD7RWf/NrIgXamBcgKuLBzx2XcS
         90e+bsR2GEo8wrQLAXdf/BzagDpAmvnWS0LAvMAVjtDS2Xp3fxFzU/GNXXJcnnEMRNvE
         ORRvw6wbdP2qy6gOdfrQGXtIyUXPg0yoixij7FPDqVBZslORJ3FLs9rB+iNWhUBRM/r/
         LE0Q==
X-Gm-Message-State: AOAM530qSyRtDGNsx1uisGYfRjlpQJRjIVmJ92a9OJ99FiWVvC4X3zIo
        Y1viAQ2CWFjyaAyJvIiaS/nx7M1j4q8j7igo
X-Google-Smtp-Source: ABdhPJzxXx1BFjc1KWaI0txpLeQx/KnOb1DN/D+akRYwuwv1Ggv9+kkVmVBuLjNw7rZjDyPaTVd9mg==
X-Received: by 2002:a05:620a:c86:: with SMTP id q6mr26855154qki.278.1627475179367;
        Wed, 28 Jul 2021 05:26:19 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:19 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 2/9] dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
Date:   Wed, 28 Jul 2021 08:25:59 -0400
Message-Id: <20210728122606.697619-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy node is a standalone node with a single muxed
interrupt.
Add documentation for it to phy-rockchip-inno-usb2.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index 5bebd86bf8b6..f16fea5cad1c 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -18,6 +18,7 @@ properties:
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
       - rockchip,rk3399-usb2phy
+      - rockchip,rk3568-usb2phy
       - rockchip,rv1108-usb2phy
 
   reg:
@@ -50,6 +51,9 @@ properties:
     description:
       Phandle to the extcon device providing the cable state for the otg phy.
 
+  interrupts:
+    description: Muxed interrupt for both ports
+
   rockchip,usbgrf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -78,8 +82,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
   otg-port:
     type: object
@@ -109,8 +111,6 @@ properties:
 
     required:
       - "#phy-cells"
-      - interrupts
-      - interrupt-names
 
 required:
   - compatible
-- 
2.25.1

