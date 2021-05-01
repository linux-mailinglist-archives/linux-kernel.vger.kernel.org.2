Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFE370658
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhEAIQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:16:45 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60605 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhEAIQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:16:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FXMWC5W4fz9sRs;
        Sat,  1 May 2021 10:15:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fg9IUuAJTwT6; Sat,  1 May 2021 10:15:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FXMWC4ZYsz9sRq;
        Sat,  1 May 2021 10:15:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D55F8B76F;
        Sat,  1 May 2021 10:15:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y1IqsAiUoALE; Sat,  1 May 2021 10:15:51 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25D8D8B763;
        Sat,  1 May 2021 10:15:51 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 04197642A5; Sat,  1 May 2021 08:15:50 +0000 (UTC)
Message-Id: <1acb97f184bf08078ebe0ba8a20b41937949a5a8.1619856556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f148cffa418ca0e6e4d79657fc8a9108917291ce.1619856556.git.christophe.leroy@csgroup.eu>
References: <f148cffa418ca0e6e4d79657fc8a9108917291ce.1619856556.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH RESEND] drm/i915/gem: Use user_write_access_begin() instead of
 user_access_begin()
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Date:   Sat,  1 May 2021 08:15:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eb_copy_relocations() only do unsafe_put_user(), it only
requires write access to user.

Use user_write_access_begin() instead of user_access_begin().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Resending with mm list in addition

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 5964e67c7d36..f7a7bb45274b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1907,14 +1907,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 		 * happened we would make the mistake of assuming that the
 		 * relocations were valid.
 		 */
-		if (!user_access_begin(urelocs, size))
+		if (!user_write_access_begin(urelocs, size))
 			goto end;
 
 		for (copied = 0; copied < nreloc; copied++)
 			unsafe_put_user(-1,
 					&urelocs[copied].presumed_offset,
 					end_user);
-		user_access_end();
+		user_write_access_end();
 
 		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
 	}
@@ -1922,7 +1922,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 	return 0;
 
 end_user:
-	user_access_end();
+	user_write_access_end();
 end:
 	kvfree(relocs);
 	err = -EFAULT;
-- 
2.25.0

