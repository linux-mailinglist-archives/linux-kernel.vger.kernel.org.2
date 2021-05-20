Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF338AE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhETMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbhETMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239EC04FF1C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so17377003wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+CY2ek6VxONI01tTBXSoeon9keiXFqschyXl+BU66Y=;
        b=V5+2RfMRWw9e+4jMcoxCK9BrpOXh8PlzSSLwIs0vIDrCJDsdznoZ/mZHGEv9sMC+dS
         WaXQDXeiDr4ZKu9x8rcfVbqtEhwxUeltzqEKMlt5ryVIIqDUnFAYXq/7C8OZTodMf+Py
         Z1r7QcMjo87mi+vFVZKlzWMI6uvU0cyHyYGms3dyWHHeTg9OxiDAcp+paxqzY8y6+Zyc
         QelZGC8HL2Hl240TRgfyIHsEtnHFarUqmoKgNrfZjR/zq5BK5NTRMZ4Ixcs8qYCka5oL
         UiOAaYBiMPUveXcrPg1n+oFoTkR+Hxvl4hteENVEwM+WGL9Ie3upaBzw1r9vu57Wg9u9
         cVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+CY2ek6VxONI01tTBXSoeon9keiXFqschyXl+BU66Y=;
        b=B+sPyotLjXTXgLeE2T8zqKOSdoPIzR1IAgo+e8aoNk7CUD+BgL9Igz7+r4ZPq2P+kJ
         1UIrn5B8VTcTiBC4bHBkrMmfNqgQnz52/g6ZpW1xeAmzuKYScK5BJCA0s/2VHkRzWsmW
         9JQyXtkkz7WCkJhO+5DSDwTk4MdM1d8z3G+jFgZkty4L2fwpNu64eBJFHbb4HfgbpClI
         50RJTo/Z1WbTcMj7wZUkl9/vSt1Mb1HaEMu9B0QBDip1S20Fc3h/waPWA38LmlENjxyK
         ztEdiNcCSWfINdGkDQHkJsTwsmeQ6PAgGEsYnlYXjZ24pNKNkN+8tRgFDl932dMo4Ocv
         9v3g==
X-Gm-Message-State: AOAM531opUC8vk1L4q+K4QZenM6lqYMtjoJ3PzztpFpkrBKsL5LxpwWy
        LhsGSIkl3LvoV3QvrNJ5CV/8eg==
X-Google-Smtp-Source: ABdhPJxoFmOkWT9VDnUJ9MEGL9uhaH5oolmp+D/Ie1OoOCnnLUyt4SbOgcGmeyEVpLs6D0FEJLYTCw==
X-Received: by 2002:adf:d231:: with SMTP id k17mr3821480wrh.78.1621512052831;
        Thu, 20 May 2021 05:00:52 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        to <linux-ntfs-dev@lists.sourceforge>
Subject: [PATCH 08/15] fs: ntfs: inode: Fix incorrect function name and demote file header
Date:   Thu, 20 May 2021 13:00:36 +0100
Message-Id: <20210520120043.3462759-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/inode.c:31: warning: Incorrect use of kernel-doc format:  * ntfs_test_inode - compare two (possibly fake) inodes for equality
 fs/ntfs/inode.c:47: warning: Function parameter or member 'vi' not described in 'ntfs_test_inode'
 fs/ntfs/inode.c:47: warning: Function parameter or member 'data' not described in 'ntfs_test_inode'
 fs/ntfs/inode.c:47: warning: expecting prototype for c(). Prototype was for ntfs_test_inode() instead
 fs/ntfs/inode.c:2945: warning: expecting prototype for ntfs_write_inode(). Prototype was for __ntfs_write_inode() instead

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: to <linux-ntfs-dev@lists.sourceforge>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f5c058b3192ce..b3badf5482956 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * inode.c - NTFS kernel inode handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
@@ -2924,7 +2924,7 @@ int ntfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 
 /**
- * ntfs_write_inode - write out a dirty inode
+ * __ntfs_write_inode - write out a dirty inode
  * @vi:		inode to write out
  * @sync:	if true, write out synchronously
  *
-- 
2.31.1

