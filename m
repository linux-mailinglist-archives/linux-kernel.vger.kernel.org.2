Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129A431655
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJRKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:44:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55780 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJRKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:44:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 979F921A6F;
        Mon, 18 Oct 2021 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634553733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9Pdzba2rTGf3Fzk/4LtwMGM6jtKJ5A/oT6ACRgzSOA=;
        b=rsC61MYb2caCdT2b8LX1W4Hw4TlvW95iZUFmGeQ8GrxyREcJk+LVhF9IDjrCctmCjJ/3lu
        bQ5HbSxlCQjuTO7uh8wAueHm5qjv0owOulfWnnNJbASRRR/Bv3MCsYzwbO4NN+OJMpLyA+
        iYtCWXLmfx0wVV48AcX4QbstcFMRUqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634553733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9Pdzba2rTGf3Fzk/4LtwMGM6jtKJ5A/oT6ACRgzSOA=;
        b=+IXDTNFuKjXTsiEBhKT9pBIODKCtSKZVcu8QREeVdnethyPDnC2HvWMTwH364RRbOk4+Fu
        xQZ5t+zYlv3xAQAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 83678A3B83;
        Mon, 18 Oct 2021 10:42:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52A011E0875; Mon, 18 Oct 2021 12:42:13 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:42:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com>
Cc:     bingjingc@synology.com, cccheng@synology.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        robbieko@synology.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in __isofs_iget
Message-ID: <20211018104213.GD29715@quack2.suse.cz>
References: <00000000000081a7bc05ce6d7c7a@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <00000000000081a7bc05ce6d7c7a@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 15-10-21 17:35:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d3134eb5de85 Add linux-next specific files for 20211011
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f5fd98b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b9662326d2be383b
> dashboard link: https://syzkaller.appspot.com/bug?extid=6fc7fb214625d82af7d1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca2e47300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17869bd4b00000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10808570b00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12808570b00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14808570b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6fc7fb214625d82af7d1@syzkaller.appspotmail.com

Let's try this:

#sys test 519d81956ee277b4419c723adfb154603c2565ba

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--C7zPtVaVf+AK4Oqc
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-isofs-Fix-out-of-bound-access-for-corrupted-isofs-im.patch"

From 5d06a4f26133fa8d45254febce7a46085e998ee7 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 18 Oct 2021 12:37:41 +0200
Subject: [PATCH] isofs: Fix out of bound access for corrupted isofs image

When isofs image is suitably corrupted isofs_read_inode() can read data
beyond the end of buffer. Sanity-check the directory entry length before
using it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 678e2c51b855..0c6eacfcbeef 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1322,6 +1322,8 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 
 	de = (struct iso_directory_record *) (bh->b_data + offset);
 	de_len = *(unsigned char *) de;
+	if (de_len < sizeof(struct iso_directory_record))
+		goto fail;
 
 	if (offset + de_len > bufsize) {
 		int frag1 = bufsize - offset;
-- 
2.26.2


--C7zPtVaVf+AK4Oqc--
