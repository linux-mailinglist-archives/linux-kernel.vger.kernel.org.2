Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4733CD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhCPF2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhCPF2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:28:04 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1926C06174A;
        Mon, 15 Mar 2021 22:28:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x27so8963030qvd.2;
        Mon, 15 Mar 2021 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91l+EZvobumpic5/EQLeULuDDYG6RJlmE6rR5M1RK9c=;
        b=KJiqHTgZJiA8fA92JzZrJVyRQHrcnMkOFSO+ZUYEGJq9WWcG70XWS/2Q6iP4eV+3Mg
         n5RvCYvzbvT6U2iuF89VHN0zJ4TKkzZVHKXz+or/WBAfKb01g14wifCI7UIgZtoIfhTL
         YjAG7ZEVlcuTGHjnVedLl6MUTTmXV5VnO+Bg3BvM6HspHzVI67UeWyJwD/sUQdqRD6qW
         +3tMl7VMiKXiMQRML3ToDtvdZK7a9AJBZ7qTEkMkghc9BegK7304YWOyaIysbJH7+PXg
         p4sc4D+M9mUxcIF+5mVROvF7+ZGf7rNZ1+uGg9q87lBjqmFRrRItx2kcEe7cTbVv1faE
         xwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91l+EZvobumpic5/EQLeULuDDYG6RJlmE6rR5M1RK9c=;
        b=runQO0m4uZuwzJKvSSunelF5qs62M2QOuhkHdRo0BhU2XMt0x9bDJ9T9jWtltXGGkd
         oPt84WbSNacHoO7Hd07Cyrq5aZcZrQmr93V3Bcvho3ng5C+v1zou/kV5nPVlrDdwxDyU
         4y1GWuruXEXau3juSI/60gqivI0gGTzuQos0aUAsP2klT/+u9AjoxiPGxIOthByIUpY9
         Jf1qS6jKLVSn6MY0hSTD6Tky76G7pa7QHfbGwhx+S0TuvYamC3ApW3XLuRYDysmktxzC
         bL4Kc+okC8z8GrlxaW2jDIFfy9LXEfxQErDFzpqNSHWuoCJE5U8zS9OB4RSZRp9bn4qu
         JSuA==
X-Gm-Message-State: AOAM530EtLtWd9a45JDVqci17qJ4XHC9xoIV8vudRmJ73qt8nEpN7vTE
        wOQ3KYROe6QwB80Az1Ek7dg=
X-Google-Smtp-Source: ABdhPJw3PcD1c3rBh3dmkpZFKOL86X6+IzmMIU2mkAxAU4zW9FQqZQfGpvOXT7Ry/boAWRVC/QYq4A==
X-Received: by 2002:a0c:b59f:: with SMTP id g31mr14223318qve.28.1615872483128;
        Mon, 15 Mar 2021 22:28:03 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.45])
        by smtp.gmail.com with ESMTPSA id i8sm12179387qtj.16.2021.03.15.22.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:28:02 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     ccaulfie@redhat.com, teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        trivial@vger.kernel.org
Subject: [PATCH] dlm: Mundane typo fixes throughout the file lock.c
Date:   Tue, 16 Mar 2021 10:57:32 +0530
Message-Id: <20210316052732.682020-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial typo fixes throughout the file.

cc: trivial@vger.kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/dlm/lock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 002123efc6b0..caadc426c8b4 100644
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
@@ -1535,7 +1535,7 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
 		return -1;
 	}

-	/* Remove for the convert reply, and premptively remove for the
+	/* Remove for the convert reply, and preemptively remove for the
 	   cancel reply.  A convert has been granted while there's still
 	   an outstanding cancel on it (the cancel is moot and the result
 	   in the cancel reply should be 0).  We preempt the cancel reply
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
2.30.2

