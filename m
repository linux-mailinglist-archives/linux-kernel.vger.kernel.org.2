Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560A43E7C52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbhHJPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbhHJPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:31:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3CC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k4so13345580wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZseZOvDFi1a/mkBTQe/OP8DG4IaH8JCVAVbciylYSk=;
        b=idEq3/EgGHmxXJi8Eym376f0bjBW+gHoaZbTjTpPDqsEpXI8VJWO52jzbVgRCcE3tF
         B3WRNzE4kPw91BzzLerYA2yFmHTnxeDOaLHX7IBsk7nFR9XF6Q72cuQ9u+flz0rs8kwk
         6INoGqD5oDwq+CDw0GQJ0lUZkShiVx/w0n5PXXf/BCzZ7sEqdXc06L8m9z+UEUdXJRay
         qahb38po4wPSteUaHGZ/dLeTBb/ssUZvOuiXSoQV7ownGkP5GWh9Vbs9zCCpD4eWvL/u
         IDZOUPTXEJTBmOQLNasJ2W6EUBfyiGBKjyEdsEYEDl0SS+U1gSds3lnuc+xjm1ovw2QA
         V/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZseZOvDFi1a/mkBTQe/OP8DG4IaH8JCVAVbciylYSk=;
        b=U94NonZ2TX7oDIBhs/BhoAuZmUw0JkhUE6B9XtbhZq0maN73/UhmWdvFCiPcpLIsF5
         X8Q2QQQqPlnJsIhNgMyPFWl7rI9eLbxfcRmy8jcl5sMn333VwYrw9J5i7kX/jlMQD++H
         53y6IEaD8f3S3LAQfUKGPcKegv6S3HlsC175RAIey8jL2ZYIzINUcr0L8WsdJjvI1C3z
         +p4iisPIFTx4cgT9tWrkqcxWeoZSJkni+MQJdL1Rg/uwEcVJeSb5ZK6gE5LpohTzy4tc
         0LeiOejh9jsLFIQkbuK3lORUbSRT/xzirzv8+yiTnxOvdmPoamAaotUGgeb2JdM/L6HI
         cvoQ==
X-Gm-Message-State: AOAM531raausoaSBco/pcVGgADdN0mliytnHi+VJQQLL+e/jMZ2S7am0
        4JhhHryMVQmB0aBVALqTPplrJw==
X-Google-Smtp-Source: ABdhPJzM/tIDWXByHfjqeUN+OiCtQYiB0UGPNUuhgkXHBNS684US9KgdOpNTYYDatpFZ5eojgA4URA==
X-Received: by 2002:a05:600c:ad8:: with SMTP id c24mr5316760wmr.28.1628609455734;
        Tue, 10 Aug 2021 08:30:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j1sm3002354wmo.4.2021.08.10.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:30:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
Date:   Tue, 10 Aug 2021 16:30:35 +0100
Message-Id: <20210810153036.1494-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210810153036.1494-1-srinivas.kandagatla@linaro.org>
References: <20210810153036.1494-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

Both of these consoles use the exact same two registers, even at the
same address, but the Wii U has eight banks of 128 bytes memory while
the Wii only has one, hence the two compatible strings.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/nintendo-otp.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
new file mode 100644
index 000000000000..dbe4ffdd644c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nintendo-otp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii and Wii U OTP Device Tree Bindings
+
+description: |
+  This binding represents the OTP memory as found on a Nintendo Wii or Wii U,
+  which contains common and per-console keys, signatures and related data
+  required to access peripherals.
+
+  See https://wiiubrew.org/wiki/Hardware/OTP
+
+maintainers:
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nintendo,hollywood-otp
+      - nintendo,latte-otp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otp@d8001ec {
+        compatible = "nintendo,latte-otp";
+        reg = <0x0d8001ec 0x8>;
+    };
+
+...
-- 
2.21.0

