Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4583764A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhEGLm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235026AbhEGLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620387718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=FsjveeURp2CTUBW3kb4tmMXhZSl7cBtuywtb79Tr2ynis4qVWWPXucgJjC+xr34Un0yW0g
        anJhVQ3jE9DU/T9ONmSnyM3Ivf3llS+QKJckTXkoQEAoA9HtIeJPv9iPQtQbtG4WtC0uE8
        YLmidtvGu2HsYnMce7P1N+gy2ld2IFI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-C4J_mM9GNCmOS7_q2lb5qQ-1; Fri, 07 May 2021 07:41:56 -0400
X-MC-Unique: C4J_mM9GNCmOS7_q2lb5qQ-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a0564025192b02903888712212fso4283376edd.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 04:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=lLgf75qUrVp69ybXPbaK2QTOEVrpMImlHcXr/nq4SZQijRK0txIR/+Q00Yavcim8Nq
         LtNRknHB7pAlYvbPI4hnPj3T3BhwLXSz5eVl7n00ZZXrp2RploawAThPuRB1jEitITKT
         VJ8SsfHSVxG9/8Z2YcPX4KNP4B5OgAXQLhbXcYKGJ2Pjl71dgGK4S9sTvZA2MR1Cb7VP
         ZTB+DJgLhtdmTMPkKgWWpiRgT7tgqGzjmdxetRRmLTicGawSL/zTIsa56nK2m9/Hv2NO
         gUGAUXiANLE6bsTFkBvUMGD2SXtSqpZXU17t7RdaVKSUo6/qsoe8KbSubHa2mmi3nk21
         gNsQ==
X-Gm-Message-State: AOAM531K0UXV9K4/lKvOvOQwsOudo8iKshk7GM3QN/OhpW/dPUweIUHr
        QsgysZy1HriShQyP5rgf7U8K4EfIp3TGUDSKEOLnKX6xzPIbIXsrteaGoMPkgUFSSHXBWWUTeLD
        /+8VPQ/tyTigc8IDq0F/Cj0AZ
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007693ejb.426.1620387715166;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe+4tEBSZQpT+iheN+fbqzfk3Ilvhkxits1eJbgq0XcZH2UeBxRoLPxQpaOHsaIcs/iRz58w==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007682ejb.426.1620387715042;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v19sm3356083ejy.78.2021.05.07.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:41:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 13:41:50 +0200
Message-Id: <20210507114150.139102-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that security_locked_down() is checked last so that a bogus
denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
ATTR_UID | ATTR_GID)) is zero.

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
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

