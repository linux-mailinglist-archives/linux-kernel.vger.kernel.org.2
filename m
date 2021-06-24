Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3973B3523
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhFXSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:03:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0AC061574;
        Thu, 24 Jun 2021 11:01:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s14so4577936pfg.0;
        Thu, 24 Jun 2021 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Kxa6sZKClpIemf8Xwi+xgUNqQi000u7Br5b9L8QPXM=;
        b=NIKFU7m4YSoY+VX+USS4jSFrp9E3oem1ny0oG0ECsadGqTOpmQvHYRLUC0ayLLser0
         L786DqLxZEGuoTZys72tLCN0jJFMt0mJmw8yzWDpPH14F9oBMQBa9pX+I12l3Ljnbtcw
         INPZeGt9s+ZPtpB0aw5jkkWxRLm4VE3AGITej9qzOMHitIsFrdF46jUuk6FHtpZdWP6+
         +7Y5sw/v4agoJUqgmgPlMBmsLfAM/hyYflMmuYp1KpmMEGQ44qqXF6yKsXvCdQAD8fGx
         bAOOyO4gkQ/Y7BX4AmhC7xw/9c8KyZuv3KmaeSsmlU0jCAS5YUZzJ0+dUhDSf3+TcN4S
         Chkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Kxa6sZKClpIemf8Xwi+xgUNqQi000u7Br5b9L8QPXM=;
        b=PTKW1BKTqyARyq8lT0vsC4ibBqUNZSYoFlsMC3ngXJLODWuI1mGwIiiS8oY1q3Qsj1
         M/QXcGcC02q2QNeAPxGfwu3QIKOcH4sKWnefIQ4Iyn/bBTwQt8IUN2Qt5XZJ1HIs9clY
         f1eYptg6BmDl2O9eAM97Lx6mPfJbrb0p7eZGuQhU5/EyJvht0vEECDFz2fyNeRHhSwi+
         seB43youes/FRjcxVTD6naxX6hye5OUe/ymAKHhkUKRFhPfEiaJ4D5t3IAE2A3jsA3YG
         ts0aN9DJhwFyCX6UsqwcyLxWLvnvc1+ODMcBhBStlP4Gc7RFOZgfqc31+NqeWmKOua51
         okHg==
X-Gm-Message-State: AOAM533koySliuRHx9W3eyxVY49oaYsbosVPetSu4UumHDCs/qfkR0B+
        WUATLWsW1bHZdG6VQJ/HAB8JCtD/7M8=
X-Google-Smtp-Source: ABdhPJybqCnZ25XS05cK+tREUWpuMOYdEEX/Q+LwEVAiQbzMb8otG8/U/7VCzZ282x853Zjezun++Q==
X-Received: by 2002:aa7:828f:0:b029:200:6e27:8c8f with SMTP id s15-20020aa7828f0000b02902006e278c8fmr6104530pfm.44.1624557668850;
        Thu, 24 Jun 2021 11:01:08 -0700 (PDT)
Received: from carrot.localdomain (i118-16-244-169.s42.a014.ap.plala.or.jp. [118.16.244.169])
        by smtp.gmail.com with ESMTPSA id go16sm7319739pjb.42.2021.06.24.11.01.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:01:07 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: remove redundant continue statement in a while-loop
Date:   Fri, 25 Jun 2021 03:01:04 +0900
Message-Id: <1624557664-17159-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of the while-loop is redundant,
remove it.

Addresses-Coverity: ("Continue has no effect")
Link: https://lkml.kernel.org/r/20210621100519.10257-1-colin.king@canonical.com
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index f42ab57201e7..ab9ec073330f 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -738,7 +738,6 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 			if (ptr2 != ptr + cnt || ++cnt == maxblocks)
 				goto end;
 			index++;
-			continue;
 		}
 		if (level == maxlevel)
 			break;
-- 
1.8.3.1

