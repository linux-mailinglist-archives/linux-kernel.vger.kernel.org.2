Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1C3BA669
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGCAWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 20:22:50 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53036 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGCAWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 20:22:46 -0400
Received: by mail-pj1-f43.google.com with SMTP id kt19so7566161pjb.2;
        Fri, 02 Jul 2021 17:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3OXQEaetOdJQLzJx+iDsq3WrFahatkljOoGHuQVfBQ=;
        b=cDetE1Xkaj0XzfCCspAqzLPKnVR2D47mqtDApoD4Nwb/ZlWG9IH2P9SlLiFF7/TpuN
         2MHYHRSAc2/GZd0BD1Ni1aBbbErmEmJXfNcvmkmeGQ2yf5C9hKle+nx9QoIG827t7MXN
         NnQHLdw8wqjh+qrj+Es7Eyzp1H1m7cNxZA1f//W05t3bvDYRmHUvEdisYDClwUapnCZ0
         EQwLVau4CPIt/n0iQeFIP5ID6vQIMXaPIH+yN3dhf4VUtkpV2BocGvmpht4qwwXDLWak
         7Np5cChGTuPyIMtcfecffTAgWRIbAba+ZNBQUrffg72y1dE7l5TM3QZvaq+bo1LnCuJX
         gdhQ==
X-Gm-Message-State: AOAM533S5iv0Lm+L5N7kkogrltdgC4LPZbLDE/kdDB/uSMmm5lO/cSKX
        t7xVyfaGMrlXEMxYjh6/fWg=
X-Google-Smtp-Source: ABdhPJwPsFpixzje0s2OC+DwGRGE1Hbs6H+K6FI2g/cVOqacjVGW2UIym7Aegj/FVFIIQBSCasKXTg==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr2072304pjv.223.1625271612031;
        Fri, 02 Jul 2021 17:20:12 -0700 (PDT)
Received: from localhost ([191.96.121.144])
        by smtp.gmail.com with ESMTPSA id 1sm5017898pfo.92.2021.07.02.17.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 17:20:11 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, minchan@kernel.org,
        gregkh@linuxfoundation.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org
Cc:     mcgrof@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] zram: use ATTRIBUTE_GROUPS
Date:   Fri,  2 Jul 2021 17:19:58 -0700
Message-Id: <20210703001958.620899-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210703001958.620899-1-mcgrof@kernel.org>
References: <20210703001958.620899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove boilerplate code and use ATTRIBUTE_GROUPS() to
simplify the code further. This produces no functional changes
other than reducing the size of the group name variable.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 205cf9287d0c..56be6817c5b2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1902,14 +1902,7 @@ static struct attribute *zram_disk_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group zram_disk_attr_group = {
-	.attrs = zram_disk_attrs,
-};
-
-static const struct attribute_group *zram_disk_attr_groups[] = {
-	&zram_disk_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(zram_disk);
 
 /*
  * Allocate and initialize new zram device. the function returns
@@ -1981,7 +1974,7 @@ static int zram_add(void)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
-	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+	device_add_disk(NULL, zram->disk, zram_disk_groups);
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
-- 
2.27.0

