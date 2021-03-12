Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3F338D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhCLMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCLMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:44:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6845EC061574;
        Fri, 12 Mar 2021 04:44:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e9so1700142wrw.10;
        Fri, 12 Mar 2021 04:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=jKu8KqJ0S9Ti0089FwYbzp6PseVn8UWEuGVbAk2j8DJU7dQ52Xp1Ke51Tb+vGopIWC
         NmGxDUqN4/27ko7EM+tj4gS/Mmahh8EAKL+MV+CI7gKgsgW3LgjefxbPmvX/8rYjE3em
         2M82od3nx6sLLXzceyi+BgkU2K81kkyyetjgZ185s7zYXZZcvKKOkLz68xyy3LTnjGXK
         wWeg/Gbg1eq7Yd6CzoPgizHJ+KYkusD2V7+KxXslWFXW+t33KR7SS4O6ghqH27gSmH55
         6lmcaDGKvA5QDHhwQgGKxhrLgfvi3tqnvlLSVkiEIngWKX7VdNmflmqQAAdSrmfEflDO
         fRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SX53bYeJpoRn/Rj8EJYnn/yWlrMIeX4TZ6gWcrZofc=;
        b=mh7ewHrbSYwbo2/iUShF/KvEGR6BBA4uIzoYx1pJvFCFHGdGJ00t0NMJVFkmImUzMy
         Og3Yyen+9rqnkEc0gwcYYTE8F7SbVi0ZUDL86jc0+WaUZSdQMu4EKrppoUBdpplYGQOk
         uGJymsh4FRBEDO73/DIN5cMt0lN7juwlSb7oyVg8U7dnVhZKt69urhpULFdW7APFInXZ
         SHIDSMhLrDQme6ooCV1ys+EX+wLepn3+YVpd62VmFaCGg3kH2gCw1SCKnqiKGN1E6G3Y
         hMI2eQ0QbBK8I771JUTB9mR3d4FfAielt+TkGtvU65wxJtPdM9XyU2xrKVK2y6KGVlT8
         bf+w==
X-Gm-Message-State: AOAM5312kQ+BllOZ6H9cCQfci69Z8T19WG2GEfTrLeCpjxTWTD6DxlYs
        Bz4F/sw0SNimll1en6FEVVU=
X-Google-Smtp-Source: ABdhPJzrmsxMYLLRKM+pCC+tNbUyIbddF/llb1BgF89xo2TU++Xf8VCyIXJFgdHYoz16BqflKtnbMA==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr13859141wrz.74.1615553074983;
        Fri, 12 Mar 2021 04:44:34 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id 36sm8213414wrh.94.2021.03.12.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:44:33 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] devicetree: nvmem: nvmem: drop $nodename restriction
Date:   Fri, 12 Mar 2021 07:28:20 +0100
Message-Id: <20210312062830.20548-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210312062830.20548-1-ansuelsmth@gmail.com>
References: <20210312062830.20548-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop $nodename restriction as now mtd partition can also be used as
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 7481a9e48f19..b8dc3d2b6e92 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -20,9 +20,6 @@ description: |
   storage device.
 
 properties:
-  $nodename:
-    pattern: "^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$"
-
   "#address-cells":
     const: 1
 
-- 
2.30.0

