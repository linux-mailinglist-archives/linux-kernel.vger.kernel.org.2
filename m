Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020E63DE3F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhHCBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhHCBZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:25:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A57160FC4;
        Tue,  3 Aug 2021 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627953910;
        bh=DJFbQz8pBMO15mtnbbjzTE0d/buN7m/N36mMycitwDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOF1SBM0NbV/Iyx/47TT4L7doisVwJuR0LGj5z+3SoKIsUrrfI+PiiOIuvri060sh
         oI75PECkeugm7ZVVhaX+PU0I1Qub4uXQsxMcNCPr4dTIJqEZD45RMotL0giSjUoCEs
         0zmUtRUC9QatSCfSNyEIyIsrcMqxmbCF774cwVscWl64adimK7IL7ZPNI8QKS6LoVC
         paqX9vFz7Qa9FBsW0bFJtN6YJbAtJitXTDCxI8y1sM0Cnh2Q4qq6NPaI+guQg6Wc2A
         mKPqX1emEYuGZJusLy8lyiGMdFgTLFaJpOYhqYdOmzfhO4pDUumchgLkyqzrb1vTXC
         a0uXP7n+9Vv8g==
Date:   Mon, 2 Aug 2021 18:25:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
Message-ID: <YQia9FBvQIRgr6cm@google.com>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
 <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03, Chao Yu wrote:
> On 2021/8/3 2:03, Jaegeuk Kim wrote:
> > On 08/01, Chao Yu wrote:
> > > On 2021/7/31 3:20, Jaegeuk Kim wrote:
> > > > On 07/07, Chao Yu wrote:
> > > > > Currently, it only works in readonly format f2fs image.
> > > 
> > > There wouldn't be any race condition because unaligned extent only works
> > > for ro feature now?
> > 
> > Isn't your patch proposing on writable partition?
> 
> Please check description in patch message, now it was designed only for
                                                 --
                                                 what do you refer "it"?

> compression case w/ ro feature, let's check and support rw partition later.

Quite confused the patch description and code changes as well. You added some
change with this as well which is for RW.

+       if (is_inode_flag_set(dn->inode, FI_COMPRESSED_FILE) &&
+                       !f2fs_sb_has_readonly(sbi)) {

> 
> Thanks,
> 
> > 
> > > 
> > > > Is there any race condition between the address in extent_cache and the one in
> > > > dnode? I feel that we could synchronize it by locking its dnode block.
> > > 
> > > Thanks,
