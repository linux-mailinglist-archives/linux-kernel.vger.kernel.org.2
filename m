Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D7237C07F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhELOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:44:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60074 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhELOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:44:45 -0400
Received: from mail-vk1-f197.google.com ([209.85.221.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgq5I-00057i-Ad
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 14:43:36 +0000
Received: by mail-vk1-f197.google.com with SMTP id k186-20020a1fa1c30000b02901deb88f03ecso3108858vke.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHEFEHQf81OxnlkSXxvYbUIWj0W6Yj6Lp4ml2UG7+00=;
        b=XIkwJ4iVNt+CHq0dBEbmHQWKrKI4esC4NaX4kAWVgsmDjALOYO7h93E0OOC1GWWG3I
         OlShdPtFm0o2VKp4UtOlS1h6qimY0Jjp6yWEmnYOC/9yfH+T9IPDGhZGygFEUXx6dlMs
         X88bRdqw07hfTpcWU0WMLjpFP3KteZNAS5TXoDMqN63d7F0tJLeM6WGWKUYvBewr/J7m
         40rAe+vV9LovCCH3Meli1URE212GmxSfJKI0bix/aFYEDZj9WC62KcV9yMH4U/TK7gzJ
         ryNPAXUF1hlCDaH6Hx5Dr3yz08UqK3523aEgaE2Nfr4Exc4K9jMQH+X2NudB1n0R82wS
         28XA==
X-Gm-Message-State: AOAM530gfpshxnNUo0C99tcbqXCINGs1NBhNHVzgCPIWrE9OJx7qV66B
        nb+ofKYWHOCinyNxaQln8p5K/RFezxxbOPPTrDRWw29a7WNiJ2cg9hxssl4w5MYtJYoB7LtFmTt
        7MiUjn8vLuEZ74+kzQm6XSwr6MMTP91GfG7PVJ6My9g==
X-Received: by 2002:ab0:278e:: with SMTP id t14mr29084974uap.25.1620830615490;
        Wed, 12 May 2021 07:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw02cwj0oM9HIUpM6IquUx2L8g6c9yDPzMDV6dCDUYq+xnie/xTTLmMlBr0NRCMxpHHUjFIXA==
X-Received: by 2002:ab0:278e:: with SMTP id t14mr29084941uap.25.1620830615269;
        Wed, 12 May 2021 07:43:35 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id a5sm1641vkl.19.2021.05.12.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:43:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nfc@lists.01.org
Subject: [PATCH 1/2] MAINTAINERS: nfc: add Krzysztof Kozlowski as maintainer
Date:   Wed, 12 May 2021 10:43:18 -0400
Message-Id: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NFC subsystem is orphaned.  I am happy to spend some cycles to
review the patches, send pull requests and in general keep the NFC
subsystem running.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

I admit I don't have big experience in NFC part but this will be nice
opportunity to learn something new.  I am already maintainer of few
other parts: memory controller drivers, Samsung ARM/ARM64 SoC and some
drviers.  I have a kernel.org account and my GPG key is:
https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/1B93437D3B41629B.asc

Best regards,
Krzysztof
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc81667e8bab..adc6cbe29f78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12899,8 +12899,9 @@ F:	include/uapi/linux/nexthop.h
 F:	net/ipv4/nexthop.c
 
 NFC SUBSYSTEM
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	netdev@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/nfc/
 F:	drivers/nfc/
 F:	include/linux/platform_data/nfcmrvl.h
-- 
2.25.1

