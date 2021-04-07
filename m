Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08333566ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbhDGIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234223AbhDGIfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A596061363;
        Wed,  7 Apr 2021 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784501;
        bh=QUPSZJEVZ4gOqekzobUa4Tu78f4ebblB6ELbnwdOIw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+xv4he5FiLWTw6uVqlGVRKzfN4vnXj8XwhEQEZGLONO/36pm0CpWha2XbchjGEVB
         /oo+0uryitIsJhls/71V1ZITjEZm54YgUFkhP+AtzkQYxRw80bSsFQC8Hkg9Ty2Q4Y
         TA0yr56OIxQtLXx57eX1ficLY5bBCUGBEcWGQtr4=
Date:   Wed, 7 Apr 2021 10:34:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [RESEND PATCH] staging: emxx_udc: Ending line with argument
Message-ID: <YG1usolTNEOfDqXh@kroah.com>
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
 <YGy4LXHBrBb/r3dk@kroah.com>
 <4c7df741-4e73-2ac4-f0d8-c9513ae29c88@gmail.com>
 <YG1FI38zNbidjt9q@kroah.com>
 <4d7ebe9c-8ebc-2fc9-10ed-6756ab42d5d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7ebe9c-8ebc-2fc9-10ed-6756ab42d5d7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:16:44AM +0100, Beatriz Martins de Carvalho wrote:
> 
> Em 07/04/21 06:37, Greg KH escreveu:
> > On Tue, Apr 06, 2021 at 09:00:07PM +0100, Beatriz Martins de Carvalho wrote:
> > > Em 06/04/21 20:36, Greg KH escreveu:
> > > > On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
> > > > > Cleans up check of "Lines should not end with a '('"
> > > > > with argument present in next line in file emxx_udc.c
> > > > > 
> > > > > Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> > > > > ---
> > > > >    drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
> > > > >    1 file changed, 4 insertions(+), 7 deletions(-)
> > > > Why is this a [RESEND] ?
> > > > 
> > > > What happened to the first version?
> > > Sorry, I didn't receive your review, and in kernelnewbies tutorial, they say
> > > if not receive a response, may have missed the patch, so I resent it.
> > Do you have a pointer to your previous patch in the lore.kernel.org
> > archives anywhere?  I can't seem to find it.
> 
> 
> I found this, it's what is you need?
> 
> https://lore.kernel.org/linux-staging/20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com/

Ah, yes, I saw Julia's review and assumed you would fix up your patch
based on her comments.  Please do not ignore review comments, it makes
everyone's lives harder.

thanks,

greg k-h
