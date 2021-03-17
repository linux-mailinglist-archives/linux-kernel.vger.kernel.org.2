Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7033ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCQJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhCQJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:31:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:31:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y1so2248018ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1JvQrYJAeTY2r8foioHnWU1JA8C4SZadDv1a3LsN+s=;
        b=Dshl4/mLY+2y8/eaHHS6lolq9b33VAfEGJy0pKnf7R52ed2jlnzPZ/tlMkPI6hsR2k
         imdlAfMONM6HW/2qZHOCPqFQcSRd2ij4NSrIYqCe7g9vaFz7bIqfO7SoYkz0hPgooduh
         9ECFo7zKKRFwAGrvLLnnzdRDaOVy8ckKVbGGU5nG6nmVhDBpdfuYoREeBoDqlUQHn3gG
         pNw5l+LxEmZmGr4o/WO51IMmcR6N3E/EgyCt73T8ThcjsoaZpJpy4Yvp3Q0nl6a/LrHj
         sAIWX+GBIXFh+DPnfhWyj4DuUdnl5D8Cuq6gdFXcfsRfCATkdG1uu/F+7c9CZsbKJshv
         jvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1JvQrYJAeTY2r8foioHnWU1JA8C4SZadDv1a3LsN+s=;
        b=ESbUrz8mHoFrRrbOVR+tNxRs5OG2WiqJrZWqdvGL4XOCbz9z5JVBMLU3uxx5QFJqtn
         cKogukiAEqGd7Hi4Ij8h3IYCNoHvCpSbgR2Q1FZnXXMLiWCPhXMGwjiBvutdF5GSLbKk
         LYauu19N4bTuqcd8knZ1DtBLify7xQT4uA9NTVWDihA+b0BOO2E+PgUJAFv0HRhLnIVM
         W4fJjkc7nPyEcHcnv9XPY5fYgLNGSVv/pZ5jo+oDhcFPekuFdvblH/VF18TH+RdqsbfC
         2BNkV8dEnF4Sr8TGmKpCoJSFQ0gJP1orXZCmBvrVkK6lZaGkobczvrwDoPb+Vat6467A
         Bf7w==
X-Gm-Message-State: AOAM531J5YNynNMi4ivSujrX0RXBLUJ9dXA60/HBTPXu2Uj4uTOk89aa
        5INIO/7VrPsndHFT1ahsMMgzcA==
X-Google-Smtp-Source: ABdhPJyNfuEMCSNz8/hVScTKZYXXn0qF+hw3di3P3T1w/Q0cuhs93WfGVDIH4QxfoZvt4zGMFnGyaQ==
X-Received: by 2002:a2e:868e:: with SMTP id l14mr1853124lji.479.1615973498694;
        Wed, 17 Mar 2021 02:31:38 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id j19sm3342054lfb.15.2021.03.17.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:31:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Liu Ying <victor.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: imx: scu-pd: Update comments for single global power domain
Date:   Wed, 17 Mar 2021 10:31:17 +0100
Message-Id: <20210317093117.16091-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of the PM domain support for the scu-pd, the genpd
framework has been continuously improved. More preciously, using a single
global power domain can quite easily be deployed for imx platforms.

To avoid confusions, let's therefore make an update to the comments about
the missing pieces.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/imx/scu-pd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 08533ee67626..6e178a63442d 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -29,6 +29,10 @@
  *    The framework needs some proper extension to support multi power
  *    domain cases.
  *
+ *    Update: Genpd assigns the ->of_node for the virtual device before it
+ *    invokes ->attach_dev() callback, hence parsing for device resources via
+ *    DT should work fine.
+ *
  * 2. It also breaks most of current drivers as the driver probe sequence
  *    behavior changed if removing ->power_on|off() callback and use
  *    ->start() and ->stop() instead. genpd_dev_pm_attach will only power
@@ -39,8 +43,11 @@
  *    domain enabled will trigger a HW access error. That means we need fix
  *    most drivers probe sequence with proper runtime pm.
  *
- * In summary, we need fix above two issue before being able to switch to
- * the "single global power domain" way.
+ *    Update: Runtime PM support isn't necessary. Instead, this can easily be
+ *    fixed in drivers by adding a call to dev_pm_domain_start() during probe.
+ *
+ * In summary, the second part needs to be addressed via minor updates to the
+ * relevant drivers, before the "single global power domain" model can be used.
  *
  */
 
-- 
2.25.1

