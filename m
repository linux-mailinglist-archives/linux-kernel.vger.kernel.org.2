Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6D39FC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFHQ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhFHQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=BA1uno2BK/K7G+gXEhWWGhirQG/iGj388AmSc7VZfKWgEw8VloyTWuDC7MZfz94+TbrgqW
        /7/dNCJNgcWWFBvrSEHoW+C0n1jAieP58vMjNzAb+9kjYkxiU65U573oRbeEFgKryxR0g5
        xZxBh1zI+WpJYgtN4r2DyWZb/1mHxBs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105--Wjo-PpxMZmrF5iOPoMDQg-1; Tue, 08 Jun 2021 12:25:59 -0400
X-MC-Unique: -Wjo-PpxMZmrF5iOPoMDQg-1
Received: by mail-oi1-f200.google.com with SMTP id o10-20020a0568080bcab02901f44e2256b9so1447281oik.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qViXgyeh1dlyqh22Awn1t3CyyorftxIelVJ9ElQQ5YY=;
        b=sjJIS5Trz3kZNXTKzbE72dgd9w49udTHtQD8UPDgYZAHVjweRIU4SorT2AYc2f/gAB
         jQ5Q5FH7EdrlMa+SyHyY3h/CwfAdJXK6WNhYJZ/YZts0wr9XgefPuV3GTqDhbK1db+Ga
         RXclb0UC2WJwFlfiFdD+KKwH872k4Gw91R1AqFhbQs64bJ05rhudmFqWCQRP2lMY8i6I
         w/V8TGoQPhleYTWB81YFO0/XgjPlKs08PINjHDuPcLDyOoUYLTk2LiLkO0g6LShIPz1h
         IOdE4d+XZ2kmaQFEOaJ3YfrasY/CGIP3LggHXjaFBrVv69yNA17OUrveC7Y9j4snn97X
         l1bw==
X-Gm-Message-State: AOAM5326ipc1M94AYamFuusRgiJ4Jgk0ivhm7ufMuH16c4AmnqOOpN3V
        Z9LyrOUeyji52r+pXo7NQtw/zJOLmrJGszQf3bkvE3YL69zQBRxVfzhFU/ELizlpJyOz9aR7aik
        acpE4QfmGU/snbzAAOW1njbdi
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr3395840oiw.161.1623169558853;
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdkIBlwY+O+Je+hrmiURYYe8KcG1gsS80R38FWHS4/03wkKj44epRlChJ09Yaxd9P5lAXdKw==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr3395828oiw.161.1623169558739;
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b26sm2831550otf.69.2021.06.08.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:25:58 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, michal.simek@xilinx.com, nava.manne@xilinx.com,
        gregkh@linuxfoundation.org, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 6/7] fpga: xilinx: remove xilinx- prefix on files
Date:   Tue,  8 Jun 2021 09:25:51 -0700
Message-Id: <20210608162551.3010533-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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

