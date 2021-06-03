Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629AB399E26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFCJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:53:30 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53156 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:53:29 -0400
Received: by mail-yb1-f201.google.com with SMTP id c9-20020a2580c90000b02904f86395a96dso6947995ybm.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kR7sRAYJgYzXAltawUkgM6QLDKs+TdWaYFMXl70NU30=;
        b=LJKZ6LsL2aYsJR1+AehJQAJ7FIgxPEQJIitSrKRyU7XfGtmDPMPSNJEHLM8HTRS5m0
         dWlIDs81zCAdesoohP+0GRT1s3FWql/S2+zquZr7AgfYstU4BGdkDoRjh63t9CQXvwPf
         LtAAb9RqanCPcIgZWoHx4PsRswyPai5x9KKxBFLKC4ZXzc/kRkITdtGrYzTkwlNGCBaG
         XIUQ8dQo/rYaOvXyTufGfx6C2LmrZ/ZbiUoCeX+RX7rrm5jeKYCTHZ77w07DPYopaYMb
         uM8WpcWu30HynSfGekZZGg13SEbYvOHMSZ7QS/h+jHGv6bcNXYpPJRZ/nYl9y1OM7qUQ
         9YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kR7sRAYJgYzXAltawUkgM6QLDKs+TdWaYFMXl70NU30=;
        b=XvHj+jFcvpkyEbbO2VZGoF0pbxlbixVF+dC7c84NeZcvZaxHodqU3QbOrn0TEK1JuE
         rotb/8kbvFSPyBWd0RrUugvqow6aBjjwkn7ncl2KixoZwmq0rU83G4qKPvAsAextA640
         ZO5WLL1eEwHFMd+VM5aZYxojBb3FpCeiMv1AWQxtA/GGsE2RgzmlF5cYy3GtUaB5GgNQ
         v6GZzg+q0IuGgrUirdBwvLsPvd4IRUnX7G97HxM1lufMk9kFevzMJgMxJpP5TnCvaV4r
         G21lVQRo98ik6v+pEDhRcV+18rkNxXRuOMTbsHZ8ZYrv7Rur+AcbvkJSmZL/kEzFYx/h
         ocgw==
X-Gm-Message-State: AOAM530vgNnAV0pi8nbYyeLXonheOLZuk3nNkif0t91xcKQQ/DmaY74j
        3lPfoSd/GWsyo4iJ+ZmabDGBNFC6dUs=
X-Google-Smtp-Source: ABdhPJwg9zQpmTee0HJgwJoqlYYAiV6WD/aVlCidtVhW+RhGawkkIOnjZoxsSBgw9O6LZXS5cWzq2nbANLM=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:3d6:: with SMTP id 205mr9832485ybd.350.1622713844030;
 Thu, 03 Jun 2021 02:50:44 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:50:37 +0000
In-Reply-To: <20210603095038.314949-1-drosen@google.com>
Message-Id: <20210603095038.314949-2-drosen@google.com>
Mime-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 1/2] f2fs: Show casefolding support only when supported
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The casefolding feature is only supported when CONFIG_UNICODE is set.
This modifies the feature list f2fs presents under sysfs accordingly.

Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dc71bc968c72..09e3f258eb52 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -720,7 +720,9 @@ F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+#ifdef CONFIG_UNICODE
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
@@ -829,7 +831,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(verity),
 #endif
 	ATTR_LIST(sb_checksum),
+#ifdef CONFIG_UNICODE
 	ATTR_LIST(casefold),
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

