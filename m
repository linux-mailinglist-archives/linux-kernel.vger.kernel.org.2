Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8139C021
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFDTGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:06:48 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46978 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:06:45 -0400
Received: by mail-wr1-f45.google.com with SMTP id a11so8410517wrt.13;
        Fri, 04 Jun 2021 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bh5QKmjnoYTHQUn3U7/OcwSchayTeJJXSPC9dyaLEIQ=;
        b=gIpjLTLiC4yxv4+CgWIuwO5lUe+hfQkwL/2q/em1wKzQxspgi+66eeYgAf9vK6wSSe
         cXOjttYOA5QqK/2Tk9gQB2RDO8CQ7d6pjLyK90ARi0ZuUIr0PuwAcZru/9A+/PO+0BF6
         l3YmDx9CdTaFm5jy3ZOPdMtsoK6MBcT+kR0bXKFqA8FcF/tn3h7tc1GwV83CSeDKcnQq
         y0TxOZXQquKMZhtLzzoHzKGCg6Llo1mArONKnOiFUYxxmljcdxoZBHoq/sf2/HBVipTV
         8mPfo3D2CVn3IKKHI2cASbqO9Qorvauf8e7MTesvn7QVa2EpDUXx9pWVcZ7ynzfdWpjk
         Ty6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bh5QKmjnoYTHQUn3U7/OcwSchayTeJJXSPC9dyaLEIQ=;
        b=TTA3+HP3F5Pi1IiwRFkdTMZFQakZTy6abqrkogr0GAlNDeM4pG3E8CBDzU0XTsfeHV
         t7tppheNaBJVx4X9yAVZ9I8R4I7URYCxfZbf6Zg2sMPc65MOsZkF0WewmYu4cMST40ng
         bcciuCgcfiRErV0NlVc6XK43cmnxVTKhDUTMLTo9M4rUWo4vquUNM/fHXezR5xHIAEfO
         JfxxmggOiA3DfWpAF0Pxu5pxeYrlT786Rmax/rcQEEAKK6H1XPSuAikajwunBdWfN4IO
         KVXh6OeYr0Kuy70I1BurL93h+2HUKIBqRbmIxx4wpmsIRpRwocQUFXQN40tefvcbcOEC
         nCwg==
X-Gm-Message-State: AOAM530LK2jvgHZ7SEqNSbL7Ud1ZqSL3ZYhUhfgc5rcP3N/AKbpRJgEM
        M7RAMrvqX/OAGb4v/F6L67E=
X-Google-Smtp-Source: ABdhPJw2AR5WV8wv59XEaugDFSNXFOdFk3qYh0L5C3KD1QKUSm+JegJqDcfXjs3nT+i7byCIv2uqvA==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr5568089wru.338.1622833436718;
        Fri, 04 Jun 2021 12:03:56 -0700 (PDT)
Received: from localhost.localdomain (p200300f137127c00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:3712:7c00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id x10sm7576200wrt.65.2021.06.04.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:03:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
Date:   Fri,  4 Jun 2021 21:03:37 +0200
Message-Id: <20210604190338.2248295-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
least very similar) HDMI TX PHY. The PHY registers are part of the HHI
register area.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
new file mode 100644
index 000000000000..18a123b9bb0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson8, Meson8b and Meson8m2 HDMI TX PHY
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |+
+  The HDMI TX PHY node should be the child of a syscon node with the
+  required property:
+
+  compatible = "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.yaml
+
+properties:
+  $nodename:
+    pattern: "^hdmi-phy$"
+
+  compatible:
+    enum:
+      - amlogic,meson8-hdmi-tx-phy
+      - amlogic,meson8b-hdmi-tx-phy
+      - amlogic,meson8m2-hdmi-tx-phy
+
+  clocks:
+    minItems: 1
+    description:
+      HDMI TMDS clock
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi_tx_phy: hdmi-phy {
+      compatible = "amlogic,meson8-hdmi-tx-phy";
+      clocks = <&tmds_clock>;
+      #phy-cells = <0>;
+    };
-- 
2.31.1

