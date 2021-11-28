Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD61A4609DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354776AbhK1U55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 15:57:57 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:64828 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353115AbhK1Uzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 15:55:48 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id rR9xmabogRLGprR9xmsUs5; Sun, 28 Nov 2021 21:52:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 28 Nov 2021 21:52:30 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     konrad.wilk@oracle.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mm/mempool: Use non-atomic '__set_bit()' when possible
Date:   Sun, 28 Nov 2021 21:52:28 +0100
Message-Id: <e52476da5cee57151745c5c3c934a69798dc6fa4.1638132190.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the 'a' and 'b' bitmap are local to this function, so no concurrent access
can occur.
So, the non-atomic '__set_bit()' can be used to save a few cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 mm/frontswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index 130e301c5ac0..6bed12260dea 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -127,7 +127,7 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 	spin_lock(&swap_lock);
 	plist_for_each_entry(si, &swap_active_head, list) {
 		if (!WARN_ON(!si->frontswap_map))
-			set_bit(si->type, a);
+			__set_bit(si->type, a);
 	}
 	spin_unlock(&swap_lock);
 
@@ -149,7 +149,7 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 	spin_lock(&swap_lock);
 	plist_for_each_entry(si, &swap_active_head, list) {
 		if (si->frontswap_map)
-			set_bit(si->type, b);
+			__set_bit(si->type, b);
 	}
 	spin_unlock(&swap_lock);
 
-- 
2.30.2

