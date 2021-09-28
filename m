Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE86341AEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhI1MZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhI1MZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:25:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:23:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so2673269pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4GeZ/5gk5iC0Am0p5VWsBHcc/TF1iKy05S6f2LF/3lk=;
        b=Qi70LZqc9eZo81OU15I3zbLToEhnqCU/ZzYn3ocgSkEtpAd2KZ0FcM021XOaiwbMxE
         jr/hWM/DvkdOD6K3lDfxi4s3NbomrFybjalsq0aMwSPa1NVUKofO4Hwunp9samcjguqt
         VK9KudzoqITsQTZ1FhxEMC6FhjOKd5eL0dd2eChuYLXtWwl4kT7KrKwgdyjlmgHidi4N
         9CQL7MFsmGVkLnHRAqfUO2g57iCZlZlvSnVBoCFUwdXBSov85VK+i6DbUipPbY/ybPX8
         XyHQxef7c03no+HSUTweOPg/5Mr0IL5Bm++hc0LzRcrEUAlzTO7l9CArhsyaJ1c4wOzr
         OXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4GeZ/5gk5iC0Am0p5VWsBHcc/TF1iKy05S6f2LF/3lk=;
        b=Mh+tBZxPCjNxdgdbUg4U0WPNlM0qH9w9dQ1H6rsLWA/wWn0K2NEPFf7OaJkxnYlk3t
         Vr3kPQK8GfOav0MLJ6pyYAghWtAW/GGc7c/T96M0vAARcM2vzJ4A2XBBpZcOZ7cCCzDR
         LuAsCabIxgA/YFtzlP9ohfF8GiVEo19Z4niePG25xaNHI+6IobSS1TPV9VxRcscJOnRY
         UsPAZD9W8gLU/91v/TRq6zp4MlYwtc78qbDgmvYl3aGO6xwxyU0xJEA+9J3BgPhiTmxZ
         FV3JhZMknc1mFcfNe/WD+a6Ul3lv7vm4L1eOEwuWktZkycYuYq0owXxTTcuzBfmudq5u
         e1uQ==
X-Gm-Message-State: AOAM5336rdbuueUuHeJ/cw9E+XyK5iVKx008jR1h5rW6Ieudw0cHsvUo
        dhaJyyETdp4VLVPf2JIAYN8=
X-Google-Smtp-Source: ABdhPJzS5wspBeT9oC9SmWiBIy1yKl+3CWyU7OrYZkOXgu6I7R88L8eFhORPmuw24fJDQhTS6VzHdg==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr5169225pju.231.1632831824876;
        Tue, 28 Sep 2021 05:23:44 -0700 (PDT)
Received: from bj10083pcu01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z85sm8874518pfc.162.2021.09.28.05.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:23:44 -0700 (PDT)
From:   Liangcai Fan <liangcaifan19@gmail.com>
To:     liangcai.fan@unisoc.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        zhang.lyra@gmail.com, Liangcai Fan <liangcaifan19@gmail.com>
Subject: [PATCH] mm: Set min_free_kbytes with user_min_free_kbytes when user_min_free_kbytes is preferred
Date:   Tue, 28 Sep 2021 20:23:17 +0800
Message-Id: <1632831797-32192-1-git-send-email-liangcaifan19@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'min_free_kbytes' and 'user_min_free_kbytes' maybe inconsistent
after a few times of memory hotplug.
When 'new_min_free_kbytes' is not larger than 'user_min_free_kbytes',
set 'min_free_kbytes' with 'user_min_free_kbytes' rather than leave
it as the 'new_min_free_kbytes' calculated for the last time.

Signed-off-by: Liangcai Fan <liangcaifan19@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..ddf9dc1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8467,6 +8467,12 @@ int __meminit init_per_zone_wmark_min(void)
 		if (min_free_kbytes > 262144)
 			min_free_kbytes = 262144;
 	} else {
+		/*
+		 * Set 'min_free_kbytes' with 'user_min_free_kbytes' rather than
+		 * leave it as the 'new_min_free_kbytes' calculated for the last
+		 * time.
+		 */
+		min_free_kbytes = user_min_free_kbytes;
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
 	}
-- 
1.9.1

