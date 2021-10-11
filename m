Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E550428A84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhJKKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhJKKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:07:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4EC061570;
        Mon, 11 Oct 2021 03:05:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so52635333eda.4;
        Mon, 11 Oct 2021 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBG8wRc1b08FIOJXITdzy5tgHamcbJY4CQQVK6+bWNs=;
        b=J2Iw2hjeiqwlM1zqpvPAwG0LAOryRE+zYqL3ShKsyNOlqBaMX5Va/FRGCBarQ/1wcy
         58cS08wolly264j1iUAWbWh9lALXR8f0e1tPF+2ETN+f5Tvym7J8Gs4m7oIR6fQIF1zI
         +gHQ5myPrrJdqjvJv8W+GOIBmA7SOZ5Sqk+2D4pCMjlJg0R+3QFaaf+fBhOuTJd7iNLP
         FhwLVnzWndA0FNkzE+WNaePmiH3KLCLQxQujr1OXgxKXQ5FzsR+/nsMjm+hHS13oIkyR
         Aoaw28KSZqhlpfHsuccuvLdHV97bvhNy6EvM5YY0TxeBQyLQMRMcYjLhdd0jbB8vEMZ1
         L+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBG8wRc1b08FIOJXITdzy5tgHamcbJY4CQQVK6+bWNs=;
        b=o64wJIfdO1i/GHKkkeEnFYBV7zQbo9rJSMVJxYZZ8gpPyoC56aZSkxEsYuCic6UGUd
         +g9LGQ/NXpMwrfT+O6S+lq5Vz1r4HG4AQGj0eFXzaUolCVx8oYsZfMUNQQLAfoMc6u+s
         od+4UkqMRqqqho2dUXTm0rKGHflpxCPRilpqyKxZkz3Xpud7/mEmoPBvym4B93e/Xd4e
         9dbWEJKcKW3wX7RqoZJRfdBDfGuOSL12v7dRLVDFRG9/rPteTT1B2V+I+9zdr1FZ9uP/
         GiO88cRbxv2gdwES9/hW4U3AkBRaW5Av7uMbPWMMXdqdIgUk+eMOwDqn0Iyhha5xSAQJ
         yupA==
X-Gm-Message-State: AOAM532Q4/+rlAjZmx+zFBj9co+q7cRxy7vwqWU8+s/LfdHVCyIuCqJg
        ZhZKsZjyswihnN+ZRmr29o8=
X-Google-Smtp-Source: ABdhPJxG6GAE47qrIe2i7HxqiXzctxRMM5+Mak/IlReykjt65+49Tp8dQ1DYJyJWSm47mU0tK5Zp/Q==
X-Received: by 2002:a50:cf4c:: with SMTP id d12mr40204516edk.115.1633946758084;
        Mon, 11 Oct 2021 03:05:58 -0700 (PDT)
Received: from seb-desktop.. ([2a02:a03f:67bf:9800:ca94:8462:89ba:62dd])
        by smtp.googlemail.com with ESMTPSA id g26sm442937ejb.84.2021.10.11.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 03:05:57 -0700 (PDT)
From:   Sebastien Van Cauwenberghe <svancau@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Sebastien Van Cauwenberghe <svancau@gmail.com>
Subject: [PATCH] dt: Add SpinalHDL vendor
Date:   Mon, 11 Oct 2021 12:05:31 +0200
Message-Id: <20211011100531.443157-1-svancau@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds SpinalHDL as vendor. This project
provides FPGA IPs including VexRiscV CPU

Signed-off-by: Sebastien Van Cauwenberghe <svancau@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..a145b9af232a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1100,6 +1100,8 @@ patternProperties:
     description: Spansion Inc.
   "^sparkfun,.*":
     description: SparkFun Electronics
+  "^spinalhdl,.*":
+    description: SpinalHDL
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
   "^sst,.*":
-- 
2.31.1

