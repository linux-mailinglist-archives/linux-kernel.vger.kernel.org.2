Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA035BAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhDLHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbhDLHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:39:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:38:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id 12so11808254wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ba8vkc1BfSZosx3uGhz1pPY/j875HME7u94kJO8dVU=;
        b=0x8a4/DegqzPKaTGbhPHvPJhPWy/aa5JytZrFbsC8wsCwIBTtA1WnY5EWX3FzqxELy
         EYTgKov9wazo9LP0UvtmbsB21XV7dVMFd2HWIuZo+cUsrrib+UIVKeMrWPfymIe5RzrH
         BN2Rhz1OIvsXP/3jiip/xT9TAAqOJlNqt9oArDXXvdqxCIhVsNHfLf/uzd91d7h47PMz
         QI4rp6aRpSc43K1z5S56aTRvX3vzegYSRyX7ES6ZRMNrqbncQMxt1sDbsJeVVQ89/MZO
         S5azl9liCp4shlG2+3ZS+rpHsORfgKadr5osWlhs2dt2c9vnYmnVULm6mv18nqYDruAI
         UOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ba8vkc1BfSZosx3uGhz1pPY/j875HME7u94kJO8dVU=;
        b=XhtkGSajDvA1z5UxhwWXLg1yvgTtbdjoomrlTa7ZM9KMaTB0VPGtpxU68oAool4Abk
         JsXeRxFkoyq0zoptkP7nIk78YL07V6f4A9f1dF3aki+XVC+LzRbHPHjooUfglCrnfoSi
         I7S1Q8hRuI0M+xQbms8/CE1VmHFHgEpx/TP3WZ3OFzfihvYnza4KWA0N8+LHPEwnRTrS
         udkbeLfaDCUVHCMi3by+7RWdZzzoa/ghuauC3JOaNqbfg3peAak0RkIH8W0fHVnRNm0/
         LPs5Gv8v+h6XYcuuw2urJAlR8bL00Fs+hQj3SUW+Hnj0r1vLqxYJh7raPmHpDWkEBuBG
         0blQ==
X-Gm-Message-State: AOAM531F634ohKCd9enCX7ihJ7P/tw4gG/TQ3LPCL6agTVSIbkzz0RLk
        +LHbLpFbyfjG+u14hD+ReBWJ+eta9gsTQ6f5VP0=
X-Google-Smtp-Source: ABdhPJzNN7fVoaZnxbco4trv/zzU5GvG94C3eALL0Sf+45NIZ9FIrtRyn1CXac5tVYi+dTm6fHT22w==
X-Received: by 2002:adf:e402:: with SMTP id g2mr30527861wrm.1.1618213120778;
        Mon, 12 Apr 2021 00:38:40 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id y31sm14500431wmp.46.2021.04.12.00.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:38:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo memory correctly
Date:   Mon, 12 Apr 2021 08:38:37 +0100
Message-Id: <20210412073837.1686-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flexible block groups are enabled on a filesystem, and there are
too many log groups per flexible block group, goto err_freebuddy rather
than err_freesgi within ext4_mb_init_backend. Cleanup code for new_inode
and successive executions of ext4_mb_add_groupinfo in the previous loop
is then correctly run. Fixes memory leak reported by syzbot at:
https://syzkaller.appspot.com/bug?extid=aa12d6106ea4ca1b6aae

Reported-by: syzbot+aa12d6106ea4ca1b6aae@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf4fc84..d24cb3dc79ff 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2715,7 +2715,7 @@ static int ext4_mb_init_backend(struct super_block *sb)
 		 */
 		if (sbi->s_es->s_log_groups_per_flex >= 32) {
 			ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
-			goto err_freesgi;
+			goto err_freebuddy;
 		}
 		sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
 			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
-- 
2.30.2

