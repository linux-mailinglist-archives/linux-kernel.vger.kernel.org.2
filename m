Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA81356880
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhDGJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhDGJyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:54:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 738B561382;
        Wed,  7 Apr 2021 09:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617789277;
        bh=zWJ+SMOiDDkk14mXom4NjVcpZ2wgtTB1vowz8JWtg5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AI+PK3sTplYdXC1BcnmhYfjkvjUTprGlfNsiS2W3IqXnzA/c94mKNyQCoFgK4rsdK
         4noemkmQdovAnE9sIKXSd9zQme4I1pKT3EG8/LNQ8GF1bW3UugRKI7i+Gc6bgDV0/P
         xmRyQQdI8hBVyrVN1g/EGl2MMyySKxhW5IcDXp/8=
Date:   Wed, 7 Apr 2021 11:54:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [RESEND PATCH] staging: emxx_udc: Ending line with argument
Message-ID: <YG2BVSOI+UNfEZTT@kroah.com>
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
 <YGy4LXHBrBb/r3dk@kroah.com>
 <4c7df741-4e73-2ac4-f0d8-c9513ae29c88@gmail.com>
 <YG1FI38zNbidjt9q@kroah.com>
 <4d7ebe9c-8ebc-2fc9-10ed-6756ab42d5d7@gmail.com>
 <YG1usolTNEOfDqXh@kroah.com>
 <e7a18709-0b26-751e-6ba4-b43dd89c203f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a18709-0b26-751e-6ba4-b43dd89c203f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:46:23AM +0100, Beatriz Martins de Carvalho wrote:
> 
> Em 07/04/21 09:34, Greg KH escreveu:
> > On Wed, Apr 07, 2021 at 09:16:44AM +0100, Beatriz Martins de Carvalho wrote:
> > > Em 07/04/21 06:37, Greg KH escreveu:
> > > > On Tue, Apr 06, 2021 at 09:00:07PM +0100, Beatriz Martins de Carvalho wrote:
> > > > > Em 06/04/21 20:36, Greg KH escreveu:
> > > > > > On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
> > > > > > > Cleans up check of "Lines should not end with a '('"
> > > > > > > with argument present in next line in file emxx_udc.c
> > > > > > > 
> > > > > > > Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> > > > > > > ---
> > > > > > >     drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
> > > > > > >     1 file changed, 4 insertions(+), 7 deletions(-)
> > > > > > Why is this a [RESEND] ?
> > > > > > 
> > > > > > What happened to the first version?
> > > > > Sorry, I didn't receive your review, and in kernelnewbies tutorial, they say
> > > > > if not receive a response, may have missed the patch, so I resent it.
> > > > Do you have a pointer to your previous patch in the lore.kernel.org
> > > > archives anywhere?  I can't seem to find it.
> > > 
> > > I found this, it's what is you need?
> > > 
> > > https://lore.kernel.org/linux-staging/20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com/
> > Ah, yes, I saw Julia's review and assumed you would fix up your patch
> > based on her comments.  Please do not ignore review comments, it makes
> > everyone's lives harder.
> Sorry, I didn't fix up my patch based on her comments, because to do this
> was
> to revert all my patch or will break a code line if I remaining within 80
> characters. How the code line still stays between 85 or 90 I assumed that
> was
> ok, so I was waiting for your review. Now I saw that I should send this
> answer
> to her. What should I do with the patch?

If you do not know, ask the reviewer what they mean by their review
comments.

thanks,

greg k-h
