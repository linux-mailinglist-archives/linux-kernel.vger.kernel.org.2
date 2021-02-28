Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17B32737A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 18:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhB1RC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 12:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhB1RCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 12:02:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64980C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:02:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so1095768edw.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JAtBldu6u1Mq/RF+u4hJlOZdKxrntXnSqw/WFID6vy8=;
        b=SQUmLrVT18kMC0VUjTmrOxFjGec4EQw8ZpMJn8QPH4CIsyipvDj0Yzr9JFIDQzZGND
         0e2FCh5hiNT9mlc6mosNbL8MWltCbPkTrGtaZCB1t6+wv5mrwNfng9hnWbppL+21+eig
         a6xCLSmXuaOUuP47kv/dMpfyX05UkaSeWiVceE+2RjXuD44ouYs2NQwdSFtZ67fL1Y3c
         fEyGHQHL4wyDXoRL6qrOTTZ3uf7uism7sEwhx7pg2m1so61CsKDMVbp7L+G3IKMbwMNb
         AW2jb+jsRX2Effj1DZkdMczeyz7NPdjV2zd3/G/XvGQkAGYgoD+Q8ZZQtnUAl08IlgGM
         O6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JAtBldu6u1Mq/RF+u4hJlOZdKxrntXnSqw/WFID6vy8=;
        b=hTj4pkXx+qPubf4+iqCCfFeXu9FJq7tPeAKnlGas/sFQYwq52qA3/NyXGLh/Kz8pFQ
         3l0v94fS0aKywiRdiUBdCqduHI7Re9OJZ0IZOZ8CLpM/k4h+d/fQEPrEJr/fo4AolZYy
         AgnB9iYYPbnocAutGxZk+b/YdTLjWUOiiovleV+dkZxumCZT32kYQypMWijgReH0vjye
         aj6hGTdwTtYD8Mp57XxpZ9+y0Lm59eN1qleHWqnPdaEXtDBMRPK7s7xI1cRXHUmgtNxC
         lD3H3KUlVq+NMWm8uX7xNt4tO3o9QREZ3VU9gqvc8j0UYG2MNu1LGKqoAgTEYODUuava
         CZKQ==
X-Gm-Message-State: AOAM531fN5OmOoG5zW4t6obdw9m9Gy5A9ocm7XdVprB5Kw/nZ5BKzDjI
        14BgEqjhvfi4CpWyoYxZtg==
X-Google-Smtp-Source: ABdhPJx8cyinb7GB4O5sxDK2csaSW0m7DnBDocVKXu5V3fIsyw4O7d8xLp/kN1CezEdAz5U7kLepRw==
X-Received: by 2002:a05:6402:438e:: with SMTP id o14mr12588862edc.215.1614531732243;
        Sun, 28 Feb 2021 09:02:12 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id e4sm10725779ejz.4.2021.02.28.09.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 09:02:11 -0800 (PST)
Date:   Sun, 28 Feb 2021 20:02:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mirq-linux@rere.qmqm.pl
Subject: [PATCH 06/11] pragma once: convert include/linux/cb710.h
Message-ID: <YDvMkmgEjkDD08pC@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 1c4107e55b322dada46879837d4d64841bc5f150 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 16:56:54 +0300
Subject: [PATCH 06/11] pragma once: convert include/linux/cb710.h

This file is concatenation of two files with two include guards.
Convert it manually.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/cb710.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/cb710.h b/include/linux/cb710.h
index 405657a9a0d5..f3055e9442db 100644
--- a/include/linux/cb710.h
+++ b/include/linux/cb710.h
@@ -1,12 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+#pragma once
 /*
  *  cb710/cb710.h
  *
  *  Copyright by Michał Mirosław, 2008-2009
  */
-#ifndef LINUX_CB710_DRIVER_H
-#define LINUX_CB710_DRIVER_H
-
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
@@ -121,15 +119,11 @@ void cb710_dump_regs(struct cb710_chip *chip, unsigned dump);
 #define CB710_DUMP_ACCESS_ALL	0x700
 #define CB710_DUMP_ACCESS_MASK	0x700
 
-#endif /* LINUX_CB710_DRIVER_H */
 /*
  *  cb710/sgbuf2.h
  *
  *  Copyright by Michał Mirosław, 2008-2009
  */
-#ifndef LINUX_CB710_SG_H
-#define LINUX_CB710_SG_H
-
 #include <linux/highmem.h>
 #include <linux/scatterlist.h>
 
@@ -197,5 +191,3 @@ static inline void cb710_sg_dwiter_read_to_io(struct sg_mapping_iter *miter,
 	while (count-- > 0)
 		iowrite32(cb710_sg_dwiter_read_next_block(miter), port);
 }
-
-#endif /* LINUX_CB710_SG_H */
-- 
2.29.2

