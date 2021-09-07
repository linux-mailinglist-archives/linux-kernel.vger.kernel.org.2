Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688A7402532
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhIGIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhIGIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:36:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78EC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z2so18082663lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+LGmeR60FWHgs4xdzy8QblxkagG3b3H0/egfK8g1+8=;
        b=jQjc45qhii4QdoeAi82n4lzXuR35YeMYqgJCNFpS0irFt4T9yQrNR3KwbU3Tjox6Fm
         7ZRRvFRTYOj0vVX1p0RDm5qxtXUD5lSWYwq0R+TahkrDUg6hIlVLTSjczZpWs6oM3wzD
         qULV6zesK39+BPEJqgQA3Gq15hOHH+HX++PNcHmPrVx7w5ueWPrpZrOgtcRIzZpy/TI1
         zHmx/meUK5ZXVyQZVcIX4IUOJScHGHpXF/JmJv3XOBwXB2OJrQF3MNllZpchpoUv8fo2
         QYsCDVVgU1li+vXQ8m6eIbJVMY5lK3D/JDVnA8CKUJ+Ge/tnG4eAoW3hZcKLIxlsSnsJ
         0Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+LGmeR60FWHgs4xdzy8QblxkagG3b3H0/egfK8g1+8=;
        b=I+Pw8NXOt8+OV/QrVY1fcX1B2HbVeH1aELLrERg/7UgrCm8cQdAqtCK+Qj9XMv7mD2
         8hBhcJb82utrDTQ/aGkPx5PHBndvgGYuwGXqoKikHzz4XUWP5jrO/NiHLroiaCh6lb+i
         Vc2ntWacSNpEoSkje0xtJ/0upuHg0pkqeS18bDILOFvuwGBs3+SH/Sbt110Vq5Nc+aDv
         HXtGOZiqGs6alFPhZSr6uLyJjHPriGOGYoxNkZ5bK4d1p7GHeL/a9fP9drCvRrFBn1K2
         bZlzwlbS4GyMj2ed3Dc8FI3I/baotZccXHAkyAVNSUN7GJij4KzNgNknORoChJadi0q1
         iQfg==
X-Gm-Message-State: AOAM530SHnbU1C4fp03F6fcpSuNhe6ULRb7pDmZdXyDE3j4B/Od4BhjP
        4eagyR4Vop8MORxTJJJ5r8M=
X-Google-Smtp-Source: ABdhPJzVE3f8EVnwVt+eekwHX5lmd0AFQA7UffXlh1GYVv/wop3r/lzWSZB8BlMIFRWHSW95aNiVQA==
X-Received: by 2002:a05:6512:304f:: with SMTP id b15mr12254996lfb.462.1631003693468;
        Tue, 07 Sep 2021 01:34:53 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q30sm944771lfb.155.2021.09.07.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:34:53 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/4] fs/ntfs3: Place Comparisons constant right side of the test
Date:   Tue,  7 Sep 2021 11:34:39 +0300
Message-Id: <20210907083441.3212-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907083441.3212-1-kari.argillander@gmail.com>
References: <20210907083441.3212-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better code readability place constant always right side of the
test. This will also address checkpatch warning.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d1477cabe3c7..d3c1c46cfb0a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1606,7 +1606,7 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
 
 	*le = NULL;
 
-	if (FILE_NAME_POSIX == name_type)
+	if (name_type == FILE_NAME_POSIX)
 		return NULL;
 
 	/* Enumerate all names. */
-- 
2.25.1

