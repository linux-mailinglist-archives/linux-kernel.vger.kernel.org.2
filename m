Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735BB34E631
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhC3LOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhC3LNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so24198268ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4nlJCx7st0JVvK4JdlximvTBeGnssC7MG9M+ZbP1oU=;
        b=O5JbLsIefSqoR7FJG804xwuBV3hCDLjltckmrXx5fLiGvUgP3l5spWVZJvxF5U3Nv+
         PkgPLg1eXRvxBfce1WobkI7cNQAqRO4Vqk+1SNSCLw1bBMUc0+Oj9hsT/HsnLfAK026z
         rUBLNlTvaPnJVFPK7AxnwcpPVWduDAOVVuqsNQIqyRe/cAxG3tCOeb3VSYDuAp1Wwn35
         vNOr7gzCgx4MFMP9grzRh0ioZuzur/aSRxhZXUDOSflCdmOLH3SGhJQPyJQGP8v3p10s
         s7PPPAovbfnwj8HnWD42S6R2PrlrIjrjrZGI/md8QBMSlhFl/p69C/pJTmP10ggvenI1
         VBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4nlJCx7st0JVvK4JdlximvTBeGnssC7MG9M+ZbP1oU=;
        b=uLrAYzw1HoZua224vetxN0do5h8kF9lHCYhEQ5YEvY9Xi6jTGtFvHQH6rzNjI0q+k+
         gD/d3SJFCXPqdUyf+g+MAnlKSwivAPf0xSI9P2jsyopmJEJ3Vl0XzKuppHKaiB5xF/Y7
         6/7v3A51oDcIH47K83ZwpPkZduQpiZTq5xMbNjdK3pGG3z59KGozPApF8+pHDjYqjJqi
         ftkMvHvH85a6rS7n+Rwwhge32McvI+f+u39OfG7VIMx+oXDrk/Fr+BzHUCEfhr7eso3a
         rAw08TPxOt3Wm7B6tCegOxq+xDcCdPNMfIde5k4xXloUMg7Oz43cE2SiOvtCQsZdrmmB
         oksA==
X-Gm-Message-State: AOAM5315mdantc4Nyyo+2QYMRfR7UnzIlO3blfBvl/v7Zv0xqherjxWB
        5iGr51WDrFZTPI11tUuxOpbAeyfGxfNh8g==
X-Google-Smtp-Source: ABdhPJwiJTUoF/AVI32CtHqkYYB2UgH7djJeYJ2J+5O9VbT9OmRn8+X2XNd57/x3L1DXNUhDzKo7nA==
X-Received: by 2002:a17:906:4a19:: with SMTP id w25mr32415014eju.180.1617102820994;
        Tue, 30 Mar 2021 04:13:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/10] dt-bindings: nvmem: add Broadcom's NVRAM
Date:   Tue, 30 Mar 2021 12:12:35 +0100
Message-Id: <20210330111241.19401-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom's NVRAM structure contains device data and can be accessed
using I/O mapping.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
new file mode 100644
index 000000000000..58ff6b0bdb1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/brcm,nvram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom's NVRAM
+
+description: |
+  Broadcom's NVRAM is a structure containing device specific environment
+  variables. It is used for storing device configuration, booting parameters
+  and calibration data.
+
+  NVRAM can be accessed on Broadcom BCM47xx MIPS and Northstar ARM Cortex-A9
+  devices usiong I/O mapped memory.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: brcm,nvram
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvram@1eff0000 {
+            compatible = "brcm,nvram";
+            reg = <0x1eff0000 0x10000>;
+    };
-- 
2.21.0

