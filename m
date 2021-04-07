Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AF357057
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbhDGPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353606AbhDGPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:30:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28ED061284;
        Wed,  7 Apr 2021 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617809436;
        bh=qA1K7GXPgJggIo7yDSDd0shoNwNJAxbUw0JD2TvPcag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfyzGWNsF1bmdjTOmt5+jEypgyfgMvhFIkBUPZVuqaSPuLIKJIqK6Owskw2/nQYud
         jDZ9O4GG3VMLuz98vXGXANX7n3EkLxgaTACr/lXmk3CWecq0wlYB0lCEac2tnGAVbf
         9GSywokjiNUpEh5Nfz7rwuDxndPapF0uPk3upcOg=
Date:   Wed, 7 Apr 2021 17:30:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] drivers: rtl8723bs: rewrite comparison to null
Message-ID: <YG3QGq0T/cO2kdFN@kroah.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
 <YG3MOCQHu3o/qHTg@kroah.com>
 <20210407152533.GA1590@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407152533.GA1590@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:25:34PM +0200, Fabio Aiuto wrote:
> On Wed, Apr 07, 2021 at 05:14:00PM +0200, Greg KH wrote:
> > On Wed, Apr 07, 2021 at 03:49:31PM +0200, Fabio Aiuto wrote:
> > > fix following post-commit hook checkpatch warnings:
> > > 
> > > CHECK: Comparison to NULL could be written "!psta"
> > > 97: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:2115:
> > > +		if (psta == NULL)
> > > 
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Nit, your subject line has "drivers:" not "staging:" here.  Be a bit
> > more careful next time please.
> > 
> > thanks,
> > 
> > greg k-h
> 
> sorry, you can drop them off the staging-testing branch and I will resend you all if you want,

Nah, it's not worth it, I'll keep them for now :)
