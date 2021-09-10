Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1D4071A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhIJTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhIJTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:04:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA1C061760;
        Fri, 10 Sep 2021 12:03:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2165227wmb.2;
        Fri, 10 Sep 2021 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGYm0fS3PLkHIJJr2lxucQs1ZqvDikYcAAG+vIZ2nzM=;
        b=WAGSmaaF5taUZLYkumxO+QBdUAszUeWCrGZREDQ0bwsTTg3bNeoLFDAyewofnHKrhi
         Y4iyGQs7uosEZWdV2FCQ1dUwkrx3VE+SK6b6uGMSOEJvIScooOdrluTES/N8OJBcnCdp
         2PfgyQvrw4CeHwarl23eTam5kcPABDkCTy0Z0LSdj6pNmvGbuZpNoO3C7nCRFKI09Mf6
         Wa6uQnnmGazgihsgdUZuu2ktR4nxNWPrn4x4kaN/RWXM8utfts21dsDfFc1D4uOKQhip
         xa94S1ejdSGEh+ysMJSwO6Eo8n70PdQ6BB6hOHHWwqMzOy78WmnpxLAoADPrEzXPaEMR
         4EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGYm0fS3PLkHIJJr2lxucQs1ZqvDikYcAAG+vIZ2nzM=;
        b=A1T7o7gzD/izn/wMEoY1NdbExZ7Wk/IlQSg4+MyvEQ5YAcp36elNK3eZRHDwwHd2tm
         SlNYERhhJvXZdvbHR2/H8IDb/DP0aOD4Bd2QKqudyt1RyqeqvcdLo8cnDUNZJMOe5tJn
         LKLmf+RuW8bwKOQj9eCUaUWozZQgx5XEhRdasNwk0/iQLEFNodrJj488PBM/5FCxXbTT
         YknXs7RL74DPnLgBC/My3CygDjEmLJEX10g+RXOgP/I6MaCvAkXFnzdqNUZAUeEEm1cB
         k1OjVRSbFEGZtX35jKYQUKKZLbkCzvU/kFRIlbnc/rBcK4InpSc8axwQ1y1IIwDxNJpJ
         BkPw==
X-Gm-Message-State: AOAM530iFhzWPK8VAYbE9Bp483gJQY8iNm0Fdtb8zlXNkOs6MDsLp37D
        xqcEkdT73/PuTQUN3qFkv4sxI2yp4B0=
X-Google-Smtp-Source: ABdhPJz8wEhimQ2HLHy2Evfr6g3vWa1/iO0LQdxwW/4nAF4WvKdf2FrFoNcd2vyO+oEYqvzGtF1lFQ==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr9708351wmp.73.1631300626293;
        Fri, 10 Sep 2021 12:03:46 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id v28sm5487641wrv.93.2021.09.10.12.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:03:45 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: add vendor prefix for Wireless Tag
Date:   Fri, 10 Sep 2021 21:03:21 +0200
Message-Id: <20210910190322.27058-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910190322.27058-1-romain.perier@gmail.com>
References: <20210910190322.27058-1-romain.perier@gmail.com>
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
index a867f7102c35..b50d62dde7c5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -517,6 +517,8 @@ patternProperties:
     description: International Business Machines (IBM)
   "^icplus,.*":
     description: IC Plus Corp.
+  "^wirelesstag,.*":
+    description: Wireless Tag (qiming yunduan)
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
   "^ifi,.*":
-- 
2.33.0

