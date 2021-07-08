Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D972D3BF7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGHJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:55:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhGHJzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:55:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA857201A1;
        Thu,  8 Jul 2021 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625737937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhlJNBpetjZSDV5/yCI47Cdt6ca/0zPJcaE8KUURNEc=;
        b=f5l6TTOQAYB3MaKb1DZ9Ruzgb2xHoK54uI9sHiBGLRmiaQokt0TJV4zeh2rFYpiEfoPau5
        XeZ3Swqiy7Kn2+OChoCLUlIaO59Ad2dxOlkgrUmLH4X1YXZjIPwHDS6x8felX1bGIGQ1D+
        EJhdDiBG3+7H1nbAG25qMUAma5eROjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625737937;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhlJNBpetjZSDV5/yCI47Cdt6ca/0zPJcaE8KUURNEc=;
        b=J6vHDs5u3ru0i/nrlj6xKeplfW0Cbu6Uj5FAG7tRm2oWd5W0XLN9eUwnpV4eHv97lQYbCZ
        R4hE2UUNrTcoS2AA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id D6302A3B88;
        Thu,  8 Jul 2021 09:52:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 589961F2CAF; Thu,  8 Jul 2021 11:52:17 +0200 (CEST)
Date:   Thu, 8 Jul 2021 11:52:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>, Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL] f2fs for 5.14-rc1
Message-ID: <20210708095217.GA32434@quack2.suse.cz>
References: <YOYHejl3CgABOnhP@google.com>
 <20210708094647.7c0d3060@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708094647.7c0d3060@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-07-21 09:46:47, Stephen Rothwell wrote:
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

Whether that particular series causing the conflict will be merged by Linus
in this merge window is uncertain - Linus didn't like how filemap_fault()
unconditionally acquired the lock. I've created an optimization patch to avoid
that but review is pending... At this point I'm leaning towards the variant
that series won't go in during the merge window. In that case I'll
probably rebase on top of rc1 and force-push everything.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
