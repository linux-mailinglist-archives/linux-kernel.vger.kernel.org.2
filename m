Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9539838AF01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhETMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbhETMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:48:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DEEC0610EB
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so5072349wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzzcFdbD299bYbwkVjVetsnIw1bNC8GFwst6cjVWrUI=;
        b=GMXi6xLdlhRxj0ZIB1xJP0ro7foTWy5f6rDTrF79SNKxRw/Ulol5tDv96DQh4RJ9fq
         iArkR5oVuBatDWEuJ8fkPz4DbaxcRoyNC6Uj5gUTtjGYxdHIAYs3NSJzVo4h2bltPeB5
         F1CHD/3AEmSVoiokmjfCa6WqlP9WmcKGFuvUsTod5wBv7EiiA+LmfrkSpOevzKZFeZp5
         P+22u0KIz9mXnSQzn/tWbF9q8QGRo0y13m6kx8hHmKkcXnlEhtkBafAfTSq8oxBb3d0V
         ga1xKH197qzhQqg0Aie4OLoNBj8gt/wnTzk9q+tHw3UFMXB4WHwABMDXJHoAIXrV0Q93
         7E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzzcFdbD299bYbwkVjVetsnIw1bNC8GFwst6cjVWrUI=;
        b=R3VnjaB3HWljcf1cRf9ojadpmq0uwTfkmIVUyz0N7TJ/15vDrvjUQaqEBjnXK8Dhra
         Khf/trJnBH+RqdHtA+vHR5KMPnG0WFf4bp3KyMyjSI6ZESLvSmEFSDTWru+O3bPo6UYO
         yrgZaAppKUX1cdlEqeVRcYnW9DzGPwRXEXZdf7xxIXJ0A/KC4AY2Ujwp/ppOG64Zf70l
         0s83Ktf/AAdVLbaK5d3hmlkFyq85LpiZZzemyKcMpf2AXcJQbuVjpVeT2pQfA/CccJy0
         M8QVcOF5MFxGcTBO6m82C+qRTED9SuO9cfTfZ49gZ/D5Lbvd6gXFD9KeVz3ZRg83xJbl
         yqKA==
X-Gm-Message-State: AOAM533guhUF4wW6wCOK/bLZhiYoqWx/ZVH1s3u+L22JfnZjx6ctsk8+
        fKy3AbmvnpvYyeX+CElZbiAakQ==
X-Google-Smtp-Source: ABdhPJxuF4aX0+PhDCmXQm7mNZdGIXuxQ38HMj2nIMfGim4EPcpJ4+uPYl1dIPCzCDraZwGAgZWrOw==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr3797852wmj.22.1621512506912;
        Thu, 20 May 2021 05:08:26 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r7sm2237170wmq.18.2021.05.20.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:08:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Keshava Munegowda <keshava_mgowda@ti.com>,
        Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Subject: [PATCH 4/7] mfd: omap-usb-host: File headers are not good candidates for kernel-doc
Date:   Thu, 20 May 2021 13:08:17 +0100
Message-Id: <20210520120820.3465562-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120820.3465562-1-lee.jones@linaro.org>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mfd/omap-usb-host.c:26: warning: expecting prototype for omap(). Prototype was for USBHS_DRIVER_NAME() instead

Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/omap-usb-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 2a3a240b4619a..787d2ae863752 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * omap-usb-host.c - The USBHS core driver for OMAP EHCI & OHCI
  *
  * Copyright (C) 2011-2013 Texas Instruments Incorporated - https://www.ti.com
-- 
2.31.1

