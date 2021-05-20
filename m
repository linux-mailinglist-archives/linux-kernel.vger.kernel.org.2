Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43E38AE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhETMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241496AbhETMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2BC04FF1A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b7so8424284wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKuqwj4W0ZaBhd+1MfxBYEd6ybavmACFUynSnrbT09Y=;
        b=TK0Jfj0dt4OTi6dd/sS/0Rz8Vi6QubSaA5C1z2R6tWQXCYVw+9C26s3IIfPRsbpnAG
         eA7mnHq/ffnac45EyLCdbGT6h82tLM3aWzUGrQufr3LwRaKFGTF0MM1UXE3MsPM47xj6
         F6c19/cJW+RwWaq55EtePiCb0Nx3YEPL4TOVc3sc74eKiiUeXc7mei8PzdEi5t+30/81
         jOtqBqRVjJ4H+cr3R1cRrrb4CQ1hldxeHbOIp2eh5zwCuHfPnVkHW++6ly74Z2iaDqNS
         FvMRYWMCfHXFDE+Ej3QjCM/aRNuC2mva4sXok6fCwQogCkQu+ZSXF49F5QLtjpM4vLxj
         UfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKuqwj4W0ZaBhd+1MfxBYEd6ybavmACFUynSnrbT09Y=;
        b=lmWYI6woWU4et+rVdRhO5DCdWh/7hUvvePYGISmmJ/M3LwKrWyECa1+0nQ7bUqfG00
         JjXYBH3BO04PPBUYxXJNbRkn0oWN+tHs8846R4shps35GIpBXEGoZpfD90HKmR8bMmJC
         221zVgc3HAuxs4pWefHnlmaRZwd371reHPobz9a2gNKX3c0E0l9cobltCByo89h46pAV
         qldBj0hOwaBNCZ7NtPtAEqNiTpBksOmGqJcZagxaXDmGYLvu4sT+YG/gIEWsVMjYKZ+g
         iYm4iluH8JNhyrDUtVFtlJUrAusEU4a7w0N3AA8nRnc5t3mtcaTJxEv0ch2vIYcfL/qW
         no1Q==
X-Gm-Message-State: AOAM530MvZhiVm/5z/Uv754r+/z7tOh0fUviTIHk9qH6TK8U9GHGQcJQ
        4SxkzwFX/nAgBD1xGpvny8soPg==
X-Google-Smtp-Source: ABdhPJzFg/x/i8fn7ZXHlJMRZmv/eev+0CIUqdEEWaPuBJoXbC8cUegoDN/CoLc46P/JNjzuA2AV0w==
X-Received: by 2002:a1c:7d13:: with SMTP id y19mr3280861wmc.41.1621512051990;
        Thu, 20 May 2021 05:00:51 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 07/15] fs: ntfs: runlist: Demote non-conformant kernel-doc headers
Date:   Thu, 20 May 2021 13:00:35 +0100
Message-Id: <20210520120043.3462759-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/runlist.c:16: warning: Incorrect use of kernel-doc format:  * ntfs_rl_mm - runlist memmove
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'base' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'dst' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'src' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: Function parameter or member 'size' not described in 'ntfs_rl_mm'
 fs/ntfs/runlist.c:22: warning: expecting prototype for c(). Prototype was for ntfs_rl_mm() instead
 fs/ntfs/runlist.c:35: warning: Function parameter or member 'dstbase' not described in 'ntfs_rl_mc'
 fs/ntfs/runlist.c:35: warning: Function parameter or member 'dst' not described in 'ntfs_rl_mc'
 fs/ntfs/runlist.c:35: warning: Function parameter or member 'srcbase' not described in 'ntfs_rl_mc'
 fs/ntfs/runlist.c:35: warning: Function parameter or member 'src' not described in 'ntfs_rl_mc'
 fs/ntfs/runlist.c:35: warning: Function parameter or member 'size' not described in 'ntfs_rl_mc'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/runlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 97932fb5179cd..6c7822cdf3ac1 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -12,7 +12,7 @@
 #include "malloc.h"
 #include "ntfs.h"
 
-/**
+/*
  * ntfs_rl_mm - runlist memmove
  *
  * It is up to the caller to serialize access to the runlist @base.
@@ -24,7 +24,7 @@ static inline void ntfs_rl_mm(runlist_element *base, int dst, int src,
 		memmove(base + dst, base + src, size * sizeof(*base));
 }
 
-/**
+/*
  * ntfs_rl_mc - runlist memory copy
  *
  * It is up to the caller to serialize access to the runlists @dstbase and
-- 
2.31.1

