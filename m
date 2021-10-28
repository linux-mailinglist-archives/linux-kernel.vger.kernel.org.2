Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5492143E872
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJ1SiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhJ1Sh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:37:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00FC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id n7so12292128ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0h9MI5+nWpL7nv3kn46aEjYMVGjl4934m5PO+DJKiLI=;
        b=MKEq0geXa1eT2tQFBS/WYl3gwCPfOmg2L0DmJjAS75wUxFQaLny2BqlgQqgc67JX8T
         1eU7Wo7elUOYI5w08gD3ujyLzYlT74MOXokrkpIJa3HLZiW8cVqXWM5wNjU2lfLhkLoI
         TIKI3YVP4DAws7hoQGvLzFOJqLhnG+mGZKyrMxjOt2lddr1jFBEIhgnXREPdMIDT+T31
         verhiIhT6LNatzJB3wZGR/qostXudLyIli6eDJiV0Fx6Q8yxhqKjjeDGQRt0C8169sdQ
         UbzsDpDwLlZt2GoI3GEuLPz4Tb+qDIrJsNkcK6Q0LHC8HEjEzaAXwPJrcC9w34NYfJhK
         2U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0h9MI5+nWpL7nv3kn46aEjYMVGjl4934m5PO+DJKiLI=;
        b=7UTfBuV3HbeF5T2JFxBNTFNBiZ7bSgFoIfHULt2ZuFjk0uzMN2QyrATpzpLJqTTpUv
         rjH/df5/kYaw0SZ3kJWQvtaZIatJXU7iD07GU7eiOOAlMOYFQ1XJ7SM34SnVqKS1TfZb
         QMFA2SbXV0kApxA2jCj7IilZRhJapnZLODXqrvkOUgo8YEUXvXXwU7CYSGanzk4dM+FX
         o2zfL4MqwsHQYLoA38f4Q+rhrAUhebp8VMCW6lmSi6/ta8QapEjrFdWeXvfO/ctQsAY3
         0ITYiB+MIMl9MGIUA8755N1YHZ9D6GuJtuNEW8KDk5kxp6d1jnKxMRNU7ywBQVuJZ3rZ
         Z5yg==
X-Gm-Message-State: AOAM5318MynUIKqYknCNkVeM8CcojI7cOBH55dXFUSdWHbqTD1YEyrTs
        AiW9vnWNGJri18tO8vdT+6OY0w==
X-Google-Smtp-Source: ABdhPJwxy/T1TXHAOSTfUZChLQnwHDSBgFoC2mGqdGsqWUdVRmYvf9KqsTRArBLOPGpZRJYiCdK+lQ==
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr6597055ljn.497.1635446130085;
        Thu, 28 Oct 2021 11:35:30 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id r127sm389488lff.62.2021.10.28.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: watchdog: Require samsung,syscon-phandle for Exynos7
Date:   Thu, 28 Oct 2021 21:35:21 +0300
Message-Id: <20211028183527.3050-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028183527.3050-1-semen.protsenko@linaro.org>
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos7 watchdog driver is clearly indicating that its dts node must
define syscon phandle property. That was probably forgotten, so add it.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 76cb9586ee00..93cd77a6e92c 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -39,8 +39,8 @@ properties:
   samsung,syscon-phandle:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      Phandle to the PMU system controller node (in case of Exynos5250
-      and Exynos5420).
+      Phandle to the PMU system controller node (in case of Exynos5250,
+      Exynos5420 and Exynos7).
 
 required:
   - compatible
@@ -58,6 +58,7 @@ allOf:
             enum:
               - samsung,exynos5250-wdt
               - samsung,exynos5420-wdt
+              - samsung,exynos7-wdt
     then:
       required:
         - samsung,syscon-phandle
-- 
2.30.2

