Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4343723F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 02:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhEDAr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 20:47:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44489 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229499AbhEDArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 20:47:55 -0400
Received: (qmail 638919 invoked by uid 1000); 3 May 2021 20:47:00 -0400
Date:   Mon, 3 May 2021 20:47:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [syzbot] WARNING in do_proc_bulk
Message-ID: <20210504004700.GA638732@rowland.harvard.edu>
References: <000000000000b47bc805c15e4b11@google.com>
 <00000000000000186405c16a6156@google.com>
 <20210503105351.0966275d0d9e001ed794de2c@linux-foundation.org>
 <20210503185614.GA628313@rowland.harvard.edu>
 <20210503122428.30ebfddbaf8f5184dc73e1a7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503122428.30ebfddbaf8f5184dc73e1a7@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 12:24:28PM -0700, Andrew Morton wrote:
> On Mon, 3 May 2021 14:56:14 -0400 Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > 
> > > do_proc_bulk() is asking kmalloc for more than MAX_ORDER bytes, in
> > > 
> > > 	tbuf = kmalloc(len1, GFP_KERNEL);
> > 
> > This doesn't seem to be a bug.  do_proc_bulk is simply trying to 
> > allocate a kernel buffer for data passed to/from userspace.  If a user 
> > wants too much space all at once, that's their problem.
> > 
> > As far as I know, the kmalloc API doesn't require the caller to filter 
> > out requests for more the MAX_ORDER bytes.  Only to be prepared to 
> > handle failures -- which do_proc_bulk is all set for.
> > 
> > Am I wrong about this?  Should we add __GFP_NOWARN to the gfp flags?
> 
> Yes, if the oversized request is a can-happen and the resulting error is handled
> appropriately, __GFP_NOWARN is the way to go.

Okay, let's see how this does.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d2b6f8a1

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -1218,7 +1218,12 @@ static int do_proc_bulk(struct usb_dev_s
 	ret = usbfs_increase_memory_usage(len1 + sizeof(struct urb));
 	if (ret)
 		return ret;
-	tbuf = kmalloc(len1, GFP_KERNEL);
+
+	/*
+	 * len1 can be almost arbitrarily large.  Don't WARN if it's
+	 * too big, just fail the request.
+	 */
+	tbuf = kmalloc(len1, GFP_KERNEL | __GFP_NOWARN);
 	if (!tbuf) {
 		ret = -ENOMEM;
 		goto done;
