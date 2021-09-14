Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5149E40BC19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhINXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234320AbhINXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631661266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4U82nHWoiCp51ZNXrLgZWl/q6yGkm2KC1XT/EobLwqE=;
        b=C96dpEBAxt08vfE17siN30xRIgTZd4/acJtWYTgZdztKY78LHvsciI9TNmOiz0T6H4gBsJ
        Jto47jrP7VFGKziAG5tQgUFuyWpSNXDJxSpXp9nD8ZomkcvbfY9UFthA6OKc7uKIkLWT2G
        5Yef373ysxgNHeOWsRuYOf0zJXBG8m0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-kGib2PDhNcOKzkAvV0De2Q-1; Tue, 14 Sep 2021 19:14:22 -0400
X-MC-Unique: kGib2PDhNcOKzkAvV0De2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C38E362F9;
        Tue, 14 Sep 2021 23:14:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82E1160C7F;
        Tue, 14 Sep 2021 23:14:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 14B38220779; Tue, 14 Sep 2021 19:14:20 -0400 (EDT)
Date:   Tue, 14 Sep 2021 19:14:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     cgel.zte@gmail.com, hare@suse.de, axboe@kernel.dk, tj@kernel.org,
        viro@zeniv.linux.org.uk, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        zhang yunkai <zhang.yunkai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH linux-next] init/do_mounts: fix potential memory out of
 bounds access
Message-ID: <YUEszOPiJKROT1UG@redhat.com>
References: <20210913114336.83684-1-xu.xin16@zte.com.cn>
 <20210914202349.GB9406@quack2.suse.cz>
 <YUElJqNI9VVL/SI/@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUElJqNI9VVL/SI/@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 06:41:42PM -0400, Vivek Goyal wrote:
> On Tue, Sep 14, 2021 at 10:23:49PM +0200, Jan Kara wrote:
> > On Mon 13-09-21 11:43:36, cgel.zte@gmail.com wrote:
> > > From: xu xin <xu.xin16@zte.com.cn>
> > > 
> > > Initially the pointer "p" points to the start of "pages".
> > > In the loop "while(*p++) {...}", it ends when "*p" equals
> > > to zero. Just after that, the pointer "p" moves forward
> > > with "p++", so "p" may points ouf of "pages".
> > > 
> > > furthermore, it is no use to set *p = '\0', so we remove it.
> > 
> > Hum, I agree it is somewhat unclear that the assignment cannot go beyond
> > the end of the page although I suspect it cannot happen in practice as that
> > would mean parameter PAGE_SIZE long and I suspect parameter parsing code
> > would refuse that earlier (but don't really know kernel cmdline parsing
> > details).
> > 
> > But what I'm quite sure about is that the assignment is not useless. If you
> > look at the loop below this assignment, you'll notice it terminates on
> > 0-length string and the assignment creates exactly this string at the end
> > of the split parameter. So your patch certainly breaks things.
> 
> Yes, that '\0' at the end is intentional so that we terminate the
> loop right after this assignment and count number of strings and
> return to caller.
> 
> Even before recent changes, get_fs_names() was doing same thing.
> It was adding at '\0' at the end. So behavior has not changed.
> 
> Now question is, is it easily possible to pass root_fs_names big
> enough that it can overflow the page we have assigned. If yes,
> then we can think if putting some safeguards and truncate the
> passed string and not overflow into next page.

Or we could pass "size" to split_fs_names() and make sure it
does not cross page boundary. Something like this. Compile
tested only. Will test tomorrow.

---
 init/do_mounts.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: redhat-linux/init/do_mounts.c
===================================================================
--- redhat-linux.orig/init/do_mounts.c	2021-09-14 18:50:13.608554845 -0400
+++ redhat-linux/init/do_mounts.c	2021-09-14 19:08:58.349284067 -0400
@@ -338,19 +338,20 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static int __init split_fs_names(char *page, char *names)
+static int __init split_fs_names(char *page, size_t size, char *names)
 {
 	int count = 0;
-	char *p = page;
+	char *p = page, *end = page + size - 1;
+
+	strncpy(p, root_fs_names, size);
+	*end = '\0';
 
-	strcpy(p, root_fs_names);
 	while (*p++) {
 		if (p[-1] == ',')
 			p[-1] = '\0';
 	}
-	*p = '\0';
 
-	for (p = page; *p; p += strlen(p)+1)
+	for (p = page; p < end && *p; p += strlen(p)+1)
 		count++;
 
 	return count;
@@ -404,7 +405,7 @@ void __init mount_block_root(char *name,
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, root_fs_names);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -543,7 +544,7 @@ static int __init mount_nodev_root(void)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, root_fs_names);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {

