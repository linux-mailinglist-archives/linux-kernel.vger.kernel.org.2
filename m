Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B703737C987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhELQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhELPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:36:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE6C08C5FE
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so3242025wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDuP19RIvFr3oYQnO2ffHmKNK3OSRhOK3RHFKslMECA=;
        b=AHsi9QcSyHxTvetudNhwrxkqTejvmZjBagws09KH8tllOy1N/4NiMyr/HaBReldoV8
         qeqBlAgDvFPkuTC+vOQ/VAN6vK/o4EYg3TNZEgHHvS3POxYlRYvtIfx4OVwjzT88jhcL
         T6DfkDjXNEz0lnH1cFFBdv8szeZAXGz7ArX3EAyCeM1Vu7k0uhkJ3j/Lcp1iN0ykjgbV
         9pqPwNrU9Lm88JgI76C5qZeCP96z7xRH7XJyNetHGc2bdRBOh3yEy0BX1SNTS53UoD8w
         f4yd89zJGGdA15NY/0Gr+hK0SOwB1Sxh4cVtAbfEguquCCBM0B8YenRrNCrDEisM8h2P
         jY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDuP19RIvFr3oYQnO2ffHmKNK3OSRhOK3RHFKslMECA=;
        b=sg6loBLY4BDWHxBJb87U+D3r7zW2c83SYljlBeGIoVouehCtULhK3YbP/QXpdvvZLt
         vtXW/LNH1oRsjKQJPjqej/JPRWjKYbJ5+ZrWccUhf5vPr6YJr2+mmvxrVCNOG4PrpZ6O
         LMOsFIAiA9S9Dh0IMfEk1BgA+nKpsFMxDeNEkNn/SZVhZINe/NG2qmd5q7J0r/w83waW
         O9sxcPa+YrLh7JinwCEDGSee+qFzQnTuTtl7z6iWPLspeGqp73ofTn7s7SS1miIn0oXh
         wItu9JkZJw4hy5JIAmtP3PK43AfPH6IW1aiiTLdjVPv6xKugL2Alxp2EdmN/qGdA8gE6
         DGdQ==
X-Gm-Message-State: AOAM532H5GpjmGdCqozHTZ333tkZDg+b+cqXG6MJHFm7nY9UxVNDq4+r
        XvA2s+ep1QQR1hGb7M6i83fJeQ==
X-Google-Smtp-Source: ABdhPJxkxuJGKpTC4HM24aBYSK3735xOUkAIGYxX68Mo3N9Oxk8oAVWYkmP52aGsOEU5pJ5UUbQhpg==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr39311918wmq.177.1620832586988;
        Wed, 12 May 2021 08:16:26 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.home (lfbn-tou-1-1465-169.w90-89.abo.wanadoo.fr. [90.89.34.169])
        by smtp.gmail.com with ESMTPSA id c15sm30095011wrr.3.2021.05.12.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:16:26 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 1/3] mfd: mt6397: add mt6358 register definitions for power key
Date:   Wed, 12 May 2021 17:16:12 +0200
Message-Id: <20210512151614.36996-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210512151614.36996-1-mkorpershoek@baylibre.com>
References: <20210512151614.36996-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support power/home key detection, add definitions for
two more MT6358 PMIC registers:

- TOPSTATUS: homekey and powerkey debounce status
- TOP_RST_MISC: controls homekey,powerkey long press reset time

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/linux/mfd/mt6358/registers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 2ad0b312aa28..201139b12140 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -8,6 +8,8 @@
 
 /* PMIC Registers */
 #define MT6358_SWCID                          0xa
+#define MT6358_TOPSTATUS                      0x28
+#define MT6358_TOP_RST_MISC                   0x14c
 #define MT6358_MISC_TOP_INT_CON0              0x188
 #define MT6358_MISC_TOP_INT_STATUS0           0x194
 #define MT6358_TOP_INT_STATUS0                0x19e
-- 
2.27.0

