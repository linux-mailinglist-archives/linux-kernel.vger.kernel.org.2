Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB23320AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBUOFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:05:46 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40651 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBUOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:05:42 -0500
Received: by mail-pl1-f180.google.com with SMTP id z7so5978798plk.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 06:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztDsdAIBTtQ1nkN7dw6CYE5xnJ1DaXEAMZjHk0Yhkkw=;
        b=A5IWgLbPwz8+oMBB5RuqGhqPheGlx/gW1aIt9ZGWP7C+6p9UhBOemFJynuTl5ZwBxA
         wzEDXZme0sX9VuVFB2SYktrhY5dgUm2Klm06JIu2PVp5bPZ4UWm0r2DRJkWV9+nYIP9a
         iAhAb2HM7vMvNKtrhACyK9ChTS0rxKzbTI50nHfqtScI14uAIuTVUrY/GjEkZf33LKtu
         oq+HmG5sZnG80ZJ+2RyOlE3Bhsp2H+1sYi68XORdQZIJ/cNbBwfSnaEMwTOT/IbEeBJm
         +kW2vZyW964G55xt3mkoCNb/QeK6SlhRpYfq320Di8W5+bmpONKsWZANQonj1EiAb4oJ
         6rMw==
X-Gm-Message-State: AOAM532prYjH/VwUu0kUM0pEqN0ePn2wKl0+X0ljwcUsyDyzG7A9wg5h
        26HKIx7RVAtk/gLgJPxM1MO9JgEdWh4=
X-Google-Smtp-Source: ABdhPJwzZcsp9cJ7K4okRUk9bpxKQIxBd+1Jag4P8sKj8kZVI6r/mZByZEV4zL13h0d9nBbmPUPj1A==
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id v17-20020a17090331d1b02900de8361739bmr17605925ple.85.1613916301220;
        Sun, 21 Feb 2021 06:05:01 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id e1sm11511838pjm.12.2021.02.21.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 06:05:00 -0800 (PST)
Date:   Sun, 21 Feb 2021 19:34:57 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: media/atomisp: don't compile unused code
Message-ID: <90eb63796a8f8aca988efb33247ea01f4a860074.1613915981.git.mail@karthek.com>
References: <cover.1613915981.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613915981.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently the functions defined in ibuf_ctrl_rmgr.c file are only
used by isys_init.c when CONFIG_VIDEO_ATOMISP_ISP2401 is selected
so dont't compile it when not needed, also fixes some sparse warnings

Signed-off-by: karthik alapati <mail@karthek.com>
---
 drivers/staging/media/atomisp/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/Makefile b/drivers/staging/media/atomisp/Makefile
index 1dfad0dd0..51498b2e8 100644
--- a/drivers/staging/media/atomisp/Makefile
+++ b/drivers/staging/media/atomisp/Makefile
@@ -126,7 +126,6 @@ atomisp-objs += \
 	pci/runtime/inputfifo/src/inputfifo.o \
 	pci/runtime/isp_param/src/isp_param.o \
 	pci/runtime/isys/src/csi_rx_rmgr.o \
-	pci/runtime/isys/src/ibuf_ctrl_rmgr.o \
 	pci/runtime/isys/src/isys_dma_rmgr.o \
 	pci/runtime/isys/src/isys_init.o \
 	pci/runtime/isys/src/isys_stream2mmio_rmgr.o \
@@ -323,7 +322,9 @@ DEFINES := -DHRT_HW -DHRT_ISP_CSS_CUSTOM_HOST -DHRT_USE_VIR_ADDRS -D__HOST__
 #DEFINES += -DUSE_KMEM_CACHE
 
 ifeq ($(CONFIG_VIDEO_ATOMISP_ISP2401),y)
-atomisp-objs += $(obj-cht)
+atomisp-objs += \
+	$(obj-cht) \
+	pci/runtime/isys/src/ibuf_ctrl_rmgr.o
 DEFINES += -DISP2401 -DISP2401_NEW_INPUT_SYSTEM -DSYSTEM_hive_isp_css_2401_system
 else
 atomisp-objs += $(obj-byt)
-- 
2.30.1

