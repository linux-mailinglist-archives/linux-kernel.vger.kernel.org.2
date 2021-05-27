Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F044C393657
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhE0Tfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhE0Tfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:35:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE55C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1064685pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwB7nCaEvIIOewgKmkB3o7VgPeoqPkNeUfYkHvV4NzM=;
        b=PCjejpsoD0Dv5/kqrNmhhTXISFG6E7MA7Aj+SezPKn47fRET4r76Fl2WMU4IDiTV+Z
         FHCRAd3I25oluZr2hpZJFk2GL9/lhefTM6Lmr4wbbqdp7ZOaUIQpxEbOVJEfFPUfHy4n
         EaHckE5PlawZXHWf6gpbwL/q9HIJrENoCpDwgmoFB/KmpsujJQvHzsfUWB/D6kZw0+Lm
         6xTu6sVzclAhhbwT8vfTO99Gg9SkpNDWkCdIJ7n5RsXjJBhbAbS47XVg5SVKquE8Yl/j
         /lXgrsBlecadBj/KdSIHqCPAThdHAjkMF2E5ToKpGmNRLrXkuHftLDRJ4aIDRsXqSTi3
         nAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwB7nCaEvIIOewgKmkB3o7VgPeoqPkNeUfYkHvV4NzM=;
        b=CYt6xGPkAMkNYn3hRdRwk3tqQ3bzBXONp+aP13xVnKytf3hCysju1MtqtW/FzfoYbB
         oFGzTS7pr1SWEemgcWQZYxg9McckCCqDyEu3bTS+s/sCN0wF7c1ec26s+JiPu3P1txHK
         I9omSXjjc5ytQo7GHan16p/IO1UozQkLtG9KiDhvebFXCljKj40AgmNQN3oJQgo1VrKH
         RFv0ph5VfDc4HYrsycGCedkgyVfbadY58Zuuy+oV0JWtPiXYtYzODqRZ0UnD/AAx8Ra4
         ebtDmbzhcHo8z8rnUlmOlQsm/fBQGKUBVqKNq96d/JXBD4yKJWWtGe2ZqtcioTZ1TMQP
         BRrQ==
X-Gm-Message-State: AOAM531ou1AfYFcXSAIdnDviaUx+66urOMPNVwNv6LyVrNteorIHhBjb
        ZeVatPQp23G04UXSHVxmLXfEF0rB61uENXOb
X-Google-Smtp-Source: ABdhPJzndpkI2ywo029rBeGofbzSEZi80YCWqbf2fJVwsXMtM7eZuwu2J5iBeiucGHu2yCwBzo+eVg==
X-Received: by 2002:a17:90a:fa91:: with SMTP id cu17mr25153pjb.178.1622144049735;
        Thu, 27 May 2021 12:34:09 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2381:b5a9:2c37:cdf5:a1b0:c566])
        by smtp.gmail.com with ESMTPSA id w123sm2475357pfb.109.2021.05.27.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:34:09 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH V3 2/2] char: pcmcia: cm4040_cs: Fix failure handling
Date:   Fri, 28 May 2021 01:03:51 +0530
Message-Id: <20210527193351.638-2-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210527193351.638-1-nizamhaider786@gmail.com>
References: <20210527193351.638-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Handled failure cases of device_create()

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V2 -> V3: Added label and moved the cleanup code
V1 -> V2: Added description and changelog
---
 drivers/char/pcmcia/cm4040_cs.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index d5e43606339c..81cc48403eb8 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -558,6 +558,7 @@ static void reader_release(struct pcmcia_device *link)
 static int reader_probe(struct pcmcia_device *link)
 {
 	struct reader_dev *dev;
+	struct device *dev_ret;
 	int i, ret;
 
 	for (i = 0; i < CM_MAX_DEV; i++) {
@@ -587,15 +588,22 @@ static int reader_probe(struct pcmcia_device *link)
 	timer_setup(&dev->poll_timer, cm4040_do_poll, 0);
 
 	ret = reader_config(link, i);
-	if (ret) {
-		dev_table[i] = NULL;
-		kfree(dev);
-		return ret;
-	}
-
-	device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
+	if (ret)
+		goto err_reader_config;
 
+	dev_ret = device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n", i);
+		goto err_device_create;
+	}
 	return 0;
+
+err_device_create:
+	reader_release(link);
+err_reader_config:
+	dev_table[i] = NULL;
+	kfree(dev);
+	return -ENODEV;
 }
 
 static void reader_detach(struct pcmcia_device *link)
-- 
2.17.1

