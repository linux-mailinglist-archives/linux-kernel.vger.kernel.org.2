Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DF40BB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhINWXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhINWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:23:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so678084pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGn1oLmePzdHYmlcy4eccOqnFVHqyVy0bNhEcQmlMYo=;
        b=JLEUOua/+uZ1UX/J0cX5CDvR/r64uTGW3p71B5rejBGO4HqLFBfEpv5lXnk8krCtul
         evg905e5m2D/YLg69YsaSEw2NmB+biygxXsRwRPsZWlICldZaAl/po8gR3QfmzeVAsXp
         MXDt52lyYq7wHxy4cyNZ08ipAugSUu4OoUlN9TCWVsQoz70h5PYcNboETQNcml1nqFdL
         PHIzfEpQqh+PBTFMoHiSDuLilMDaAX8KJIGbAZn1nk6B0uCtJKgOfpvepvS7PzKsSWd2
         HOjk/S8bKDV0t8Jl+5Y4eUbsOQLfehO339gHAdVznyHtH9tRDJNaYLqpi3RBi67+nEfh
         l9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGn1oLmePzdHYmlcy4eccOqnFVHqyVy0bNhEcQmlMYo=;
        b=7GDLcoCFKJe0dfh1sOA1u4vhZKst+YTiErDWwejShdI3zkuz3niPTrktGDWCavRgwf
         IJrQXkojmOPCxTuNCAoxxB2IbpeDwnETXGWn7DPY7RN1VyHit3yUek00KxhlZZUQ0rdf
         NQ2xMMwriwfD9fAuXuU1ZV+deodgA3thyzgLb6hvDf9Ba2p5uCUwI6OZVCK1dOqo5g6n
         dQwFa9nSjpm7gjDbsZEaSdiEt4UjgntDVV3nPM7nJI+FMuCmVwYHFEU6P8idG0smcS/z
         5UjHR37htxHIB5VMI8z6/zIv4Dlw+NFpBQIGtMHYZJyjiy+IjTlLFs8srpKagV6pzs4C
         JBxA==
X-Gm-Message-State: AOAM532G1tCHlU9drCBoxmNj4nqi7XIPtqM2Tsbb9vyxx4Vb396gtWRy
        eOu1NNzEjROQ9T+8wJ3uixE=
X-Google-Smtp-Source: ABdhPJyRy0UTgmL/8WM8KxwnunbROWpTVV/0rgobevyrYtukEFsf2FNLr4hVenMNJqbEcTX+vrlm8A==
X-Received: by 2002:a63:2d86:: with SMTP id t128mr17440306pgt.316.1631658118223;
        Tue, 14 Sep 2021 15:21:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14sm2694951pjq.13.2021.09.14.15.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:21:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72116
Date:   Tue, 14 Sep 2021 15:21:46 -0700
Message-Id: <20210914222146.214115-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914222146.214115-1-f.fainelli@gmail.com>
References: <20210914222146.214115-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72116 uses a quad core Brahma-B53 CPU complex which uses the same tuning
as done for previous chips, add that chip to the list.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index e6579fc82b9e..2c975d79fe8e 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -137,6 +137,7 @@ static int __init mcp_write_pairing_set(void)
 static const u32 a72_b53_mach_compat[] = {
 	0x7211,
 	0x72113,
+	0x72116,
 	0x7216,
 	0x72164,
 	0x72165,
-- 
2.25.1

