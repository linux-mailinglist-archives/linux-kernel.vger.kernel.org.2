Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32533F9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhCQUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhCQUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:21:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB93C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:21:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x184so1924786pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gDAq4DE4PBvBHlZJ3CaMSbFvBl5PB60V3/mTqquUBA0=;
        b=nqNnsd9QjmZAEesBQrZiDjMyz3oLxxXJxKtkKMe8GT3X2N6dFYpbXOzZSISq+SZbFu
         tSC9Z6PDiZMWE/xGc/MwC8vtjq+rRJm8icXpKQHAnrxx7MO1URm+sTtT/fv/wuirgPG4
         GV6TlokkfSmrLjle/XO9RMiamLMB8xLeizvigigoN/TwoKTpTDwobhY9luHgQko3A3Ve
         tK6u3Shsmz9IzoedC5GoT3gz4mrhoeeBJuQkGnv3fJsFqIsgXxjMspnhULe29+lIOI0E
         kfAW6p39MN1Q4MTYcF1hNL/JC8f0tfGrPYjEMzwZu+xmKmGXDpwXe5zwIQsIjGTZMzTS
         f7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gDAq4DE4PBvBHlZJ3CaMSbFvBl5PB60V3/mTqquUBA0=;
        b=BUYpR1DcrqGjafxSFGtmOMH3whGWDqfdV+++oisvH1x+vHWGx09Zc161OdSlmikRMi
         iOdc1suHP9U6Qgc23B211KbnnA6y37nNJ7QhrIM1YpiytXYZPQuJm8KytxI/UwfQOlHV
         sKM4sWeWKYTSHhr4MRpNT62+NXqLk1wKGlbs57123LVfqZQ7MswQiKMmRlrl/Gb/w/as
         b3uF6GRvwN1BjPBYkN4tynRNO22ab+LtrusfkLoFnDUV5YCFtOQNDqxGf2wH4GcJazzy
         f78qLpUqYchWtyn+IiiRtoy107TMuiK5WKe3M9aeMlxbi5nzKX8Tpt/gdx1BhMeb8LJH
         txyA==
X-Gm-Message-State: AOAM532RUsgWjyVqazJE2gOQ4R2BEB4d+2JT2vuMb9ZKTDSSCJUqVkdg
        pIygIRkcL+xp564khGHoAvo=
X-Google-Smtp-Source: ABdhPJw//WXqfEPZhDC07hr0kMIG47o3Qo6OU6JBopYEdvbfgnNCCWuUDtw9QnzuRULP02XBC5CIKQ==
X-Received: by 2002:aa7:9605:0:b029:20e:b183:fc89 with SMTP id q5-20020aa796050000b029020eb183fc89mr695965pfg.70.1616012514025;
        Wed, 17 Mar 2021 13:21:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:85d1:b0af:d6ff:42d8])
        by smtp.googlemail.com with ESMTPSA id e1sm8555pjt.10.2021.03.17.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:21:53 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: asihpi: fix comment syntax in file headers
Date:   Thu, 18 Mar 2021 01:51:44 +0530
Message-Id: <20210317202144.20290-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are files in sound/pci/asihpi which follow this syntax in their file
headers, i.e. start with '/**' like comments, which causes unexpected
warnings from kernel-doc.

E.g., running scripts/kernel-doc -none on sound/pci/asihpi/hpidspcd.h
causes this warning:
"warning: Cannot understand
 on line 4 - I thought it was a doc line"

Provide a simple fix by replacing the kernel-doc like comment syntax with
general format, i.e. "/*", to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 sound/pci/asihpi/hpicmn.h   | 2 +-
 sound/pci/asihpi/hpidspcd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
index de3bedd29d94..8ec656cf8848 100644
--- a/sound/pci/asihpi/hpicmn.h
+++ b/sound/pci/asihpi/hpicmn.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
 
     AudioScience HPI driver
     Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
index a01e8c6092bd..9f1468ed7096 100644
--- a/sound/pci/asihpi/hpidspcd.h
+++ b/sound/pci/asihpi/hpidspcd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /***********************************************************************/
-/**
+/*
 
     AudioScience HPI driver
     Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
-- 
2.17.1

