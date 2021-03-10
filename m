Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D61333D58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhCJNJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:09:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4451 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhCJNIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:08:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DwXSt3c9szB09Zj;
        Wed, 10 Mar 2021 14:08:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Lq6Kc8eUPitN; Wed, 10 Mar 2021 14:08:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DwXSt26QQzB09Zh;
        Wed, 10 Mar 2021 14:08:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1E638B78A;
        Wed, 10 Mar 2021 14:08:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i5rQz8Reddhl; Wed, 10 Mar 2021 14:08:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69C718B77E;
        Wed, 10 Mar 2021 14:08:31 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 60F4867560; Wed, 10 Mar 2021 13:08:31 +0000 (UTC)
Message-Id: <25459896a398909d195fd5eb3d82ca1acb07b783.1615381467.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] iov_iter: Use user_read_access_begin() instead of
 user_access_begin()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 13:08:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_compat_iovec_from_user() only do unsafe_get_user(),
it only requires read access.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f66c62aa7154..76952a117b47 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1665,7 +1665,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 		(const struct compat_iovec __user *)uvec;
 	int ret = -EFAULT, i;
 
-	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
+	if (!user_read_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	for (i = 0; i < nr_segs; i++) {
@@ -1686,7 +1686,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 
 	ret = 0;
 uaccess_end:
-	user_access_end();
+	user_read_access_end();
 	return ret;
 }
 
-- 
2.25.0

