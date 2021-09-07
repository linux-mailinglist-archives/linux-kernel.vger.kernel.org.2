Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74F402B83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbhIGPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345070AbhIGPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D1BE61107;
        Tue,  7 Sep 2021 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027733;
        bh=Ea6i7nuMuxo3nuep6k3/uS6l/jmabdXQI6pMdAahtL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ffKmvK3wBprZET4qTUhh03G1E3cAf1H157JybTYOQC1b9RvN1zuCmjlk0mLZAbG1G
         M70zYMMgr+417YC4BSLX4lB6w8hFwZBhQjVQp1Ec/IDE0K3v2gn3j/vyqYhGK2Rkal
         WZdHkuu5+0EGtL+OH33Eb7ZZ1v3zrEs6RmIFeaMzjYVQK2pAk7wscCO5lfSNO1r1SA
         Chd34hjt0ForzdkRbWeNXLdc3Qla7HayKJJ1QK4JGP9kbMLrLQIEX8oobHlKi1HueD
         yFCNM6sUqwhzB0Sj3MZRHEgvbcwwPSSjZ6qEK/WtV1kur+YLzNPFvP/dGiKB6ghF4G
         tK0JyD3NYMg3A==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Gregor Beck <gbeck@esigma-technology.com>,
        Gregor Beck <gregor.beck@gmail.com>
Subject: [PATCH RT 2/3] fscache: fix initialisation of cookie hash table raw spinlocks
Date:   Tue,  7 Sep 2021 10:15:28 -0500
Message-Id: <b0d883b82b275ffe9aa0c9e3ca7960377e78c06e.1631027711.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregor Beck <gbeck@esigma-technology.com>

v5.4.143-rt64-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


The original patch, 602660600bcd ("fscache: initialize cookie hash
table raw spinlocks"), subtracted 1 from the shift and so still left
some spinlocks uninitialized.  This fixes that.

[zanussi: Added changelog text]

Signed-off-by: Gregor Beck <gregor.beck@gmail.com>
Fixes: 602660600bcd ("fscache: initialize cookie hash table raw spinlocks")
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/fscache/cookie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 5508d92e3f8f..cba2a226897f 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -963,6 +963,6 @@ void __init fscache_cookie_init(void)
 {
 	int i;
 
-	for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
+	for (i = 0; i < ARRAY_SIZE(fscache_cookie_hash); i++)
 		INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
 }
-- 
2.17.1

