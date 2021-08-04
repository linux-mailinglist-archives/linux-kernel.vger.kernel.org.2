Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD813E00D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbhHDMHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:07:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49500
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237987AbhHDMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:07:11 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 83E143F22C;
        Wed,  4 Aug 2021 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628078818;
        bh=I5iMEiYeK7cuE7cXx3He18rSygUas33plv7CQH+qomo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=oKgu7LLaNOTt74RaPSZyRHkmp5yWtEGV147IXE6ePMGAtzEwc0Q3bi7MTOcmT1zqP
         zdl5NTXsCx0JnZ+RrgfaS6r1pKra/92ZJNnZWQvnKXDM3Zk+pwmLJV4h+tOS3mEETb
         Pe6Jlmu3qrq3qWjcBLYim9LMX5qln+CNNWofZH2ieZPKA028GXTKaqaYtPfLbA8jXq
         UZOORXeRoiIy+BKStZp5cILJ/iFT9yk7qsPqufOmIYbUPhx+TDhT4EYaRScEW4MJOj
         4a8JHR7c4nYX+zDZGcKtBtgF3Tc9btIjbja0mcBvaooRkmYMazEHPXG9anUjIm16mJ
         B0Az3PkkL0amw==
From:   Colin King <colin.king@canonical.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kernel/user.c: Fix spelling mistake "cpunter" -> "counter"
Date:   Wed,  4 Aug 2021 13:06:58 +0100
Message-Id: <20210804120658.110124-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a panic message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/user.c b/kernel/user.c
index a2673f940506..7fc40af8d8ac 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -223,7 +223,7 @@ static int __init uid_cache_init(void)
 		INIT_HLIST_HEAD(uidhash_table + n);
 
 	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
-		panic("percpu cpunter alloc failed");
+		panic("percpu counter alloc failed");
 
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
-- 
2.31.1

