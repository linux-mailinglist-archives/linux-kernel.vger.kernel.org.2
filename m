Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE2310B29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhBEMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhBEMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:33:30 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABBFC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:32:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t63so6674985qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIl0vUGiIcn5LDLEPIIUwYzTzjM35v+uq40OpmkLVNk=;
        b=pUbUesdzQUoc0eu8Ycu42IhATyUfNK8cUV+rJN2Ho8KsKmXuMX7vDENg9LKyaRcA9b
         6ttPqs1qq5chnsQo2SFulew+C513sF5pHFD5MNdK43psSZBnZUsu+RZzW6xv4Bbt99O3
         Dh2RLZWKE6u5zVOd430qngg9mx+NIGswsxRNZ2uia7CE1oYy17gDfxM9ZzudDYbAIX9O
         +CJ2PDWUfXfgygDkJuPYkgZWI5mXtns/TZyV158/D9Bt8XJCRngbRNChrVJcBKsz1cs0
         SNfa/hGMq7Rlq9n0jhKsnsjH5V8N/A9J6b/VV4He2d0SgybG9gTbmdZpqOYgL5C7b/1W
         mzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIl0vUGiIcn5LDLEPIIUwYzTzjM35v+uq40OpmkLVNk=;
        b=hgVXjekhE5fbI/vcr9LBtvpNjMx/9+amWtCvNWJPSHHgJq+yy02h0nuM56Bor5c1eb
         lKV1Nk6v7e03MRI1s4oJt61oUky8XZIzaCd2nGT7JbMJU57v60ettAJjgvFLCO7kR92o
         sr2aCRom1DXVLjMZ9dpoEjRE+7tdTbAp+VVk5i2NsSkg1x5jiUKhAat/UxZrv+Z3GjAW
         xcGakmqgQ3jUaaSqqeJQVxDTCkQLIIbl+HybKideNbiZm5F5CAwfrncKcYQQWiNtGK+K
         Mj3v3oWr7plRP8Z8iR8Y/ZGvAecJMJhT2/EwzaRmGVkkKMnRRFIhtrwbZKZM2AxwP1Qm
         C1yA==
X-Gm-Message-State: AOAM530btkkm3GAZQxFgk4gfHFxSmCF2Zf2QpB5lMoFWN8oelUcGN4lK
        HSutODeMvqPG89/ZwJKe8QYu90yNBDDk6VtZ
X-Google-Smtp-Source: ABdhPJxKpvxoTLEF1IAT+6S3GSaX/ECrudrXkIEZq2/6Y6b2dXohhEYbZP01Ed8Y12IGgMQxWRfbQQ==
X-Received: by 2002:a05:620a:711:: with SMTP id 17mr3831371qkc.501.1612528369010;
        Fri, 05 Feb 2021 04:32:49 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id z5sm8880588qkc.61.2021.02.05.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:32:48 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs: configfs: Fix sentence with a better word in the file symlink.c
Date:   Fri,  5 Feb 2021 18:02:35 +0530
Message-Id: <20210205123235.1365780-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/fucking/wonderful/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index cb61467478ca..26676e27346b 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -169,7 +169,7 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	 * link(2) and symlink(2) - they wanted the target resolved
 	 * at syscall time (as link(2) would've done), be a directory
 	 * (which link(2) would've refused to do) *AND* be a deep
-	 * fucking magic, making the target busy from rmdir POV.
+	 * wonderful magic, making the target busy from rmdir POV.
 	 * symlink(2) is nothing of that sort, and the locking it
 	 * gets matches the normal symlink(2) semantics.  Without
 	 * attempts to resolve the target (which might very well
--
2.30.0

