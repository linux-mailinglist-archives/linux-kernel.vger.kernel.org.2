Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91C402AC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbhIGOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbhIGOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:30:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB1C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:28:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f2so16903049ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsEUb4i0UZiEHWMRMSPWGXQkcz0r9bMyZf/QmVFGIfw=;
        b=Tc8svVaVugRu85UV8OtdL2R5U5yJ/XHZXBb9mDEevh3QXNwn9pZ/zGV+yZPrssT5/Y
         qZ5FhIG72J6N+8fq03SpO8olGi+JlxmAYhGr2TBpSvH5jW80I+uSJUpxsNvGsdUJRR0G
         f+eeDJaLO4qTkWmw9KkSImiXgltJwDJznqaWuSN62qEV3xyWCpYG8Q/pyta2HztQ/zDV
         WnyJPHPp1hSbeE+B11XVCU+4nISWqN94Ky1D22qZpdxxgbyn/7JafVUD5S6KjivKdEQy
         6fvHP9TrZxGUe8eMY4mvJ/LW3cK4KLxQQegN+tA9yB2AKz5hs2cUvWRaVq1kg4ioO8aD
         qezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsEUb4i0UZiEHWMRMSPWGXQkcz0r9bMyZf/QmVFGIfw=;
        b=FXmWTtZQDqoS8cEy3l5mKmi8rzueWXxgUGOaWAbb5oVEjsKZi97A6UG0tFgJB7igAe
         NCSxZAOcCCF8fky8lP8+5IwYdUcWwLKt0J5B/wsmMxJGN8iNhwYyJ54lpSGMxTErQEDg
         NHz4d432bxVbFoOB32KngUtH2cxIZyBWxBMHZF4PZPVI+4oo1UKIwpuYS76I7uILg/dX
         frsKCRNXh4e6c9NiEtuRXlUi0ERG6zfRaohquyex/ooH5BEVPMSX81IYGw9SHy4mJm4u
         0uVcUYSMHr2YqG3t8BnQliQqZN+Ii8SsB57yIdhRz6DHp3YGR1iaRC35mjVDSc7yUqcV
         rSTQ==
X-Gm-Message-State: AOAM532wEVgmmHyrV+QgjzY66+oao8N54VqKEQAQSva2BFVyBazrH6r4
        s5PBA+ePfJp6eRKA/OqtPlCVg4laqF8=
X-Google-Smtp-Source: ABdhPJzLSJk3/CorSyD+j6UH8YbIlfCOXkDBNK6GrQvmGwkZMGtERmliZJWYLz0akxkuFHbIUf9u2w==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr14598197ljp.518.1631024933370;
        Tue, 07 Sep 2021 07:28:53 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id l11sm1014251lfg.39.2021.09.07.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:28:53 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs/ntfs3: Remove always false condition check
Date:   Tue,  7 Sep 2021 17:28:40 +0300
Message-Id: <20210907142842.133181-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907142842.133181-1-kari.argillander@gmail.com>
References: <20210907142842.133181-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need this check as this is same thing as
NTFS_MIN_MFT_ZONE > zlen. We already check NTFS_MIN_MFT_ZONE <= zlen and
exit because is too big request. Remove it so code is cleaner.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/fsntfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index ae7c6435d7bc..99d0a2799b0e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -423,11 +423,8 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 	ztrim = len > zlen ? zlen : (len > zlen2 ? len : zlen2);
 	new_zlen = zlen - ztrim;
 
-	if (new_zlen < NTFS_MIN_MFT_ZONE) {
+	if (new_zlen < NTFS_MIN_MFT_ZONE)
 		new_zlen = NTFS_MIN_MFT_ZONE;
-		if (new_zlen > zlen)
-			new_zlen = zlen;
-	}
 
 	wnd_zone_set(wnd, zlcn, new_zlen);
 
-- 
2.25.1

