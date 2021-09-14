Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677A40B71B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhINSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhINSn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:43:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D17C061574;
        Tue, 14 Sep 2021 11:42:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so249826wms.4;
        Tue, 14 Sep 2021 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyJobn76MJiXHkPQp9MLWLMLF6o7dTUGkJBoxNkALkM=;
        b=Kts+kWt8sMohhqvdQt3uH2CVwp1uYiuSo+4Q0UbSQKA4bWzOTo8+gkqIBoaIxdBDZ4
         6g6uJzelPRzCwGV/6iEV+Iykq4MbAdTQr5DmBzdZlolHU8FcM2AwtZB9PMHc6cM6Uudx
         vLGAVRB+LEx6E/lH4YLNSwP9NFeLOh/xNTXEIYq57OBL8feCRXnImG6nAUCHTB6zG00g
         fB7wrPCCAn424owDDCGPnpsd4gbnqorPRR5YwQI0ZtYmhIah8fmEhQGXF3xayJ+PwkO4
         eKD6kC3fzVOiM9eD+ynIkvB4JSSUEM0VlQkdYBASf66JVkSLZhrOOdWV9tmuWemOBMcQ
         KHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyJobn76MJiXHkPQp9MLWLMLF6o7dTUGkJBoxNkALkM=;
        b=3KHNvJiHl8GzSL5kF872swu3t2+oNO0Og8F3bjIqjPyflb1t7Fc1ABCO3EaPoQ13RV
         OrBlMBkjB6c3fOFS0FI+LN5oVzZ+RBhQ+rLWDH1MFoNylSjVpHISKMarVWrNecBEI4XX
         /clQaj2+yKkMmbhT3fNheioKcwbzp/cI2LAiqJ4yh0JjqxbYGKQem+/OxpbJVjJhdPB8
         VJi7FITo304KNy/JI+QVLzAzSTWqviBSuzLmIkeSm3PY6VSOSc5lgRnpNG4T4rZrqwsT
         2QT6MjbiBmdq2M/A1dSKsvp6QSBUsluQpyzFBVrIDeAxlNs2e2/ENSBr8Q8TwlivdNkX
         RpQg==
X-Gm-Message-State: AOAM532eL8tlgoTivqCseI+SwcXrbJfmsk4F/HIgn96AJdGRmwyfQ+5c
        NtcR7qmUHjei2oqsXt8jon27VxSBQ2c=
X-Google-Smtp-Source: ABdhPJy6mN2vjzQdkKdWzD8chfGsauJJi82R8tcWK1tawsu6+1u83PPV3ZABhEOnik8+F4ZydtWNtA==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr472726wmh.165.1631644929595;
        Tue, 14 Sep 2021 11:42:09 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id y6sm3661042wrp.46.2021.09.14.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:42:09 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: add vendor prefix for Wireless Tag
Date:   Tue, 14 Sep 2021 20:41:40 +0200
Message-Id: <20210914184141.32700-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914184141.32700-1-romain.perier@gmail.com>
References: <20210914184141.32700-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix for wireless tag boards and SOMs.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..de18b6fdbf56 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1296,6 +1296,8 @@ patternProperties:
     description: Winbond Electronics corp.
   "^winstar,.*":
     description: Winstar Display Corp.
+  "^wirelesstag,.*":
+    description: Wireless Tag (qiming yunduan)
   "^wits,.*":
     description: Shenzhen Merrii Technology Co., Ltd. (WITS)
   "^wlf,.*":
-- 
2.33.0

