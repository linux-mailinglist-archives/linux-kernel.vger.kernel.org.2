Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E649438F57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJYGYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:24:42 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45253 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhJYGYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:24:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8194E5806B0;
        Mon, 25 Oct 2021 02:22:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Oct 2021 02:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5hM2/XE4eiulT
        ofdooK30iMnhhF3G/1JqJNrpfwoEqw=; b=UVuUAEBJ76s0ZcUT/ROOu1tlZ3vzq
        Xx1YDpYYPzZeD5RGkK/wFDcjjFNeTIKKfN9vBIRaCYHLiD7+zA5UQr/0vSk/hjAI
        LO4HuV9Tt2Tj//UoQXLkb+KVGKp6tUdclcbHf0jUcRijaKcUF+vxVHczDUB+6vJI
        Z/lTv1eqiCwpqWTM3NH/DEDvBFMemAbOFk2UgBsramehtGpmQSF2DyRe8NOQDvCG
        jnk+6kQe0rRqD48JRZ34ZvCKPUXsL4zlobFx/ejg/v+S9DqOIrPy6bmOKQBJD75v
        A5p0qrLOYII/plv4KueHEtxPOOOkhYQlfbY//CagGsHezNZ7FTM5faB5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5hM2/XE4eiulTofdooK30iMnhhF3G/1JqJNrpfwoEqw=; b=YtRap/SQ
        av5gPRWe3hBnO0AR3EZ2kqZP60CEKcwrsFFVHvRevvk1Brh+rbamLyNfIi21l/vZ
        CuwWAI7l7O6WxNqyXiUOFubkoNPVs+vpeImJ27TM5U4ksV1KWeEhREZuHiCa8QsP
        1DLjXlYtJ1j1QmElyh4pKgH9UC2xPiX7BGPfZZNqVXvJo/fujPVrKHUdbKqRkuhl
        9IsSiu8em5Gw0s8cus4/6nlrO9uV2Bq6jsxByh5Po8E3bxndKtK9c2M8mlA/435q
        7h8VO8xCZ0b60rlpVUF8I0BVnwaTM97FIVAtVPsnNDrEuJMgGJ0SKOQO9RNY084h
        6ia/uUhD0n5D4w==
X-ME-Sender: <xms:GE12YRvaxwtWOE6YnJFkfNxt5QF81l7b_ULL0MnEU6Y4JArAvqXIYw>
    <xme:GE12Yac75lQ5kifsuLgnrwXWksrB3nDOILJq9qB1DCMN_vh0Ue98413sMdFBR1kDG
    ktNyVIVPmCzekzblNw>
X-ME-Received: <xmr:GE12YUzI88a_4qq6-0iRh9_AcWvaRC8QMGAAotWLotoOg82ScoaI120xTZq5bz67KVhX7ohs9VvHnbDYoPTjsBaObWeIYsqK8rKnjSCCcAqyTCfCf-s-acc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpefhfeffjedvkeeliedtffeihffhffevffeijeetfeehuddtgffffedtjeehtdet
    heenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:GE12YYP8s44P66fYJdlgeBHFdf3o0Tp-d8BzlHZyZMGut8Yqb4S2Ow>
    <xmx:GE12YR_6hxZiV1ADH6wqpEbe6oCaB7Pj3eqQGYB3SN2sd-LryJwTDA>
    <xmx:GE12YYX1F7qzAlrnqg-hQL14Z_hZDDUrUnNMQ4KcDjkAJfxteLbR1w>
    <xmx:GU12YYVz2s6DBecHvQo7VQo3ualJKyZErnpqBgCMh_dmL0OoFHCzIw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 02:22:14 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: mailbox: Add Apple mailbox bindings
Date:   Mon, 25 Oct 2021 08:22:03 +0200
Message-Id: <20211025062204.1517-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211025062204.1517-1-sven@svenpeter.dev>
References: <20211025062204.1517-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple mailbox controller are found on the M1 and are used for
communication with various co-processors.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/mailbox/apple,mailbox.yaml       | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
new file mode 100644
index 000000000000..2c1704b34e7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/apple,mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Mailbox Controller
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  The Apple mailbox consists of two FIFOs used to exchange 64+32 bit
+  messages between the main CPU and a co-processor. Multiple instances
+  of this mailbox can be found on Apple SoCs.
+  One of the two FIFOs is used to send data to a co-processor while the other
+  FIFO is used for the other direction.
+  Various clients implement different IPC protocols based on these simple
+  messages and shared memory buffers.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          ASC mailboxes are the most common variant found on the M1 used
+          for example for the display controller, the system management
+          controller and the NVMe coprocessor.
+        items:
+          - const: apple,t8103-asc-mailbox
+
+      - description:
+          M3 mailboxes are an older variant with a slightly different MMIO
+          interface still found on the M1. It is used for the Thunderbolt
+          co-processors.
+        items:
+          - const: apple,t8103-m3-mailbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: send fifo is empty interrupt
+      - description: send fifo is not empty interrupt
+      - description: receive fifo is empty interrupt
+      - description: receive fifo is not empty interrupt
+
+  interrupt-names:
+    items:
+      - const: send-empty
+      - const: send-not-empty
+      - const: recv-empty
+      - const: recv-not-empty
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+        mailbox@77408000 {
+                compatible = "apple,t8103-asc-mailbox";
+                reg = <0x77408000 0x4000>;
+                interrupts = <1 583 4>, <1 584 4>, <1 585 4>, <1 586 4>;
+                interrupt-names = "send-empty", "send-not-empty",
+                 "recv-empty", "recv-not-empty";
+                #mbox-cells = <0>;
+        };
-- 
2.25.1

