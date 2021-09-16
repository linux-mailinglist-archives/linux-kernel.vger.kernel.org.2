Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5140E5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351263AbhIPRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59420
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245204AbhIPRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:38 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05D95402D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811926;
        bh=2in4Ee9Den/iF6lPr3kqJcbqH/e6c33reOi3jUtDPLA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=HOcAh4Cgom7rfOMZtEiGNnjael8PxwW8zfX2tBRb4ad4BSpcfXJsV2uZ0co3j5VnP
         Xk2QCG1s6F5yXI9Wc4h0g5AgXdZHRPP9b0RoOMT7T+6jKvQsDL22jztYRQeR0j4fte
         LDeOfRMLOQFY9UngWgR+wsmhPOP5/FdtjJinJG/ueK0R41CTTqwXx41f2/TUm6faU1
         EXZ8r4BczwQ1H/p5gWkTf3E3IXoy/AxsM8fCMwGMj9qUcyXXB6pkaUUSrF2SYqHWnS
         i1sYjcKetnXfWaRuUwlKv//WZSN98vEt06bOpIWCeAtycs+SkLLKWP+5vbHvl3Hh3m
         pL3wPVQ0wHyYw==
Received: by mail-wr1-f71.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso1377439wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2in4Ee9Den/iF6lPr3kqJcbqH/e6c33reOi3jUtDPLA=;
        b=rQnNc0TxyWRBOtCKRAQecPU6wdcGIv9HHLNDq3Jb0zpN6ACYDn0KMGn+AyeYAY+gqa
         rXK0WjWCbakEqfaJfx75Zj2cZ7UtIzGIQOldlzM27swiBVVGWZPvJg+rV/16CUsqqb8n
         0e0zNc16+WvG/QntEq2obYlLLUbsEmf30Rj3TZ5CpOqrHN5ZWePhOd4ixQ5ZOHv9Thvn
         KKbZyc3sOFXO7epoFf6klwrGsjvMTWeWfs5An+76dJsmIHIMUJnERSUhmiSGpRu86JYO
         RP/fNLUMHYXVSRRKjE55Ebdk3E9CnM1bPks3FDdGDWlg/wvIgKrR9Dye9wS4G38UxDTt
         niOA==
X-Gm-Message-State: AOAM531xRPtqRKvNq0pEAXHJGRAZRiWUDJOTZibPED8pHP3gqUJvBzAv
        ctR9JXAm/Xg//u2cxLbyq62LUuMRkWtt6Is4CYmJVJE8E5pIBi6p/gdHbfAyYUpReExbu4elejj
        4VjvP+cP4aAkdwJqYmP7mSHaE5BrWk+XsaVbR/ilEBg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr7232425wrm.198.1631811925488;
        Thu, 16 Sep 2021 10:05:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweEXTvdgMrZFo+fiFdqAWkUZFpEa72JKe/21s+Rqw0H5pXNd34exqlivJU2zCzk9x4QzLSQg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr7232394wrm.198.1631811925284;
        Thu, 16 Sep 2021 10:05:25 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id f3sm3807850wmj.28.2021.09.16.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: marvell/cesa: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:22 +0200
Message-Id: <20210916170523.138155-1-krzysztof.kozlowski@canonical.com>
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
 drivers/crypto/marvell/cesa/cesa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index f14aac532f53..5cd332880653 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -615,7 +615,6 @@ static struct platform_driver marvell_cesa = {
 };
 module_platform_driver(marvell_cesa);
 
-MODULE_ALIAS("platform:mv_crypto");
 MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
 MODULE_AUTHOR("Arnaud Ebalard <arno@natisbad.org>");
 MODULE_DESCRIPTION("Support for Marvell's cryptographic engine");
-- 
2.30.2

