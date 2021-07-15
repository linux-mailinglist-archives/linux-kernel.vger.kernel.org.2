Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABD3C9C56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhGOKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240948AbhGOKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:05:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C564C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:02:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x16so2964637plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0TwHbiKa4jLrlaR4uupjt1Nvt6BBHkFS2kGDMtNo4U=;
        b=HcMXqSaXb9gxcUOng+pdaNIC6T39etk+CGwXxJfakwtDxMCQP/Ub9AVO20E22Iky90
         bzsGzt63onQLH7vuDrGBnXHvTGHrTN3sxtA1mnUf/UVsUOSmhSQ7t5vN87zALFKmDagd
         XLNlHOISy7LHvgtJRmutkj0fs/6S+5Yaw1QW26HAWfREqBk5zaLoUV5CXIvgqc3J+FLg
         4g4fZWnCRpYYKOwZjF6rcK0VyMifuMFIiNKWWX51Ub3xgjPaJ7ZzHvmd8UbKfJ10kJYK
         hUxjDv95E6DWLC88fc8WV6JErE4G5GF/dtWvpsCA1frH7/pCHGADEoL6vxQDW3M9Laiv
         bIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0TwHbiKa4jLrlaR4uupjt1Nvt6BBHkFS2kGDMtNo4U=;
        b=Sar/g0pGn64rpJhD+pbNQNpnei23YAI7Vf5MoRT7JuC59gFNVKO1deZYmWTuVpJuF9
         ZSzLI9ARMftoDsMlTnkRZrv+HmxxkJ7byVdCTZuM72wLKYdkwREQnm6YOeX1w4eawsAB
         VmG/M2cfufEZg6ky1WzdVpTaCUXhZ86DZ6P4Xy4IxzWNy0vZYg66ZJHy3q+19vy5EEFW
         hGYGQKotreyDcgLYCTzLZk0/igjz9Hpzo1fhAL/4TSIcze+W6sZtCbW8VYJWDRqk438k
         jGOMeG6c/QzK4KVfrD1nc35NCcwWTs54qKl5Dqqzae/vWXkPgdm9RTBll7DLH2DXyeOJ
         KFqg==
X-Gm-Message-State: AOAM533v9C+dj7mtpOClx1TGyzhD09pe8OBUgrK8dw95gtKVM/LichzU
        ANP1BSukXhHv/w/du9336kJf
X-Google-Smtp-Source: ABdhPJxCFuHiksDVSuB6pWpOnNml95yP2UdSGoIo3HnPkTK/Cr7ozZlySqDVCqwRyJdXKhmXeXhiAw==
X-Received: by 2002:a17:90a:d80f:: with SMTP id a15mr3705242pjv.174.1626343359575;
        Thu, 15 Jul 2021 03:02:39 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id 21sm5727017pfh.103.2021.07.15.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 03:02:38 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to YAML
Date:   Thu, 15 Jul 2021 19:02:36 +0900
Message-Id: <20210715100236.228531-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
deleted file mode 100644
index 3052bf619dd547..00000000000000
--- a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
-The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
-Programmable Logic (PL). The configuration uses  the firmware interface.
-
-Required properties:
-- compatible: should contain "xlnx,zynqmp-pcap-fpga"
-
-Example for full FPGA configuration:
-
-	fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&zynqmp_pcap>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-	};
-
-	firmware {
-		zynqmp_firmware: zynqmp-firmware {
-			compatible = "xlnx,zynqmp-firmware";
-			method = "smc";
-			zynqmp_pcap: pcap {
-				compatible = "xlnx,zynqmp-pcap-fpga";
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
new file mode 100644
index 00000000000000..565b835b7fbac0
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Ultrascale MPSoC FPGA Manager Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  Device Tree Bindings for Zynq Ultrascale MPSoC FPGA Manager.
+  The ZynqMP SoC uses the PCAP (Processor configuration Port) to
+  configure the Programmable Logic (PL). The configuration uses the
+  firmware interface.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-pcap-fpga
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      zynqmp_firmware: zynqmp-firmware {
+        zynqmp_pcap: pcap {
+          compatible = "xlnx,zynqmp-pcap-fpga";
+        };
+      };
+    };
+...
-- 
2.32.0

