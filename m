Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB637659F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhEGMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236580AbhEGMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=FeeqIKQUJ5oDBp/JRTcOr+LSGe4ow5VsWwzx+If8zMACjpxMVsLtywSGQTiZlMILLkSyFx
        oqyU0+XKxbwKgfiQ0ewpqFFPXeBaatj0PoY0TXgMYlRdhAedwi+zLbPYWL++Cn9i2Sg66q
        KYqZqPTIefzylh3jkB6RQad2ElD6FOA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-y3Vh0Uu8MhGnmR9qcGsMpA-1; Fri, 07 May 2021 08:53:10 -0400
X-MC-Unique: y3Vh0Uu8MhGnmR9qcGsMpA-1
Received: by mail-ej1-f70.google.com with SMTP id f8-20020a1709068248b02903a8adf1f5c2so1884086ejx.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 05:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=sLNyJV9o5MkG0I4+xVXgqBPvRiQ2dxjF6l/9U4CkL1tI1zn1wyNPBkDEAyCyqoqvXr
         RqAqtdzQaB8OPTlHhC41vyhZ6jK7SgzFX7ytuq0SdsP2lV7EbVm+/H5QqQ2eRuqwGhAR
         MLn02MDFPNaJwkOmkLlNeNHIL29LXymNvsv5mRv0BNusTffFJjupmib/0FoN8elNMdn+
         taeCgPPQZqqAm6lfb40TVnBQWasxkAWNR4/y3/bD4f/65BAvP2aQLmWXb+FSLOwobfTs
         wAeALLr4zW3n8jwqXlH+wYSBsiU9bxMIpvfl1gJmTVulQAkVhrZoA6BzsKdUdhRtnzez
         GWQw==
X-Gm-Message-State: AOAM531Pj/wdzBkjkmArq1u6q+wHv2op4s5w9rnFaC/nhGmFaYaZ6SCz
        m5oRsi/orXG6JFRQqshCppCvNeYTtRLmXHOAlWdXzfpBk23IGb0v0xCweTirbxHlV052dMorVjf
        JymPjpC5tv+UWxRUzpw8TUgpO
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662197ejb.198.1620391989174;
        Fri, 07 May 2021 05:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx3Z+9lizDuJOODp1PHOn4ynHaHjZttKyHDznmtmt2QFV4vRXq1H+M273vfCF/TzadAicR/g==
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662180ejb.198.1620391988967;
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id qh12sm3415986ejb.109.2021.05.07.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 14:53:04 +0200
Message-Id: <20210507125304.144394-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) is zero, then
the SELinux implementation of the locked_down hook might report a denial
even though the operation would actually be allowed.

To fix this, make sure that security_locked_down() is called only when
the return value will be taken into account (i.e. when changing one of
the problematic attributes).

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: try to explain the problem better in the description

 fs/debugfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22e86ae4dd5a..bbfc7898c1aa 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -45,10 +45,13 @@ static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
 static int debugfs_setattr(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct iattr *ia)
 {
-	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+	int ret;
 
-	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
-		return ret;
+	if (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		ret = security_locked_down(LOCKDOWN_DEBUGFS);
+		if (ret)
+			return ret;
+	}
 	return simple_setattr(&init_user_ns, dentry, ia);
 }
 
-- 
2.31.1

