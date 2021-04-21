Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F253670D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbhDUREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbhDUREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:04:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC16FC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:03:29 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZGG4-00757O-RP; Wed, 21 Apr 2021 17:03:24 +0000
Date:   Wed, 21 Apr 2021 17:03:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH 053/190] Revert "ecryptfs: replace BUG_ON with error
 handling code"
Message-ID: <YIBa3L88Ak1vBM4Y@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-54-gregkh@linuxfoundation.org>
 <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
 <20210421161329.GD4991@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421161329.GD4991@sequoia>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:13:29AM -0500, Tyler Hicks wrote:

> > It *is* functionally harmless, AFAICS, but only because the condition
> > is really impossible.  However,
> > 	* it refers to vague (s)tool they'd produced, nevermind that
> > all they really do is "find BUG_ON(), replace with returning an error".
> > 	* unlike BUG_ON(), the replacement does *NOT* document the
> > fact that condition should be impossible.
> > IMO either should be sufficient for rejecting the patch.
> 
> I agree that it was not a malicious change. There are other places
> within the same function that return -EINVAL and the expectation is that
> errors from this function should be handled safely.

Umm...  Assuming that failure exits in the callers will function properly
if those conditions are true.  Which is not obvious at all.

> That said, I can find no real-world reports of this BUG_ON() ever being
> a problem and I don't think that there's any actual need for this
> change. So, I'm alright with it being reverted considering the
> circumstances.

AFAICS, at least some parts of that BUG_ON() are provably impossible
(e.g. NULL crypt_stat would've oopsed well upstream of the only call
of that function).  ECRYPTFS_STRUCT_INITIALIZED is set after
ecryptfs_alloc_inode() and never cleared, i.e. it should be present
in ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat.flags for
all inodes.  And crypt_stat we are passing to that thing is
calculated as &(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat),
which is another reason why it can't be NULL.

Incidentally, what's ecryptfs_setattr() doing with similar check?
It had been introduced in e10f281bca03 "eCryptfs: initialize crypt_stat
in setattr", which claims
    Recent changes in eCryptfs have made it possible to get to ecryptfs_setattr()
    with an uninitialized crypt_stat struct.  This results in a wide and colorful
    variety of unpleasantries.  This patch properly initializes the crypt_stat
    structure in ecryptfs_setattr() when it is necessary to do so.
and AFAICS at that point the call of ecryptfs_init_crypt_stat() in
ecryptfs_alloc_inode() had already been there and EXCRYPTFS_STRUCT_INITIALIZED
had been (unconditionally) set by it.  So how could that check trigger in
ecryptfs_setattr()?  No direct calls of that function (then as well as now),
it's only reachable as ecryptfs_{symlink,dir,main}_iops.setattr.  The first
two could only end up set by ecryptfs_interpose(), for inode returned by
iget5_locked() (i.e. one that had been returned by ->alloc_inode()),
the last is set by ecryptfs_init_inode(), called by ecryptfs_inode_set(), 
passed as callback to iget5_locked() by the same ecryptfs_interpose().
IOW, again, the inode must have been returned by ->alloc_inode().

I realize that it had been a long time ago, but... could somebody
recall what that patch had been about?  Michael?

Commit in question contains another (and much bigger) chunk; do
the comments in commit message refer to it?  Because it really
looks like
	if (!(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
		ecryptfs_init_crypt_stat(crypt_stat);
part in ecryptfs_setattr() is a confusing no-op...
