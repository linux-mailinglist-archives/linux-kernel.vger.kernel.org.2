Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE00326FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhB1BFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 20:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1BFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 20:05:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377EC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:04:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h8so13141154qkk.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ov50pcOYpHPtDidYN1luJvbz0DQd6yKs2tzdfomyZg=;
        b=ZOOevc8WR4DU2Km970h1PaQ2OSMUevwx2tRp67xaIbM+pOaDSr4Y4yzkAiXNr55rD+
         /hKilYYwrdDEHuKLiUFAxmqltdkC5RnreHWZXfScql9iCnxVjBIPdrm+xlWipCXNwfbg
         u07QZV1dcWwkXkBhEc378cUqGuLLVnQW1Rj2V1aTAkuoZy8r4JpzqUtuWuuQU6Txt2Hk
         8iPbjUfENPoUpPb96aN38i86+egEEGnd17XDhQDbh5OGmFfi+KOm76wT1v6E22ZHa4BN
         nuQclIo8EcepO3b5Ld3h8WGmYOS2iE5HO162MGT1v1bp57KQNAlQEMTM36xHIzSSbgCC
         urbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ov50pcOYpHPtDidYN1luJvbz0DQd6yKs2tzdfomyZg=;
        b=nS1K9/xeEuFTxjSAQY3Oo0FEcz4yYG44zWPZGZxYdkx1lySTviElfvwvVo7EGeJGYZ
         Ot7QvASVI/rcFl1satpRR/OS0jo8AHp/cnUckyBnGjcScAgEGZTxCKj6rWVMA6c7fINa
         v3uGH//l9fVgSl9njh9s4RYAYBilDtGwLRyAOxsoIkLs1dyJRrrmuoc6/udnwnvTXsON
         PxVIOII6oQFSRz3dAtHF2L8OZFyyY6EzZuDNBswDekBfAmzK021rbbsDIYo1TkWtjDHH
         vaMngDnGELySwSav8UiizFPb/rd6pHzeRdtS7T3a8zpgPCiB3iPd2ICMuMlZNif5nvEE
         epjA==
X-Gm-Message-State: AOAM530NtTsgtq1dd2ZfvLKPvZmXmnUoLHK+syrJa9p2u5arZTi+v77I
        hfMSr/JDTWXB4bS1JPjL7sU=
X-Google-Smtp-Source: ABdhPJw9bzTub02JH6QsLgxGMcJKN84KUZfjDyYV5+H6gSu9epEpGs0FZhaTB9VT4NlfgkiNvlDaTA==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr8640946qkk.209.1614474272546;
        Sat, 27 Feb 2021 17:04:32 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.3])
        by smtp.gmail.com with ESMTPSA id a34sm8706771qtc.97.2021.02.27.17.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 17:04:31 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ccaulfie@redhat.com, teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] fs: dlm: Spellings fixed throughout the file lock.c
Date:   Sun, 28 Feb 2021 06:32:05 +0530
Message-Id: <20210228010205.28697-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Few spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
 Fixed the subject line typo.
 Measured unwanted blank lines insertion.

 fs/dlm/lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 002123efc6b0..b00001c36ed5 100644
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
--
2.26.2

