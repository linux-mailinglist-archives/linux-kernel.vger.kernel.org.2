Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C345F716
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhKZXLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhKZXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:09:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C95C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:06:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r25so44363657edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dZaITcZBt90z1oqsumsEwuslKh6nLTGZIBE5hBYKeg=;
        b=EzV6k65lbx7QcXkxyIKCcXDzVI7ORoNHi+4xgPC08pVwHsCOFP/rIzoQ6BCYfAqLv7
         s4Q5hpq+jhvBKYtldNczh8PeWDtJr7346xm8MMsVnB1sKMl4e97PQL+Z4EpDkCt62QIU
         YbaspfNgfDqRERxNS6JzBF2hs4VRWkYyh50MypdHtk6G8gEuD0kqwoYrJlOZqZwM1BxG
         oMOG1PsZkglohrcOcVpifju9osdmY2yM1jZcYaeRC358efOMgjWGyVKZXrUemQeadL3/
         sZCjD7oO2uHhr0K2mB1VaGQq7eyvbFvoOAzVGff6TTV4UnOIgINFDWNUkHNaVoodfcMp
         KTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dZaITcZBt90z1oqsumsEwuslKh6nLTGZIBE5hBYKeg=;
        b=nm39Md9Ty/3uPUWY3vW+ao1UaTa3tvhytx1sElqtZKONeoocyXrIVIr4mix4mysB/g
         B7afkssyccY9BX3yA3I0JK/jfWawLvCM2T85PBJ3IDJD89DWJO29qo9ULPddOUL98mmF
         658egItJWKjqPLOgqPok7utJC5i9UcW6Cr8t7hrsTyKwmadqUSBueZ+lxnO5OZW5e2On
         IihvRVx7gjzLFlA85h1x/WbNJF2rAzWx7tNrO/IViZcqNzCaIyWxtzyBAe0caAk213kf
         /yg2Ub4IYevUGK+EntuS2UeIy1QLzOtLK5DiOK73bjNmpET03VQnYrvZf0JeT8Mu7p4B
         jkCg==
X-Gm-Message-State: AOAM530s1oTBuNbJ0PHyuq25zIRmnvfjiwXHcIicHgzm/3DJ0FPVOc+I
        YbGIobAK7WcsBOG1TcAx4DMqyw==
X-Google-Smtp-Source: ABdhPJz4vlmWEyXRQtVC4Lj1sj+KYn4XcVXuDojzatks16AzF0kHPL72CAQHiH8jbtLLC3JWHD5pVw==
X-Received: by 2002:a17:906:730b:: with SMTP id di11mr42281246ejc.97.1637967981599;
        Fri, 26 Nov 2021 15:06:21 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id sd2sm4241198ejc.22.2021.11.26.15.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 15:06:21 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: syscon: Add samsung,exynos850-sysreg
Date:   Sat, 27 Nov 2021 01:06:20 +0200
Message-Id: <20211126230620.478-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Samsung Exynos850 compatible for system registers.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 5de16388a089..fdd96e378df0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -57,6 +57,7 @@ properties:
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
               - samsung,exynos5433-sysreg
+              - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
 
           - const: syscon
-- 
2.30.2

