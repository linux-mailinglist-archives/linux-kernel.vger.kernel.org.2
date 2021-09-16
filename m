Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624D340E5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbhIPROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:14:16 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59192
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345308AbhIPRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:06:34 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B2C21402CD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811912;
        bh=rJLndy7vYT8KK3DyfsRiA9NiE5njla3gXvJ0MjK8FFQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tG2PQYJkUgtH7lLcqGQ1nZYjMXWyXNLqCxEWaPhwSIS2Re64Vu52ESkRq4IsRW9pw
         5RxBcYMNr/IXxg7a5NhRVVP9UkgCkFvQxvgho/6YgMFWUPBsSYyFTb9cj3o8MqSbJ1
         ZO/3AZVA27Hf5RulesOEBaPnnB46JKVLBIsBkAZgPwWYgNI6mHGFbSvRcaYjHhEmce
         cUKrJQerVPM9hWKVfIOJXas6u7TtlE5joENIreNuNtKPJP5pk4wht5n1nsmECnX15v
         4HZmuU9cWx28fjpccRNKsjoBIcLqAmHhlcajm9uPbtAZolIpD30FqNW3vi1kYu6z/V
         L9rwm1ysFERXw==
Received: by mail-wm1-f69.google.com with SMTP id b139-20020a1c8091000000b002fb33c467c8so3391442wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJLndy7vYT8KK3DyfsRiA9NiE5njla3gXvJ0MjK8FFQ=;
        b=u/IgUVfuEdCVQWK6zF1+yzHsfIl00B3RoZ7QR7lVIxmnBP8P29nsYfO5fYsGWZbtxP
         hVqoSlwqDGVsDjmuF++WhT27BOUTbum0oKRYE0kL0FJuWObfGithOmNlicJGpJC8a2uq
         YrRYXQpfMNj0UIOEzwzZMPfu0wTWNin0htKOls9UsOyZPB5Nf3fn66L8Syz4fB2N4Cpp
         PinIIUHV1BxMsSYFem9ZrzDV7VFDXo7+KuaJCCbyqM55THr2fgkFZfBYcEYTGMqYlTnr
         XnHUSWcVQ+SScX58P1TnugwjG8s9P4AYdBArs956Y5fJzCQOtGbcaDTAOEhvDMeB6yXP
         4JDg==
X-Gm-Message-State: AOAM532hD075kMYwe9ILw+9Zj3/T5JNO8UQEtjpMqgAd01FOq9hwKmh4
        8XaZMG8OFxgz6MvXeQa0MpW4ndPOipc3WU+IBx3uoAghi/te6h/xDD8XVms4kCALoHym52GMO7D
        2yEzbu+K5dN41DyhsZGfJag3ikNH7KQPVhOD2QHRYZw==
X-Received: by 2002:adf:c550:: with SMTP id s16mr7421778wrf.25.1631811910950;
        Thu, 16 Sep 2021 10:05:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFYtHcY/pCrEnne5d5sj3Tc+0m4I8Dcf1ztUXT2sEDAI/adJeu3Bu9HXH0roVlg18oA0IcyA==
X-Received: by 2002:adf:c550:: with SMTP id s16mr7421732wrf.25.1631811910658;
        Thu, 16 Sep 2021 10:05:10 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c15sm4139190wrc.83.2021.09.16.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH] net: microchip: encx24j600: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:08 +0200
Message-Id: <20210916170508.137820-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for spi driver.
Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/ethernet/microchip/encx24j600.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index ee921a99e439..c548e6372352 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -1122,4 +1122,3 @@ module_spi_driver(encx24j600_spi_net_driver);
 MODULE_DESCRIPTION(DRV_NAME " ethernet driver");
 MODULE_AUTHOR("Jon Ringle <jringle@gridpoint.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:" DRV_NAME);
-- 
2.30.2

