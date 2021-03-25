Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5F349748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCYQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:48:10 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:34773 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCYQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:47:49 -0400
Received: by mail-il1-f180.google.com with SMTP id u2so2693350ilk.1;
        Thu, 25 Mar 2021 09:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1O1E/xRwZme5NOHcXojTDxawVUZizZj5kgRyChIK9Ao=;
        b=sfi7ror6M6j9nyTvcoRvlWfNcETGxKZaeUeJtcOY1SOnTUmKBhzakvuSGzT0IfPxxl
         beEfrwA+u2bm+8jQE/+yDv6jWvXs1049j0lv7fQ7tsAELZ7qn1XJvC+BrpPn8l6IMh9G
         nwYDhFEz4MP/6gJSO28dpkGSoWUfLfM3KliIjCXarWhClpVAK1lEIattqqlOhi+mk8yN
         /Wunr4bdbGXJU1XknqA+zCOxhiLzqXMeWDRVklOtBXw+fWYVTb77RiA6LAUEH9/gIZ7z
         OSqhWIW48NxO+vIna50tiFAHd7cLOw4uWrM1X01uSSWNE2yiwOXN7WlzNaghFYlhM8x3
         uVPw==
X-Gm-Message-State: AOAM5326XItPh+mNexOp7fxztIrmwm4alh3nCyIYoPeycmMAd3ZYtQfC
        7Q4jaYmBBraPFHIsv9OnaBqxeVB5rg==
X-Google-Smtp-Source: ABdhPJyYIbxtyMkD85vDHkGNFWPiFlXHfzohxPgp8c0NXKytdpBdfMpWXOPqzFN5cE03yAPqwtByVA==
X-Received: by 2002:a05:6e02:1d9b:: with SMTP id h27mr7501787ila.279.1616690868432;
        Thu, 25 Mar 2021 09:47:48 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id h13sm2868615ila.82.2021.03.25.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:47:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 8/8] docs: dt: Add DT API documentation
Date:   Thu, 25 Mar 2021 10:47:13 -0600
Message-Id: <20210325164713.1296407-9-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325164713.1296407-1-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc for the DT APIs are not included in the documentation
build. Add them.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/index.rst      |  1 +
 Documentation/devicetree/kernel-api.rst | 57 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/kernel-api.rst

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 70b5dcdbcf07..1a2fc8014996 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -11,6 +11,7 @@ Kernel Devicetree Usage
 
    usage-model
    of_unittest
+   kernel-api
 
 Devicetree Overlays
 ===================
diff --git a/Documentation/devicetree/kernel-api.rst b/Documentation/devicetree/kernel-api.rst
new file mode 100644
index 000000000000..b7429e6ed6d5
--- /dev/null
+++ b/Documentation/devicetree/kernel-api.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _devicetree:
+
+======================================
+DeviceTree Kernel API
+======================================
+
+Core functions
+--------------
+
+.. kernel-doc:: drivers/of/base.c
+   :export:
+
+.. kernel-doc:: include/linux/of.h
+   :internal:
+
+.. kernel-doc:: drivers/of/property.c
+   :export:
+
+.. kernel-doc:: include/linux/of_graph.h
+   :internal:
+
+.. kernel-doc:: drivers/of/address.c
+   :export:
+
+.. kernel-doc:: drivers/of/irq.c
+   :export:
+
+.. kernel-doc:: drivers/of/fdt.c
+   :export:
+
+Driver model functions
+----------------------
+
+.. kernel-doc:: include/linux/of_device.h
+   :internal:
+
+.. kernel-doc:: drivers/of/device.c
+   :export:
+
+.. kernel-doc:: include/linux/of_platform.h
+   :internal:
+
+.. kernel-doc:: drivers/of/platform.c
+   :export:
+
+Overlay and Dynamic DT functions
+--------------------------------
+
+.. kernel-doc:: drivers/of/resolver.c
+   :export:
+
+.. kernel-doc:: drivers/of/dynamic.c
+   :export:
+
+.. kernel-doc:: drivers/of/overlay.c
+   :export:
-- 
2.27.0

