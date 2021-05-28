Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528E394210
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhE1Lmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235898AbhE1Lmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:42:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196376124B;
        Fri, 28 May 2021 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622202060;
        bh=OvugPkURUxn+WVVJ4+/5mH+U1d5M6OsfuQvwYKxvUA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0YohcvmD2+guMfsHL01fCEEV1zZ+l3E5FdasDcVxhWhRhJZlB4Rhj+1ma4bSwrI+
         grH/fnfydf41C7gv5esa4+chh2ZX5KR6lcszLZEdhdyLXQePRKmv6RzSkvGdwJ9yL5
         hgrCvwFoUi9imT5JExoPlBoehjjqI9LX7cSrZf9cyMgNv7WwCjqJJwXgePNRUd7GOG
         zXxoxJt3ZY2qHnngDtosfH/sTRlW0oqdhqtof3baUkO38F7VP3fYamL6PyMudf27HX
         L9emcxcHewAdWSokdX0AnJqNZ3bg2Zbn3IAjg9r0UySZWM+kKX1yaIFgx3KHjK01Lz
         dxi3AeCPNwvwQ==
Date:   Fri, 28 May 2021 13:40:57 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cred: add missing return error code when
 set_cred_ucounts() failed
Message-ID: <20210528114057.nd7e6fk4xlyb22ty@example.org>
References: <20210526143805.2549649-1-yangyingliang@huawei.com>
 <m1sg29kuxo.fsf@fess.ebiederm.org>
 <20210527085613.7nnnh3ocwedvcntz@example.org>
 <m1mtsgkvik.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mtsgkvik.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:10:27AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
> 
> > On Wed, May 26, 2021 at 05:10:43PM -0500, Eric W. Biederman wrote:
> >> Yang Yingliang <yangyingliang@huawei.com> writes:
> >> 
> >> > If set_cred_ucounts() failed, we need return the error code.
> >> 
> >> Alex how does this look to you?
> >> 
> >> This is showing up now as I have finally dropped the code in linux-next
> >> and other people are looking at it.
> >> 
> >> At a quick fix looks correct to me.
> >
> > Yes, this is the right fix. I miss it.
> 
> 
> Can I have your Acked-by or Reviewed-by.
> Thank you.

Yes.

Reviewed-by: Alexey Gladkov <legion@kernel.org>
Acked-by: Alexey Gladkov <legion@kernel.org>

> >> > Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
> >> > Reported-by: Hulk Robot <hulkci@huawei.com>
> >> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> > ---
> >> >  kernel/cred.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/kernel/cred.c b/kernel/cred.c
> >> > index db7c46bf36e5..e6fd2b3fc31f 100644
> >> > --- a/kernel/cred.c
> >> > +++ b/kernel/cred.c
> >> > @@ -372,7 +372,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
> >> >  		ret = create_user_ns(new);
> >> >  		if (ret < 0)
> >> >  			goto error_put;
> >> > -		if (set_cred_ucounts(new) < 0)
> >> > +		ret = set_cred_ucounts(new);
> >> > +		if (ret < 0)
> >> >  			goto error_put;
> >> >  	}
> >> 
> 
> Eric
> 

-- 
Rgrds, legion

