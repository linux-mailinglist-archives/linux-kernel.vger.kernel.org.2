Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AE3F047B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhHRNTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:19:18 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46354
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236705AbhHRNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:19:16 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E16C1412AF;
        Wed, 18 Aug 2021 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629292721;
        bh=KCyLAuo8HtLXKU1YHXXydapUWUMTiSslZXAgKBUTZwI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=BScUvlRgWK1BCt2qB8IVte4thG+lTiB4LiSQ4nTMdaQJGhY1JWzJnuZjZBnhSFyG5
         gkbbX02rpvoXctDli99v3x/8Fw4H1zlCXex9VGX+j/yrgh7DodfQFF85yTTqFzNA7u
         oER6/yIITWtab09DPrFI3sFA/TfyDDJ//7rCPuXZ8sTo0UBa9Y7tFcf6/Jk/jr/ytI
         J0yQI4re20KqKGqAMp4ZK18JVmGBrOsTcRjL43sOZ3zHoOm+L7ra1zx3Fhh+6wR7Fp
         qZa3h/ESUr60NdwN/KrAh0JEmji/qCLkD7P8Iqb1S+ck3ZXpU++MSwy+LU9ffNUjOL
         vT88htE+h8Mcg==
From:   Colin King <colin.king@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] futex: fix assigned ret variable that is never read
Date:   Wed, 18 Aug 2021 14:18:40 +0100
Message-Id: <20210818131840.34262-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check on the rt_waiter and top_waiter->pi_state is
assigning an error return code to ret but this later gets re-assigned,
hence the check is currently ineffective. I believe the original
intent was to return -EINVAL rather than assign it to ret. Fix this.

Addresses-Coverity: ("Unused value")
Fixes: dc7109aaa233 ("futex: Validate waiter correctly in futex_proxy_trylock_atomic()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e7b4c6121da4..30e7daebaec8 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2025,7 +2025,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	 * and waiting on the 'waitqueue' futex which is always !PI.
 	 */
 	if (!top_waiter->rt_waiter || top_waiter->pi_state)
-		ret = -EINVAL;
+		return -EINVAL;
 
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
-- 
2.32.0

