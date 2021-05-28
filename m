Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1639393CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhE1FSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 01:18:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38528 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhE1FSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 01:18:53 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 736871FD2F;
        Fri, 28 May 2021 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622179037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lf/+eyXUUYbQ1axVyCT91t5kYmjbn3mXiPxb/rcORlw=;
        b=es0EAR2op8pXmWGW0oPzsz9ADc+BmicfJz2uV5j/iDYLr8Da7m9Am/TtSaQe6ouur5wufJ
        K0OZd7oASKn6aFx0J3XKzeGeTQITGjN3InTiok3tjbMxp9ZyqBcrBY/UQPIMy7J8yCMP+y
        2yAzzMwnuXDiIeoEczmFL8DPT+Zwka8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622179037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lf/+eyXUUYbQ1axVyCT91t5kYmjbn3mXiPxb/rcORlw=;
        b=oHc6aSsIML9x6av81AQVbX9VdLcsCBKwrnw9C7zL0+wWIa/FuHwLKTcaUf5EjGvws84Wc8
        BCxY4+m1wjG3nhAg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id CE82411A98;
        Fri, 28 May 2021 05:17:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH] vfs: allow O_PATH file descriptors for open_by_handle_at()
Date:   Fri, 28 May 2021 15:17:12 +1000
Message-id: <162217903209.27719.15641706922296023647@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The purpose of the "mount_fd" arg to open_by_handle_at() is solely to
identify a particular mount.  i.e.  it indicates "a location in the
filesystem tree" which is one of the purposes of O_PATH.

So change fdget() to fdget_raw().

Cc: stable@vger.kernel.org # O_PATH introduced in 3.0+
Signed-off-by: NeilBrown <neilb@suse.de>
---

This seems generally sensible, but will particularly be useful in
preparing the Lustre filesystem for upstream.

 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index ec6feeccc276..0020a0afdf86 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -122,7 +122,7 @@ static struct vfsmount *get_vfsmount_from_fd(int fd)
 		mnt = mntget(fs->pwd.mnt);
 		spin_unlock(&fs->lock);
 	} else {
-		struct fd f = fdget(fd);
+		struct fd f = fdget_raw(fd);
 		if (!f.file)
 			return ERR_PTR(-EBADF);
 		mnt = mntget(f.file->f_path.mnt);
-- 
2.31.1

