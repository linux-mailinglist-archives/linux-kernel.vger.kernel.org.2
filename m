Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81A140E5C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351191AbhIPRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:13 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54306
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245060AbhIPRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCBAD4028E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811928;
        bh=WXKe5m1WFK2T2xtC6IGo+bzCWD4dX+Fxzr37C4Jwfqk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XDV96Uo6A3d1xsslfwEKMXrSEyevng8Sh5kjQQM60necY2IaDDD1xLS24zHKzvM/w
         BtDOGqctWGotqfn6ndbih8Q/JqOcLsVTcseTtb51z20UkkAazSJ+QTtN9T9+tdZXQW
         Z4Udy++5Ns1LrgYTVVco8ExuOiQ1/GtODvkfvtRZhACeKLGfSzE3v0E5ujChndm0Ve
         BRWoJ1aQvSUbi/uZWNQlim/o0RaGsuS6yJhJEYM+W7hiaI8YCLKr/2Azy0qLwNshlz
         hdD6XxzpbBCL66o9Y1rN0yDoblK+qLlXpc9llYIms03GCv/jSVjmnZQet7TIwQhkrY
         8XUdNAXp2XOBg==
Received: by mail-wr1-f69.google.com with SMTP id j1-20020adff541000000b001593715d384so2686505wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXKe5m1WFK2T2xtC6IGo+bzCWD4dX+Fxzr37C4Jwfqk=;
        b=yiW8JrHYSj93Ld24uMsHm76CAG3iO9Ec51Trr/dJ1VD3N/rvB21k8+GuwEqDDSJ0Ff
         ES+N28lZZwdDxbxEbCkoz2VhRXk7mrIXcKsLu9zMFN6gpyZuI92pJniSu/f8enzfExeI
         qe3L0lwOLJU6PK8WfEICfgLhLJt6mog2UvPrSGpwyiv34SgqMZCD1t15EUrHoRKh0D8W
         X+8jYE3NkaJl0zNLGwnRrKIydhORvNYN8XtPMjPDYBQzl8h9PJ8eKEicvSCU9CsTh1cp
         GjLSpUqMJTAQpAqXGHS2EOIZewnisE4n/X/tzaSmE99/D4/BRSTSWJ6QjKm4J/coRx1c
         lD3A==
X-Gm-Message-State: AOAM530tO/KhsFCrGUXIhhNTtofrVK9VLDirTHjQmCyr9gF9Zt61YRAQ
        C34xtCqpoNj4TqZ00ywimvLIhfjtTe540puSE1VVJu7iOiU3dmLpImlLs/BIKJdeMvvaarNeg0y
        DUtYoPfN7XH2+jn7tt4p5zJR7gaV6E9WOaQMvIZUJHg==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr5224069wrp.343.1631811928050;
        Thu, 16 Sep 2021 10:05:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzbiXH7/wi3JUra7ET2cX0rxHHywWY9UGoVMmDagLPhxHP6EXY2072ZIdGH85KuTjhOrMlCQ==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr5224037wrp.343.1631811927837;
        Thu, 16 Sep 2021 10:05:27 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c15sm4139946wrc.83.2021.09.16.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: max77620: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:25 +0200
Message-Id: <20210916170525.138216-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pinctrl/pinctrl-max77620.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index c643ed43ebbf..004299cc3f7b 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -665,5 +665,4 @@ module_platform_driver(max77620_pinctrl_driver);
 MODULE_DESCRIPTION("MAX77620/MAX20024 pin control driver");
 MODULE_AUTHOR("Chaitanya Bandi<bandik@nvidia.com>");
 MODULE_AUTHOR("Laxman Dewangan<ldewangan@nvidia.com>");
-MODULE_ALIAS("platform:max77620-pinctrl");
 MODULE_LICENSE("GPL v2");
-- 
2.30.2

