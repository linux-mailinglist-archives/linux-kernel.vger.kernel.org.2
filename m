Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7E36FA69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhD3Mgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhD3Mg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:36:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4BC06134E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so6435866ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLF6UjbQpAiSk+1C2cRPJjTl6Fxr5nN+XcLDFX38OUc=;
        b=xGmTOesTxL8g9FKL+MsqLAHEbz8FjAV+meUFhGiuUAZNOpO4VhDYCpnpM5baKZZ4yT
         DLNBm97Zsdsba4Fhcc6sJetAeNnW8gqYXy+PUzt93NeD3tkNdfm7e68mzGXCy9fqP4+D
         jQwXe9wS0xdCgcukD7CpPUvaLRezu44FKeLtwWgK99jegz3BwmCpPMXWLn5Z4l7vJJ9c
         m3MgKDZfENJvnY1gryDs0bNANjYtsEhGQqFPcWItwTeqYc71eeRqvXnPrO7rv6/zDug6
         LhJIAE1NWkAP7pLfIXaCgEXkub1qT6301YSlytbQsXotlkjENoygk9NsDFTfxOqdx2Xh
         cI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLF6UjbQpAiSk+1C2cRPJjTl6Fxr5nN+XcLDFX38OUc=;
        b=WnCy8toiyBgI425Mf+fszkJZryAAYC6n3gZmSQUrIQ8ZyuZYw1K97uEc2Xy2q8UYmx
         RR6G9Tog+DXifQFvooV4Q4e2SV0RrC1Vqge1L26yWP50UnjV2eEISGe3upJiv58qPvEO
         niY4RoP2b/pI1S68ERxkbQIRolTOLeYVEcNNpy7qIQoToFBCxy46t1aWlQmZiGar+d3y
         9Mmm25e6S5pQvflsfUcdtxlyV6VjhbvM7EY9U8N9oL9CG/0eZP3Z3uWCD4d10Tc0UYOM
         ZJ/CIB4VK0H8TqmrDGCHi54kOCpfFYe4yJPCjuChkz1XeyZXsto20dF73QGUU/bW+Vn/
         sq7w==
X-Gm-Message-State: AOAM532oC6Jkkfds54621TiYxZ9h48R4I+Dh6WHgDpAx2gGFZd81IKcT
        /V2htH/JYzr1/+RspMuU5NhDSA==
X-Google-Smtp-Source: ABdhPJwFg3XdDCuqkDBWAZNT1Y6uM9fsvwP/FCRzFDiREFeamN2RNu0EO4UoCJ8H64rkgg060yRFhg==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr4177146ejc.185.1619786129968;
        Fri, 30 Apr 2021 05:35:29 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-15.xnet.hr. [88.207.97.15])
        by smtp.googlemail.com with ESMTPSA id d15sm1822988ejj.42.2021.04.30.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 05:35:29 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lee.jones@linaro.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, jdelvare@suse.com, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Fri, 30 Apr 2021 14:35:11 +0200
Message-Id: <20210430123511.116057-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430123511.116057-1-robert.marko@sartura.hr>
References: <20210430123511.116057-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta Networks TN48M
CPLD MFD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..7193624868c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5096,6 +5096,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta
 
+DELTA NETWORKS TN48M CPLD DRIVERS
+M:	Robert Marko <robert.marko@sartura.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+F:	drivers/gpio/gpio-tn48m.c
+F:	drivers/hwmon/tn48m-hwmon.c
+F:	drivers/mfd/tn48m-cpld.c
+F:	include/dt-bindings/gpio/tn48m-gpio.h
+F:	include/linux/mfd/tn48m.h
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.31.1

