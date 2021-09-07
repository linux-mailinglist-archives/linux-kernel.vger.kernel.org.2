Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62860402AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhIGOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhIGOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:30:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D576C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:28:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q21so16860014ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsN0bPPvCsrWyorA5YRODaEgcyng9oY+K6BTTNsB91c=;
        b=fusIBYP/pW7tKm3U0PWc7v6QwQe3e/OSgkUKCw/hVcNwUgj2exPqNqTSXtZW/0oBSz
         BItlN7i+OVHYOUqXjguwe/KLIa5a07xDMFrTgE/Lg8raJs5LB+oZ28LpmPWf53E7oH+j
         cXy+PXJgs4B0HSqKZ8huaLRqKv3+/ICM8e5/Us3h4qL0coekgO7fQloTefTJBcEaLXU9
         pG+i+y5yMThOCx7k3zAowYmm6B7LjJD2uQy8n9ljRO7SFXZlwMmfXLAqBpHTUWWG1ObF
         Xqnp3bMTfAhwOz682QHrimGn2eA8NMwmMSeH63J5jr0natNVP5kEX2w/KpSdtZGnEohR
         QrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsN0bPPvCsrWyorA5YRODaEgcyng9oY+K6BTTNsB91c=;
        b=OrqHcHx9pPDwk2t4VhZNcrcnlpqkrw5T6lrRZn8/PVpvgcYjd0M9YRQv5J9MGWw7ek
         2p8sQ+6BZyaymrb4/8O7RVy778aDrlgjUYjJbL1Y+5ea7hhg4CCQE5M8d5gTUE1eyVuy
         iGtuxBkL7Aek2EIMGAIOutY4danpZHCPwwrjhl01kaPdqyBNEaPDL5geZvUdW23XYiCg
         fDSnNHWXoSuIqNC829lRer03lvJR9Vo/F2AEnVOyVOZrxEfFXCXYLn/CVQKl/NLucuPi
         2TzJcuirf1W0X5c2Jgxrhz7s8SY9wns4+qUxqLbUbgFGEK6VhGJaM7pQAvICRAcdKakV
         VCuA==
X-Gm-Message-State: AOAM530ERmD70R9ysORxL2pHXYdCAdtBfch8pQmhI8fkpob6ZTFF3DV1
        eNYdsZCIQdv4M9DbByKOOew=
X-Google-Smtp-Source: ABdhPJzsBMszE+ALzBtXa5jKhejAVyexEAWCCthHAZo0/XShvKYC+16avfq4O4pxB592jRpKBDg94w==
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr14422972lja.318.1631024934626;
        Tue, 07 Sep 2021 07:28:54 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id l11sm1014251lfg.39.2021.09.07.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:28:54 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs/ntfs3: Use clamp/max macros instead of comparisons
Date:   Tue,  7 Sep 2021 17:28:41 +0300
Message-Id: <20210907142842.133181-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907142842.133181-1-kari.argillander@gmail.com>
References: <20210907142842.133181-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can make code little more readable by using kernel macros clamp/max.

This were found with kernel included Coccinelle minmax script.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/fsntfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 99d0a2799b0e..4a0a1aa085d5 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -420,11 +421,8 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 	/* How many clusters to cat from zone. */
 	zlcn = wnd_zone_bit(wnd);
 	zlen2 = zlen >> 1;
-	ztrim = len > zlen ? zlen : (len > zlen2 ? len : zlen2);
-	new_zlen = zlen - ztrim;
-
-	if (new_zlen < NTFS_MIN_MFT_ZONE)
-		new_zlen = NTFS_MIN_MFT_ZONE;
+	ztrim = clamp_val(len, zlen2, zlen);
+	new_zlen = max_t(size_t, zlen - ztrim, NTFS_MIN_MFT_ZONE);
 
 	wnd_zone_set(wnd, zlcn, new_zlen);
 
-- 
2.25.1

