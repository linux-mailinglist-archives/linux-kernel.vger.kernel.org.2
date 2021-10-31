Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699344410DA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJaUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 16:54:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48736
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230041AbhJaUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 16:54:49 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E88623F170
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635713535;
        bh=xqCsE/aHJs5ZoBOU3zIm5sgDqctAPmcQP3VY/zMUALg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=i/aTVOxDPspzEPm8Xjv7FYk4Lj5YsPD7x5iVhNz/CroOJZUvTxA/DbVKS6bIj/Fbl
         eGRjjClt8JhZgaRKsWa1HKfIu7wskK2zTURtOCYGfbhb8QPzczlqIzIdSkkaGu5yka
         B3g9mRy0noQV5dkjBsaoZVq9Q0e9eveKyF2qUCEjS5XLs2AkOvdel/VKpaaLdFwZMr
         sfYnltwvMBp4uPr77XyJpKQwzO8dFwIggGjV3RGSOrxCHHL/atuIjD6BEWheuNKe4d
         qBdfIU/KM8Iy36PqUpoyIey2fV40Fus012UxaNpZtL66+zF8EbemWBOjZAg/P8GRMA
         AiRJRXRotn7Sg==
Received: by mail-lj1-f198.google.com with SMTP id a20-20020a2eb554000000b0020de66f70bcso5077042ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 13:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqCsE/aHJs5ZoBOU3zIm5sgDqctAPmcQP3VY/zMUALg=;
        b=dettuJFPBvE0UMf/yR6iHcAffCcwTo1VNc5VTO2PUOWj+MtWCUQp/f7O/Z9gl3FXhL
         Dj+9XNf/2Z8VNu73Zb785zpZcJ3+F6f3ztt9zYT8riqI8YFazfCQ36r4+k80SnJ1a8Gr
         Uv7y0VD3hyO2UdQ5m/TskLAz4Rj9TKQ/Dpuj0VPdEZb39dXy1EFjHKHa2/FBO53nsyfl
         a1Z7w8nUgyF3TZAtAak95ovi7zY+Kfj3FIHIAunu9qe0luzZtodJU8pYN7gsSOmuDpWx
         0nbZj25Nq3isACWE7ot6FwkIqptXTfjJjbFcCdX9j4njUVwYUfn7NTLtfEYX6TS6AUZl
         ZKKw==
X-Gm-Message-State: AOAM530ruJkMNFH4jUKfCqHVuw/HcmIsfRAQphIHDpW/ZzP8WB8YVulj
        /VkS+i3Wv+wDu8E0BrvGiBiGiQEJAG6hVJIbpfxHtPKLunfmogTGHrAFiJ3HT9A8/AKyExJOpbP
        7+RWQ1nk7ZYI43RnSFRSVkEBvmx+9WoQB4yjAvmp5Uw==
X-Received: by 2002:a2e:b546:: with SMTP id a6mr17389314ljn.177.1635713535090;
        Sun, 31 Oct 2021 13:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYFvfcT9ZuKuLCScS0pjq4nYmoHdEKIO5HyNQrxc+9+E9mHbSyqnvub3G+p1XUdqCS3uK4Rw==
X-Received: by 2002:a2e:b546:: with SMTP id a6mr17389305ljn.177.1635713534932;
        Sun, 31 Oct 2021 13:52:14 -0700 (PDT)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bt10sm1233007lfb.193.2021.10.31.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 13:52:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Virag <virag.david003@gmail.com>
Subject: [PATCH] soc: samsung: exynos-chipid: describe which SoCs go with compatibles
Date:   Sun, 31 Oct 2021 21:52:12 +0100
Message-Id: <20211031205212.59505-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos ChipID driver, like most of the Exynos drivers, uses one
compatible for entire family of compatible devices using one devicetree
"compatible".  The compatibility is here described by programming
interface (register layout), not by actual values, so the product ID
register on one family of devices has different values for different
SoCs.

Describe which SoC goes with which compatible for documentation
purposes, if the DTS is not available in mainline.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/soc/samsung/exynos-chipid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index a28053ec7e6a..baf3afc69d79 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -42,6 +42,7 @@ static const struct exynos_soc_id {
 	unsigned int id;
 } soc_ids[] = {
 	/* List ordered by SoC name */
+	/* Compatible with: samsung,exynos4210-chipid */
 	{ "EXYNOS3250", 0xE3472000 },
 	{ "EXYNOS4210", 0x43200000 },	/* EVT0 revision */
 	{ "EXYNOS4210", 0x43210000 },
@@ -55,6 +56,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5440", 0xE5440000 },
 	{ "EXYNOS5800", 0xE5422000 },
 	{ "EXYNOS7420", 0xE7420000 },
+	/* Compatible with: samsung,exynos850-chipid */
 	{ "EXYNOS850", 0xE3830000 },
 	{ "EXYNOSAUTOV9", 0xAAA80000 },
 };
-- 
2.32.0

