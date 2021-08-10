Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B673E53F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhHJGzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhHJGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:55:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:55:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso2966007pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp6AQyVuidbbmZh4SpEnbdNrLtEBOB0mz0m+17qvH80=;
        b=Z2PfQTKHT/f2cgdX8JT6mIdT8GrweddGz6wWggyjQOVyZ+5gJzRgclw1kl/MmtOeA4
         Qg7VnIjiSk4AKyjgE/OrlEul1zGhmLTxFmOH7TmUJsAftiN3geenFmvhUG9GZs+OSzVC
         8CoQkfDZC1F+GsMXDkpfbUzlMkx13AMVafJaJrkkbqJrw2xacfsfu3Tfk932odh7p6nu
         JmiXIHH/ZiE1EGR2vO+m5JLo/REnZwSTDRSKI9j0cdMI11KMDtm1py4fPffTZ/Hi295J
         Gx3meUaiEnhEJc8Iru1Evwk5GC+0OXLFC//a8fn39JhFadc85L2/ZdiLW/ATMwnPcfM1
         Vbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wp6AQyVuidbbmZh4SpEnbdNrLtEBOB0mz0m+17qvH80=;
        b=LuEy2G+pOfel0ELwZjA4GakFnLwcsWjRIPOq4N8MhOdPUEYE37bhZdAdNpQl+HFuNw
         0uP18XE/4+c5K69zoMhfHXqOasjRKXizGMxSOObhXfG9wkmKb4vJVhinUdwah3tY8Wy4
         xlbpUfIpNTT5GwMIWhl/++cB9mty8Jb4mZiW1KtJF7s6WbKVFTQq2nbvYNGfHWH3GxH+
         l1rgIydPCu9AbJp6E6c0YIxGZolQ3ao/LR2VrZiNfnCsYRcruo0a9bYU6HA4Eezlj28i
         Wjb4ldBQDNJFSIHyvYcqQJxD4Mdr2+jhqUNlXyx/y/Ro2DGVWfRAY/sDiFiN9MhkFIA6
         9q7w==
X-Gm-Message-State: AOAM530k/NBNzf3aQIPAjxniQCCUPSITN1wg/yOozwAn7VullW+1IhZ+
        dUiyrqGq0QdG4bc5v7eVg+U=
X-Google-Smtp-Source: ABdhPJyA9LmdyqIvPLhi85SmsV6nAGqM8rJ8oFoHSoOwf7HnCEnq9KFc3tFAHT2cBpaSvcSXkCu1zA==
X-Received: by 2002:a63:36cb:: with SMTP id d194mr8637pga.224.1628578517243;
        Mon, 09 Aug 2021 23:55:17 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id bk24sm1667496pjb.26.2021.08.09.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:55:17 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: directly use wrapper erofs_page_is_managed() when shrinking
Date:   Tue, 10 Aug 2021 14:54:50 +0800
Message-Id: <20210810065450.1320-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We already have the wrapper function to identify managed page.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 78e4b59..a809730 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -310,7 +310,6 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
-	struct address_space *const mapping = MNGD_MAPPING(sbi);
 	int i;
 
 	/*
@@ -327,7 +326,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 		if (!trylock_page(page))
 			return -EBUSY;
 
-		if (page->mapping != mapping)
+		if (!erofs_page_is_managed(sbi, page))
 			continue;
 
 		/* barrier is implied in the following 'unlock_page' */
-- 
1.9.1

