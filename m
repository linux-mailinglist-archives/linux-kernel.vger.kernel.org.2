Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA633143F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33129 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCHRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:09:57 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJOG-0003Hm-NP
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:09:56 +0000
Received: by mail-wr1-f71.google.com with SMTP id y5so5106922wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukC0JfJdbz8UciMbMC02R4iISKuzu012voJzqN/ruB0=;
        b=fGxnSkSOFbue9x6Zxh5wiusqJhB3zMepqqdYkDnE95zEigNJM/BPS3YRIBRjsALAOM
         PHmAFN6hGx+98rwwT2waltgj3tC8KVHcSvIbnG2GzPAwcmBJ8f9bnl1LCpgFASAu5Sju
         ErRKenH0eQQyL25dINrxHMAFMc8KGIVBjR9dpcHbFAV3oK94ooe0jNE4NyQUNokAbHYw
         Q/9HohjoRR1SbTKirEkkYv+rQG3cY9nrW4q0SY37hB+kqdrcJu5DRpfbtMiteV8SED/M
         FXbaw6FswRyeXtF/OU0yUCVivfamTQogxWJ9UBv2TeZh79PT0jIN4Oh7otXzWlj28DHz
         QErQ==
X-Gm-Message-State: AOAM530FHD4fxzDtbmiQK/BpIqRsIv1jsmVfkgJjuMZTnPLXBNA0G9FN
        RjL57qNvR2oP+rcTg4jDtinepsN2FB/im6DvEeNihiBz6EcVyg27hLL660ImkE8IVbiC/QB896I
        TkGL/JqaKIikw9xTIHGmZpVH1qPg0GF5xSrHyC+jxRw==
X-Received: by 2002:a1c:9a48:: with SMTP id c69mr22783958wme.157.1615223396355;
        Mon, 08 Mar 2021 09:09:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg1tzEzl6V9B1Py+afG08QLfhRYQSYMhg4CheqNajHRwteoMi2lzjfEhuUWx8liPV8o2DNDw==
X-Received: by 2002:a1c:9a48:: with SMTP id c69mr22783934wme.157.1615223396161;
        Mon, 08 Mar 2021 09:09:56 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:09:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 01/10] dt-bindings: arm: intel,keembay: limit the dtschema to root node
Date:   Mon,  8 Mar 2021 18:09:36 +0100
Message-Id: <20210308170945.161468-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The check for the board compatible should be limited only to the root
node.  Any other nodes with such compatible are not part of this schema
and should not match.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 Documentation/devicetree/bindings/arm/intel,keembay.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,keembay.yaml b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
index 69cd30872928..107e686ab207 100644
--- a/Documentation/devicetree/bindings/arm/intel,keembay.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
@@ -11,6 +11,8 @@ maintainers:
   - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 
 properties:
+  $nodename:
+    const: '/'
   compatible:
     items:
       - enum:
-- 
2.25.1

