Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F239746E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhFANhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:37:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFANht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:37:49 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo4Yx-0005K5-Nt
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 13:36:07 +0000
Received: by mail-ed1-f70.google.com with SMTP id c15-20020a05640227cfb029038d710bf29cso7790813ede.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdrwxPjOVbLLEQao+8w5TJgGCv7vD4c/43FIdShoDJs=;
        b=WaY4uIwLMPXIhPwALjhqnShWWJzwmjYQqQSaXW6U257Z/+g2IvuTUJm2O17qBVtin9
         jlQAR+3T49YKt4gMJ1AnRHWWgAeX/DZScFSakM2tCnhYhUjMLym73XDoTuwfdOkzBsvF
         VpQrkOMNzWUNyOs/lzEt18/y8el48x0gzx8DW6UUQUFLqb/lyrtyEy5efGdE6KRPplN7
         UMMKJpgup7zK2lCSoL6StBo7MdouXpKl7+M0bx62bcxBdEY1jcx3PhY7LpCW/xe86HRG
         Suru9f0b5YQCHQwHkpMKpYVrT51QjlC+gacvymcrEOlE83cqH/7hifTIb5fnPrDSHDo+
         R0zw==
X-Gm-Message-State: AOAM533y+WLE06GBuaSLmLYnCbJBlNGe6HGau2U/JuN7hww8qvSlRG2K
        IbxYDCD1M6eq6D7tiv8EfjXPeWoPiyRnTh4kW4hg05u6GzU/8yWiHN6H6K/IfMi4+KzY1PJzSIg
        DqzksTSFYOhJtkgvyhucA26A6baqVKjhm25BVIoSbFQ==
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr32131910edc.368.1622554567522;
        Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWLv5THL6TSFbxkXvKLAIgNMaFXdmlMfxUSudPIpijlMGKPlOSS/zojznQMGRH1X2l7WAbCw==
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr32131894edc.368.1622554567412;
        Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id p5sm7210941ejm.115.2021.06.01.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:36:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] MAINTAINERS: power: supply: cover also header files
Date:   Tue,  1 Jun 2021 15:36:00 +0200
Message-Id: <20210601133600.285452-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
References: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one header (smartreflex.h) in include/linux/power/ is not related
to battery or charger drivers.  All others should be covered by power
supply maintainers entry so patches to them will reach respective people
and lists.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 365f873d0077..2f9961310c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14744,6 +14744,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	drivers/power/supply/
+F:	include/linux/power/
 F:	include/linux/power_supply.h
 
 POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
-- 
2.27.0

