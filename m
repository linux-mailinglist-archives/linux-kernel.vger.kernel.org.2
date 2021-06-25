Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987673B4005
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFYJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFYJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:08:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:06:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h4so7067275pgp.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOLeIgAIvP8vpXLszRPKmMnwt1c4hjaEVVQjo9BHJhs=;
        b=EtkhxB0fWq8+kE0/veZxXU+GWcKR5ZEfz9btnvT3/5oy4+fCMaHMp3acUVLYutJTev
         iCPrSlSJX+sSKfclYjAxx91nWumYGtWMhNz0KAMhIgG2rPMBXp80ZbvjrwTuiaxdh7s9
         98mTFRswvVn3qmNrr5FIh0MQIgETnuGhq0avkviWNOlP4iEojB/dO2bhBYZtrBok3aYJ
         Qq01391XWaoZOEt4eDc9Do5AMu5hltlowtoFU9RfCogTvW8KjNpUhvJ0Eia0tHGPK0Le
         PTZfiK1r9H3HJXnvKsQvlss5ZoBozMSC20dKE1XdnrWZicopN95pU7cJ368rYRsIQTMT
         UVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOLeIgAIvP8vpXLszRPKmMnwt1c4hjaEVVQjo9BHJhs=;
        b=dQtGPc4wKetVoYHigrIrwf37GyK1gHpU1Y/01tPbka/DvlqjYl6nUJvlAJpWIL398H
         LLXE2wNNK/QE47JcPK9yvJpB4Zvakfh+xcX2GYfGQ4CWNRCrZFaf8JCqoy6O4eJJmynu
         3+LVGoXUrIGeJEruwW9fBU2hVSRznXULsuJQaN79YDwG/Q62Xonh/oqC2VqRvUHJxJ7s
         dfM/eUliea/qyPB48AS1CtKg6OGD8Y60+MBNXCwBRAawcWB+dWb2qCaUaZ8lR9iido7c
         YLTK6iO2xb3TSbUPPHSOMdHHZOZfHF73kwQIP6pLOAWBtd4gbaGKFtznAiKU6D3OCHct
         G9Nw==
X-Gm-Message-State: AOAM532jf6mbYlwdsGwKsaWBWEcoGuxLbM1UOmvKu/4bnWTbV63p+r4L
        w+4zSiVHsMjlVhvzBdNbmvU=
X-Google-Smtp-Source: ABdhPJwSeHh1JYSc2btBjWej5uE0dCFvN6mISja6McFbMLxnctpP/z7KqRDsz6FdRGYUCX6ot1WJkw==
X-Received: by 2002:a62:86ca:0:b029:303:53e5:6016 with SMTP id x193-20020a6286ca0000b029030353e56016mr9571450pfd.15.1624611974485;
        Fri, 25 Jun 2021 02:06:14 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id t13sm5236078pfq.4.2021.06.25.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:06:13 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC PCIe multi-function card support
Date:   Fri, 25 Jun 2021 17:05:55 +0800
Message-Id: <20210625090555.11349-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC PCIe multi-function card

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index b74efa4..0bab573 100644
--- a/Kconfig
+++ b/Kconfig
@@ -2156,5 +2156,19 @@ config MFD_INTEL_M10_BMC
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_SUNIX_SDC
+	tristate
+	select MFD_CORE
+	select SERIAL_8250_SDC
+	select CAN_SX2010
+
+config MFD_SUNIX_SDC_PCI
+	tristate "SUNIX SDC PCIe multi-function card support"
+	select MFD_SUNIX_SDC
+	depends on X86 && PCI
+	help
+	  Selecting this option will add support for SUNIX SDC PCIe
+	  multi-function card.
+
 endmenu
 endif
-- 
2.20.1

