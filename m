Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD22A425059
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbhJGJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:52:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGJw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:52:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5EEBB219C6;
        Thu,  7 Oct 2021 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633600235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYkDUdF+OLTXGm2Zepwf0hfryRvinAJIHFd6tFGrkGQ=;
        b=hsjIK/Ectk0N3rysdgrijLOgeJNiV0mrd5eTGRva6YItYPaerqvdSEWJ3IuYbuWforlRQx
        22w7j8HrF2b3xfw8fROoF5bmrSF6xh5+g29CqiwUZlVXnpBTOdGbNQTPvRYEXYoablx70e
        O1Jy3c+yyrFlxOD0go3+5EdrSKs+xAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633600235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYkDUdF+OLTXGm2Zepwf0hfryRvinAJIHFd6tFGrkGQ=;
        b=ZOwuGY63814MdJHzgcLafdFxCLSsaQW09EHzcbdv7l2ZNw2+ndQgdtFC7JsfJ3pqjF+TlC
        jQYql68YpqAJ1vCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 4A708A3B90;
        Thu,  7 Oct 2021 09:50:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C28411F2C8F; Thu,  7 Oct 2021 10:44:49 +0200 (CEST)
Date:   Thu, 7 Oct 2021 10:44:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
Cc:     dvyukov@google.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] possible deadlock in dquot_commit
Message-ID: <20211007084449.GA12712@quack2.suse.cz>
References: <000000000000a05b3b05baf9a856@google.com>
 <000000000000aa4cd605c91fe2b3@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <000000000000aa4cd605c91fe2b3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 09-08-21 05:54:27, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66745863ecde Merge tag 'char-misc-5.14-rc5' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13edca6e300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
> dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aeba6e300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a609e6300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 4096
> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: writeback.
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc4-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor211/9242 is trying to acquire lock:
> ffff88803a37ece8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x57/0x360 fs/quota/dquot.c:474
> 
> but task is already holding lock:
> ffff88803a303e48 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x9e5/0x1cb0 fs/ext4/inode.c:631
> 
> which lock already depends on the new lock.

I've got back to this and I have one more idea what could be causing this
and why I'm not able to reproduce. I think we free some inode with
i_data_sem locking class set to 2 and when the inode gets reused (which
doesn't happen in my VM for some reason) for a normal file, problems trigger.
Let's try attached patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 60a9483534ed0d99090a2ee1d4bb0b8179195f51

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--cWoXeonUoKmBZSoM
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-Make-sure-to-reset-inode-lockdep-class-when-quo.patch"

From 2c0f00967aecfbc03216feb5a6d7286346268932 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 7 Oct 2021 10:30:46 +0200
Subject: [PATCH] ext4: Make sure to reset inode lockdep class when quota
 enabling fails

When we succeed in enabling some quota type but fail to enable another
one with quota feature, we correctly disable all enabled quota types.
However we forget to reset i_data_sem lockdep class. When the inode gets
freed and reused, it will inherit this lockdep class (i_data_sem is
initialized only when a slab is created) and thus eventually lockdep
barfs about possible deadlocks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fbe9cae63786..70b5fcbd351a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6355,8 +6355,19 @@ int ext4_enable_quotas(struct super_block *sb)
 					"Failed to enable quota tracking "
 					"(type=%d, err=%d). Please run "
 					"e2fsck to fix.", type, err);
-				for (type--; type >= 0; type--)
+				for (type--; type >= 0; type--) {
+					struct inode *inode;
+
+					inode = sb_dqopt(sb)->files[type];
+					if (inode)
+						inode = igrab(inode);
 					dquot_quota_off(sb, type);
+					if (inode) {
+						lockdep_set_quota_inode(inode,
+							I_DATA_SEM_NORMAL);
+						iput(inode);
+					}
+				}
 
 				return err;
 			}
-- 
2.26.2


--cWoXeonUoKmBZSoM--
