Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC738DC9A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEWTc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhEWTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:32:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79538C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 12:30:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q25so1014836pfn.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Kf/UF+Vd+0KuEACgK2hPCdgTDiko1STgJdhti6izwc=;
        b=OrhmbUYMsjqtDzx0DuSZMmUqn3OiB1q1BTn2yLn3hsEG1tdG3kLiwDYzR5tKfwnrM2
         9nFWhmYisPYoe8CrpquInGo4OOsCeLK9Jdl3sFYgN1jEh1qhNxsDZ3tkxMG2+1zMMZnF
         LEoRDxk+rIMFM1f8AgSPJtVLz5A+rqy5OUG72KyLo9JOMQGjUui/WeAZE9QhOyxfD0Ee
         GkVS/QHZV479EjxPYyyDEroEwEN8WSPmfxDJT5FhiknW+T+TTcsR8oEJD840VGz8H2Pz
         +JNo0s2UXGPPjz3bXBSodxZ0Wh47KPloYdJalqLmwe0gLYGJp+USFJrAcYXTmlvOXpde
         KM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Kf/UF+Vd+0KuEACgK2hPCdgTDiko1STgJdhti6izwc=;
        b=PHWWFKe11KyhdGm+qzV+6ENSrUx2C6uAgLZhsNYry5wGEEOZ7bchf+Svl+xvpEGp1j
         GuTHi5yULdmQ5Vgq04Eclz1YaubTS+1ML/eO+GXvYQ8cIt1UmgRZqoQ/zyrk3o6oMjD+
         /u5V2wLY9xf01RdYVyRWpTckN6A0/pG2lMuSq85RDX1kGIhekisuoRJ+LQD2xwSsdBW1
         2uKn3LXi0R5TIX+Khz/OxG53jTyVjGd1JR9vgPE79A3HrMBasPvJlfFAPmUETweoEhM/
         KV5Y4CvzR6daV1+98s7hvlL4QOF4ahDwr6GtGNv+qM8G/3olU2s7T+5hkVRhPZHwKHWs
         NxIA==
X-Gm-Message-State: AOAM531dHe8/D1Fo1Wfu6+px7BWHcxknjtA4Witjo0amh71YnXmKojCi
        igIkmOZInosSZSqR2pU+UhE=
X-Google-Smtp-Source: ABdhPJy3JpMftqHeL6twhKgxLM/avpeljxlHjSCwXwRnV7F9H+U6wdMwIVW69DYPuXHi6IMP2bxpPQ==
X-Received: by 2002:a65:464b:: with SMTP id k11mr9860921pgr.407.1621798258907;
        Sun, 23 May 2021 12:30:58 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:4c18:f4c7:dc37:2dd:3064:28d9])
        by smtp.gmail.com with ESMTPSA id ci2sm8427370pjb.56.2021.05.23.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 12:30:58 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH 2/2] char: pcmcia: cm4040_cs: Fix failure handling Handled failure cases of device_create()
Date:   Mon, 24 May 2021 01:00:29 +0530
Message-Id: <20210523193029.3178-2-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210523193029.3178-1-nizamhaider786@gmail.com>
References: <20210523193029.3178-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
 drivers/char/pcmcia/cm4040_cs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index d5e4360..30bb977 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -558,6 +558,7 @@ static void reader_release(struct pcmcia_device *link)
 static int reader_probe(struct pcmcia_device *link)
 {
 	struct reader_dev *dev;
+	struct device *dev_ret;
 	int i, ret;
 
 	for (i = 0; i < CM_MAX_DEV; i++) {
@@ -593,8 +594,15 @@ static int reader_probe(struct pcmcia_device *link)
 		return ret;
 	}
 
-	device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
-
+	dev_ret = device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
+        if (IS_ERR(dev_ret)) {
+                printk(KERN_ERR "device_create failed for %d\n",
+                               i);
+                reader_release(link);
+                dev_table[i] = NULL;
+                kfree(dev);
+                return -ENODEV;
+        }
 	return 0;
 }
 
-- 
2.7.4

