Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4E4123D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352442AbhITS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:27:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50958
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377636AbhITSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:20:47 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 89CF1402D0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632161959;
        bh=8LE4EIzxd0T+JDVOM82ADVNZZun+tXpi3OMlHIizBP0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eVoqcBF1GD5kyq/Wcy7EmPth0z9XE2VzkSppp4il5GtLtdIxm3fIoXR7dDIVho+Zq
         dYpKwhFX2/pYM0YwdNWvt4Cj2IIfxI+gPJtUoxmyTyNGu0Ifw4hE2kZxTOBzCkJpmC
         DKiUgZDvl1EyTIfnVwffCtb98ej78Diue76vgndFekPYYdYp3+hY7J2/AgWmc0Gsag
         AHDDalBT7NwOb0Fqiswd7IdqXT+3m5b0r4Mz53FU2N+bkDly8bE+qxYbqgs9Vvq3qB
         jVUwqr5w8uibKoYfMV1ovPfpvLADfa337G/oEmroLhLrJojSRyK7SFrhRKKqDSAEz6
         X9nw+TFY6Bxuw==
Received: by mail-wr1-f72.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so6791734wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LE4EIzxd0T+JDVOM82ADVNZZun+tXpi3OMlHIizBP0=;
        b=F/IFxYv1NVLYxy2CeIhJZrBZUsWQacZJ++5aUCQy18ZO6LIWIevSXiu7X3low7v9nq
         JwPqdAzjb/1OU8IxQSy5EOiw/aALB+TudjkIwUDlu2Aeg1sZuNHUkJ4E4U5V+cu63esD
         QUXcveHAiLVQEbGNo8mJhFGtOoN3JF0/xRX5TUJYravVpQl61S88u1hvv9fc1CWnWwJJ
         houRW0n3HfzQgi56kj4rtmHVILPngnYWilJkXro4ORvFYSbFIKWAENqTEaUoNI4EAZ91
         4YbbqaFBR4P8rXP7cYSY9NQwrbioPuw+RzpVSjeGM9GUahBBGNEx3PwX12sOqR5wF8t1
         9Z4w==
X-Gm-Message-State: AOAM532tfuZdjxIKjF6xSzIRbDGw+Cxvcn0I3tMa9X30rgK1th6iXTGK
        EaAF5m4YKeye1ork8rkd7X2qVWVoyhCrVtdyKTtFPImrGW5lgTiP5GLo6OkFa5nNXidM+v6Uvv0
        0TY5WPJxYyv+OCEEexcYvef+cgOuGKokGZgH1bqZXFQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr29646442wrs.316.1632161958896;
        Mon, 20 Sep 2021 11:19:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNJJwddFB3b21EgLGMrF3yJtWKG5vCNW9/ixrWYfXCGuslD2w3YlxVBQxVqbRl07dIFSGBNA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr29646431wrs.316.1632161958775;
        Mon, 20 Sep 2021 11:19:18 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i27sm253134wmb.40.2021.09.20.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:19:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 2/2] dt-bindings: hwmon: lm90: do not require VCC supply
Date:   Mon, 20 Sep 2021 20:19:13 +0200
Message-Id: <20210920181913.338772-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
References: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM90-like sensors usually need VCC supply, however this can be
hard-wired to the board main supply (like in SiFive HiFive Unmatched
RISC-V board).  Original bindings made VCC supply as required but in
practice several other boards skipped it.  Make it optional.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 Documentation/devicetree/bindings/hwmon/national,lm90.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
index e712117da3df..6e1d54ff5d5b 100644
--- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
+++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
@@ -55,7 +55,6 @@ properties:
 required:
   - compatible
   - reg
-  - vcc-supply
 
 additionalProperties: false
 
-- 
2.30.2

