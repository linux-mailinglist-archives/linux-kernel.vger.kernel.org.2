Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2093441767C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346649AbhIXOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhIXODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:03:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F9C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:01:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r26so14605274oij.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E866vCrK/nEkvPI6DhB6g/rM4e6hptH7T7fdbGR7E4I=;
        b=iNEtB0Z49iCbx99BtFJrHoIoKw15gBFS4wIqh4kd+c5iiF9F4hN98ub1Z+7O0NwxmE
         xIP00cmXOvY2ZsxjlR2DsGC++f5P0Z/XvgEVgT8WWBo4tUQEnHUQrnSPYmeGeKxROcG+
         333yCNmxtau0uVddhHNVUeTgXHgAt8gMQWx3QatSQeh8FZxo62hGhNHx+/hoVxNMKcr9
         WdBAOJQKhEZGmu4SF1RVrBhCvgmrqyjSLSl9+3XL4WFnnKXj06+C3rW4eYd9QPXlUjLq
         HZKGTGA2Kfqm27jmupM5Ue1Jizc9VYgRlOY7ydO479fnJ4mJR9FyDwYeJCNMXf8s5t33
         1cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E866vCrK/nEkvPI6DhB6g/rM4e6hptH7T7fdbGR7E4I=;
        b=t/UzIXpq7r+SvzlewK1UJ1P9HRNblTfHY/2aRlK57zT7dEOeZJE9zr2Yk+3KiqeikZ
         vuLn8phOrgAiqPzzfjIljN1EZW8lg95oaexkbm1dMfXideBS31WOqBrgzSuLs0nnIir0
         gAbcigmbdw780nABVPVYIDGIaCJKyGNDR08zDs+w2bIXyRmz3dRW78JTm4D6yjotUF3E
         ZLiQDjV3rTJi7Q1dHRdOxKyJrFzZPQv3Huann1O6NKM6R8g1dldfjsUVF4kRJyl9QGza
         RmEmVUtXSHDk4aP5+8SUHDojrtFvTaQ5RS/DTSVtQ9lkHoDB/b6KhI0lar5KxZNXs2yZ
         339w==
X-Gm-Message-State: AOAM531cKvhDRSgf4O2QZ4fmIIf9BQ0TGwjAeyCm2l3fSLfUB+p2MdbS
        /g2vgf1zQhLLQ65t4UAf+CeZTKQexVe3Zg==
X-Google-Smtp-Source: ABdhPJz2h7rqbrQMZKRNYQRPVUg4givp/hlgmbqKInkuYhVVFpHX2PSZ6IziVaPJasAjUKssdCmnbQ==
X-Received: by 2002:aca:5f0a:: with SMTP id t10mr1526693oib.38.1632492111724;
        Fri, 24 Sep 2021 07:01:51 -0700 (PDT)
Received: from fedora.. ([196.32.91.248])
        by smtp.gmail.com with ESMTPSA id h25sm1011600otl.1.2021.09.24.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:01:50 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        kernel@collabora.com
Subject: [PATCH] imx: soc: Select REGMAP_MMIO
Date:   Fri, 24 Sep 2021 11:01:46 -0300
Message-Id: <20210924140146.29264-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx-gpcv2 driver needs Regmap MMIO. Select it, and fix:

drivers/soc/imx/gpcv2.c:420:34: error: array type has incomplete element type ‘struct regmap_range’
  420 | static const struct regmap_range imx7_yes_ranges[] = {
      |                                  ^~~~~~~~~~~~~~~
drivers/soc/imx/gpcv2.c:421:17: error: implicit declaration of function ‘regmap_reg_range’; did you mean ‘remap_pfn_range’? [-Werror=implicit-function-declaration]
  421 |                 regmap_reg_range(GPC_LPCR_A_CORE_BSC,
      |                 ^~~~~~~~~~~~~~~~
      |                 remap_pfn_range

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/soc/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 05812f8ae734..a840494e849a 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -6,6 +6,7 @@ config IMX_GPCV2_PM_DOMAINS
 	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
+	select REGMAP_MMIO
 	default y if SOC_IMX7D
 
 config SOC_IMX8M
-- 
2.31.1

