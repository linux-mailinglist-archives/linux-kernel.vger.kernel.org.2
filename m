Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3638F2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhEXS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:29:31 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41943 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233488AbhEXS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:29:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 74F56581E72;
        Mon, 24 May 2021 14:28:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 May 2021 14:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LwSKq/ex842eG
        i/egnj5f1CpSQ34FFJ9YcYzjun5nOQ=; b=2MVTAWaPVPvNHvFg2rYWvao0Ur3wo
        ATIE+7KWNKWNA+F+sKfMXbkH2tMQXSUDsvFrSPi39VDZ10GxwMk34ddLQ/G3vN88
        LiXqwIA+pgD5WLNydG0z0ZNxz6LRIyzDiLytVNM3UvJt59hFZEueb+bc/Ln77Aby
        isvHPE7idQ9WuJ8nNRdWroUo7gQtzstmdQ4w3rGusuhUSch+yIBlr85toK6KK0Iv
        1j3sf3YvK1dFlsCdicBA+tKJc++tUHCFNsTncyZmT8obdrTLYPkouQm/HT68OmH6
        WukCJPSEM7eGwz6bAOWH3z88KeKT14azDfkAukB20IvvbF8N+0faKwcww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LwSKq/ex842eGi/egnj5f1CpSQ34FFJ9YcYzjun5nOQ=; b=jaETDRqV
        GFXmd92DPk5LEAYmrFUMayOm2reliCekKQaKQLuhqeyIweALc5GnoTpTNiN4sAbD
        N5h5U8gYbycPEZtk1Jy6QVKxnefdN0Jzm3hk5fF7A5XD0LRTD7n/DUmxXxNkbcHA
        GMamD92SzXBIxRwFGwVytpCqsS+Fpa2eMFiS6cYvJ0Vu48J0RhpRITUW8HUO8HYD
        bLeWBdvdPC3MOkvhW+kjtBbYuqxSGa2rmrmBYhOuGEKzOD2msUXr4JjriahsIPtr
        ShaNZprd5lYyuXDY5KHRjfCoQ2He4sUOPjwuElzOmI0TeXxA1y96rJ2Hij238nWV
        7OJ76bjjq2Ux+Q==
X-ME-Sender: <xms:MPCrYLCiOzMS3mifBoAfqp4LgpHaR4a6sH5pivsOIhvMEiwbFvpCcw>
    <xme:MPCrYBiBxEaphgT88uOyRgj-JSjzxQKd5wxRx9uhftw1ukU4XzRnwDt1lNgKZAMmy
    Cp_tcLBvPHB-yvw8o4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeefgefhgeelhefhtedvuddvudehffffgffftedugeeufeevtdegudfhjeeuieeu
    hfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhgihhthhhusgdrtghomh
    dpfhhrvggvnhhouggvrdhnvghtnecukfhppedujeeirdduleelrddvuddurdduvdegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:MPCrYGnfJncxUnDsTVKiTn5dKzViIo2bRfWmld3rNQLeaavAyE3EBA>
    <xmx:MPCrYNzh9O8Si2VS01oLbfV9HySl-YkPWYt1XevQQqc39m_dCn48EQ>
    <xmx:MPCrYASXQ2nGYns1INR2J7rRJTDI_wpodE_RGlMFzN-K7x0LY6iK4w>
    <xmx:MPCrYDF04GEp6GuHoS4tyxsJ2gkewnMWbel1ywjzqVI4DiwjD1tZ_A>
Received: from photon.s7r42.com (ip-176-199-211-124.hsi06.unitymediagroup.de [176.199.211.124])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 14:27:58 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 1/3] dt-bindings: clock: add DT bindings for apple,gate-clock
Date:   Mon, 24 May 2021 20:27:43 +0200
Message-Id: <20210524182745.22923-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210524182745.22923-1-sven@svenpeter.dev>
References: <20210524182745.22923-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These gated clocks are found on Apple SoCs, such as the M1, and
are required to enable access to MMIO regions of various peripherals.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/clock/apple,gate-clock.yaml      | 60 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,gate-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/apple,gate-clock.yaml b/Documentation/devicetree/bindings/clock/apple,gate-clock.yaml
new file mode 100644
index 000000000000..3aae47c40b42
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/apple,gate-clock.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/apple,gate-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Apple clock gates
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description: |
+  Apple SoC's such as the M1 contain various clock gates.
+  These clock gates do not have a frequency associated with them and are only
+  used to power on/off various peripherals. Generally, a clock gate needs to
+  be enabled before the respective MMIO region can be accessed.
+
+  Each clock gate is configured by a single 32bit MMIO register which contains
+  the actual and the target state. The state is encoded as four bits but
+  right now only "powered on" / 0b1111 and "powered off" / 0b0000 are used.
+
+
+properties:
+  compatible:
+    enum:
+      - apple,t8103-gate-clock
+      - apple,gate-clock
+
+  "#clock-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clock-output-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock@3b7001c0 {
+      compatible = "apple,t8103-gate-clock";
+      reg = <0x3b7001c0 0x4>;
+      #clock-cells = <0>;
+      clock-output-names = "sio_busif_clk";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 008fcad7ac00..59c026ce4d73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1654,6 +1654,7 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
+F:	Documentation/devicetree/bindings/clock/apple,gate-clock.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
-- 
2.25.1

