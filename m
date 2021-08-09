Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84AA3E47F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhHIOwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:52:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhHIOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:52:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5930F21E6F;
        Mon,  9 Aug 2021 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628520732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXgNCxd+SgCE6NDh3ACmakqiEC7xEF9v8cmNkXeJUIE=;
        b=X0Oidp/S5+jDO7n1DPIspWjc6BTt1aMmhTMSP8APb4I53V+f6rT4nLB2HAopFbM7IzEFeV
        eRuT/tqZXvN6iVrl0Zl/NfBxvIgy2mbFTxidkqKqb3azI+SqhA+by91kCl01QFGlx3eUfa
        JROa1viu6jvhC4EC3WeFIWuYiVFNVXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628520732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXgNCxd+SgCE6NDh3ACmakqiEC7xEF9v8cmNkXeJUIE=;
        b=xVX39Xvg39qjvpnY+gAct0TQaIe0pNbw5tvxcKgZNQuFShfmvugNKd9iQHHXSTvaWZTnBD
        CauzAw33LbSK4OCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 4244BA3B81;
        Mon,  9 Aug 2021 14:52:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1D0C01E3BFC; Mon,  9 Aug 2021 16:52:09 +0200 (CEST)
Date:   Mon, 9 Aug 2021 16:52:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
Cc:     dvyukov@google.com, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] possible deadlock in dquot_commit
Message-ID: <20210809145209.GD30319@quack2.suse.cz>
References: <000000000000a05b3b05baf9a856@google.com>
 <000000000000aa4cd605c91fe2b3@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <000000000000aa4cd605c91fe2b3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
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

Hmm, looks like hidden quota file got linked from directory hierarchy.
Attached patch should fix this.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 902e7f373fff2476b53824264c12e4e76c7ec02a

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--Nq2Wo0NMKNjxTN9z
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-Make-sure-quota-files-are-not-grabbed-accidenta.patch"

From 6efc0878a8c8f498eb138bdb57fad8a6c85d115c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 9 Aug 2021 16:09:27 +0200
Subject: [PATCH] ext4: Make sure quota files are not grabbed accidentally

If ext4 filesystem is corrupted so that quota files are linked from
directory hirerarchy, bad things can happen. E.g. quota files can get
corrupted or deleted. Make sure we are not grabbing quota file inodes
when we expect normal inodes.

Reported-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..2c33c795c4a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4603,6 +4603,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_iloc iloc;
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
@@ -4613,9 +4614,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	projid_t i_projid;
 
 	if ((!(flags & EXT4_IGET_SPECIAL) &&
-	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
+	     ((ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO) ||
+	      ino == le32_to_cpu(es->s_usr_quota_inum) ||
+	      ino == le32_to_cpu(es->s_grp_quota_inum) ||
+	      ino == le32_to_cpu(es->s_prj_quota_inum))) ||
 	    (ino < EXT4_ROOT_INO) ||
-	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
+	    (ino > le32_to_cpu(es->s_inodes_count))) {
 		if (flags & EXT4_IGET_HANDLE)
 			return ERR_PTR(-ESTALE);
 		__ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
-- 
2.26.2


--Nq2Wo0NMKNjxTN9z--
