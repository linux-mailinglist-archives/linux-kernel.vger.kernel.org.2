Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B63F774D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhHYO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60334
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241571AbhHYO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64E1A4076C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901543;
        bh=xADZ5MR3j2UoJgl2B5VMNlWhMMlwmkQewYypsYcTAYw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TLejc506X+y5tBxBhOGMInvJZjganvJAIVesk9T8Em65Rq3yrBVWJ76uHoak+mc1Q
         Z+UwNB7Vlag/hrRqADVfKbTSoow4S6rpfc0f9fkLoVbrk02OaQ8bX23oBgsfkNQM1H
         6TNN9PvWp/PJi1OBDxOogW5k64Q58thVFmjW9W0zOZh9eVH/Mav//XICBzJLUIVgle
         0crA4/1a93gKn+VTi1rh6C+fQfnukUNwiSSnM8VQYw7mNqE1OojkNHVl0sRQhF0P0u
         N8bwGHRba4ir9FNUB1FktrC8sIBcp07jm15otkYUKrB82CfpraPXS+M4gkoAxE6qnV
         27p6pTTsPFCdw==
Received: by mail-wr1-f69.google.com with SMTP id b7-20020a5d4d87000000b001575d1053d2so1855220wru.23
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xADZ5MR3j2UoJgl2B5VMNlWhMMlwmkQewYypsYcTAYw=;
        b=sfqKOlHfnPmlS/lcYZVhtbvzPgDU9+78e9IoFvwfPhQrsyKvoI0eTy6MJCiR+9mcDJ
         DbhST1EV/LULuOoUJB+PvYOMGJSrcF3tL8eu7nnKLNWEh0roGw2gp1DhdalyF6zdcdmL
         Q/fsXcBK5D+bEZ0yiDAKzBx2ckezVDFsEhhxEdgXEcd2+xG7gJLXmDtFRqbwI11m21Ei
         fQpo0TA+viz4EyX+w7/6pVFPTt+Mv0CIsnbKUs/00Sb4bwesJrm36xa555eUPMW1XTVH
         ULfCi49YIoJFEvKzVYNKcY6XfCfcOqrKVyhDYiZIrWGiKEDY3ZsPNNG6GaER7DgUjvQC
         Tpbg==
X-Gm-Message-State: AOAM533f7L0CvEZ46cbwPlHnhsOAadmfFOkpACs5YB6AU2mvC5MLrJbE
        SI+3ptrLFwY6NAJm6xlBfx3yNy0X/KEcSR680NVrCF31Jlz2xfIgeQF70P9sAbUJzQdvw0zkQ7V
        5dMPsyQxddA9xTGrIhqx66yt0adAOW1qBRmB+PT6cWg==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr25607295wrm.64.1629901542943;
        Wed, 25 Aug 2021 07:25:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxug4tswqoivqT7ijzKJIPir03HLyMSYUse/bfkgOkUwy2/0691p92fR8CeB10092meUcEfnw==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr25607278wrm.64.1629901542827;
        Wed, 25 Aug 2021 07:25:42 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nfc: mrvl: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:55 +0200
Message-Id: <20210825142459.226168-2-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/nfcmrvl/i2c.c | 3 ---
 drivers/nfc/nfcmrvl/spi.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index c38b228006fd..ceef81d93ac9 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -8,12 +8,9 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/pm_runtime.h>
 #include <linux/nfc.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
 #include "nfcmrvl.h"
diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index b182ab2e03c0..5b833a9a83f8 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -7,11 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/pm_runtime.h>
 #include <linux/nfc.h>
-#include <linux/gpio.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
 #include <linux/spi/spi.h>
-- 
2.30.2

