Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED837FBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhEMQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEMQyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:54:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4409C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:53:30 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 5so10128644qvk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42C6HOQrWTE0332FVLv9iuHqZnhb3K1H7/h3GIL4MSc=;
        b=Raa/HtVQFN4MxVNBhJb2DcKBQ35J32lWAHZ9m46iVjAkEGldvsU27tymx4FCCwkMXJ
         mvF5aVQ6bnvDF+MH3Ll41123hc/AselJ2NOXfOWx6d3lTMbQy6EriVpiCTCRVxNfmJ9b
         RGia/m6ELIrspl3UqMiDcwYcYhlyJ/QV/WmBsGKKTNrLohOQYbqERrTyTTuwt8hznHT0
         8UR4fXxkH7GAeEt4A17KUP2r+gdy0585kqSlFNliZfEFtU/GRlLO68htSh3eUbIGg8HY
         diPlAy7TRFBB26gwboQQ84yzE20V6hMu8hF4sNaer6NKCHxwJsneQ96+qRVZclvunNw/
         KnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42C6HOQrWTE0332FVLv9iuHqZnhb3K1H7/h3GIL4MSc=;
        b=VwcjTIVSNFXjRq1B3O5yEN9Klov2fkK8+y98yk9Tqo7FrUSUaOMiLdrbLzoaQ3afCp
         pp/twmvGZLDuKrkO4YW2MsW+A6nmKPfdo3eZIV1GEAbRjdpTXODi5sUIlMyb88i2hpDA
         durKl6iBCN/Fm9XUWe4Xr4Rks96RaQVKuwQjsq7ncGkeqgARmOAmgrpaiYLJIXxriunW
         Mg7xlx1dJi7l1SmKFX7ORryHL3nbX6jmhoZc2Yoay/oUz5RMzuofEBzXyWWnXEZk+1wS
         TIHMQiwMl3OGWnkG8z2rmQSyh8N/+Fg9XifxHO22NqYZzllXAGxoMzg7eTc1I24TvEBr
         LC0A==
X-Gm-Message-State: AOAM533n8V5p9hdeeX+doEarnPcMWFZ7AkBwBoDLqu7UxUW4pQtX4Es5
        Wd5EW/nriM3n+F6L7RJy90ENIA==
X-Google-Smtp-Source: ABdhPJy8PV+5DleMbIb9dyQ7HoX38+dWkm1AuVlsPPqh4Zo4I+nwD6VBNcOT2pcnZhMrFGbXPL43FA==
X-Received: by 2002:a05:6214:2a46:: with SMTP id jf6mr41803898qvb.28.1620924809987;
        Thu, 13 May 2021 09:53:29 -0700 (PDT)
Received: from bunsen3.telenet.unc.edu (bunsen3.telenet.unc.edu. [204.85.191.47])
        by smtp.googlemail.com with ESMTPSA id p11sm2822391qkj.3.2021.05.13.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 09:53:29 -0700 (PDT)
From:   wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     wenhuizhang <wenhui@gwmail.gwu.edu>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: deadstore delete in deferred files
Date:   Thu, 13 May 2021 12:53:23 -0400
Message-Id: <20210513165323.16593-1-wenhui@gwmail.gwu.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210509233327.22241-1-wenhui@gwmail.gwu.edu>
References: <20210509233327.22241-1-wenhui@gwmail.gwu.edu>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadstore detected by Lukas Bulwahn's CodeChecker Tool (ELISA group).

line 741 struct cifsInodeInfo *cinode;
line 747 cinode = CIFS_I(d_inode(cfile->dentry));
could be deleted.

cinode on filesystem should not be deleted when files are closed, they are representations of some data fields on a physical disk, thus no further action is required.
The virtual inode on vfs will be handled by vfs automatically, and the denotation is inode, which is different from the cinode.

Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>

---
 fs/cifs/misc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 524dbdfb7184..801a5300f765 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -738,13 +738,11 @@ void
 cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 {
 	struct cifsFileInfo *cfile;
-	struct cifsInodeInfo *cinode;
 	struct list_head *tmp;
 
 	spin_lock(&tcon->open_file_lock);
 	list_for_each(tmp, &tcon->openFileList) {
 		cfile = list_entry(tmp, struct cifsFileInfo, tlist);
-		cinode = CIFS_I(d_inode(cfile->dentry));
 		if (delayed_work_pending(&cfile->deferred))
 			mod_delayed_work(deferredclose_wq, &cfile->deferred, 0);
 	}
-- 
2.17.1

