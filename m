Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895E03F5BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhHXKWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236023AbhHXKWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:22:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF2CA6127B;
        Tue, 24 Aug 2021 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800507;
        bh=xJCfJs8RZmn3g/5lvkqUBr+gT+oZyrinafGUL3DOSGY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UJeIZHkNabA/L55+6x0syo7gdCEu9epNSQ03c0pEBoeJfwy99uzx6mOk9RuVeHtS5
         NE065IYoJnQDrt6IL555JCq+P+bjr47h2B5SFk1R/9XaycamagLuVm11uREAS4VliH
         elNC8qxKW92ASuerZ8iRF2wZ+MWaEjKGqdhlhCpD9Mt4XfBf7mWHpvPnwLFOufXMl0
         hZKtDgLHrctGOaljfF0J/SiicoER9aKhVm4cNs27SZVZDEHo+cfaj8nL2l/9BaC2FM
         hmxGbdoclA2JLqhYZwbJXatX+f/RqvJ45KXju07sSXiUnXGBaw2iyNDn48clDjcC3m
         sKcXYq6XMuQtg==
Message-ID: <9fdf35533dab9ae95947bcc3709d14a268b14368.camel@kernel.org>
Subject: Re: [PATCH] fs: 9q: remove unnecessary label "out_err"
From:   Jeff Layton <jlayton@kernel.org>
To:     asmadeus@codewreck.org, cgel.zte@gmail.com
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 24 Aug 2021 06:21:45 -0400
In-Reply-To: <YSSl4tPGeowannmy@codewreck.org>
References: <20210824074503.62333-1-ran.xiaokai@zte.com.cn>
         <YSSl4tPGeowannmy@codewreck.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-24 at 16:55 +0900, asmadeus@codewreck.org wrote:
> cgel.zte@gmail.com wrote on Tue, Aug 24, 2021 at 12:45:03AM -0700:
> > From: CGEL <ran.xiaokai@zte.com.cn>
> > 
> > due to commit 798b2ae3cd58 ("Merge remote-tracking branch
> > 'file-locks/locks-next'"), label "out_err" should be removed to
> > avoid build warning.
> 
> That commit is not in master (it's a linux-next commit), you cannot
> refer to a commit id that hasn't been merged in commit messages.
> Also given it's a trivial merge commit so please take a minute to find
> the real culprit (fs: remove mandatory file locking support) next time.
> 
> 
> Given it's not merged yet, Jeff can still fix his patch in his branch,
> I've added him to recipients -- can you remove the label?
> I've never used mandatory file locking myself so I'll admit I didn't
> really look at your patch the other day...
> 

Yep, I've already fixed this in my branch. The next linux-next merge
should have it. We'll probably merge the patch in v5.15, so hopefully
any pain and merge conflicts will be short-lived...

Thanks,
Jeff

> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: CGEL <ran.xiaokai@zte.com.cn>
> > ---
> >  fs/9p/vfs_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> > index 978666530d8e..d2d83163d6b0 100644
> > --- a/fs/9p/vfs_file.c
> > +++ b/fs/9p/vfs_file.c
> > @@ -319,7 +319,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
> >  		ret = v9fs_file_getlock(filp, fl);
> >  	else
> >  		ret = -EINVAL;
> > -out_err:
> > +
> >  	return ret;
> >  }
> 
> Thanks,

-- 
Jeff Layton <jlayton@kernel.org>

