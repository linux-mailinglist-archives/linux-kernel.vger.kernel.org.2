Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC43F774B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbhHYO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:39 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60330
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241577AbhHYO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0FCCE40779
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901546;
        bh=lRHNkLEWcITIq9BTwsdkr00e4mkdm7zBYjY+jga9Eao=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=el/CTzzK7Uz91iMvCL7+O7MhF5oWG0+OyfiX/nASb5lJSHMNGdmeR9+s7HF0OxhXY
         OK92mKDg0de6rnDtAZ2CD0uS+cujsUNGUm/Ly+XfbCNqr3bMopRPqcXRBJKYekYZXe
         6H/9R2w9Xr9I6BNgYuV2JvlFAyd97z8n/RENUKEbVz2gBjEBAzkydIdgj+1g6hW6J8
         OfXMgjjCfQuZfBxxqL+VH3U/oo3GH5I+SWNWbB2xKNCfzH5jvq27g3POrifsjQeUkn
         Nwt7ZVu/dO3Ar6XauvMHr5A9yn3lAmGmhWkGkO54C/Ftnqvqj4TJ/8A3qEYOiWWYCZ
         lG2Dm0KsGi5YQ==
Received: by mail-wm1-f71.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso1594840wmx.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRHNkLEWcITIq9BTwsdkr00e4mkdm7zBYjY+jga9Eao=;
        b=OUQu4etSSzuFgsR85gphvouJm6OG0oZF2f9yJo5c/nOsycZwkyXAkhxBTEQAgqxHeL
         VvBSedgzkArkkU4+BEb8btAfZ3026EginjipRADguk5cEPo3p1CoXcqGu1AoOjsFTDij
         P44RrDHCJV/x2sGzloN0rzLS0/nqDSasHwtawJhQ2YPHjtH7n7PdYbk62F+o1cyi4Sji
         Eg7qq17BNTIwvsZrdkHpr4HaVjbRO/cdq1HlXF8f0LCHjLT6ni0Mc76WZCEC2M14PZRp
         OvvKm9ztFusVePYjGdGDfOjYM8u8avaT1cam1ePZHxWb5GuLrwqOn747BMkYGcDfJgAr
         q34w==
X-Gm-Message-State: AOAM531vKr+aM2umSA28K7Ng7NMQabw/ihDuOwKfpqLzdrvlFE7p+T7o
        HCAFzaOkXeCo2WbDUCHoIGOO/oskxG1YtWMefRYuG0Fdjx9zqZki2zWrKSNC/ygdpwzEu9yGfmI
        /unNtsBb7VEU7G08HiUTzrwTMRYnBn7xpbvhMv7ZUwA==
X-Received: by 2002:adf:c506:: with SMTP id q6mr2585027wrf.78.1629901545222;
        Wed, 25 Aug 2021 07:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9h6tV76fJDoGPVoO6pO3iRtwkAZF73BAzecjKNib/5DLYsyj/NjVU59vWpxchWluq9DoRhQ==
X-Received: by 2002:adf:c506:: with SMTP id q6mr2585022wrf.78.1629901545111;
        Wed, 25 Aug 2021 07:25:45 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nfc: st-nci: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:57 +0200
Message-Id: <20210825142459.226168-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
References: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include unnecessary headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st-nci/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index 72bb51efdf9c..a367136d4330 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -9,8 +9,6 @@
 #include <linux/nfc.h>
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
 
 #include "st-nci.h"
 
-- 
2.30.2

