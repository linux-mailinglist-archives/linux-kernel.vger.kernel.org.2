Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26D377BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhEJFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:45:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49855 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhEJFpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:45:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 98D865803ED;
        Mon, 10 May 2021 01:44:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 10 May 2021 01:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=E8QunPh9AaMnR
        gR+ENPZuJJI09F8EPSuDjGchklbXy8=; b=ci1Usrf1jf2DBeAn6MFtJNhve1NwA
        gjTe1jVG0rdmByllTmNu7H0U+K8RSlcKwR0UD4nJcT7Gkuai219yAj5jgSMm6DYd
        HUYP1/0T6hhMBdWREGIafGmh4R52A8yVQTW8N17fTxMnBIsVkJ8v29tHVUUGNFOB
        XtmH0j/NF+hlA6XGv/+j6Fx0G9E8wZv/aKNY25R4w0iU+Op+1OzOnM+snepW+0Jf
        VfnklXDjwnGuoPZbrzN6IpxfpEAamj+RSrFB2JjSumPCM1EfaYzbDGLjDJBAA7rA
        fhKpZzb4LpsemG764keME44qjZshs7/KZtwr+8ZOyBSV6EDafsC9l8ueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=E8QunPh9AaMnRgR+ENPZuJJI09F8EPSuDjGchklbXy8=; b=klEKiaei
        SrE0ckKtCFdFf+eEJ2WCv8u+m+5LNs09+rl5UX4c+aJiYNtqxTcHvBYUIc/p2bxv
        RQSUjH74K+tRrjy+YRlDLJ1opjp1uwCpHg+Ql95+pkdVceUUE74hhUY/ajzoY9mK
        oXbxlnyMT/4kN7V6+4pHFznXQV9if9+2BHvezaBQp2SV7Z8yF3NtboJYoFKYIHFK
        DJrJmZvuafoNNEjHp36LKgVUMdOLN6b39IunkluKbwiBlO07YH3iL4PlwiuKqChY
        h2ShAYsJRXPBIOvbhwSHRXPGUWQ9iXOn+KKSXXEOrJBMdELu+FzFordDDLdiX/HF
        I6pK2OIHb4c0bA==
X-ME-Sender: <xms:PciYYCZlJov8g_FNkOjgwkLCNn-H_OB-e_p1oCJJPT7qtvsfq114ng>
    <xme:PciYYFZRNzlcO9657hfMOICBenW4AFcPEQfuiRt3i1n6BhKSGzmlftd0kzmHBxI_X
    WVR8x13TVN1BPv9Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtth
    gvrhhnpeejgfdvveehteekveeggeellefgleetteejffelffdvudduveeiffegteelvefh
    teenucfkphepvddtfedrheejrddvudehrdeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:PciYYM89SZaognR9-5oOPejqMpuwTbLrV7uwTCnTZiOekj7ZyWD_Xw>
    <xmx:PciYYEq3bowAkiDKmbnbCX_9mUexpHB8JtOAYl6swEQL0OjwzHAKEw>
    <xmx:PciYYNpKTKTSpNZvnFYwaPbSQsorvgGojA0N9gjB-eS3KO_mk8YvGw>
    <xmx:PciYYIC9AZg5Q6aJAqkiTigRDfgEXW0sL890E2-zZO5rSFSB79-Zow>
Received: from localhost.localdomain (unknown [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 01:44:23 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 13/16] dt-bindings: ipmi: Add optional SerIRQ property to ASPEED KCS devices
Date:   Mon, 10 May 2021 15:12:10 +0930
Message-Id: <20210510054213.1610760-14-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating IO and IRQ resources to LPC devices is in-theory an operation
for the host, however ASPEED don't appear to expose this capability
outside the BMC (e.g. SuperIO). Instead, we are left with BMC-internal
registers for managing these resources, so introduce a devicetree
property for KCS devices to describe SerIRQ properties.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
index 697ca575454f..4ff6fabfcb30 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
@@ -49,6 +49,18 @@ properties:
       channels the status address is derived from the data address, but the
       status address may be optionally provided.
 
+  aspeed,lpc-interrupts:
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    minItems: 2
+    maxItems: 2
+    description: |
+      A 2-cell property expressing the LPC SerIRQ number and the interrupt
+      level/sense encoding (specified in the standard fashion).
+
+      Note that the generated interrupt is issued from the BMC to the host, and
+      thus the target interrupt controller is not captured by the BMC's
+      devicetree.
+
   kcs_chan:
     deprecated: true
     $ref: '/schemas/types.yaml#/definitions/uint32'
@@ -84,9 +96,11 @@ allOf:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     kcs3: kcs@24 {
         compatible = "aspeed,ast2600-kcs-bmc";
         reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
         aspeed,lpc-io-reg = <0xca2>;
+        aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
         interrupts = <8>;
     };
-- 
2.27.0

