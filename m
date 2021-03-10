Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D743333D59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhCJNJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:09:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30842 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhCJNIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:08:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DwXSv449XzB09Zk;
        Wed, 10 Mar 2021 14:08:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SACp_rCSIXG4; Wed, 10 Mar 2021 14:08:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DwXSv2PNZzB09Zh;
        Wed, 10 Mar 2021 14:08:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B48EF8B78A;
        Wed, 10 Mar 2021 14:08:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SDT6w526Z2pV; Wed, 10 Mar 2021 14:08:32 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D7268B77E;
        Wed, 10 Mar 2021 14:08:32 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5E7BA67560; Wed, 10 Mar 2021 13:08:32 +0000 (UTC)
Message-Id: <db895662571f39581edf7105f5e0d886b952db99.1615381468.git.christophe.leroy@csgroup.eu>
In-Reply-To: <25459896a398909d195fd5eb3d82ca1acb07b783.1615381467.git.christophe.leroy@csgroup.eu>
References: <25459896a398909d195fd5eb3d82ca1acb07b783.1615381467.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] drm/i915/gem: Use user_write_access_begin() instead of
 user_access_begin()
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Wed, 10 Mar 2021 13:08:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eb_copy_relocations() only do unsafe_put_user(), it only
requires write access to user.

Use user_write_access_begin() instead of user_access_begin().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index d70ca36f74f6..eb7a4bfd53ef 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1851,14 +1851,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
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
@@ -1866,7 +1866,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 	return 0;
 
 end_user:
-	user_access_end();
+	user_write_access_end();
 end:
 	kvfree(relocs);
 	err = -EFAULT;
-- 
2.25.0

