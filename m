Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A963D1CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 06:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGVDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 23:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhGVDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 23:21:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6AC061575;
        Wed, 21 Jul 2021 21:02:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id my10so4365387pjb.1;
        Wed, 21 Jul 2021 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0z54twZ+AgT0+7a2useNZocEp9hbUYo5ZhqzjAiSPZU=;
        b=GqkjAGLTYo/CiiHjQcfJSEDwGAKjJTR8mxDyBTZ4gu42tlYkEscznirikuDRCqg4Lt
         fl0RghB/kOTBnks+DFqXFv1VBaiCqwkFAbUs7vZf0Oc1Mb5OHIyY6wxpdSSuK5fIyOcP
         Auu4fvKwnukZ1Rl4SNwP26M5CqH+rZ/vFGd8poggTghwQKvC7ZzUVqM70zJrrd1QdAP0
         YDCKAE4kMwejcTjEZlkSnjlbTlgEbhkZJnREm/5MokRCIvAW8hK1l73/+vdmobQKk6Fx
         eH+8eo/GRopLlZvmvOpR5cZh7/0J5eGMX90veFwkw0OWw/MJ/dTQWU+te/clw9r2ppTH
         WawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z54twZ+AgT0+7a2useNZocEp9hbUYo5ZhqzjAiSPZU=;
        b=tyBfiplPE1IQWDg3BSbN2Yq/esSO9t58PG8+mrMHgjMuiJ+hBbzvU2vr2GgpJg0v1J
         iEPmy8mGYMchoWujdyLAzp1mMxuNeI04Mn8YAR64KL0c9ZQUP2vKPgkZjcWYqJ6/OVMj
         QhdpfNwg1sSoao59AL1RvBmueexpObLnuNcY0GjITS1aXSNnNXfUTpgjzEZVJtiYFrk8
         y2ySIrluMm2+uIR3Jmcx9V1fGqFKbI7jc+ceE97dBGFHu2Phv8fhlp0oHpetkEa0fDJy
         d4rU0WJxF6hklGJBkN7EUJN+lwi9KLThokEfVCFx56PKkObgJMswLfOgmPQdtty5wCyA
         UBAQ==
X-Gm-Message-State: AOAM53010ueI9nY0NwNTGGvVwC3hENpAwFervHneBvcfprP3eF5TYig5
        shi3RHFYJHa2VKjZ1YRdIM4=
X-Google-Smtp-Source: ABdhPJyJm/V2f3KXD5bsjKlj6cYv4Ii88IMH/oWHjd5y2vjxoyIAFc0iXUmgtgCjpBCUXdB9WMQdDw==
X-Received: by 2002:a17:902:ea0a:b029:12b:46f3:2db3 with SMTP id s10-20020a170902ea0ab029012b46f32db3mr30343550plg.21.1626926527620;
        Wed, 21 Jul 2021 21:02:07 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:07 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 08/29] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Thu, 22 Jul 2021 12:01:03 +0800
Message-Id: <20210722040124.7573-8-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a4d4c757eea0..684539a65692 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER

 	  This is the case for the Nintendo Wii SDHCI.

+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
--
2.32.0

