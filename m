Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786283970B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhFAJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:55:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFAJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:55:50 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo168-0004g7-Fk
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 09:54:08 +0000
Received: by mail-wr1-f71.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso4650400wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P84Q3P77QPurEsVerB80kS5Kb6uIBsDdK0mS7TTN5Ls=;
        b=PZob2MdBtvFn3Frh6Rv+FrcHFgs7Pm7tMHOytRLeVMCJk3kL0RGupAd5ZaMH6sItGW
         XEszIcYKQ4hCoB0PVD45fEvHhpTXmPvG2Lq+XzvuWib8BnP09xKkN+qCuJCMRqr9gSh6
         nzzalybvRGrHP3eFyGoVWz+1ni2e9YX6RiMF3EeDbOtU6rcvnPRMEFY/vAKiEg7HD6/x
         wSFI/s8RsSIO7su7qnoJvQTv7tD/6oIwV+x2+OMEMZchhTvEPdb6YL0j3CYfco1H16NF
         U/vkSYpicdFL/qxParmzMr3Y6p+H0SQcl8kpj9YyJ5IQh+tGUFBOpLGW2HWabtoRiDvt
         sUlQ==
X-Gm-Message-State: AOAM530GTerIryAImTrwrsIR60p7Zbek/G87lZdgZpsYbubhW/+k9y+o
        uk7rbLyz0XI7Yj6lFSbSd8dcuA44twywQnjD3BWrgEts8wkrvpg7ic4gIEONV2OpalB3txKCopK
        9z+h827/msPUvEAH5LGcCSnaVnlI6H9Qp2up+5cik1A==
X-Received: by 2002:adf:c392:: with SMTP id p18mr5967451wrf.373.1622541248293;
        Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRXf0Kyx8EiU6f8ShfqUFg8yihrjM9vJAYd72HYDtdzKblhZwGcYeC5Mg2gYKZnCmpkWc00w==
X-Received: by 2002:adf:c392:: with SMTP id p18mr5967433wrf.373.1622541248201;
        Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id c7sm2018363wml.33.2021.06.01.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-sprd: use sdhci_sprd_writew
Date:   Tue,  1 Jun 2021 11:54:03 +0200
Message-Id: <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci_sprd_writew() was defined by never used in sdhci_ops:

    drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 5dc36efff47f..11e375579cfb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -393,6 +393,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
+	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
 	.get_max_clock = sdhci_sprd_get_max_clock,
-- 
2.27.0

