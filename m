Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527713FCCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhHaSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbhHaSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d16so262456ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/2+IO+onR8n3ZdfuwB5lM1ps4vOPHv1OrjjTrVRTCk=;
        b=X0ufsWfC9N2z4/uotq23vGlo/DdqC+468GqPtNuc1ZZfkah7kMxpeku5LUa9pPVVH+
         TmWaglhxqM2zYn1HRHLkMhgeU8GgkEefvt3gA9U7CPFqiu18mEllBf6br8uo/VF7RVYo
         vuSImix2ItWDgrpRdbjLgfyxGDmxG0BJvNJvJNxVLtDdmrShZaXBLrOjOCJ+zXD7gA+r
         If0dgYQk9rhRpbxyhrzFLL11zbsKubj/F4bY9dEJ1B86QOXvHBcK7UzFGPRCS9w5DO7W
         5fv/MjFwb2VWAHeBpssB14VYKbmiaRyiSVKnqK+y/k6BNcpuxvn9/LzCdd/drCH2kLj9
         xaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/2+IO+onR8n3ZdfuwB5lM1ps4vOPHv1OrjjTrVRTCk=;
        b=Yq1Vcs7Vpk7PnLsLDoeVDNEvMDtrq+AO77/fbYRhKyxXNOUPho7Hkuw5plHYnibfSc
         cmPEC1+Xn2odkpAoKKvKZYrQrPxk6ErqSNncEXa0wCZ4v1rJ4XtF9RI7jL8TQvYs/6H5
         fMdNAHnD3tqrCVKdvihZNi9QHcs8DUKFOAnUBRzPPv808buWwKKE3NLqTw6BTEEUDeXQ
         V4wlhVftZO0KT20YOowKzfCcDE8aXLD/K3EursRb8i/TfxZKV6EFoJ39sr7l/krWgOpX
         QVwiURuzJjmAyT2PsCe5Nj1/Vwvanl3jETdzJQbO/qdDpogmBJUbxsiibu3GqHTrXt91
         1Spg==
X-Gm-Message-State: AOAM533nVJrhtOq5eC5kGfE112Ng+xHozdcYMH5WyusdPnzRH7FYylTt
        KgP0PNY7rfl6dhtQc+mrftw=
X-Google-Smtp-Source: ABdhPJxhmdZK3kigK1ngsxDNVQmlXUBtaQ3R9N3n636p96WyNZX9i6F2MzjU99X5en0g7aZpxIpBkg==
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr7039974ljh.43.1630433720728;
        Tue, 31 Aug 2021 11:15:20 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z11sm2270757ljn.114.2021.08.31.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:15:20 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] fs/ntfs3: Remove braces from single statment block
Date:   Tue, 31 Aug 2021 21:15:04 +0300
Message-Id: <20210831181505.1074767-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831181505.1074767-1-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single statment block as they are not needed. Also
Linux kernel coding style guide recommend this and checkpatch warn about
this.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bc3887635012..61448325c4d1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2906,9 +2906,9 @@ bool ni_remove_name_undo(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de + 1, de_key_size);
 		mi_get_ref(&ni->mi, &de->ref);
 
-		if (indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 1)) {
+		if (indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 1))
 			return false;
-		}
+
 	}
 
 	return true;
-- 
2.25.1

