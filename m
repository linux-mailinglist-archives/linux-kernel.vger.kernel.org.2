Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7A36A5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhDYJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:09:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 02:09:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y1so11715116plg.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KovP6x9LkmwwQOxAnbrKATiZyVoCztzmjmzZtGrFd5s=;
        b=vgRcZ7ZCDZZbHaaMgaYDUTqA8jjKHfEAwxrfg9hlAWGOew5h0i0T/tp4mug3uI3WZq
         fUe0IVzOde8FYWlwhvb/p+/i85ykYaxro9O/AVwJb1ftOy4vTdSeCvdOuGhFLbar9emE
         xeHj6sW6vqKNZ+rKxmYlT50zjS/8tm7C4G8hnKLuo6aic6N8U5WQyqrMNuxE5ZyYCKgs
         Pbdga9PASpuJtDarO92n5taplHW5K2URoUKwZZcHl35BVivkkj53mCQtwD6GnzDIK1Ze
         K5YDClAWUegvKwkRy0Di30bjgboCiSxNBj2CBdCxxhfqPAo94iD/E9rfzPKfvN6aaUD5
         5AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KovP6x9LkmwwQOxAnbrKATiZyVoCztzmjmzZtGrFd5s=;
        b=VwZrrMtKzxsfTKPZnEPhCHsafKYAea1O5RbAgrAzmBrmnOY9U0zX2u88abgyb+dGs9
         wo+9VVEcJZWnvGdpS5sVUbQzFYaOBwuHpgEG/9ZiXYRMaDyhbIv0YB/5AsUx3DA7NYc+
         oUqxHlj2QrFwbHn7BbJvy3cKaA2fQZzQmDALVXydGVh1Mk1McwB38iNIZ20Ep5ALc8Ch
         XRrzFtM5C3z2D+pYtKRkIlxIp/c6PC8neO3EWpFBGCFIOEQkx9YcwEzR/hx9ZDTqNXe5
         hhTKJVxsq+ONaMF6UUxXZyD/5PXaywNMiS0AeaOrJ9D4Mx/Cpv4YsKPq4bhVmDaRxGJO
         aiOA==
X-Gm-Message-State: AOAM531v9DzG7VeLoSqHkFiiKXFhaGcSHefQgFn4y4DJsKTYu5IHtr0E
        sC7AQCG0HvcrFfvjLzCZpeo=
X-Google-Smtp-Source: ABdhPJzbMvkLuAkvHdRAZbxt9JQUIs13Fbmx6xjneebOpXFPjAQYfW+PZCuONofVgGE1MWjPqonF4w==
X-Received: by 2002:a17:902:b705:b029:e6:f027:adf8 with SMTP id d5-20020a170902b705b02900e6f027adf8mr12618646pls.72.1619341741456;
        Sun, 25 Apr 2021 02:09:01 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.82])
        by smtp.gmail.com with ESMTPSA id p10sm8189983pfo.210.2021.04.25.02.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 02:09:01 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mtd: rawnand: marvell: Minor documentation correction
Date:   Sun, 25 Apr 2021 14:38:41 +0530
Message-Id: <1619341721-5580-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->
drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
with '/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

Minor documentation correction.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 79da6b0..e7b48d4 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -451,7 +451,7 @@ struct marvell_nfc_timings {
 };
 
 /**
- * Derives a duration in numbers of clock cycles.
+ * TO_CYCLES*() - Derives a duration in numbers of clock cycles.
  *
  * @ps: Duration in pico-seconds
  * @period_ns:  Clock period in nano-seconds
-- 
1.9.1

