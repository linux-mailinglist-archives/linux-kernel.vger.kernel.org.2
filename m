Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F9416E15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbhIXIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbhIXIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:38:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:36:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s11so9161946pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zJn8oIFC9ELM0JQoijzm75QBJICN8Ovtq+B3p7oqTBU=;
        b=Yphwy3ZKqXddFDGpxvile/vh988Cxf76vsWqbKvALDG0+J5JlPw7zALq/0/lXTKg4S
         mY6CR8TFfmWtSKpdCag46aV6Xr33zgTyYrArtl78M+D/jjduPIKcdLxF14oiHUID6BXZ
         Fu7UBHrgdqJZtzWtM9BLI4zNGH3OKwkjNLuUYj5Drn+7WFeorLqHpta9uAI3PeozNn8q
         12uzOOVSjIwjKdva9T10VZVS90jrME/r4+OQ2han+SWQ8RYwexwQ23ohGbPkBuXBUOSg
         Jzky4XfLbCXMg0WBPuP5WQaAhyfFnDH0kOtbqcBlVfv50kHDzjoBjIeOiK3Mm2fONDjw
         i1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJn8oIFC9ELM0JQoijzm75QBJICN8Ovtq+B3p7oqTBU=;
        b=ljyqbXc5GesUmGpxwFUL2zmZyQv1R+fWD/pyzH/vg0dSQ2bfEZhl/ClYo83MamL4rQ
         Tzc/Jn/xv8guhcKHbo1xSf16Jac1kmMehHGydZdmbzM0+krPF6MCN/Gg6/mfX/9MlaWx
         Ft+2Pi+KAheGuByYmnuInlGQnkpJqE7Q82HNC79GYm45TeE5kPP1lCbIWJPAKzf0OYmf
         vy4A2DUUYWdhQRatQWuqBb4fhKPRzZyMbppnA1D20VnkqpIkbUxJ6UczXns3+GgsPtL5
         cVEoJ4Pw/Zl4sxFJwuJCoUPJJLaBJEmVK3tki9aGbT+3YmG570SYQZnvUreWCpvtYYAR
         DLGw==
X-Gm-Message-State: AOAM5336vdOxsi6Qtj/ezwP1txbXzQIDxj7d54bOD4HFFHNZGQ6/zBjm
        2RUBB2N2pKewwS3zCDa1ydetsMe0iPRSKA==
X-Google-Smtp-Source: ABdhPJz5lUFZG8e0UoKI/ETdn1Nu0A9w6MqDapDzGFbn9do7XBw8k8ZGpofv/Thwe8dh16akg68onA==
X-Received: by 2002:a63:cf10:: with SMTP id j16mr2783288pgg.257.1632472590197;
        Fri, 24 Sep 2021 01:36:30 -0700 (PDT)
Received: from bj10083pcu01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 65sm8197024pfu.187.2021.09.24.01.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:36:29 -0700 (PDT)
From:   Liangcai Fan <liangcaifan19@gmail.com>
To:     liangcai.fan@unisoc.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        zhang.lyra@gmail.com, Liangcai Fan <liangcaifan19@gmail.com>
Subject: [PATCH] mm: Show watermark_boost of zone in zoneinfo
Date:   Fri, 24 Sep 2021 16:36:06 +0800
Message-Id: <1632472566-12246-1-git-send-email-liangcaifan19@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

min/low/high_wmark_pages(z) is defined as
(z->_watermark[WMARK_MIN/LOW/HIGH] + z->watermark_boost).
If kswapd is frequently waked up due to the increase of
min/low/high_wmark_pages, printing watermark_boost can quickly locate
whether watermark_boost or _watermark[WMARK_MIN/LOW/HIGH] caused
min/low/high_wmark_pages to increase.

Signed-off-by: Liangcai Fan <liangcaifan19@gmail.com>
---
 mm/page_alloc.c | 2 ++
 mm/vmstat.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c..fe343ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5980,6 +5980,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		printk(KERN_CONT
 			"%s"
 			" free:%lukB"
+			" boost:%lukB"
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
@@ -6000,6 +6001,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			"\n",
 			zone->name,
 			K(zone_page_state(zone, NR_FREE_PAGES)),
+			K(zone->watermark_boost),
 			K(min_wmark_pages(zone)),
 			K(low_wmark_pages(zone)),
 			K(high_wmark_pages(zone)),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620..dbe37ed 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1656,6 +1656,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	}
 	seq_printf(m,
 		   "\n  pages free     %lu"
+		   "\n        boost    %lu"
 		   "\n        min      %lu"
 		   "\n        low      %lu"
 		   "\n        high     %lu"
@@ -1664,6 +1665,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   "\n        managed  %lu"
 		   "\n        cma      %lu",
 		   zone_page_state(zone, NR_FREE_PAGES),
+		   zone->watermark_boost,
 		   min_wmark_pages(zone),
 		   low_wmark_pages(zone),
 		   high_wmark_pages(zone),
-- 
1.9.1

