Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B210234F108
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhC3Sb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3Sba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:31:30 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:31:25 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRJ8m-0015x3-Kf; Tue, 30 Mar 2021 18:31:00 +0000
Date:   Tue, 30 Mar 2021 18:31:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Stanley <joel@jms.id.au>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>,
        "William A . Kennington III" <wak@google.com>,
        Lei YU <mine260309@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: Hook up splice_write callback
Message-ID: <YGNuZMUkzH0tkce6@zeniv-ca.linux.org.uk>
References: <20210330134537.423447-1-joel@jms.id.au>
 <20210330161715.GA12783@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330161715.GA12783@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:17:15PM +0200, Christoph Hellwig wrote:
> On Wed, Mar 31, 2021 at 12:15:37AM +1030, Joel Stanley wrote:
> > overlayfs using jffs2 as the upper filesystem would fail in some cases
> > since moving to v5.10. The test case used was to run 'touch' on a file
> > that exists in the lower fs, causing the modification time to be
> > updated. It returns EINVAL when the bug is triggered.
> > 
> > A bisection showed this was introduced in v5.9-rc1, with commit
> > 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops").
> > Reverting that commit restores the expected behaviour.
> > 
> > Some digging showed that this was due to jffs2 lacking an implementation
> > of splice_write. (For unknown reasons the warn_unsupported that should
> > trigger was not displaying any output).
> > 
> > Adding this patch resolved the issue and the test now passes.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

The same goes for quite a few other filesystems, actually - at least
adfs, affs, bfs, hfs, hfsplus, hostfs, hpfs, minix, omfs, sysv, ufs 
and vboxsf are in the same boat, and I suspect that ecryptfs and ntfs
might be too.

Christoph, do you see any problems with doing the same thing for that
bunch as well?
