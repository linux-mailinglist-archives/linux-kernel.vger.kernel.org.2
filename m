Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA943D4A44
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhGXVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:09:11 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43918
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGXVJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:08 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 51F003F34A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163379;
        bh=lqncaONSiNw90ZsWSl9AH9IIEf03wH8Ti3Z9kPsi5zE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uXPUW+XCi1UT/z45GbDNv8Xjzy1YwtDn3mzN6Xs4NtV5XGtIZ09VyFewhPQKBoW9k
         jAJ3uF/qef8ibmUFvmzNGpxlUt/VFYMXD+QttIiAev+eUmmRA1TAteSvrZD026VrxG
         B8hCTmDCfaPk9yZ3jLPag/ifNu2b6JDn4ZeCSEe96kRl9+A7Xf9g//tWw4LfIJSwRd
         AtPsE3KtaPtEPP0BwjclOplSm9pX1mkK5WnoyW5Wb/jMoP5eDzrBPZbYrd6UdU+RwY
         EhwiMv6cdDjJ5HTGlPlcxcIJ8YwW7sqB7TCREtr7FWggVlg8bPAp+UN0X675gy1Oy5
         NCfEGsj9P4Fkw==
Received: by mail-ed1-f69.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso2764896edf.23
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqncaONSiNw90ZsWSl9AH9IIEf03wH8Ti3Z9kPsi5zE=;
        b=hKZOYMX6j/Lk5BYpa3larv0n0MDCRXW8YcEUZJIZpdUZ43XaDzKMYMGz7w3zmlGuao
         DmvE1f+ZLC/YG7c5G89ASJ2fUjQ9OqvJ/5+SpMnhqPF7cMLPu7uXMwnhRFGphzh9khaC
         stsassC7J47JxcCjnudgmJH8SeEa7tgW/lNa8QiTLNoVbXmcFNvnED0prccHrhmaCIZ/
         iWJwN5Qr4jltnwdY/q2R6KtTMYCX5VnVVSt9nVhkZt63QoLPS+ds9D8gyLeMoKCsVfUW
         O5RLvqHFJacA0f1sJR2wFHTc2+gozVPwrqDXcQwb5oS0EbW6VCdmvaVbL7o4IYtHc7HU
         9/9g==
X-Gm-Message-State: AOAM532H9WaaXFWRaF+RIumCWnlFrvWXLahGvYWQFaUOmaSBeK+1dEfT
        Actkh8vnIZVZ1/k/QjtuBRQ3SPi4sjglB8kQalJPE/ULhyuoH4+wQVFpoW/FRHVIVnA12+PI2Jz
        S+udy/ueHPoWbo11KEFI6UUBrkidQhIflz0GiHBtjkw==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr12994093edj.168.1627163378140;
        Sat, 24 Jul 2021 14:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs2MCWxVY/iIgBmUT84/VHcn/wv31k1R7oXnENH/7sKHYpMW13rHzV1X6lKvVGgvVFlM+aqQ==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr12994078edj.168.1627163378020;
        Sat, 24 Jul 2021 14:49:38 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 06/12] nfc: st21nfca: constify file-scope arrays
Date:   Sat, 24 Jul 2021 23:49:22 +0200
Message-Id: <20210724214928.122096-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver only reads len_seq and wait_tab variables.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 9dc9693a7356..1b44a37a71aa 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -76,8 +76,8 @@ struct st21nfca_i2c_phy {
 	struct mutex phy_lock;
 };
 
-static u8 len_seq[] = { 16, 24, 12, 29 };
-static u16 wait_tab[] = { 2, 3, 5, 15, 20, 40};
+static const u8 len_seq[] = { 16, 24, 12, 29 };
+static const u16 wait_tab[] = { 2, 3, 5, 15, 20, 40};
 
 #define I2C_DUMP_SKB(info, skb)					\
 do {								\
-- 
2.27.0

