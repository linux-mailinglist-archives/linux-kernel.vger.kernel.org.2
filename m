Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC7326FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 00:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhB0Xgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 18:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB0Xgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 18:36:49 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB71C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 15:36:09 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z128so12965502qkc.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peWghVwzakObRswcYtMdIQaLAPGjdtQ5TK7CULWgtzo=;
        b=tEQXszhTSZ8Xak2YxD7qWsuee8szbd6+Tx99NxjmKbLH6lvB5RYY9X2P8SLMyUwHNc
         2e7H8jmlGZSIwhIG/N6DGIO0F6vslBLiRaWMYG6CAd76O516HrPlLVVZT05ErZcyBWhB
         3ekBRuplxDSIpe2sFk3kPLO9i8Zd0IcREAtjQvfU0XnKukGfnbtoK72TnHRNiVANoxke
         nwI8WfUu4y4wKXOmO06LMhlW9wf8UTHhG49dab7hGotPkpNGW+LGr08cNM8NESPavYFb
         XF1q9sN3IXMiV3VZ6aKcoJ5T2KhItQmDlpRl6spRAbvetoLu2qUyq/9YRDue8ikBmv9E
         2NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peWghVwzakObRswcYtMdIQaLAPGjdtQ5TK7CULWgtzo=;
        b=hAep7+rb39GnkEt3ZzK/8VyigsW+euGVGhc3S4i0B6z2UqoRSuxl27WxBHoLVI5c9f
         xatctjCzUWu9Kx9oI/9vnWGYf51t2ULKEWyZaLJO520vBeIFk8NkYA3HB2cLhXgRdF0I
         Z589YuRXnM/cFoXZzndHyTkqn2flJU18u8VoUQFhsSw5A29BvvcTYzz8mbSvIeIc8k6g
         O6KieMVvlZimiDjXTrkoE7bUBbgQuYf39Gvwhxsdibngq0fRZFrjGQtPtR+LumUzU/qf
         PFgXrIThfAi/PluVYujNf94gYp7FrX4eZN8NS0wGA1jTe2wJk81EGHKWR++8qh02v1OR
         FZbQ==
X-Gm-Message-State: AOAM531miItO7XH0W+k8ihJtRd/VTTC0uz7H2omIfX+0fckXNW4vMvYs
        kxvRKFTfxQOnYRrD6nZX3RjPuHpDMkzQxA==
X-Google-Smtp-Source: ABdhPJyw5onIAkNUvSK4Om9JRgqKDy20b5WlQGitBylKsJxFxxyOqj+kghsr1d9p+DCKzanKWkVMHg==
X-Received: by 2002:a05:620a:2206:: with SMTP id m6mr8711634qkh.176.1614468968270;
        Sat, 27 Feb 2021 15:36:08 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.27])
        by smtp.gmail.com with ESMTPSA id o19sm8159568qtt.62.2021.02.27.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 15:36:07 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ccaulfie@redhat.com, teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs: dlm: Spellings fixed throughout the fle lock.c
Date:   Sun, 28 Feb 2021 05:03:36 +0530
Message-Id: <20210227233336.6290-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Few spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/dlm/lock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 002123efc6b0..efcd84faca14 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -91,7 +91,7 @@ static void del_timeout(struct dlm_lkb *lkb);
 static void toss_rsb(struct kref *kref);

 /*
- * Lock compatibilty matrix - thanks Steve
+ * Lock compatibility matrix - thanks Steve
  * UN = Unlocked state. Not really a state, used as a flag
  * PD = Padding. Used to make the matrix a nice power of two in size
  * Other states are the same as the VMS DLM.
@@ -594,7 +594,7 @@ static int find_rsb_dir(struct dlm_ls *ls, char *name, int len,
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (error)
 		goto do_toss;
-
+
 	/*
 	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
@@ -2357,14 +2357,14 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 * 6-5: But the default algorithm for deciding whether to grant or
 	 * queue conversion requests does not by itself guarantee that such
 	 * requests are serviced on a "first come first serve" basis.  This, in
-	 * turn, can lead to a phenomenon known as "indefinate postponement".
+	 * turn, can lead to a phenomenon known as "indefinite postponement".
 	 *
 	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
 	 * the system service employed to request a lock conversion.  This flag
 	 * forces certain conversion requests to be queued, even if they are
 	 * compatible with the granted modes of other locks on the same
 	 * resource.  Thus, the use of this flag results in conversion requests
-	 * being ordered on a "first come first servce" basis.
+	 * being ordered on a "first come first serve" basis.
 	 *
 	 * DCT: This condition is all about new conversions being able to occur
 	 * "in place" while the lock remains on the granted queue (assuming
@@ -5745,7 +5745,7 @@ int dlm_recover_process_copy(struct dlm_ls *ls, struct dlm_rcom *rc)

 		log_debug(ls, "dlm_recover_process_copy %x remote %d %x %d",
 			  lkid, rc->rc_header.h_nodeid, remid, result);
-
+
 		dlm_send_rcom_lock(r, lkb);
 		goto out;
 	case -EEXIST:
--
2.26.2

