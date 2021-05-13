Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5328037FBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhEMQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEMQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:56:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:55:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id k19so818451qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A3RlebzumK4fwWT1g6X56MvDeVE+yh0/VbEO7iqxO7Y=;
        b=aM0eoV69VvprQUrTyUbnsyRwLhtc9v2X9TTz1Bh90nd46vAUrT+gV31TPjMejwxTOh
         CQm0ficz7+HsBbj3VlrSA2yvkkjcSAYzOAjF5nWlMbxEbnXXHRFwyacMQ8aS5fryRNxa
         oY7JbaFR2p2696Ai3bWtmhr4BEnyfFdooX8eZOp3kPyzppVHu3WB0NPhqNQn5AUOG819
         mq7M0qMuSQJCMQL99KoC8DMOoYssJiWLTuSqdbR0iXYCAh9DKI2wZso9f23vhMXYQwrG
         0FcddsgDsF1D1I9D1U16v+Vud12aHFpgS6UjrKBY0JccA+RltlHsbtEX7Z7p7auuGlbz
         JvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A3RlebzumK4fwWT1g6X56MvDeVE+yh0/VbEO7iqxO7Y=;
        b=RieK+Ngc3TfLKfSzibw9CzFOjJGu+yTAUqZC+KZMLQtKqmYeEyLjbuWUZzGKvAWTQS
         ZSHTNBdIKIAXvGyi43ptd73qUm/HhXML6Jm0/87jk430kKuftW2Jb7v0lk0VFk+Ctl2D
         zBbcQhbpD8L1PKmM4H3/jq9XqGv9v7iiDkgYvxnheP7ahFko9yZjhBdIRQr25YEqrwuy
         Pn0hTM7/ZkYnIN/d2+Oz6trEd5ThR6dC3+X2nZiC/SO3JKSjQwcOOkazCdgAL7uT4B0P
         uhsws/mMqoZKVsBo9CcrkX3wiPvr+mDe48Wc9kp+7wF1PYL/Tef/y60PwivXyM1quFXE
         ysbQ==
X-Gm-Message-State: AOAM531gWcaTQMioCTLWWUYCr3RypJENMqPkqCOUgi2fzHvpRoQjbegY
        Nl6LIIdY7ASt3tmBxXnShZ/sNpnzffirIoEj
X-Google-Smtp-Source: ABdhPJz9xooi0rxfZFpdaGUuPRq+I58reGjaeHKKrSFzRId6ykzgNlpy2+VVtXYndE/rFxu/go2OTQ==
X-Received: by 2002:a05:622a:289:: with SMTP id z9mr39845914qtw.325.1620924922983;
        Thu, 13 May 2021 09:55:22 -0700 (PDT)
Received: from bunsen3.telenet.unc.edu (bunsen3.telenet.unc.edu. [204.85.191.47])
        by smtp.googlemail.com with ESMTPSA id x28sm2941976qtm.71.2021.05.13.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 09:55:22 -0700 (PDT)
From:   wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     wenhuizhang <wenhui@gwmail.gwu.edu>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove deadstore in cifs_close_all_deferred_files()
Date:   Thu, 13 May 2021 12:55:16 -0400
Message-Id: <20210513165516.17723-1-wenhui@gwmail.gwu.edu>
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

cinode on filesystem should not be deleted when files are closed, 
they are representations of some data fields on a physical disk, 
thus no further action is required.
The virtual inode on vfs will be handled by vfs automatically, 
and the denotation is inode, which is different from the cinode.

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

