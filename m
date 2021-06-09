Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CF3A1585
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhFINZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236208AbhFINZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623245009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=gXU8yA2yvF+nwtWA8QsfPrOB6Pdkm7WfzhoTkZ31qFrGvlHwgbuy9v5EWD2LSjMEKsqvj5
        LpJ1N49kiAuyWJKLqu9hRjOdwHT9dMuLHFr9wFcys7KxXn+B6v49y5qaz8W4nHDImiyaIV
        gAIRif9BVbGLbCgtobaVm6hNicNt2e8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-elPpMLKwPT-Pfofudctoqg-1; Wed, 09 Jun 2021 09:23:27 -0400
X-MC-Unique: elPpMLKwPT-Pfofudctoqg-1
Received: by mail-oo1-f70.google.com with SMTP id b3-20020a4ab4830000b029020d5d68e38dso15505294ooo.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=hj+pP02PN1W5rquc3XBA2Sm7Dl7BpvGyAqokbLjV4m60qDnVUrmZBikHmxpqvg29vQ
         0i03fGEyf+7FCoFg75YbLtbgZg2CYVoxccqrcLFFyjKGQkdgFD0kBm0FqNH+pdff5ujp
         nqae0ATeeSgpWtI+sVuiyVpJ00k9b8Wtzc7QbhYNp66JRAvBcCjnl84SjaLv812W8S+l
         zq9Fr+7Xacmpz1Je0kSJQK24+Pn+eMYugaH67gRhJ5m7UhoiASCtf3sovXb6rxB90DqS
         AHOpaK14zslp+8ZJV2IBK9VXTWauVSxjomaJyEJohpqPwksSPQJOw7g6Et1rBbO9IJoY
         8P2A==
X-Gm-Message-State: AOAM533IkSnBzZJ/KRwkIsL6eq1TkQd0slaWJYs1JfVltjcotxYtrY5v
        yJWVbUJBJzhgLPNzgpR3TeKiXknbjTFw2oEnmnPKQYQqspkgUcJEKOnNlX3q+r6n2LwadbQY1mQ
        vzfPrhx0ulMBeo+tU278Lss1/
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr3492359otm.217.1623245006772;
        Wed, 09 Jun 2021 06:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYlq5NQAg9r5rM56eciALlRRoXOllzEovCjy257M0FuEL28u377Zg2s+BEXW70oM5w182g1Q==
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr3492350otm.217.1623245006642;
        Wed, 09 Jun 2021 06:23:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm3165654otd.21.2021.06.09.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:23:26 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 6/7] fpga: xilinx: remove xilinx- prefix on files
Date:   Wed,  9 Jun 2021 06:21:50 -0700
Message-Id: <20210609132151.3081379-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210609132151.3081379-1-trix@redhat.com>
References: <20210609132151.3081379-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

It is not necessary to have a xilinx- prefix on a file
when the file is in a xilinx/ subdir.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xilinx/Makefile                                  | 4 ++--
 drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} | 0
 drivers/fpga/xilinx/{xilinx-spi.c => spi.c}                   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} (100%)
 rename drivers/fpga/xilinx/{xilinx-spi.c => spi.c} (100%)

diff --git a/drivers/fpga/xilinx/Makefile b/drivers/fpga/xilinx/Makefile
index 7bb7543412790..4ac727d03e140 100644
--- a/drivers/fpga/xilinx/Makefile
+++ b/drivers/fpga/xilinx/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
-obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
+obj-$(CONFIG_XILINX_PR_DECOUPLER) += pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA) += zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA) += zynqmp-fpga.o
 
diff --git a/drivers/fpga/xilinx/xilinx-pr-decoupler.c b/drivers/fpga/xilinx/pr-decoupler.c
similarity index 100%
rename from drivers/fpga/xilinx/xilinx-pr-decoupler.c
rename to drivers/fpga/xilinx/pr-decoupler.c
diff --git a/drivers/fpga/xilinx/xilinx-spi.c b/drivers/fpga/xilinx/spi.c
similarity index 100%
rename from drivers/fpga/xilinx/xilinx-spi.c
rename to drivers/fpga/xilinx/spi.c
-- 
2.26.3

