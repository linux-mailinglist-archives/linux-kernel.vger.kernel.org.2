Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F842F397
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhJONhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:37:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39504
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234697AbhJONhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:37:31 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 838E240062
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634304924;
        bh=Y4U/fJqXuLgg52bUOfbV+iRZ91dG+diGxyV+QIZgnxY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kUfr5mjMpWFC5fPiFxCb6T4BMnjK/15PB3L6/VqLFx4Jcsw8pzdkje5TEy9oCjoSY
         ik63wXBH1BOXootrUfRGy7XVQfF7qgUMxZc6EqozPrKCj82Q8bXmxylmkEWUMp2KaZ
         X9SAUI69iSEbyLPBD87pa2s97+Kl/TgjdbSGyGujbD/mlkS0ld45Yfw7RK4ZA791xy
         j6TE4JljXWNsToaiE2m5udve/Vwh0EZcFEIB1K/d8n+efMcm2TsPdGqy2tit5XpheK
         MUyBWJ6SNSoZ//QEoa1qu+vZQdFesyMMei3BslhKXnsFXBHN++akZaJHhbTcnUZY4K
         GFZYNokAGAGJA==
Received: by mail-pj1-f72.google.com with SMTP id l10-20020a17090ac58a00b001a04b92a5d4so4953912pjt.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y4U/fJqXuLgg52bUOfbV+iRZ91dG+diGxyV+QIZgnxY=;
        b=lQ9gTIJoBbufKlIJKEa0n8YB9rUXfnm8up/GARL+u31s2JjHTdlLz6qXC7aNXg6qxP
         Wwlt2p0bk8ELOk0pqYqBVeyUQxZp04a/gGkZNlxmuRAxY/efsbDt3WASQYxTRdVeTvVF
         HheFgcaHYOOCpRGau2Io+QhFrNJUBTBkjJWagomxPzA0+yChuyr9tWinJfWcxHQR3MDF
         d+FJWcLJYJLu8MxFafNiuu1kOpFLGCGcEN6OfsOnDa6OXUDHixTO4Ah+w7Ia+m6fncfp
         yPlinkrCZ7v/imv1hO+IQVwrjW53B7VXQBFLFeuv8NPV/QCY8oM/9k6Ie4f1MbGRpHNY
         qYwg==
X-Gm-Message-State: AOAM533P6nDwGJEl7fKjJp2TixhNFxUv02cVuprrmgLyUMuTRAHZMDlW
        pGrFxTDz25SsqliFWHoM+RaUHueOoDlZ4n5KVjy/7od+89pG1hzy3ZOnwq44R2MgaopqBOTCwh/
        aK6aStcp+e01tpmH5/d+/sbkSSL/YJfzODM8M9QWGjg==
X-Received: by 2002:a62:e90d:0:b0:44d:35a1:e5a0 with SMTP id j13-20020a62e90d000000b0044d35a1e5a0mr11806362pfh.54.1634304922960;
        Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz07OGlC4jPnkxjhJx1/FXGc+HkyjOrYc/PtEHciW7RhWaLFxsvrbGwzHFbiuv9FCIULMRE8Q==
X-Received: by 2002:a62:e90d:0:b0:44d:35a1:e5a0 with SMTP id j13-20020a62e90d000000b0044d35a1e5a0mr11806331pfh.54.1634304922600;
        Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-3814-7c46-b875-7e50-69b7-4e53.dynamic-ip6.hinet.net. [2001:b011:3814:7c46:b875:7e50:69b7:4e53])
        by smtp.gmail.com with ESMTPSA id y8sm5143327pfe.217.2021.10.15.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:35:22 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with RT711_JD_NULL
Date:   Fri, 15 Oct 2021 21:34:24 +0800
Message-Id: <20211015133424.494463-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
will be overridden by rt711/rt711_sdca_add_codec_device_props when
the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
to RT711_JD1 and cause confusion while debugging the JD mode of
the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
to honor the jd_src value in rt711/rt711_sdca init.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 6b06248a9327..d05c0565e09c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -15,7 +15,7 @@
 #include "sof_sdw_common.h"
 #include "../../codecs/rt711.h"
 
-unsigned long sof_sdw_quirk = RT711_JD1;
+unsigned long sof_sdw_quirk = RT711_JD_NULL;
 static int quirk_override = -1;
 module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
-- 
2.20.1

