Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839D833EBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCQIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhCQIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:47:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA6DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:46:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w8so711703pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uf2e3QzWU47aSOUQcIqXRLusIihEiK3LNk9Jiw8pXQ=;
        b=Nqb/wbo0V2pTidoBgStv630PZo3p5tFmHecRmtHBHwkrTnCXhP7/tcUKjRleDGW9ik
         mCQYfItFw7WwI3hqbUJ02WTC3itiHq3LwFAvmDKCkLgAj4qDXD9nJlKYIa7AwnUVyXKM
         RHHh598/YQVb+SDWWJWoaBc2CQ+QJfrHP0ctTXnzCBuIXV2ZmMaFad7CHLZeBzm4ZmeL
         LGLiprfBPtoE7dbWfqXQiO5rkHnYK3qKx+0/IjI7LA8JqSQWHHwwaZwHaAl3SZZ8hjqA
         lx/j6NKhbClY2SUlU0BxavIfsj5Q+FWRyb73wSe3jPXenfMXp3uhs1RWMoAxryQST6Re
         MW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uf2e3QzWU47aSOUQcIqXRLusIihEiK3LNk9Jiw8pXQ=;
        b=OKbg1NdhzwuF7lMsbhl3uFLnFtXgcn3P87WOs+au5Ce/6uRQLV9NN5JduNtjd09bc1
         o/TuhbldDJuqc9f/P3UeekXG7C9eoP8eznToyMVdBqlvpwPcpCKIbdObUaAGqZQcmt5/
         K0Oa81I92uE2lQ6tPFTTAad+1emxJs6Ao/BZE78V1w5ScFhcl/roVo5f/r8bhK8VhB13
         dsllV1Tkjdw9sapWGXcd6XFaK6VK9qx5fAeOD1Vx3/WyoItJJjly8T0+8md0r46klkNY
         VVufJeiqckcx7jA6c3BHKMbSjuuSI9QVjtyI68aBXZIB8p6E5sTTITrs6r1g8dcjN/uS
         TT4Q==
X-Gm-Message-State: AOAM532DxtAJhRhrzRTT0JOXRX41Af20HU1yPQ4ScbVtgsF+z0bvJOYh
        75zpBm41uWno/jm108Ys1W6iezVc0TxuHw==
X-Google-Smtp-Source: ABdhPJznm5wR2KWyRcXqq7Q72cXz8yYrM3nCD4jF3g0cgsdJEPuQ2D/Yaal+4widFj25OaPvffeQaQ==
X-Received: by 2002:a17:90a:fb47:: with SMTP id iq7mr3591198pjb.159.1615970811765;
        Wed, 17 Mar 2021 01:46:51 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c24sm1998664pjv.18.2021.03.17.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:46:51 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     christian.brauner@ubuntu.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] kernel:signal: Fix typo issue
Date:   Wed, 17 Mar 2021 16:46:52 +0800
Message-Id: <20210317084652.12049-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'situration' to 'situation'
change 'delievered' to 'delivered'
change 'overriden' to 'overridden'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef39a9e..2ab8ee48416d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1499,7 +1499,7 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
  * There is nothing in the encoding that can allow
  * copy_siginfo_to_user32 to detect this confusion of formats, so
  * handle this by requiring the caller of kill_pid_usb_asyncio to
- * notice when this situration takes place and to store the 32bit
+ * notice when this situation takes place and to store the 32bit
  * pointer in sival_int, instead of sival_addr of the sigval_t addr
  * parameter.
  */
@@ -2170,7 +2170,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 
 	/*
 	 * If @why is CLD_STOPPED, we're trapping to participate in a group
-	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
+	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delivered
 	 * across siglock relocks since INTERRUPT was scheduled, PENDING
 	 * could be clear now.  We act as if SIGCONT is received after
 	 * TASK_TRACED is entered - ignore it.
@@ -3280,7 +3280,7 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
  *
  * Note: This function does not work properly for the SIGCHLD on x32, but
  * fortunately it doesn't have to.  The only valid callers for this function are
- * copy_siginfo_to_user32, which is overriden for x32 and the coredump code.
+ * copy_siginfo_to_user32, which is overridden for x32 and the coredump code.
  * The latter does not care because SIGCHLD will never cause a coredump.
  */
 void copy_siginfo_to_external32(struct compat_siginfo *to,
-- 
2.25.1

