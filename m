Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D184738DB91
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhEWPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEWPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 11:12:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65EC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 08:11:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v12so13340572plo.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIc55do0bccAKFgTyg84IMBPiYaFgDUKTJbsB02B1Cc=;
        b=e/tkWYOG+JtPJeKxj9C/lKdIWPjbzo0AcEJ0FsRYy+dM9//rP9qAnUqj4QxMxU6OJN
         xf4BQu2mlSq61OBdMRTU8NlEXuG6Z2eUl//qcK14D+SuYMiiM8Nv1V+cWdAVfH7UwMWq
         Sf5C0DctNCIO8uy1+P5sWJwc9aa4QW8C11Jmu3XqnUHciMvK8YDbHwq6l7uDgZB4HwRd
         n7bLY6VjZOLt7QMGweOYPBap/qZyVjGJlvBlWRBuAlCylyEpanwuetrMgdk2/Sno6cNt
         XTJDj3TV6+dLHbcCIZHurXh8B1m0Lt+1y2ZeOpxoPlm5q9NZ5I99/NvOB7r6aehTjW9g
         nU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIc55do0bccAKFgTyg84IMBPiYaFgDUKTJbsB02B1Cc=;
        b=RogQ0jIrT2jZfiTjLXOAXeaMkBsc1bWNqwU+YnxODiXAD85VH8+QOXfh6UR2JWEOPi
         d7ulx6BvCvAPeBA/UVNoml2otCrrDVOlWO/FAIkGUpZwPsCv6WoNOaCpyaMhno+eyryT
         63I8NhJCG5v4JIG/5S/qXVcmIaWDYjjGQ4hg/1hwmgHc0AuUGVNC/Teur0VAKAq6J41E
         Yw4TlqjHPIaj6La1gFB+J7rsC8+1IpzJIog3rZKCRx/etAPOqdL5CFj+bLG4nNE/s5S2
         ri5JPHr2U2Wrj1cJEp5HEUjeXVGXb7C2/7heQqUUIqo3uuU5lTRQRZk+fRImyuuRvrXn
         Dfqw==
X-Gm-Message-State: AOAM530EmPq4P/zp3Zz1+APUJaMjsy3Q0ZYdp/70+IH7YX+MgReLReTA
        NkTl5VMEWO0kXDSaODsljs8=
X-Google-Smtp-Source: ABdhPJwDJs99WRmyD7q8YsDujx4ChqX9x5z3/LSL3D4wJ3+5MO3h5cG4StLbcdzyBIe4Xa/1u8aduQ==
X-Received: by 2002:a17:90b:689:: with SMTP id m9mr20903785pjz.102.1621782689485;
        Sun, 23 May 2021 08:11:29 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:4c18:f4c7:1973:665d:b2b5:b2a3])
        by smtp.gmail.com with ESMTPSA id 5sm8341219pfe.32.2021.05.23.08.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 08:11:29 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     lkundrak@v3.sk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH 2/2] char: pcmcia: scr24x_cs: Fix redundant fops Removed redundant fops assignment, which was already done in cdev_init()
Date:   Sun, 23 May 2021 20:41:11 +0530
Message-Id: <20210523151111.2968-2-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210523151111.2968-1-nizamhaider786@gmail.com>
References: <20210523151111.2968-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
 drivers/char/pcmcia/scr24x_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index cad1990..0265d72 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -266,7 +266,6 @@ static int scr24x_probe(struct pcmcia_device *link)
 
 	cdev_init(&dev->c_dev, &scr24x_fops);
 	dev->c_dev.owner = THIS_MODULE;
-	dev->c_dev.ops = &scr24x_fops;
 	ret = cdev_add(&dev->c_dev, MKDEV(MAJOR(scr24x_devt), dev->devno), 1);
 	if (ret < 0)
 		goto err;
-- 
2.7.4

