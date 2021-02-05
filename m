Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F012F311ADD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhBFE2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:28:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50930 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhBFDSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:18:39 -0500
Received: from mail-oi1-f197.google.com ([209.85.167.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l8ABD-00085H-6N
        for linux-kernel@vger.kernel.org; Fri, 05 Feb 2021 23:06:23 +0000
Received: by mail-oi1-f197.google.com with SMTP id l4so2926050oif.16
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL+PN/3Ia+pzgjJLL+mRMyGT9OjrJOTglHNfm1iXNKw=;
        b=UebJ7skcbBpZQCuor7m+PnlincUlWou4HaR4WPeFXTWrHQsl4UnC/gvqVQe4cOlgTV
         eg2jkNcecVRmUKkvYTNMPOVhzGL/r7upIoLx2+iDbXjc1Q1X77zru8WFQhEcAuKfh7cF
         7Zu2lTCf95p3JwGulMQxaeqsWMeTrR4ieizYvhqpeGsLVtotmFCExuRG4xbWO4OWZ0Xo
         hPgOmYOvi31qFtgmSw2qqJixSIZ25zP+4U66D5KK/KUuZgja+ouimWy6NcimakcH0i0n
         FV4baU/bWALhwU6H4IEdwNeY2LhKdBqq3Nhd63gKQHzojeK1czt4Pd0By7kTeVF+DZtm
         mjlQ==
X-Gm-Message-State: AOAM531mfQzlF8U6PWdMGaSytZNmlFIC+elISo1JWqK/pnA5lJnyAyvs
        qSyWBjFxNsl+9MNUBrCmRq5nzDr3dTEWFXo1AYgZmJlfM3CE4OnYg4byv8XirBLy7WBnCZdQD1o
        NR3/WBKHeJzqCoYrOIm1ObwqQecxF2XJja2VJzpbTOA==
X-Received: by 2002:a9d:4e81:: with SMTP id v1mr4028717otk.18.1612566382223;
        Fri, 05 Feb 2021 15:06:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvs9TQA5TKt+CAisx2zwMD4RJd1+tEjp6Ia1b1F+JZJ5RCBrJ1ib/XXQFu7GcbeKbNLoXSdA==
X-Received: by 2002:a9d:4e81:: with SMTP id v1mr4028705otk.18.1612566381984;
        Fri, 05 Feb 2021 15:06:21 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2b7:eb67:ff8d:8b15])
        by smtp.gmail.com with ESMTPSA id m10sm2087472otp.19.2021.02.05.15.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 15:06:21 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Date:   Fri,  5 Feb 2021 17:06:20 -0600
Message-Id: <20210205230620.518245-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature requires ino_t be 64-bits, which is true for every
64-bit architecture but s390, so prevent this option from being
selected there.

Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..3347ec7bd837 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT
+	depends on TMPFS && 64BIT && !S390
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
-- 
2.29.2

