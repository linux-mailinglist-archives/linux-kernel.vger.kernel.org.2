Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658353D6819
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGZTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:42:29 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:43542 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:42:28 -0400
Received: by mail-pj1-f52.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso1723206pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKPigKXjdV4qBwaqasq1yafxFh0+DSKTqxlVHiaFIYE=;
        b=r28HzO9bwTl8yWD115f9ONuyoxOoUKnVGJWYw/aA4GJrfBm8sfhy4g8abadf1CHxYX
         09tbAR2YRtJ4DVDZB/szf/Z27RQ5KiJ/lmOEyAm2AQa1NXLT4X/GKEpWGklxPg64pT5h
         3lSHx2ddZ0M1c7GHQVYvLmaOeDRZbeXiQ43tQxO6lFB5gIxDsn8eYhCWYzhekJksbjwB
         6A2YXZbiX7rCFiPlrQgqNtDvjup8BqwqmtkkQYa2bDFFNilXmbZqm8UeqrQPJrw7lQHy
         KIB3InZqe9WGbox40onJ7Szt5FUqadBq+Jxf+TAxv5LhrqZBvNxvYzr4O908G4GM+bPX
         5JRQ==
X-Gm-Message-State: AOAM533+8xqlQc8PhVeoBajmCOkDJuTZncK4urp5IIuTdzpZbTwqXprK
        JxLGS9Xo4TAOBngBwu0IpKk=
X-Google-Smtp-Source: ABdhPJyx9p92SefgrP0ASUFeyji6GUxhqrdCm7ntQ4C4uALjta9UQT8yZW8o4kfDJZaVyGPkl0Y6cA==
X-Received: by 2002:a63:e213:: with SMTP id q19mr16267409pgh.419.1627330976413;
        Mon, 26 Jul 2021 13:22:56 -0700 (PDT)
Received: from localhost ([191.96.121.228])
        by smtp.gmail.com with ESMTPSA id 30sm687083pgq.31.2021.07.26.13.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 13:22:55 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, neilb@suse.de
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] afs: simplify sget_fc() call
Date:   Mon, 26 Jul 2021 13:22:53 -0700
Message-Id: <20210726202253.2226788-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can just use set_anon_super_fc(), no need for our own
custom implementation of something we already have available.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/afs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index e38bb1e7a4d2..b6d044913a0f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -434,11 +434,6 @@ static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 		as->dyn_root);
 }
 
-static int afs_set_super(struct super_block *sb, struct fs_context *fc)
-{
-	return set_anon_super(sb, NULL);
-}
-
 /*
  * fill in the superblock
  */
@@ -575,7 +570,7 @@ static int afs_get_tree(struct fs_context *fc)
 	/* allocate a deviceless superblock */
 	sb = sget_fc(fc,
 		     as->dyn_root ? afs_dynroot_test_super : afs_test_super,
-		     afs_set_super);
+		     set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto error;
-- 
2.30.2

