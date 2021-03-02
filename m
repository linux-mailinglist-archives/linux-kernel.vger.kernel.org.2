Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EA32A146
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576919AbhCBFef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhCBDj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:39:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:39:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z7so11214052plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqISnWngL+yQot4HH6Rw8UIVFO0OHNLi2++GZbUw8x0=;
        b=aMghwdOS3Go0j4qpk4OnvKE5BOndXBfRD0V41XsskYioATt09VpvPPcks+FdVK16pk
         KulRMIOMb/yCU9Jdd+P3JBF9jabJpgt6qm7NOkdPpvQMO8nTbd1oJU06Qtz2VIODwfbj
         TZ0X5IPFz4OYA4zzpBwJnjV2cv3BeOLuSwJlQWDa0SW8LQggyDmrghtSGWkfc14gJ3UA
         DYvLWFUcA+keAzvaZaUx9qt50MtEYPlUg10MgxqmPPbSHbb9mJcQFuC91hjYjPH5a9MO
         AjJjeHkuGw9GR+24wbPO3PEgnJ+l7weFF0xn38OwIutgH1JxuREPY4VyWkkjwziZ1YH0
         io8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqISnWngL+yQot4HH6Rw8UIVFO0OHNLi2++GZbUw8x0=;
        b=GDD34qXuajn/78srN4JXuhRLDIBJKJP2AkJzjszbD6wmWXH0zjn6mDcR8zdrmEWq76
         Bz66C5kT3fgy9TpD7fKGviPr7NzaG3NAbuM7lp88Mpvjc95dSHAgBze6LU17lPlvgGEp
         Ki/+WPbTNoQZ/D5VF+TLAhxrin7F7nURp2W758SgoXoT94fppod7s9sSHyyrZVS+XOW1
         r2QkcWDs1s8hwTHlQuer6DQNlwKkGobXX3c+XL08IpAds/YDl1Rqbv26HJC+LvhTN0Av
         jYxklmcwB2owKBpcWe/ekFRr+94l+HS4kWex+WP7DIE3gpxLwbcXYe2Qao0WwYHSYF8k
         A0tQ==
X-Gm-Message-State: AOAM532oPlIATq+48645zheT0TzDkS6Nw726FWWx4Y8e6FnGCWm3SH48
        6jnMRmvG9i7HaFTO+hRaE7c=
X-Google-Smtp-Source: ABdhPJxyBAbKjQr0x2APdr0DOIyqRnTN9IgEeNa2mU5134gItPqpC4gYjWU3BtzHgAd+hAuEQbmZOQ==
X-Received: by 2002:a17:902:e8d4:b029:e4:a950:c832 with SMTP id v20-20020a170902e8d4b02900e4a950c832mr1747714plg.3.1614656356447;
        Mon, 01 Mar 2021 19:39:16 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id c30sm1556589pgn.88.2021.03.01.19.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 19:39:16 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] include/linux/slab.h: use for() and left shift to calculate
Date:   Tue,  2 Mar 2021 11:39:08 +0800
Message-Id: <20210302033908.51706-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use for() and left shift to calculate the value that compared with size.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 include/linux/slab.h | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7ae604076767..0411f57930fb 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -347,6 +347,8 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
+	int i;
+
 	if (!size)
 		return 0;
 
@@ -357,30 +359,12 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 		return 1;
 	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
 		return 2;
-	if (size <=          8) return 3;
-	if (size <=         16) return 4;
-	if (size <=         32) return 5;
-	if (size <=         64) return 6;
-	if (size <=        128) return 7;
-	if (size <=        256) return 8;
-	if (size <=        512) return 9;
-	if (size <=       1024) return 10;
-	if (size <=   2 * 1024) return 11;
-	if (size <=   4 * 1024) return 12;
-	if (size <=   8 * 1024) return 13;
-	if (size <=  16 * 1024) return 14;
-	if (size <=  32 * 1024) return 15;
-	if (size <=  64 * 1024) return 16;
-	if (size <= 128 * 1024) return 17;
-	if (size <= 256 * 1024) return 18;
-	if (size <= 512 * 1024) return 19;
-	if (size <= 1024 * 1024) return 20;
-	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
+
+	/* The maximum of size is 2^26 = 64 * 1024 * 1024 */
+	for (i = 3; i <= 26; i++) {
+		if (size <= (1 << i))
+			return i;
+	}
 	BUG();
 
 	/* Will never be reached. Needed because the compiler may complain */
-- 
2.29.0

