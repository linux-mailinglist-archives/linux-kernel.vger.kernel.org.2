Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5A37794D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEIXen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhEIXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:34:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A52C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 16:33:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so13794278qkj.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YkDDytZNQxbBUAfAVAEk4fD9xRC/hQr+ckTlhR7Sl/U=;
        b=FG6PiqyE9rwCmLm9vyAou6ABFbikh0QGJVU0tj77mdedT8Gdo/QKRDk6Gkn50zGeLC
         Svv58IeJagoFS7uMs2L5zQi0Se21n5ap2lva5U9g3qMt/9IjtBYTGNfLb47dHk1LN92S
         iWClsRA7Mc1xYvmY1v5g2PEUNU+eSH9HgLTf3QLQ8Dnhqmsc3X/ix2mW6PHZbtTcXdz2
         5fI+JZAuWqEChaenVa3KD6cA2a0ZHFJfK/sDWYE+rPFlvkqOnLMkmVv54emtTkv+rfML
         6ZRnhHaVcyH7PqQ47CqDBIdP1GBmNeu+UP29Wu5JKza9mvY7yndPNUysZhJsf+CQz0Az
         rIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YkDDytZNQxbBUAfAVAEk4fD9xRC/hQr+ckTlhR7Sl/U=;
        b=XUeAtN78V+bghYnctV9yor4vqmzSfwy/by2/b5aVAV7Y2ZPn7mmEdidXXTrmOwP4vn
         RHdrSaQRljwHFZJgNlv46sRF/g3AfGSZtqc1J0p4BAnCN4yBI5uJGFD22Bgsfhqx93Dq
         MQ7AJh10HvFkecJXZeIFEjpsTOWaELLKQTgjdzJOhCRos2buOi+VbzN5O3hbA9RRbxl/
         lwUB74u0Vobm6MRFej3g4NQmnpLBPzctoWHNI3kF2q+rZ45RedKtJtsYL3gmGAY0vIed
         NHryUB36Fh2WiIvAc76t3V8vejjfr8Xb22e8x+FSv9zpulF1wbIEW8odVEQHfLemIG8j
         Fxog==
X-Gm-Message-State: AOAM531PDg8Br/3n5aVqK5qgnLNr8mS4bt9SkH57zqQbfTUnOEIw+e4J
        q8iYXBEWK8BK0GlWLMBPLPVwWfJGd9MIdA==
X-Google-Smtp-Source: ABdhPJx8IK1oBHvd+hmpLgGmiiozZrYWxFIVWOxr6sSYq+mtN0m69XKwqC5beCyk5AaJfI+3WS4Tvg==
X-Received: by 2002:a05:620a:c8f:: with SMTP id q15mr444683qki.400.1620603214599;
        Sun, 09 May 2021 16:33:34 -0700 (PDT)
Received: from bunsen3.telenet.unc.edu (bunsen3.telenet.unc.edu. [204.85.191.47])
        by smtp.googlemail.com with ESMTPSA id 7sm5789256qkd.20.2021.05.09.16.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 16:33:34 -0700 (PDT)
From:   wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     wenhui@gwmail.gwu.edu, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>
Date:   Sun,  9 May 2021 19:33:27 -0400
Message-Id: <20210509233327.22241-1-wenhui@gwmail.gwu.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadstore detected by Lukas Bulwahn's CodeChecker Tool (ELISA group).

line 741 struct cifsInodeInfo *cinode;
line 747 cinode = CIFS_I(d_inode(cfile->dentry));
could be deleted.

Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>

cinode on filesystem should not be deleted when files are closed, they are representations of some data fields on a physical disk, thus no further action is required.
The virtual inode on vfs will be handled by vfs automatically, and the denotation is inode, which is different from the cinode.
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

