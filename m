Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8298B370657
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEAIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:16:42 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51857 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhEAIQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:16:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FXMWB4wshz9sRr;
        Sat,  1 May 2021 10:15:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HMIzFJMW1339; Sat,  1 May 2021 10:15:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FXMWB41GFz9sRq;
        Sat,  1 May 2021 10:15:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 686338B76F;
        Sat,  1 May 2021 10:15:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y2T5rQuBPH_a; Sat,  1 May 2021 10:15:50 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33A598B763;
        Sat,  1 May 2021 10:15:50 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 05CE0642A5; Sat,  1 May 2021 08:15:49 +0000 (UTC)
Message-Id: <f148cffa418ca0e6e4d79657fc8a9108917291ce.1619856556.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH RESEND] iov_iter: Use user_read_access_begin() instead of
 user_access_begin()
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat,  1 May 2021 08:15:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_compat_iovec_from_user() only do unsafe_get_user(),
it only requires read access.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Resending with mm list in addition

 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 61228a6c69f8..fd9bd229d51d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1932,7 +1932,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 		(const struct compat_iovec __user *)uvec;
 	int ret = -EFAULT, i;
 
-	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
+	if (!user_read_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	for (i = 0; i < nr_segs; i++) {
@@ -1953,7 +1953,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 
 	ret = 0;
 uaccess_end:
-	user_access_end();
+	user_read_access_end();
 	return ret;
 }
 
-- 
2.25.0

