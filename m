Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D633DE35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbhCPTwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:52:38 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:43179 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhCPTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:51:14 -0400
Received: by mail-io1-f44.google.com with SMTP id f20so38489695ioo.10;
        Tue, 16 Mar 2021 12:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMNAus66Cv3MGTkhcoT8NihfQA1eHKsYqqZ0WAFNt8w=;
        b=hvA50IJOKH0iabcmYiOoiyqDE+dS7luhtCsZYqCS8mc1LVjx6Spz9WdI79WCvHbXgG
         vq1Qrzhj5FJAKobb9/6/S8Q4JWzr4oxKocaYCRkNeT25UBEWKwHu7ZDH9u8GN5hIckye
         RNLs3H/ao3PJcFO+2XFk1u3iSBFpO3LedEG3BplfKQ/OTK15ztIKQK3NszeSBaUStMPx
         zHd0AK19PimT3IhYuorpnuphTOcm2Khk6ed6ZRHh4OSR++tA5FTF78Zn8Ut6ZztMJkJj
         Rgbznuz9GSpxmjJGUFOCClWqXrENX0gTAUpbLBLxfLwwV+CCBv/5595Jzkv9p7lCkgf1
         re1w==
X-Gm-Message-State: AOAM531zHwYYrtCc6yxaXD3XUGKNfJsVH1O1DKRt7EaIh0jThOBHc6vR
        59k7mKFiTgmlULOSQEbcky4XzjdTKA==
X-Google-Smtp-Source: ABdhPJwWIKKePm09BC8hGBvHNFQ8bS8C38OMqAuItlgQKZAkP0UgDWmNquAO2QyO1Q2gDcxKMBrgAg==
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr4627602iok.208.1615924273929;
        Tue, 16 Mar 2021 12:51:13 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id w9sm9334951iox.20.2021.03.16.12.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:51:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: nvmem: use base meta-schema for consumer schema
Date:   Tue, 16 Mar 2021 13:51:11 -0600
Message-Id: <20210316195111.3531755-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common consumer schemas need to use the base.yaml meta-schema because
they need to define different constraints (e.g. the type) from what
users of the common schema need to define (e.g. how many entries).

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
index 828e4a1ece41..b1da238c8bcb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
@@ -2,7 +2,7 @@
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
 
 title: NVMEM (Non Volatile Memory) Consumer Device Tree Bindings
 
-- 
2.27.0

