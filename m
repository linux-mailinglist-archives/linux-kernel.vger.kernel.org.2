Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DD3BF2B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhGHANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhGHANB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:13:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 595CE61C42;
        Thu,  8 Jul 2021 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625703020;
        bh=u5cr8gCXRmIVEx9nPKy91mk6gsb4DsQEiJQdZ5vKous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIP1pj7y1EiJTOl39ck4CBjDTiGSrUCBNLAU5lITvUNN80ii13vqkMY/7CXxMumy6
         JC7y877N/SeUUo3B/bQp1rqMYfNE/2j+69+3uXSH3fFnZpBCw0HpGZ2p1mDm6IX2y9
         GUPosEvXYcUvthWDVzEcpCBZwbyZOOUHW28IRYkOOwRvz56V3lNve/XJYkrEB4OF93
         zqnQMwHqRRSoHx5D6V2uODT5QEQRuGXEzhFq2blXLMFLjbv8nV5UH9TtHH4BrMMra4
         DVYOMr9zjr9HOKycdSC9LniG1n35QHFK8zJQIoesaxTqlcSPPeXgOAq4UcmYdwBLqq
         /LbRs+JReC2vg==
Date:   Wed, 7 Jul 2021 17:10:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>, Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL] f2fs for 5.14-rc1
Message-ID: <YOZCaqG7TZVLOnl+@google.com>
References: <YOYHejl3CgABOnhP@google.com>
 <20210708094647.7c0d3060@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708094647.7c0d3060@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 07/08, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> On Wed, 7 Jul 2021 12:58:50 -0700 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Could you please consider this pull request?
> > 
> > Thanks,
> > 
> > The following changes since commit bd3c9cdb21a2674dd0db70199df884828e37abd4:
> > 
> >   Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2021-05-14 10:52:47 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.14-rc1
> > 
> > for you to fetch changes up to 28607bf3aa6f9762b32dc7f1ed0488823c0651b8:
> > 
> >   f2fs: drop dirty node pages when cp is in error status (2021-07-06 22:05:06 -0700)
> 
> Its worth mentioning the semantic conflict against the ext3 tree (which
> hasn't been merged by Linus yet, but presumably will be).
> 
> https://lore.kernel.org/lkml/20210623104922.30a5a3fa@canb.auug.org.au/

I think this looks good to me. Thank you~

> 
> The ext3 commit has been rebased and is now
> 
>   1474c39351f0 ("f2fs: Convert to using invalidate_lock")
> 
> but I am still applying the mentioned merge resolution patch.
> -- 
> Cheers,
> Stephen Rothwell


