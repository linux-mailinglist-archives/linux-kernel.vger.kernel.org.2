Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5792F44D3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhKKJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:15:10 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48484
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbhKKJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:15:07 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EDC9E3F1EB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636621937;
        bh=COHbret3CYWs1LPEWi5njubL+5DtolSP4rEmltng+R4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ITITTF1PWSo7Vzjb/CulwVPQ/7YF/qMXZXst4uICPSqWKk3yfskICb9WjQ5u9KIGm
         oX18RbxCytrsOSW0B4WeQ0IZSKPZGTm4mXP3yl8Yzig4XnScycm2eVQAGufNYo1iK+
         QLI6iUz3IBS42xLsRGAhtjNtReLZpiiIjYihS8ue1lSfY/ikNH41nuRQa2Bkh7kz7d
         3qozF9ucR+hS9D1+d/vErnzfrKSXIiEag3eV+t+Xqd4W2m43ALucXxuXdV1bkIcEIY
         tJLCpAEE9VK7LeSadRSYLOMOs2Uf4chmCfOJWN9ZqmDXtBh4Od2AOrP5gArn7fS4lF
         OZUZdifKidSYg==
Received: by mail-lj1-f199.google.com with SMTP id l9-20020a2e8349000000b00218c7c981bcso1533879ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COHbret3CYWs1LPEWi5njubL+5DtolSP4rEmltng+R4=;
        b=gy3MMpOKWQQJtt9jny20kBuScGfzqTI10+u1GnoK73HZQCLq7qIHoRPz+I87xqS4nK
         3h26YVH9FIl+onZD21QvDG3Mn3boCdgEcVbT9aPFYwnCxg5EVHw93WBXTBhGspp8IMbp
         4V20GcNl9Cq9JFeY/m0NcM/AG/UzHEbv1/4G7l2RhZy7ucbf+49J89GftvjGzV7ZSigj
         FBbhyN5h+xOmrC73qsFoC5LezcJh1K0NTbKGG18gWjApaCLaiMH1b4KN6DOyGF4L/loW
         GaePVH9s7drY71SnrdL/oxrXYgnfHcP1FqH2M/ALmUuzP7h2b8jb+ogh5xyuC//lKhHH
         RKoQ==
X-Gm-Message-State: AOAM532KG82/6+NEWu0qIqrBy2V8NItBH/tLuUx5CVJM1rZdCsoyS1SE
        SJ2E4gIQpMDc+MipyHcauy/ehJyDEQHo98RK0LGJGHfwnIt+RSp+Za6zbs2o+CINQrDIpf5AlF+
        JuHGrQ3wpdiG87Pq86AO4SzsdZA3Lnbcfg7YqlbJleg==
X-Received: by 2002:a05:6512:159d:: with SMTP id bp29mr5203071lfb.257.1636621937415;
        Thu, 11 Nov 2021 01:12:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw50uaVBUyMp68i8IYHq/Zi1gbhDBuJB9AdjaC3oCIQ1IUx0+dBC99oJabniaazPTA5FmmCGw==
X-Received: by 2002:a05:6512:159d:: with SMTP id bp29mr5203063lfb.257.1636621937265;
        Thu, 11 Nov 2021 01:12:17 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g22sm230580lfr.237.2021.11.11.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:12:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: s3c: include header for prototype of s3c2410_modify_misccr
Date:   Thu, 11 Nov 2021 10:11:23 +0100
Message-Id: <20211111091123.50853-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the header with prototype of s3c2410_modify_misccr to fix W=1
warning:

  arch/arm/mach-s3c/gpio-samsung.c:1309:14: warning:
    no previous prototype for ‘s3c2410_modify_misccr’ [-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/mach-s3c/gpio-samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
index 76ef415789f2..fda2c01f5a08 100644
--- a/arch/arm/mach-s3c/gpio-samsung.c
+++ b/arch/arm/mach-s3c/gpio-samsung.c
@@ -35,6 +35,7 @@
 #include "gpio-core.h"
 #include "gpio-cfg.h"
 #include "gpio-cfg-helpers.h"
+#include "hardware-s3c24xx.h"
 #include "pm.h"
 
 int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
-- 
2.32.0

