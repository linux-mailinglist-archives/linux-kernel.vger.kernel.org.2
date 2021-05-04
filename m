Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4943730DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhEDTgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhEDTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d11so10635133wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGH4gKVqMFGwtn6qnf+9iZ3a3vefAvfwW/d/3Z1krdI=;
        b=zASfNWHRz1uXc+PDQtDVcFqPtvHY5VdiDHD/4G2VJOJAPRo4NbTO1z2H6LfZ4AzkSr
         tphH6TDrILepJSikB4SgPkvbuFbZu7dFWjLRTLZ4HPfKs89CWxWKKSDFB1DO6wbLQ5ay
         BICt9cqWGaNawYQVMPuxbo8RLfm1F7ph8A3Q1m/tP6w4icJDhN4inbGN93/Ofq//2CVu
         j7QIOi+VHU3ssXB64KWr2dTVK5VjMvtli+jFOwXFt1DWDCFL+bktD+2NWsTCfcoYkOJT
         QGgVVIYVl5kzZfyNxxnWsTyeRAelRQKpaSjFRJ+exqbjhav+RgiiOwJwQxRfR36JVrKT
         pVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGH4gKVqMFGwtn6qnf+9iZ3a3vefAvfwW/d/3Z1krdI=;
        b=EjLmJzDfsFHEk+pX9RrgRZXWqw6Xc5ZExJlI1is1v3XTv6BcXbrk+9sRIpMe2MpLJY
         GJe0KqUKLYBkMX7uIvOE3nG/ekoSWkBS9IX14HzYv86I39igCPGMfiINf7kFkWZDJXCg
         fEitxXxFvrXjjZ9+9RRenpPYx7wX4av7N+MujQafx6Z84+Rlc0nFFBBFcRGN7I3jPLDn
         b30vAGCpPus/6sZotR/DCB7junkSdgnbZ1YgqleONHJhHeQ9IEtMjZ3zYoyKZU29+Cyr
         3FE+GuwDdxQpFX9mwG2L/fKOJumulNpMiWmBuQWN51nfwgPYZJKRxszzySOTblZ3OCll
         AK5w==
X-Gm-Message-State: AOAM531ewpEaZ7iIGmbgdnV7ipvUGPgZkUDnaCVj1OnEWRVrupJr7jUd
        +wJHZ01zKdQsTxlj535OowkGoA==
X-Google-Smtp-Source: ABdhPJyQHKfnAbPYhTTf6e5lMTFkW5CZeYWMhTWodx6MLel4EJC4lf+P/tfcTkGYStfLwQ/drNfktA==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr33567229wrs.264.1620156905644;
        Tue, 04 May 2021 12:35:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/5] ARM: ixp4xx_defconfig: add MTD_PHYSMAP
Date:   Tue,  4 May 2021 19:34:54 +0000
Message-Id: <20210504193457.4008384-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504193457.4008384-1-clabbe@baylibre.com>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without MTD_PHYSMAP/MTD_PHYSMAP_OF the flash partitions of my welltech,epbx100
are not detected.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/ixp4xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index e3bcf2bed25c..9a7667383df9 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -109,6 +109,8 @@ CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_IXP4XX=y
 CONFIG_MTD_RAW_NAND=m
-- 
2.26.3

