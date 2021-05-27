Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA7392A27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhE0I5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235593AbhE0I5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5BC6135F;
        Thu, 27 May 2021 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622105776;
        bh=pHpbUISEer8PDwFQ8j+A4Oe5qLCwqoNUkZ1wvkRPezA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOqijrU+XIbluJ6NeCd+uLKx/RWmHX5/8T9lHdYzC0YXpPAFVgahH36jiYOCd9n1W
         sATrxbNQLoTKrMJk/iFzdqvAmcIoImr3bqKhdEkaVoEPiyLLlH4snuNV9KA4YxRtE2
         RIs+LkpK26JfpbMELiiuZVm9eIwMKF7ryaYh8+yOWA/WmyvtCIRM8bYkt3As2N84Lt
         gqYIA6OR/dokT5u7F8xy5tTnxhos0d9jHxxuSr9HHJursp3LPawPmMO2ygvJJaUT1L
         Orwtv5yuecNcRoFxfgzWJ4XwAq2j5x7NgvK96yLcstfymblTn83jNLOj/EvDxs/CpZ
         1AUy1ZhEn2TpQ==
Date:   Thu, 27 May 2021 10:56:13 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cred: add missing return error code when
 set_cred_ucounts() failed
Message-ID: <20210527085613.7nnnh3ocwedvcntz@example.org>
References: <20210526143805.2549649-1-yangyingliang@huawei.com>
 <m1sg29kuxo.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sg29kuxo.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 05:10:43PM -0500, Eric W. Biederman wrote:
> Yang Yingliang <yangyingliang@huawei.com> writes:
> 
> > If set_cred_ucounts() failed, we need return the error code.
> 
> Alex how does this look to you?
> 
> This is showing up now as I have finally dropped the code in linux-next
> and other people are looking at it.
> 
> At a quick fix looks correct to me.

Yes, this is the right fix. I miss it.

> > Fixes: 905ae01c4ae2 ("Add a reference to ucounts for each cred")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  kernel/cred.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/cred.c b/kernel/cred.c
> > index db7c46bf36e5..e6fd2b3fc31f 100644
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -372,7 +372,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
> >  		ret = create_user_ns(new);
> >  		if (ret < 0)
> >  			goto error_put;
> > -		if (set_cred_ucounts(new) < 0)
> > +		ret = set_cred_ucounts(new);
> > +		if (ret < 0)
> >  			goto error_put;
> >  	}
> 

-- 
Rgrds, legion

